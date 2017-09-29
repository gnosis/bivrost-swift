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
        
        init?(_ address: Swift.String) {
            let hex = address.hasPrefix("0x") ? Swift.String(address[address.index(address.startIndex, offsetBy: 2)...]) : address
            guard let bigInt = BigUInt(hex, radix: 16),
                let uint = Solidity.UInt160(bigInt) else {
                    return nil
            }
            value = uint
        }
    }
}

// MARK: - StaticType
extension Solidity.Address: StaticType {
    func encode() -> SolidityEncodable.EncodeFormat {
        return value.encode()
    }
}
