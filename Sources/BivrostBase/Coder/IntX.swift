//
//  IntX.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 26.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//

import BigInt

extension Solidity {
    fileprivate class IntXBase: StaticType {
        let value: BigInt
        
        public init?(bits: UInt, bigInt: BigInt) {
            guard bigInt.bitWidth <= bits else {
                return nil
            }
            value = bigInt
        }
        
        func encode() -> SolidityEncodable.EncodeFormat {
            // BigInt returns an empty Data when serializing '0' which will be
            // turned into the empty string. Check early here to guarantee that
            // we actually return 32bytes of 0.
            guard value.signum() != 0 else {
                return "0".padToSolidity()
            }
            let padCharacter: Character = value.sign == .plus ? "0" : "F"
            return value.serialize().toHexString().padToSolidity(character: padCharacter).lowercased()
        }
    }
}

extension Solidity {
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
}

extension Solidity {
    public struct Int160: StaticType {
        private let wrapper: IntXBase
        
        init?(_ value: BigInt) {
            guard let wrapper = IntXBase(bits: 160, bigInt: value) else {
                return nil
            }
            self.wrapper = wrapper
        }
        
        func encode() -> SolidityEncodable.EncodeFormat {
            return wrapper.encode()
        }
    }
}

extension Solidity {
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
