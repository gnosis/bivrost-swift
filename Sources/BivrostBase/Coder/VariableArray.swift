//
//  VariableArray.swift
//  BivrostBase
//
//  Created by Luis Reisewitz on 28.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//

import BigInt

extension Solidity {
    struct VariableArray<T: SolidityEncodable> {
        let items: [T]
        let length: Solidity.UInt256
        
        init?(_ items: [T]) {
            guard let length = Solidity.UInt256(BigUInt(items.count)) else {
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
        throw BivrostError.notImplemented
    }
    
    func encode() -> SolidityEncodable.EncodeFormat {
        return length.encode() + BaseEncoder.encode(items)
    }
}

extension Solidity.VariableArray: Equatable {
    static func ==(lhs: Solidity.VariableArray<T>, rhs: Solidity.VariableArray<T>) -> Bool {
        return false
    }
}

