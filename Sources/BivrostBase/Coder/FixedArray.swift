//
//  FixedArray.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 26.09.17.
//

extension Solidity {
    struct FixedArray<T: SolidityEncodable>: SolidityEncodable {
        static var isDynamic: Swift.Bool {
            // TODO: For a correct isDynamic response this should look at the
            // allocated capacity for the (generated?) SolidityArray. e.g. bytes[0] is always static.
            return T.isDynamic
        }
        
        let items: [T]
        // FIXME: This does not check length of the array
        func encode() -> SolidityEncodable.EncodeFormat {
            return SolidityBase.encode(items)
        }
    }
}
