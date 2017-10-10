//
//  VariableArray.swift
//  BivrostKit
//
//  Created by Luis Reisewitz on 28.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//

import BigInt

extension Solidity {
    struct VariableArray<T: SolidityCodable & Equatable> {
        let items: [T]
        let length: Solidity.UInt256
        
        init?(_ items: [T]) {
            guard let length = try? Solidity.UInt256(BigUInt(items.count)) else {
                return nil
            }
            self.items = items
            self.length = length
        }
    }
}

// MARK: - DynamicType
extension Solidity.VariableArray: DynamicType {
    static func decode(source: BaseDecoder.PartitionData) throws -> Solidity.VariableArray<T> {
        let sizePart = source.consume()
        guard let size = UInt(sizePart, radix: 16) else {
            throw BivrostError.Decoder.invalidArrayLength(hex: sizePart)
        }
        let items = try BaseDecoder.decodeArray(source: source, capacity: size, decoder: T.decode)
        guard let array = Solidity.VariableArray(items) else {
            throw BivrostError.Decoder.couldNotCreateVariableArray(source: source)
        }
        return array
    }
    
    func encode() -> SolidityCodable.EncodeFormat {
        return length.encode() + BaseEncoder.encode(items)
    }
}

extension Solidity.VariableArray: Equatable {
    static func ==(lhs: Solidity.VariableArray<T>, rhs: Solidity.VariableArray<T>) -> Bool {
        return lhs.length == rhs.length && lhs.items == rhs.items
    }
}
