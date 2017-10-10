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


let group = Group {
    let parseCommand = command(
        Argument<String>("pattern",
                         description: "Pattern for json files to be parsed. Needs to be escaped with quotes to prevent the shell from expanding it.")) {
                            print("Parsing with pattern \($0).")
    }
    $0.addCommand("parse",
                  "Parses ABI files and outputs internal representation",
                  parseCommand)
}

group.run()
