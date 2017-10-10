//
//  Bivrost.swift
//  BivrostKit
//
//  Created by Luis Reisewitz on 10.10.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//

public struct BivrostKit {
    /// Parses the JSON files located at the given input paths and exports them as
    /// Swift Contract classes to the given output folder.
    ///
    /// - Parameters:
    ///   - inputFiles: A list of JSON file paths. JSON files should be valid contract
    ///     JSON containing a `contract_name` and an `abi` field.
    ///   - outputFolder: Generated `.swift` files will be exported to this folder.
    public static func generateContracts(from inputFiles: [String], to outputFolder: String) throws {
        print("Exporting files \(inputFiles) to folder \(outputFolder)")
        
    }
    
    /// Generates types that need to be generated (e.g. ArrayX, UIntX variants).
    /// Does not move or copy anything else.
    ///
    /// - Parameter outputFolder: Generated `.swift` files will be exported to this folder.
    public static func generateTypes(to outputFolder: String) {
        
    }
}
