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
    Option<String>("output", default: "./solidity", description: "Output folder which will contain all necessary Solidity files (generated and auxiliary)."),
    Flag("force", default: false, flag: "f", disabledName: nil, disabledFlag: nil, description: "If set, deletes all contents of the output folder before recreating it. Make sure there is nothing else in there.")) { inputPattern, output, force in
        
        let expandedPaths = paths(from: inputPattern)
        let outputFolder = Path(output).absolute().string
        do {
            try BivrostKit.generateSolidityFiles(from: expandedPaths, to: outputFolder, force: force)
        } catch {
            print("=== An error occurred during contract generation. ===")
            print("=== Error: ===")
            print(error)
        }
}

generate.run()
