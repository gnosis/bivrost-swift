//
//  ContractGenerator.swift
//  BivrostKit
//
//  Created by Luis Reisewitz on 11.10.17.
//

import Stencil

struct ContractGenerator {
    static func generateCode(from contract: Contract) throws -> String {
        let templateModel = generateTemplateModel(contract: contract)
        let template = Template(templateString: Templates.Contract)
        return try template.render(["contract": templateModel])
    }
}

// MARK: - TemplateContract Model

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
        let decodeReturnTypes: [DecodeType]
        
        let decodeArgumentsReturnValue: String // Name to be returned at the end of decode(argumentsData:)
        let decodeArgumentsTypes: [DecodeType]
        
        struct DecodeType {
            let name: String
            let type: String
        }
    }
}

// MARK: - TemplateContract Creation
extension ContractGenerator {
    fileprivate static func generateTemplateModel(contract: Contract) -> TemplateContract {
        let contractName = contract.name.capitalized
        
        let functions = contract.elements.flatMap { element -> TemplateContract.TemplateFunction? in
            guard case .function(let object) = element else { return nil }
            
            let functionName = object.name.capitalized
            let functionMethodId = object.methodId
            
            let inputString = typeString(for: object.inputs)
            let outputString = typeString(for: object.outputs)
            
            let encodeArgumentsString = encodeArguments(for: object.inputs)
            let decodeReturnTypesArray = decodeTypes(for: object.outputs)
            let decodeReturnReturnValueString = decodeReturnReturnValue(for: decodeReturnTypesArray)
            let decodeArgumentsTypesArray = decodeTypes(for: object.inputs)
            let decodeArgumentsReturnValueString = decodeArgumentsReturnValue(for: decodeArgumentsTypesArray)
            
            return TemplateContract.TemplateFunction(name: functionName, methodId: functionMethodId, input: inputString, output: outputString, encodeArguments: encodeArgumentsString, decodeReturnReturnValue: decodeReturnReturnValueString, decodeReturnTypes: decodeReturnTypesArray, decodeArgumentsReturnValue: decodeArgumentsReturnValueString, decodeArgumentsTypes: decodeArgumentsTypesArray)
        }
        
        return TemplateContract(name: contractName, functions: functions)
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
    
    fileprivate static func decodeTypes(for outputs: [Contract.Element.Function.Output]) -> [TemplateContract.TemplateFunction.DecodeType] {
        return decodeTypes(for: outputs.map { (name: $0.name, type: $0.type) })
    }
        
    fileprivate static func decodeTypes(for inputs: [Contract.Element.Function.Input]) -> [TemplateContract.TemplateFunction.DecodeType] {
        return decodeTypes(for: inputs.map { (name: $0.name, type: $0.type) })
    }
    
    fileprivate static func decodeTypes(for namedParameters: [(name: String, type: Contract.Element.ParameterType)]) -> [TemplateContract.TemplateFunction.DecodeType] {
        return namedParameters.enumerated().map { index, element in
            let name = element.name.isEmpty ? "ret\(index)" : element.name
            let type = element.type.generatedTypeString
            return TemplateContract.TemplateFunction.DecodeType(name: name, type: type)
        }
    }
    
    fileprivate static func decodeReturnReturnValue(for decodeReturnTypes: [TemplateContract.TemplateFunction.DecodeType]) -> String {
        return decodeReturnValue(for: decodeReturnTypes, tupleName: "Return")
    }
    
    fileprivate static func decodeArgumentsReturnValue(for decodeArgumentsTypes: [TemplateContract.TemplateFunction.DecodeType]) -> String {
        return decodeReturnValue(for: decodeArgumentsTypes, tupleName: "Arguments")
    }
    
    fileprivate static func decodeReturnValue(for decodeTypes: [TemplateContract.TemplateFunction.DecodeType], tupleName: String) -> String {
        guard !decodeTypes.isEmpty else {
            // In case of an empty return, we want it to read "return" without any identifier
            return ""
        }
        if decodeTypes.count == 1,
            let firstType = decodeTypes.first {
            // If we only have one return type, we want to directly return it (e.g. "return ret0")
            return firstType.name
        }
        
        let invocation = decodeTypes.map { "\($0.name): \($0.name)" }.joined(separator: ", ")
        return "\(tupleName)(\(invocation))"
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
            returnValue = firstParameter.type.generatedTypeString
        } else if namedParameters.isEmpty {
            returnValue = "Void"
        } else {
            let tupleString = namedParameters.enumerated().map { index, element in
                let name = element.name.isEmpty ? "arg\(index)" : element.name
                let type = element.type.generatedTypeString
                return "\(name): \(type)"
            }.joined(separator: ", ")
            returnValue = "(\(tupleString))"
        }
        return returnValue
    }
}

// MARK: - Parser Type to Code Type
fileprivate let generatedTypePrefix = "Solidity."

extension Contract.Element.ParameterType {
    var generatedTypeString: String {
        switch self {
        case let .staticType(wrappedType):
            return wrappedType.generatedTypeString
        case let .dynamicType(wrappedType):
            return wrappedType.generatedTypeString
        }
    }
}

extension Contract.Element.ParameterType.StaticType {
    var generatedTypeString: String {
        let nonPrefixedTypeString: String
        switch self {
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
            let innerType = type.generatedTypeString
            nonPrefixedTypeString = "Array<\(innerType)>\(length)"
        }
        return "\(generatedTypePrefix)\(nonPrefixedTypeString)"
    }
}

extension Contract.Element.ParameterType.DynamicType {
    var generatedTypeString: String {
        let nonPrefixedTypeString: String
        switch self {
        case .bytes:
            nonPrefixedTypeString = "Bytes"
        case .string:
            nonPrefixedTypeString = "String"
        case .array(let type):
            let innerType = type.generatedTypeString
            nonPrefixedTypeString = "VariableArray<\(innerType)>"
        }
        return "\(generatedTypePrefix)\(nonPrefixedTypeString)"
    }
}
