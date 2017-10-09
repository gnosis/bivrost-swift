//
//  JsonParser.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 12.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//
//

public struct JsonParser {
    /// Parses a list of json contract elements into a Contract struct.
    ///
    /// - Parameter json: Should be a valid JSON array containing functions and
    ///     events, according to
    ///     https://github.com/ethereum/wiki/wiki/Ethereum-Contract-ABI#json
    /// - Returns: An initialised contract struct.
    /// - Throws: Throws if the json was malformed, e.g. a required field was missing.
    static func parseContract(from json: [[String: Any]]) throws -> Contract {
        let elements = try json.map { try ElementJsonParser.parseContractElement(from: $0) }
        return Contract(elements: elements)
    }
    
    public static func parseContract(from json: [[String: Any]]) throws -> String {
        let contract: Contract = try parseContract(from: json)
        return String(describing: contract)
    }
}
