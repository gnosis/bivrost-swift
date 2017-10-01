//
//  Solidity.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 26.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//

import BigInt

/// Blanket Holder for Solidity Types
struct Solidity {}

protocol SolidityEncodable {
    typealias EncodeFormat = String
    func encode() -> EncodeFormat
    static var isDynamic: Swift.Bool { get }
}

/// To be used as a marker protocol as to not always have to add the `isDynamic` var.
/// Can only be used if the type is always static.
protocol StaticType: SolidityEncodable {}
extension StaticType {
    static var isDynamic: Bool {
        return false
    }
}

/// To be used as a marker protocol as to not always have to add the `isDynamic` var.
/// Can only be used if the type is always dynamic.
protocol DynamicType: SolidityEncodable {}
extension DynamicType {
    static var isDynamic: Bool {
        return true
    }
}

private extension String {
    var hexStringByteSize: Int {
        return characters.count / 2
    }
}

struct SolidityBase {
    private static let solidityLocationSizeInBytes = 32

    static func encode(_ arguments: [SolidityEncodable]) -> SolidityEncodable.EncodeFormat {
        var parts = [(data: SolidityEncodable.EncodeFormat, dynamic: Bool)]()
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
                sizeOfStaticBlockInBytes = sizeOfStaticBlockInBytes + encoded.hexStringByteSize
            }
        }
        var staticPart = ""
        var dynamicPart = ""
        parts.forEach { pair in
            if pair.dynamic {
                let location = sizeOfStaticBlockInBytes + dynamicPart.hexStringByteSize
                guard let locationUint = Solidity.UInt256(BigUInt(location)) else {
                    fatalError("SolidityBase calculated invalid location for dynamic part")
                }
                staticPart = staticPart + locationUint.encode()
                dynamicPart = dynamicPart + pair.data
            } else {
                staticPart = staticPart + pair.data
            }
        }
        
        return staticPart + dynamicPart
    }
    
    static func encode(arguments: SolidityEncodable...) -> SolidityEncodable.EncodeFormat {
        return encode(arguments)
    }
    
    static func encodeUnPadded(uint: BigUInt, bitWidth: UInt) -> SolidityEncodable.EncodeFormat {
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
