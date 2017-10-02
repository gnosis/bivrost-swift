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
        private let bigInt: BigUInt
        
        init?(_ address: Swift.String) {
            let hex = address.hasPrefix("0x") ? Swift.String(address[address.index(address.startIndex, offsetBy: 2)...]) : address
            guard let bigInt = BigUInt(hex, radix: 16),
                let uint = Solidity.UInt160(bigInt) else {
                    return nil
            }
            value = uint
            self.bigInt = bigInt
        }
        
        /// Returns an unpadded hex string version of the underlying number.
        /// We only pad to 40 characters = 20 bytes in case of an address that
        /// can be represented in less bytes (e.g. 0 address).
        ///
        /// - Returns: A 20 byte/40 character hex representation of the address.
        func encodeUnpadded() -> SolidityEncodable.EncodeFormat {
            let paddedSize = Int(value.bitWidth) / 8 * 2
            return BaseEncoder
                .encodeUnPadded(uint: bigInt, bitWidth: value.bitWidth)
                .pad(toMultipleOf: paddedSize, character: "0", location: .left)
        }
    }
}

// MARK: - StaticType
extension Solidity.Address: StaticType {
    func encode() -> SolidityEncodable.EncodeFormat {
        return value.encode()
    }
}
