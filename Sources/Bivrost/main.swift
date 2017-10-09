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

func jsonArray(from path: String) throws -> [[String: Any]] {
    let url = URL(fileURLWithPath: path)
    let data = try Data(contentsOf: url)
    return try! JSONSerialization.jsonObject(with: data, options: []) as! [[String: Any]]
}

let group = Group {
    $0.command("parse", description: "Parses ABI files and outputs representation") { (path: String) in
        print("Parsing \(path)")
        let json = try jsonArray(from: path)
        print(try JsonParser.parseContract(from: json))
    }
    $0.command("generate", description: "Generates necessary Solidity files for Swift") { (path: String) in
        print("Generate: Dummy command in path \(path)")
    }
}

group.run()

