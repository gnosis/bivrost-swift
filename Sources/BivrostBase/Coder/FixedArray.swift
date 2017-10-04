//
//  FixedArray.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 26.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//

extension Solidity {
    struct FixedArray<T: SolidityCodable & Equatable> {
        let items: [T]
        
        init(_ items: [T]) {
            self.items = items
        }
    }
}

extension Solidity.FixedArray: SolidityCodable {
    static func decode(source: BaseDecoder.PartitionData) throws -> Solidity.FixedArray<T> {
        // FIXME: we need length of the array here
        throw BivrostError.notImplemented
    }
    
    static var isDynamic: Swift.Bool {
        // TODO: For a correct isDynamic response this should look at the
        // allocated capacity for the (generated?) SolidityArray. e.g. bytes[0] is always static.
        return T.isDynamic
    }
    
    // FIXME: This does not check length of the array
    func encode() -> SolidityCodable.EncodeFormat {
        return BaseEncoder.encode(items)
    }
}

extension Solidity.FixedArray: Equatable {
    static func ==(lhs: Solidity.FixedArray<T>, rhs: Solidity.FixedArray<T>) -> Bool {
        guard lhs.items.count == rhs.items.count else {
            return false
        }
        return lhs.items == rhs.items
    }
}
