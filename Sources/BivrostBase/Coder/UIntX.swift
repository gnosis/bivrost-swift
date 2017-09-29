//
//  UIntX.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 26.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//

import BigInt

extension Solidity {
    fileprivate class UIntXBase: StaticType {
        let value: BigUInt
        
        public init?(bits: UInt, bigUint: BigUInt) {
            guard bigUint.bitWidth <= bits else {
                return nil
            }
            value = bigUint
        }
        
        func encode() -> SolidityEncodable.EncodeFormat {
            // BigUInt returns an empty Data when serializing '0' which will be
            // turned into the empty string. Check early here to guarantee that
            // we actually return 32bytes of 0.
            guard value.signum() != 0 else {
                return "0".padToSolidity()
            }
            return value.serialize().toHexString().padToSolidity()
        }
    }
}

extension Solidity {
    public struct UInt8: StaticType {
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
}

extension Solidity {
    public struct UInt32: StaticType {
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
}

extension Solidity {
    public struct UInt128: StaticType {
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
}

extension Solidity {
    public struct UInt160: StaticType {
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
}

extension Solidity {
    public struct UInt256: StaticType {
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
