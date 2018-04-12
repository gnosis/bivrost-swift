//
//  Function.swift
//  BivrostPackageDescription
//
//  Created by Luis Reisewitz on 01.10.17.
//  Copyright © 2017 Gnosis Ltd. All rights reserved.
//

extension Solidity {
    struct Function {
        let address: Address
        let functionSelector: Swift.String

        /// Represents a function to be called on any contract. Function selector
        /// has to be passed as a hex string with exactly 8 characters (4 bytes).
        /// Refer to https://github.com/ethereum/wiki/wiki/Ethereum-Contract-ABI#function-selector
        /// for information on how to create one.
        ///
        /// - Parameters:
        ///   - functionSelector: The encoded function selector.
        ///     4 Bytes/8 Characters. Example: 095ea7b3
        ///   - address: The address of the contract to be called.
        init(_ functionSelector: Swift.String, at address: Address) throws {
            guard functionSelector.characters.count == 8 else {
                throw BivrostError.Function.invalidFunctionSelector(functionSelector)
            }
            self.address = address
            self.functionSelector = functionSelector
        }
    }
}

// MARK: - StaticType
extension Solidity.Function: StaticType {
    func encode() -> SolidityCodable.EncodeFormat {
        // Address string padded to 20 bytes
        let addressHex = address.encodeUnpadded()

        let unPaddedString = addressHex + functionSelector
        return unPaddedString.padToSolidity(location: .right)
    }

    static func decode(source: BaseDecoder.PartitionData) throws -> Solidity.Function {
        let line = try source.consume()
        // 20 bytes / 40 chars for Address as UInt160
        let addressHex = String(line[line.startIndex ..< line.index(startDistance: 40)])
        let uint = try BaseDecoder.decodeUInt(data: addressHex)
        let address = try Solidity.Address(bigUInt: uint)
        let functionSelector = String(line[line.index(startDistance: 40) ..< line.index(startDistance: 48)])
        return try Solidity.Function(functionSelector, at: address)
    }
}

//// it("should encode correctly") {
//let testAddress = Solidity.Address("0xFF")!
//let functionSelector = "095ea7b3"
//// Address encoded as 20 bytes, then 4 bytes function selector,
//// then padding to 32 bytes on the right
//let testString = "00000000000000000000000000000000000000ff\(functionSelector)0000000000000000"
//expect(Solidity.Function(functionSelector, at: testAddress)?.encode()) == testString
//}

extension Solidity.Function: Equatable {
    static func == (lhs: Solidity.Function, rhs: Solidity.Function) -> Bool {
        return lhs.address == rhs.address && lhs.functionSelector == rhs.functionSelector
    }
}
