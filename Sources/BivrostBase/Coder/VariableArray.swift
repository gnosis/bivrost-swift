//
//  VariableArray.swift
//  BivrostBase
//
//  Created by Luis Reisewitz on 28.09.17.
//

import BigInt

extension Solidity {
    struct VariableArray<T: SolidityEncodable>: DynamicType {
        let items: [T]
        let length: Solidity.UInt256
        
        init?(_ items: [T]) {
            guard let length = Solidity.UInt256(BigUInt(items.count)) else {
                return nil
            }
            self.items = items
            self.length = length
        }
   
        func encode() -> SolidityEncodable.EncodeFormat {
            return length.encode() + SolidityBase.encode(items)
        }
    }
}

