//
//  AuxWriter.swift
//  BivrostKit
//
//  Created by Luis Reisewitz on 15.10.17.
//

import PathKit

struct AuxWriter {
    static func writeAuxiliaryFiles(to outputFolder: String) throws {
        try FileTool.create(path: outputFolder)
        let outputFolder = Path(outputFolder)
        let resources = Path("./Resources")
        try resources.children().forEach { try $0.copy(outputFolder + $0.lastComponent) }
    }
}
