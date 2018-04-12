//
//  ContractParser.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 12.09.17.
//  Copyright © 2017 Gnosis Ltd. All rights reserved.
//
//

import PathKit
import Foundation

struct ContractParser {
    /// Parses a dictionary of json contract elements into a Contract struct.
    ///
    /// - Parameter json: Should be a valid JSON dictionary containing name and
    ///     elements of the contract. Elements include functions and events,
    ///     according to
    ///     https://github.com/ethereum/wiki/wiki/Ethereum-Contract-ABI#json
    /// - Returns: An initialised contract struct.
    /// - Throws: Throws if the json was malformed, e.g. a required field was missing.
    static func parseContract(from json: [String: Any]) throws -> Contract {
        guard let name = json[.contractName] as? String else {
            throw ParsingError.contractNameInvalid(json: json)
        }
        guard let elementsJson = json[.abi] as? [[String: Any]] else {
            throw ParsingError.contractAbiInvalid
        }
        
        let elements = try elementsJson.map { try ElementJsonParser.parseContractElement(from: $0) }
        return Contract(name: name, elements: elements)
    }
    
    /// Reads the given file and parses the content into a `Contract` struct.
    /// File should contain a valid JSON dictionary containing the contract
    /// metadata and abi.
    ///
    /// - Parameter file: Absolute file path of the JSON file.
    /// - Returns: An initialised contract struct.
    /// - Throws: Throws if the json was malformed, e.g. a required field was missing.
    static func parseContract(from file: String) throws -> Contract {
        let jsonData = try Path(file).read()
        guard let jsonDict = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] else {
            throw ParsingError.invalidJsonFile
        }
        return try parseContract(from: jsonDict)
    }
}
