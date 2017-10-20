//
//  AuxWriter.swift
//  BivrostKit
//
//  Created by Luis Reisewitz on 15.10.17.
//

import PathKit
import Foundation

struct AuxWriter {
    static func writeAuxiliaryFiles(to outputFolder: String) throws {
        try FileTool.create(path: outputFolder)
        let outputFolder = Path(outputFolder)
        
        // Find Resources folder
        let relativeResources = Path("Resources")
        let relativeToWorkingDir = Path.current + relativeResources
        
        let resources: Path
        if let relativeExecutablePathString = CommandLine.arguments.first {
            let relativeExecutablePathWithoutExecutableString = (relativeExecutablePathString as NSString).deletingLastPathComponent
            let executablePath = Path.current + Path(relativeExecutablePathWithoutExecutableString)
            let relativeToExecutable = executablePath + relativeResources
            // Check if executablePath/Resources exists (e.g. with Mint), otherwise use ChDir/Resources
            resources = relativeToExecutable.exists ? relativeToExecutable : relativeToWorkingDir
        } else {
            // Just use ChDir/Resources
            resources = relativeToWorkingDir
        }
        try resources.children().forEach { try $0.copy(outputFolder + $0.lastComponent) }
    }
}
