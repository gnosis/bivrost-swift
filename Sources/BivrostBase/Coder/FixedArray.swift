//
//  FixedArray.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 26.09.17.
//

extension Solidity {
    struct FixedArray<T: StaticType>: StaticType {
        let items: [T]
        // FIXME: This does not check length of the array
        func encode() -> SolidityEncodable.EncodeFormat {
            // FIXME: This only works for static types, fix when using dynamic types.
            return items.lazy.map { $0.encode() }.reduce("", +)
        }
    }
}
