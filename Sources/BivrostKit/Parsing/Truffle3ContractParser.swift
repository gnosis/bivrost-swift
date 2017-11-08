//
//  Truffle3ContractParser.swift
//  BivrostKit
//
//  Created by Luis Reisewitz on 08.11.17.
//

struct Truffle3ContractParser: ContractParser {
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
            throw ParsingError.contractNameInvalid
        }
        guard let elementsJson = json[.abi] as? [[String: Any]] else {
            throw ParsingError.contractAbiInvalid
        }

        let elements = try elementsJson.map { try ElementJsonParser.parseContractElement(from: $0) }
        return Contract(name: name, elements: elements)
    }
}
