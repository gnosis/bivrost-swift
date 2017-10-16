//
//  AuxWriter.swift
//  BivrostKit
//
//  Created by Luis Reisewitz on 15.10.17.
//

import PathKit

struct AuxWriter {
    static func writeAuxiliaryFiles(to outputFolder: String) throws {
        try print(Path("./").children())
        
//        let resources = Bivrosthelper()
//        // Write resources to file system
//        try resources.export(to: outputFolder)
//        // Move one level up (as FakeBundle export adds an intermediate folder named `BivrostHelper`
//        let outputFolder = Path(outputFolder)
//        let fullPath = outputFolder + resources.filename
//        try fullPath.children().forEach { try $0.move(outputFolder + $0.lastComponent) }
//        try fullPath.delete()
    }
}
