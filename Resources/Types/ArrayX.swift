//
//  ArrayX.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 26.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//

/// Base type for fixed-length Solidity.Arrays. Do not use directly.
extension _DoNotUse {
    // swiftlint:disable:next type_name
    class _ArrayX<T: SolidityCodable & Equatable> {
        private let items: [T]
        class var length: UInt {
            fatalError("Not meant to be called directly.")
        }
        
        required init(_ items: [T]) throws {
            let expectedLength = type(of: self).length
            guard items.count == expectedLength else {
                throw BivrostError.ArrayX.itemCountMismatch(expected: expectedLength, actual: UInt(items.count))
            }
            self.items = items
        }
    }
}

// MARK: - SolidityCodable
extension _DoNotUse._ArrayX: SolidityCodable {
    static var isDynamic: Swift.Bool {
        guard length != 0 else {
            return false
        }
        return T.isDynamic
    }
    
    func encode() -> SolidityCodable.EncodeFormat {
        return BaseEncoder.encode(items)
    }
    
    static func decode(source: BaseDecoder.PartitionData) throws -> Self {
        return try self.init(BaseDecoder.decodeArray(source: source, capacity: length, decoder: T.decode))
    }
}

// MARK: - Equatable
extension _DoNotUse._ArrayX: Equatable {
    static func ==(lhs: _DoNotUse._ArrayX<T>, rhs: _DoNotUse._ArrayX<T>) -> Bool {
        guard type(of: lhs).length == type(of: lhs).length,
            lhs.items.count == rhs.items.count else {
                return false
        }
        return lhs.items == rhs.items
    }
}
