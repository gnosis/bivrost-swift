//
//  Bytes.swift
//  BivrostBase
//
//  Created by Luis Reisewitz on 27.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//

import Foundation
import BigInt

extension Solidity {
    public struct Bytes {
        let value: Data
        let length: UInt256
        
        init?(_ value: Data) {
            guard let length = Solidity.UInt256(BigUInt(value.count)) else {
                return nil
            }
            self.value = value
            self.length = length
        }
    }
}

// MARK: - DynamicType
extension Solidity.Bytes: DynamicType {
    static func decode(source: BaseDecoder.PartitionData) throws -> Solidity.Bytes {
        guard let bytes = try Solidity.Bytes(BaseDecoder.decodeBytes(source: source)) else {
            throw BivrostError.Decoder.couldNotCreateBytes(source: source)
        }
        return bytes
    }
    
    func encode() -> SolidityCodable.EncodeFormat {
        return length.encode() + value.toHexString().padToSolidity(location: .right)
    }
}

extension Solidity.Bytes: Equatable {
    public static func ==(lhs: Solidity.Bytes, rhs: Solidity.Bytes) -> Bool {
        return lhs.length == rhs.length && lhs.value == rhs.value
    }
}
