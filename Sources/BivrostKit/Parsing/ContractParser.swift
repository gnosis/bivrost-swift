//
//  ContractParser.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 12.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//
//

import PathKit
import Foundation

protocol ContractParser {
    static func parseContract(from json: [String: Any]) throws -> Contract
}

extension ContractParser {
    /// Reads the given file and parses the content into a `Contract` struct.
    /// File should contain a valid JSON dictionary containing the contract
    /// metadata and abi.
    ///
    /// - Parameter file: Absolute file path of the JSON file.
    /// - Returns: An initialised contract struct.
    /// - Throws: Throws if the json was malformed, e.g. a required field was missing.
    static func parseContract(from file: String) throws -> Contract {
        return try parseContract(from: jsonDict(from: file))
    }

    /// Reads the given file and parses the contents as a json dictionary.
    /// File should contain a valid JSON dictionary.
    ///
    /// - Parameter file: Absolute file path of the JSON file.
    /// - Returns: A dictionary of the json contents.
    /// - Throws: Throws if the json was malformed or was not a dictionary.
    private static func jsonDict(from file: String) throws -> [String: Any] {
        let jsonData = try Path(file).read()
        guard let jsonDict = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] else {
            throw ParsingError.jsonFileNotADictionary
        }
        return jsonDict
    }
}
