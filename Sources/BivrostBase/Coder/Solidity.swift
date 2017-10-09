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
public struct Solidity {}
/// Blanket holder for Abstract Solidity Types.
public struct _DoNotUse {}

// FIXME: Rename to something more appropriate
protocol SolidityCodable {
    typealias EncodeFormat = String
    static var isDynamic: Swift.Bool { get }
    
    func encode() -> EncodeFormat
    static func decode(source: BaseDecoder.PartitionData) throws -> Self
}

/// To be used as a marker protocol as to not always have to add the `isDynamic` var.
/// Can only be used if the type is always static.
protocol StaticType: SolidityCodable {}
extension StaticType {
    static var isDynamic: Bool {
        return false
    }
}

/// To be used as a marker protocol as to not always have to add the `isDynamic` var.
/// Can only be used if the type is always dynamic.
protocol DynamicType: SolidityCodable {}
extension DynamicType {
    static var isDynamic: Bool {
        return true
    }
}

private extension String {
    var hexStringByteSize: Int {
        return characters.count / 2
    }
    
    static func hexStringSize(forBytes: UInt) -> UInt {
        return forBytes * 2
    }
}

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
                sizeOfStaticBlockInBytes = sizeOfStaticBlockInBytes + encoded.hexStringByteSize
            }
        }
        var staticPart = ""
        var dynamicPart = ""
        parts.forEach { pair in
            if pair.dynamic {
                let location = sizeOfStaticBlockInBytes + dynamicPart.hexStringByteSize
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

struct BaseDecoder {
    static func partitionData(inHex string: SolidityCodable.EncodeFormat) -> [SolidityCodable.EncodeFormat] {
        return string.splitSolidityLines()
    }
    
    static func decodeUInt(data: SolidityCodable.EncodeFormat) throws -> BigUInt {
        guard let bigUInt = BigUInt(data, radix: 16) else {
            throw BivrostError.Decoder.invalidUInt(hex: data)
        }
        return bigUInt
    }
    
    static func decodeBool(data: SolidityCodable.EncodeFormat) throws -> Bool {
        guard let bigUInt = BigUInt(data, radix: 16) else {
            throw BivrostError.Decoder.invalidUInt(hex: data)
        }
        switch bigUInt {
        case BigUInt(0):
            return false
        case BigUInt(1):
            return true
        default:
            throw BivrostError.Decoder.invalidBool(hex: data)
        }
    }
    
    static func decodeInt(data: SolidityCodable.EncodeFormat) throws -> BigInt {
        guard let bigInt = BigInt(twosComplementHex: data) else {
            throw BivrostError.Decoder.invalidInt(hex: data)
        }
        return bigInt
    }
    
    static func decodeBytesX(data: SolidityCodable.EncodeFormat, length: UInt) throws -> Data {
        let hexStringSize = String.hexStringSize(forBytes: length)
        let endIndex = data.index(data.startIndex, offsetBy: Int(hexStringSize))
        let hexPartition = String(data[data.startIndex..<endIndex])
        guard let byteData = Data(fromHexEncodedString: hexPartition),
            byteData.count == length else {
                throw BivrostError.Decoder.invalidBytesX(hex: data, capacity: length)
        }
        return byteData
    }
    
    static func decodeBytes(source: PartitionData) throws -> Data {
        let sizePart = source.consume()
        guard let size = Int(sizePart, radix: 16) else {
            throw BivrostError.Decoder.invalidBytesLength(hex: sizePart)
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
            throw BivrostError.Decoder.invalidStringEncoding(data: data)
        }
        return string
    }
    
    static func decodeArray<T>(data: SolidityCodable.EncodeFormat, decoder: (SolidityCodable.EncodeFormat) throws -> T) throws -> [T] {
        let lines = partitionData(inHex: data)
        let sizePart = lines[0]
        guard let size = Int(sizePart, radix: 16),
            size == lines.count - 1 else {
            throw BivrostError.Decoder.invalidArrayLength(hex: sizePart)
        }
        guard size != 0 else {
            return []
        }
        return try (1..<lines.count).map { try decoder(lines[$0]) }
    }
    
    static func decodeArray<T: SolidityCodable>(source: PartitionData, capacity: UInt, decoder: (PartitionData) throws -> T) throws -> [T] {
        guard capacity != 0 else {
            return []
        }
        guard T.isDynamic else {
            // Static parameter case is easy, just use all the data instantly
            return try (0..<capacity).map { _ in try decoder(source) }
        }
        // We have dynamic types, we need to check the dynamic array
        // Consume all locations to jump cursor ahead to dynamic section
        (0..<capacity).forEach { _ in _ = source.consume() }
        return try (0..<capacity).map { _ in try decoder(source) }
    }
}

extension BaseDecoder {
    class PartitionData {
        let lines: [SolidityCodable.EncodeFormat]
        init(_ lines: [SolidityCodable.EncodeFormat]) {
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
