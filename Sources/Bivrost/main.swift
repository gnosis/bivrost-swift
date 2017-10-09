//
//  main.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 27.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//

import Commander

let group = Group {
    $0.command("generate", description: "Generates necessary Solidity files for Swift") { (path: String) in
        print("Running bivrost in path \(path)")
    }
}

group.run()
