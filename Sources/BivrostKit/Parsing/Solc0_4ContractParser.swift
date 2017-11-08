//
//  Solc0_4ContractParser.swift
//  BivrostKit
//
//  Created by Luis Reisewitz on 08.11.17.
//

struct Solc0_4ContractParser: ContractParser {
    static func parseContract(from json: JsonDict) throws -> Contract {
//        guard let contractsDict = json[.contracts] as? JsonDict else {
//            throw ParsingError.contractsDictInvalid
//        }

        // FIXME: Solc0.4 combined json includes multiple contracts in one file.
        // FIXME: This is not compatible with our current architecture of input files.
        // FIXME: maybe switch to two separate bivrost commands for solc & truffle.

        fatalError("")
    }
}
