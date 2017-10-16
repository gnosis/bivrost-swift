//
//  FileTool.swift
//  BivrostKit
//
//  Created by Luis Reisewitz on 12.10.17.
//

import PathKit

struct FileTool {
    /// Writes the given text to the specified file.
    ///
    /// - Parameters:
    ///   - text: The full text to write into the file.
    ///   - file: Absolute file path of the destination file.
    static func write(_ text: String, to file: String) throws {
        try Path(file).write(text, encoding: .utf8)
    }
    
    /// Copies a file or folder from the file system to the specified destination.
    /// Depending on the value of the `useSourceName` parameter, the original
    /// file name is appended to the destination path.
    ///
    /// - Parameters:
    ///   - source: Absolute path of the source file or folder.
    ///   - destinationFolder: Absolute file path of the destination folder.
    ///   - useSourceName: If this is set, the complete destination path will be
    ///     `<DestinationFolder>/<OriginalFilename>`.
    static func copy(source: String, into destinationFolder: String, useSourceName: Bool = true) throws {
        let sourcePath = Path(source)
        let destination = Path(destinationFolder) + (useSourceName ? sourcePath.lastComponent : "")
        try sourcePath.copy(destination)
    }
    
    /// Creates the specified path, including all intermediate directories.
    ///
    /// - Parameter path: Path to create.
    static func create(path: String) throws {
        try Path(path).mkpath()
    }
    
    /// Deletes the specified path, including all contents in case of a directory.
    ///
    /// - Parameter path: Path to delete.
    static func delete(path: String) throws {
        try Path(path).delete()
    }
}
