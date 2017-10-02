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
    func encode() -> SolidityEncodable.EncodeFormat {
        return length.encode() + BaseEncoder.encode(items)
    }
}
