//
//  ContractGenerator.swift
//  BivrostKit
//
//  Created by Luis Reisewitz on 11.10.17.
//

import Stencil

/// Private model only used in getting data into the template renderer.
/// Created via `ContractGenerator.generateTemplateModel(contract:)`.
fileprivate struct TemplateContract {
    let name: String
    let functions: [TemplateFunction]
    
    struct TemplateFunction {
        let name: String
        let methodId: String
        let input: String // Direct Arguments Type/Tuple
        let output: String // Direct Return Type/Tuple
        let encodeArguments: String // e.g. arguments.spender, arguments.value
        
        let decodeReturnReturnValue: String // Name to be returned at the end of decode(returnData:)
        let decodeReturnTypes: [DecodeReturnType]
        
        struct DecodeReturnType {
            let name: String
            let type: String
        }
    }
}

struct ContractGenerator {
    
    fileprivate static let typePrefix = "Solidity."
    
    fileprivate static func typeString(for type: Contract.Element.ParameterType) -> String {
        switch type {
        case let .staticType(wrappedType):
            return typeString(for: wrappedType)
        case let .dynamicType(wrappedType):
            return typeString(for: wrappedType)
        }
    }
    
    fileprivate static func typeString(for type: Contract.Element.ParameterType.StaticType) -> String {
        let nonPrefixedTypeString: String
        switch type {
        case .uint(let bits):
            nonPrefixedTypeString = "UInt\(bits)"
        case .int(let bits):
            nonPrefixedTypeString = "Int\(bits)"
        case .address:
            nonPrefixedTypeString = "Address"
        case .bool:
            nonPrefixedTypeString = "Bool"
        case .bytes(let length):
            nonPrefixedTypeString = "Bytes\(length)"
        case .function:
            nonPrefixedTypeString = "Function"
        case let .array(type, length: length):
            let innerType = typeString(for: type)
            nonPrefixedTypeString = "Array<\(innerType)>\(length)"
        }
        return "\(typePrefix)\(nonPrefixedTypeString)"
    }
    
    fileprivate static func typeString(for type: Contract.Element.ParameterType.DynamicType) -> String {
        let nonPrefixedTypeString: String
        switch type {
        case .bytes:
            nonPrefixedTypeString = "Bytes"
        case .string:
            nonPrefixedTypeString = "String"
        case .array(let type):
            let innerType = typeString(for: type)
            nonPrefixedTypeString = "VariableArray<\(innerType)>"
        }
        return "\(typePrefix)\(nonPrefixedTypeString)"
    }
    
    fileprivate static func encodeArguments(for inputs: [Contract.Element.Function.Input]) -> String {
        let returnValue: String
        if inputs.count <= 1 {
            // For both 0 & 1 elements we just use BaseEncoder.encode(arguments: arguments)
            returnValue = "arguments"
        } else {
            returnValue = inputs.enumerated().map { index, element in
                let name = element.name.isEmpty ? "arg\(index)" : element.name
                
                return "arguments.\(name)"
            }.joined(separator: ", ")
        }
        return returnValue
    }
    
    fileprivate static func decodeReturnTypes(for outputs: [Contract.Element.Function.Output]) -> [TemplateContract.TemplateFunction.DecodeReturnType] {
        return outputs.enumerated().map { index, element in
            let name = element.name.isEmpty ? "ret\(index)" : element.name
            let type = typeString(for: element.type)
            return TemplateContract.TemplateFunction.DecodeReturnType(name: name, type: type)
        }
    }
    
    fileprivate static func decodeReturnReturnValue(for decodeReturnTypes: [TemplateContract.TemplateFunction.DecodeReturnType]) -> String {
        guard !decodeReturnTypes.isEmpty else {
            // In case of an empty return, we want it to read "return" without any identifier
            return ""
        }
        if decodeReturnTypes.count == 1,
            let firstType = decodeReturnTypes.first {
            // If we only have one return type, we want to directly return it (e.g. "return ret0")
            return firstType.name
        }
        
        // FIXME: Identifiers (name property) are not linked to the corresponding `typeString(for outputs)` identifiers and can break.
        let returnInvocation = decodeReturnTypes.map { "\($0.name): \($0.name)" }.joined(separator: ", ")
        return "Return(\(returnInvocation))"
    }
    
    fileprivate static func typeString(for inputs: [Contract.Element.Function.Input]) -> String {
        return typeString(for: inputs.map { (name: $0.name, type: $0.type) })
    }
    
    fileprivate static func typeString(for outputs: [Contract.Element.Function.Output]) -> String {
        return typeString(for: outputs.map { (name: $0.name, type: $0.type) })
    }
    
    fileprivate static func typeString(for namedParameters: [(name: String, type: Contract.Element.ParameterType)]) -> String {
        let returnValue: String
        if namedParameters.count == 1,
            let firstParameter = namedParameters.first {
            returnValue = typeString(for: firstParameter.type)
        } else if namedParameters.isEmpty {
            returnValue = "Void"
        } else {
            let tupleString = namedParameters.enumerated().map { index, element in
                let name = element.name.isEmpty ? "arg\(index)" : element.name
                let type = typeString(for: element.type)
                return "\(name): \(type)"
            }.joined(separator: ", ")
            returnValue = "(\(tupleString))"
        }
        return returnValue
    }
    
    fileprivate static func generateTemplateModel(contract: Contract) -> TemplateContract {
        let contractName = contract.name.capitalized
        
        let functions = contract.elements.flatMap { element -> TemplateContract.TemplateFunction? in
            guard case .function(let object) = element else { return nil }
            
            let functionName = object.name.capitalized
            let functionMethodId = object.methodId
            
            let inputString = typeString(for: object.inputs)
            let outputString = typeString(for: object.outputs)
            
            let encodeArgumentsString = encodeArguments(for: object.inputs)
            let decodeReturnTypesArray = decodeReturnTypes(for: object.outputs)
            let decodeReturnReturnValueString = decodeReturnReturnValue(for: decodeReturnTypesArray)
            
            return TemplateContract.TemplateFunction(name: functionName, methodId: functionMethodId, input: inputString, output: outputString, encodeArguments: encodeArgumentsString, decodeReturnReturnValue: decodeReturnReturnValueString, decodeReturnTypes: decodeReturnTypesArray)
        }
        
        return TemplateContract(name: contractName, functions: functions)
    }
    
    static func generateCode(from contract: Contract) throws -> String {
        let templateModel = generateTemplateModel(contract: contract)
        let template = Template(templateString: Templates.Contract)
        return try template.render(["contract": templateModel])
    }
}
