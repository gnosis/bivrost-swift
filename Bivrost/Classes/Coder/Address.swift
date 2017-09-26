//
//  Address.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 26.09.17.
//

import BigInt

extension Solidity {
    public struct Address: SolidityEncodable {
        let value: Solidity.UInt160
        func encode() -> SolidityEncodable.EncodeFormat {
            return value.encode()
        }
        
        init?(_ address: String) {
            let hex = address.hasPrefix("0x") ? String(address[address.index(address.startIndex, offsetBy: 2)...]) : address
            guard let bigInt = BigUInt(hex, radix: 16),
                let uint = Solidity.UInt160(bigInt) else {
                    return nil
            }
            value = uint
        }
    }
}
