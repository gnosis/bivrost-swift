//
//  Address.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 26.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//

import BigInt

extension Solidity {
    public struct Address {
        let value: Solidity.UInt160
        /// Only used for some internal calculations, do not use otherwise.
        private let bigInt: BigUInt

        init(_ address: Swift.String) throws {
            let hex = address.hasPrefix("0x") ? Swift.String(address[address.index(address.startIndex, offsetBy: 2)...]) : address
            guard let bigInt = BigUInt(hex, radix: 16) else {
                throw BivrostError.Address.invalidAddress(hex)
            }
            try self.init(bigUInt: bigInt)
        }

        init(bigUInt: BigUInt) throws {
            guard let uint = try? Solidity.UInt160(bigUInt) else {
                throw BivrostError.Address.invalidBigUInt(bigUInt)
            }
            value = uint
            self.bigInt = bigUInt
        }

        /// Returns an unpadded hex string version of the underlying number.
        /// We only pad to 40 characters = 20 bytes in case of an address that
        /// can be represented in less bytes (e.g. 0 address).
        ///
        /// - Returns: A 20 byte/40 character hex representation of the address.
        func encodeUnpadded() -> SolidityCodable.EncodeFormat {
            let bitWidth = type(of: value).bitWidth
            let paddedSize = Int(bitWidth) / 8 * 2
            return BaseEncoder
                .encodeUnPadded(uint: bigInt, bitWidth: bitWidth)
                .pad(toMultipleOf: paddedSize, character: "0", location: .left)
        }
    }
}

// MARK: - StaticType
extension Solidity.Address: StaticType {
    func encode() -> SolidityCodable.EncodeFormat {
        return value.encode()
    }

    static func decode(source: BaseDecoder.PartitionData) throws -> Solidity.Address {
        let uint = try BaseDecoder.decodeUInt(data: source.consume())
        let address = try Solidity.Address(bigUInt: uint)
        return address
    }
}

extension Solidity.Address: Equatable {
    public static func ==(lhs: Solidity.Address, rhs: Solidity.Address) -> Bool {
        return lhs.value == rhs.value
    }
}
