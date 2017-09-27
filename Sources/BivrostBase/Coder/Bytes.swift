//
//  Bytes.swift
//  BivrostBase
//
//  Created by Luis Reisewitz on 27.09.17.
//

import Foundation
import BigInt

extension Solidity {
    public struct Bytes: DynamicType {
        let value: Data
        let length: UInt256
        
        init?(_ value: Data) {
            guard let length = Solidity.UInt256(BigUInt(value.count)) else {
                return nil
            }
            self.value = value
            self.length = length
        }
        
        func head() -> SolidityEncodable.EncodeFormat {
            // FIXME: implement
            return ""
        }
        
        func encode() -> SolidityEncodable.EncodeFormat {
            return length.encode() + value.toHexString().padToSolidity(location: .right)
        }
    }
}
