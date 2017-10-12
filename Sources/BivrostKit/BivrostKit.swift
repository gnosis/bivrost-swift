//
//  Bivrost.swift
//  BivrostKit
//
//  Created by Luis Reisewitz on 10.10.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//

import PathKit
import Foundation

public struct BivrostKit {
    /// Generates Solidity types, generates Solidity contracts from JSON files
    /// located at the given input paths, and copies all required files to the
    /// given output folder.
    ///
    /// - Parameters:
    ///   - inputFiles: A list of JSON file paths. JSON files should be valid contract
    ///     JSON containing a `contract_name` and an `abi` field.
    ///   - outputFolder: Solidity `.swift` files will be exported to this folder.
    public static func generateSolidityFiles(from inputFiles: [String], to outputFolder: String) throws {
        let typeFolderName = "Generated Types"
        let contractFolderName = "Generated Contracts"
        let typeFolderPath = (Path(outputFolder) + Path(typeFolderName)).absolute().string
        let contractFolderPath = (Path(outputFolder) + Path(contractFolderName)).absolute().string
        
        try copyAuxiliaryFiles(to: outputFolder)
        try generateTypes(to: typeFolderPath)
        try generateContracts(from: inputFiles, to: contractFolderPath)
    }
    
    /// Parses the JSON files located at the given input paths and exports them as
    /// Swift Contract classes to the given output folder.
    ///
    /// - Parameters:
    ///   - inputFiles: A list of JSON file paths. JSON files should be valid contract
    ///     JSON containing a `contract_name` and an `abi` field.
    ///   - outputFolder: Generated `.swift` files will be exported to this folder.
    public static func generateContracts(from inputFiles: [String], to outputFolder: String) throws {
        try ContractWriter.writeContracts(from: inputFiles, to: outputFolder)
    }
    
    /// Generates types that need to be generated (e.g. ArrayX, UIntX variants).
    /// Does not move or copy anything else.
    ///
    /// - Parameter outputFolder: Generated `.swift` files will be exported to this folder.
    public static func generateTypes(to outputFolder: String) throws {
        try TypeWriter.writeTypes(to: outputFolder)
    }
    
    /// Copies auxiliary files to the specified output folder.
    ///
    /// - Parameter outputFolder: Auxiliary `.swift` files will be copied to this folder.
    public static func copyAuxiliaryFiles(to outputFolder: String) throws {
        // TODO: Hardest part. Figure out how to copy all files in `Export` folder
        // to the outputFolder without resources in SPM. 
    }
}
