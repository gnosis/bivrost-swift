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
    }
}

struct ContractGenerator {
    fileprivate static func typeString(for type: Contract.Element.ParameterType) -> String {
        // FIXME: implement
        return String(describing: type)
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
            return TemplateContract.TemplateFunction(name: functionName, methodId: functionMethodId, input: inputString, output: outputString)
        }
        
        return TemplateContract(name: contractName, functions: functions)
    }
    
    static func generateCode(from contract: Contract) throws -> String {
        let templateModel = generateTemplateModel(contract: contract)
        let template = Template(templateString: Templates.Contract)
        return try template.render(["contract": templateModel])
    }
}
