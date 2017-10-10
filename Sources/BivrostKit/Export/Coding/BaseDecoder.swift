//
//  BaseDecoder.swift
//  BivrostKit
//
//  Created by Luis Reisewitz on 10.10.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//
import Foundation
import BigInt

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
        let hexStringSize = String._hexStringSize(forBytes: length)
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

