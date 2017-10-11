//
//  ContractGenerator.swift
//  BivrostKit
//
//  Created by Luis Reisewitz on 11.10.17.
//

import Stencil

fileprivate struct TemplateContract {
    let name: String
    let functions: [TemplateFunction]
    
    struct TemplateFunction {
        let name: String
        let methodId: String
        let inputs: [TemplateFunctionInput]
        let outputs: [TemplateFunctionOutput]
        
        struct TemplateFunctionInput {
            let name: String // Can be empty
            let type: String // e.g. "Solidity.Address"
        }
        
        struct TemplateFunctionOutput {
            let name: String // Mostly empty
            let type: String // e.g. "Solidity.Address"
        }
    }
}

struct ContractGenerator {
    fileprivate static func typeString(for type: Contract.Element.ParameterType) -> String {
        return "Solidity.UInt12"
    }
    
    fileprivate static func generateTemplateModel(contract: Contract) -> TemplateContract {
        let contractName = contract.name.capitalized
        
        let functions = contract.elements.flatMap { element -> TemplateContract.TemplateFunction? in
            guard case .function(let object) = element else { return nil }
            
            let functionName = object.name.capitalized
            let functionMethodId = object.methodId
            
            let inputs = object.inputs.flatMap { input -> TemplateContract.TemplateFunction.TemplateFunctionInput? in
                let inputName = input.name
                let inputType = typeString(for: input.type)
                return TemplateContract.TemplateFunction.TemplateFunctionInput(name: inputName, type: inputType)
            }
            let outputs = object.outputs.flatMap { output -> TemplateContract.TemplateFunction.TemplateFunctionOutput? in
                let outputName = output.name
                let outputType = typeString(for: output.type)
                return TemplateContract.TemplateFunction.TemplateFunctionOutput(name: outputName, type: outputType)
            }
            
            return TemplateContract.TemplateFunction(name: functionName, methodId: functionMethodId, inputs: inputs, outputs: outputs)
        }
        
        return TemplateContract(name: contractName, functions: functions)
    }
    
    static func generateCode(from contract: Contract) throws -> String {
        let templateModel = generateTemplateModel(contract: contract)
        let template = Template(templateString: Templates.Contract)
        let contract = try template.render(["contract": templateModel])
    }
}
