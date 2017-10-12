//
//  ContractGenerator.swift
//  BivrostKit
//
//  Created by Luis Reisewitz on 11.10.17.
//

import Stencil
import Foundation

struct ContractGenerator {
    static func generateCode(from contract: Contract) throws -> String {
        let templateModel = ContractTemplateModel(contract: contract)
        let timestamp = Date().timeIntervalSince1970
        
        let template = Template(templateString: Templates.Contract)
        return try template.render(["contract": templateModel,
                                    "timestamp": timestamp])
    }
}
