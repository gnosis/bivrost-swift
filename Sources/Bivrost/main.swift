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

let generate = command(
    Option<String>("input", default: "./abi/*.json", description: "Input file pattern specifying which json files should be parsed. Needs to be escaped with quotes to prevent the shell from expanding it."),
    Option<String>("output", default: "./solidity", description: "Output folder which will contain all necessary Solidity files (generated and auxiliary).")) { inputPattern, output in
        
        let expandedPaths = paths(from: inputPattern)
        let outputFolder = Path(output).absolute().string
        do {
            try BivrostKit.generateSolidityFiles(from: expandedPaths, to: outputFolder)
        } catch {
            print("=== An error occurred during contract generation. ===")
            print("=== Error: ===")
            print(error)
        }
}

let group = Group {
    $0.addCommand("generate",
                  "Generates Swift contract classes from contract JSON file and exports them, including all necessary auxiliary files to the specified folder.",
                  generate)
}

group.run()
