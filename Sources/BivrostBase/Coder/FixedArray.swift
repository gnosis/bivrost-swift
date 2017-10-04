//
//  FixedArray.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 26.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//

extension Solidity {
    struct FixedArray<T: SolidityEncodable> {
        let items: [T]
        
        init(_ items: [T]) {
            self.items = items
        }
    }
}

extension Solidity.FixedArray: SolidityEncodable {
    static func decode(source: BaseDecoder.PartitionData) throws -> Solidity.FixedArray<T> {
        throw BivrostError.notImplemented
    }
    
    static var isDynamic: Swift.Bool {
        // TODO: For a correct isDynamic response this should look at the
        // allocated capacity for the (generated?) SolidityArray. e.g. bytes[0] is always static.
        return T.isDynamic
    }
    
    // FIXME: This does not check length of the array
    func encode() -> SolidityEncodable.EncodeFormat {
        return BaseEncoder.encode(items)
    }
}
