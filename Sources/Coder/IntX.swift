//
//  IntX.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 26.09.17.
//

import BigInt

extension Solidity {
    class IntXBase: StaticType {
        let value: BigInt
        
        public init?(bits: UInt, bigInt: BigInt) {
            guard bigInt.bitWidth <= bits else {
                return nil
            }
            value = bigInt
        }
        
        func encode() -> SolidityEncodable.EncodeFormat {
            let padCharacter: Character = value.sign == .plus ? "0" : "F"
            return value.serialize().toHexString().padToSolidity(character: padCharacter).lowercased()
        }
    }
    
    public struct Int8: StaticType {
        private let wrapper: IntXBase
        
        init?(_ value: BigInt) {
            guard let wrapper = IntXBase(bits: 8, bigInt: value) else {
                return nil
            }
            self.wrapper = wrapper
        }
        
        func encode() -> SolidityEncodable.EncodeFormat {
            return wrapper.encode()
        }
    }
    
    public struct Int256: StaticType {
        private let wrapper: IntXBase
        
        init?(_ value: BigInt) {
            guard let wrapper = IntXBase(bits: 256, bigInt: value) else {
                return nil
            }
            self.wrapper = wrapper
        }
        
        func encode() -> SolidityEncodable.EncodeFormat {
            return wrapper.encode()
        }
    }
}
