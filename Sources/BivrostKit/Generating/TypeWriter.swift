//
//  TypeWriter.swift
//  BivrostKit
//
//  Created by Luis Reisewitz on 12.10.17.
//

import PathKit

fileprivate enum TypeFile: String {
    case bytesX = "BytesX"
    case intX = "IntX"
    case uintX = "UIntX"
    case arrayX = "ArrayX"
    
    var filename: String {
        return rawValue + "-Generated.swift"
    }
}

struct TypeWriter {
    static func writeTypes(to outputFolder: String) throws {
        // Make sure the output path actually exists before trying to write into it.
        try FileTool.create(path: outputFolder)
        
        try write(TypeGenerator.generateUIntX(), to: outputFolder, type: .uintX)
        try write(TypeGenerator.generateIntX(), to: outputFolder, type: .intX)
        try write(TypeGenerator.generateArrayX(), to: outputFolder, type: .arrayX)
        try write(TypeGenerator.generateBytesX(), to: outputFolder, type: .bytesX)
    }
    
    private static func write(_ typeText: String, to outputFolder: String, type: TypeFile) throws {
        let filePath = Path(outputFolder) + type.filename
        try FileTool.write(typeText, to: filePath.absolute().string)
    }
}
