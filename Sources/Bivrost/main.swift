//
//  main.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 27.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//

import Commander
import BivrostBase
import Foundation
import PathKit

func jsonArray(from path: String) throws -> [[String: Any]] {
    let url = URL(fileURLWithPath: path)
    let data = try Data(contentsOf: url)
    return try! JSONSerialization.jsonObject(with: data, options: []) as! [[String: Any]]
}

func parse(path: String) throws -> String {
    let json = try jsonArray(from: path)
    return try JsonParser.parseContract(from: json)
}

func parsePattern(pattern: String) throws -> [String] {
    let paths = Path.glob(pattern)
    return try paths.map {
        try parse(path: $0.absolute().string)
    }
}

let group = Group {
    let parseCommand = command(
        Argument<String>("pattern",
                         description: "Pattern for json files to be parsed. Needs to be escaped with quotes to prevent the shell from expanding it.")) {
                            print(try parsePattern(pattern: $0))
    }
    $0.addCommand("parse",
                  "Parses ABI files and outputs internal representation",
                  parseCommand)
}

group.run()
