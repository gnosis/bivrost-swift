//
//  VariableArray.swift
//  BivrostBase
//
//  Created by Luis Reisewitz on 28.09.17.
//

import BigInt

extension Solidity {
    struct VariableArray<T: StaticType>: DynamicType {
        let value: [T]
        let length: Solidity.UInt256
        
        func head() -> SolidityEncodable.EncodeFormat {
            // FIXME: implement
            return ""
        }
        
        init?(_ value: [T]) {
            guard let length = Solidity.UInt256(BigUInt(value.count)) else {
                return nil
            }
            self.value = value
            self.length = length
        }
   
        func encode() -> SolidityEncodable.EncodeFormat {
            // FIXME: This only works for static types, fix when using dynamic types.
            let dataPart = value.lazy.map { $0.encode() }.reduce("", +)
            return length.encode() + dataPart.padToSolidity(location: .right)
        }
    }
}

