//
//  main.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 27.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//

import Commander
import BivrostKit
import Foundation
import PathKit

func paths(from pattern: String) -> [String] {
    return Path.glob(pattern).map { $0.absolute().string }
}

let generateContracts = command(
    Option<String>("input", default: "./*.json", description: "Input file pattern specifying which json files should be parsed. Needs to be escaped with quotes to prevent the shell from expanding it."),
    Option<String>("output", default: "./contracts", description: "Output folder for generated contracts.")) { inputPattern, output in
        
        let expandedPaths = paths(from: inputPattern)
        let outputFolder = Path(output).absolute().string
        do {
            try BivrostKit.generateContracts(from: expandedPaths, to: outputFolder)
        } catch {
            print("=== An error occurred during contract generation. ===")
            print("=== Error: ===")
            print(error)
        }
}

let group = Group {
    $0.addCommand("generate-contracts",
                  "Generates Swift contract classes from contract JSON file.",
                  generateContracts)
}

group.run()
