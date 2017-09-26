//
//  UInt.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 26.09.17.
//

import BigInt

extension Solidity {
    class UIntXBase: SolidityEncodable {
        let value: BigUInt
        
        public init?(bits: UInt, bigUint: BigUInt) {
            guard bigUint.bitWidth <= bits else {
                return nil
            }
            value = bigUint
        }
        
        func encode() -> SolidityEncodable.EncodeFormat {
            return value.serialize().toHexString().padToSolidity()
        }
    }
    
    public struct UInt8: SolidityEncodable {
        private let wrapper: UIntXBase
        
        init?(_ value: BigUInt) {
            guard let wrapper = UIntXBase(bits: 8, bigUint: value) else {
                return nil
            }
            self.wrapper = wrapper
        }
        
        func encode() -> SolidityEncodable.EncodeFormat {
            return wrapper.encode()
        }
    }
    
    public struct UInt32: SolidityEncodable {
        private let wrapper: UIntXBase
        
        init?(_ value: BigUInt) {
            guard let wrapper = UIntXBase(bits: 32, bigUint: value) else {
                return nil
            }
            self.wrapper = wrapper
        }
        
        func encode() -> SolidityEncodable.EncodeFormat {
            return wrapper.encode()
        }
    }
    
    public struct UInt128: SolidityEncodable {
        private let wrapper: UIntXBase
        
        init?(_ value: BigUInt) {
            guard let wrapper = UIntXBase(bits: 128, bigUint: value) else {
                return nil
            }
            self.wrapper = wrapper
        }
        
        func encode() -> SolidityEncodable.EncodeFormat {
            return wrapper.encode()
        }
    }
    
    public struct UInt160: SolidityEncodable {
        private let wrapper: UIntXBase
        
        init?(_ value: BigUInt) {
            guard let wrapper = UIntXBase(bits: 160, bigUint: value) else {
                return nil
            }
            self.wrapper = wrapper
        }
        
        func encode() -> SolidityEncodable.EncodeFormat {
            return wrapper.encode()
        }
    }
    
    public struct UInt256: SolidityEncodable {
        private let wrapper: UIntXBase
        
        init?(_ value: BigUInt) {
            guard let wrapper = UIntXBase(bits: 256, bigUint: value) else {
                return nil
            }
            self.wrapper = wrapper
        }
        
        func encode() -> SolidityEncodable.EncodeFormat {
            return wrapper.encode()
        }
    }
}
