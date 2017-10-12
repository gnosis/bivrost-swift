//
//  ContractWriter.swift
//  BivrostKit
//
//  Created by Luis Reisewitz on 12.10.17.
//

import PathKit
import Foundation

struct ContractWriter {
    static func writeContracts(from inputFiles: [String], to outputFolder: String) throws {
        try FileTool.create(path: outputFolder)
        try inputFiles.forEach { path in
            let contract = try ContractParser.parseContract(from: path)
            let outputFile = (Path(outputFolder) + fileName(for: contract)).absolute().string
            try FileTool.write(ContractGenerator.generateCode(from: contract), to: outputFile)
        }
    }
}

private func fileName(for contract: Contract) -> String {
    return contract.name + ".swift"
}
