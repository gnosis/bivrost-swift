//
//  BaseEncoder.swift
//  BivrostKit
//
//  Created by Luis Reisewitz on 10.10.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//

import Foundation
import BigInt

struct BaseEncoder {
    private static let solidityLocationSizeInBytes = 32
    
    static func encode(_ arguments: [SolidityCodable]) -> SolidityCodable.EncodeFormat {
        var parts = [(data: SolidityCodable.EncodeFormat, dynamic: Bool)]()
        var sizeOfStaticBlockInBytes = 0
        
        arguments.forEach {
            let encoded = $0.encode()
            if type(of: $0).isDynamic {
                parts.append((data: encoded, dynamic: true))
                // Add length of location entry to static block
                sizeOfStaticBlockInBytes = sizeOfStaticBlockInBytes + solidityLocationSizeInBytes
            } else {
                parts.append((data: encoded, dynamic: false))
                // Add byte size (hexString / 2)
                sizeOfStaticBlockInBytes = sizeOfStaticBlockInBytes + encoded._hexStringByteSize
            }
        }
        var staticPart = ""
        var dynamicPart = ""
        parts.forEach { pair in
            if pair.dynamic {
                let location = sizeOfStaticBlockInBytes + dynamicPart._hexStringByteSize
                guard let locationUint = try? Solidity.UInt256(BigUInt(location)) else {
                    fatalError("BaseEncoder calculated invalid location for dynamic part. This should not happen.")
                }
                staticPart = staticPart + locationUint.encode()
                dynamicPart = dynamicPart + pair.data
            } else {
                staticPart = staticPart + pair.data
            }
        }
        
        return staticPart + dynamicPart
    }
    
    static func encode(arguments: SolidityCodable...) -> SolidityCodable.EncodeFormat {
        return encode(arguments)
    }
    
    static func encodeUnPadded(uint: BigUInt, bitWidth: UInt) -> SolidityCodable.EncodeFormat {
        guard uint.bitWidth <= bitWidth else {
            fatalError("\(#function) called with UInt \(uint) that is too big for bit width \(bitWidth).")
        }
        // BigUInt returns an empty Data when serializing '0' which will be
        // turned into the empty string. Check early here to guarantee that
        // we actually return 0.
        guard uint.signum() != 0 else {
            return "0"
        }
        return uint.serialize().toHexString()
    }
}
