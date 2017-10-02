//
//  Solidity.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 26.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//

import BigInt
import Foundation

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
    
    static func hexStringSize(forBytes: Int) -> Int {
        return forBytes * 2
    }
}

struct BaseEncoder {
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

struct BaseDecoder {
    static func partitionData(inHex string: String) -> [String] {
        return string.splitSolidityLines()
    }
    
    static func decodeUInt(data: String) throws -> BigUInt {
        guard let bigUInt = BigUInt(data, radix: 16) else {
            throw BivrostError.invalidUInt(hex: data)
        }
        return bigUInt
    }
    
    static func decodeBool(data: String) throws -> Bool {
        guard let bigUInt = BigUInt(data, radix: 16) else {
            throw BivrostError.invalidUInt(hex: data)
        }
        switch bigUInt {
        case BigUInt(0):
            return false
        case BigUInt(1):
            return true
        default:
            throw BivrostError.invalidBool(hex: data)
        }
    }
    
    static func decodeInt(data: String) throws -> BigInt {
        guard let bigInt = BigInt(twosComplementHex: data) else {
            throw BivrostError.invalidInt(hex: data)
        }
        return bigInt
    }
    
    static func decodeBytesX(data: String, length: Int) throws -> Data {
        let hexStringSize = String.hexStringSize(forBytes: length)
        let endIndex = data.index(data.startIndex, offsetBy: hexStringSize)
        let hexPartition = String(data[data.startIndex..<endIndex])
        guard let byteData = Data(fromHexEncodedString: hexPartition),
            byteData.count == length else {
                throw BivrostError.invalidBytesX(hex: data, capacity: length)
        }
        return byteData
    }
    
    static func decodeBytes(source: PartitionData) throws -> Data {
        let sizePart = source.consume()
        guard let size = Int(sizePart, radix: 16) else {
            throw BivrostError.invalidBytesLength(hex: sizePart)
        }
        
        var byteHolder = Data()
        while byteHolder.count < size {
            if let data = Data(fromHexEncodedString: source.consume()){
                byteHolder.append(data)
            }
        }
        return byteHolder.prefix(upTo: size)
    }
    
    static func decodeString(source: PartitionData) throws -> String {
        let data = try decodeBytes(source: source)
        guard let string = String(data: data, encoding: .utf8) else {
            throw BivrostError.invalidStringEncoding(data: data)
        }
        return string
    }
}

extension BaseDecoder {
    class PartitionData {
        let lines: [String]
        init(_ lines: [String]) {
            self.lines = lines
        }
        
        convenience init(data: String) {
            let lines = BaseDecoder.partitionData(inHex: data)
            self.init(lines)
        }
        
        var index: Int = 0
        
        func consume() -> String {
            let returnValue = lines[index]
            index = index + 1
            return returnValue
        }
        
        func reset() {
            index = 0
        }
    }
}
