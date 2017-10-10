//
//  ContractParser.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 12.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//
//

public struct ContractParser {
    /// Parses a list of json contract elements into a Contract struct.
    ///
    /// - Parameter json: Should be a valid JSON array containing functions and
    ///     events, according to
    ///     https://github.com/ethereum/wiki/wiki/Ethereum-Contract-ABI#json
    /// - Returns: An initialised contract struct.
    /// - Throws: Throws if the json was malformed, e.g. a required field was missing.
    static func parseContract(from json: [String: Any]) throws -> Contract {
        guard let name = json[.contractName] as? String else {
            throw BivrostError.Parser.contractNameInvalid
        }
        guard let elementsJson = json[.abi] as? [[String: Any]] else {
            throw BivrostError.Parser.contractAbiInvalid
        }
        
        let elements = try elementsJson.map { try ElementJsonParser.parseContractElement(from: $0) }
        return Contract(name: name, elements: elements)
    }
}
