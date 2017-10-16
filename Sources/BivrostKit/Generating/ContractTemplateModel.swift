//
//  ContractTemplateModel.swift
//  BivrostKit
//
//  Created by Luis Reisewitz on 12.10.17.
//

/// Private model only used in getting data into the template renderer.
/// Created via `ContractGenerator.generateTemplateModel(contract:)`.
struct ContractTemplateModel {
    let name: String
    let functions: [Function]
    
    struct Function {
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
    
    init(contract: Contract) {
        name = contract.name
        
        functions = contract.elements.flatMap { element -> ContractTemplateModel.Function? in
            guard case .function(let object) = element else { return nil }
            
            let functionName = object.name.capitalized
            let functionMethodId = object.methodId
            
            let inputString = tupleString(for: object.inputs)
            let outputString = tupleString(for: object.outputs)
            
            let encodeArgumentsString = encodeArguments(for: object.inputs)
            let decodeReturnTypesArray = decodeTypes(for: object.outputs)
            let decodeReturnReturnValueString = decodeReturnReturnValue(for: decodeReturnTypesArray)
            let decodeArgumentsTypesArray = decodeTypes(for: object.inputs)
            let decodeArgumentsReturnValueString = decodeArgumentsReturnValue(for: decodeArgumentsTypesArray)
            
            return ContractTemplateModel.Function(name: functionName, methodId: functionMethodId, input: inputString, output: outputString, encodeArguments: encodeArgumentsString, decodeReturnReturnValue: decodeReturnReturnValueString, decodeReturnTypes: decodeReturnTypesArray, decodeArgumentsReturnValue: decodeArgumentsReturnValueString, decodeArgumentsTypes: decodeArgumentsTypesArray)
        }
    }
}

// MARK: - Conversion Helper Methods
fileprivate func encodeArguments(for inputs: [Contract.Element.Function.Input]) -> String {
    guard inputs.count > 1 else {
        // For both 0 & 1 elements we just use BaseEncoder.encode(arguments: arguments)
        return "arguments"
    }
    return inputs.enumerated().map { index, element in
        let name = element.name.isEmpty ? "param\(index)" : element.name
        return "arguments.\(name)"
    }.joined(separator: ", ")
}

fileprivate func decodeTypes(for outputs: [Contract.Element.Function.Output]) -> [ContractTemplateModel.Function.DecodeType] {
    return decodeTypes(for: outputs.map { (name: $0.name, type: $0.type) })
}

fileprivate func decodeTypes(for inputs: [Contract.Element.Function.Input]) -> [ContractTemplateModel.Function.DecodeType] {
    return decodeTypes(for: inputs.map { (name: $0.name, type: $0.type) })
}

fileprivate func decodeTypes(for namedParameters: [(name: String, type: Contract.Element.ParameterType)]) -> [ContractTemplateModel.Function.DecodeType] {
    return namedParameters.enumerated().map { index, element in
        let name = element.name.isEmpty ? "param\(index)" : element.name
        let type = element.type.generatedTypeString
        return ContractTemplateModel.Function.DecodeType(name: name, type: type)
    }
}

fileprivate func decodeReturnReturnValue(for decodeReturnTypes: [ContractTemplateModel.Function.DecodeType]) -> String {
    return decodeReturnValue(for: decodeReturnTypes, tupleName: "Return")
}

fileprivate func decodeArgumentsReturnValue(for decodeArgumentsTypes: [ContractTemplateModel.Function.DecodeType]) -> String {
    return decodeReturnValue(for: decodeArgumentsTypes, tupleName: "Arguments")
}

fileprivate func decodeReturnValue(for decodeTypes: [ContractTemplateModel.Function.DecodeType], tupleName: String) -> String {
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

fileprivate func tupleString(for inputs: [Contract.Element.Function.Input]) -> String {
    return tupleString(for: inputs.map { (name: $0.name, type: $0.type) })
}

fileprivate func tupleString(for outputs: [Contract.Element.Function.Output]) -> String {
    return tupleString(for: outputs.map { (name: $0.name, type: $0.type) })
}

fileprivate func tupleString(for namedParameters: [(name: String, type: Contract.Element.ParameterType)]) -> String {
    let returnValue: String
    if namedParameters.count == 1,
        let firstParameter = namedParameters.first {
        returnValue = firstParameter.type.generatedTypeString
    } else if namedParameters.isEmpty {
        returnValue = "Void"
    } else {
        let tupleString = namedParameters.enumerated().map { index, element in
            let name = element.name.isEmpty ? "param\(index)" : element.name
            let type = element.type.generatedTypeString
            return "\(name): \(type)"
        }.joined(separator: ", ")
        returnValue = "(\(tupleString))"
    }
    return returnValue
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
