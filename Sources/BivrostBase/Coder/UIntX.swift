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
        let bitWidth: UInt
        
        public init?(bits: UInt, bigUint: BigUInt) {
            guard bigUint.bitWidth <= bits else {
                return nil
            }
            value = bigUint
            bitWidth = bits
        }
        
        func encode() -> SolidityEncodable.EncodeFormat {
            return BaseEncoder.encodeUnPadded(uint: value, bitWidth: bitWidth).padToSolidity()
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
        // TODO: This could be refactored for every type (when generating types maybe)
        // Currently only used for Address encoding
        let bitWidth: UInt = 160
        private let wrapper: UIntXBase
        
        init?(_ value: BigUInt) {
            guard let wrapper = UIntXBase(bits: bitWidth, bigUint: value) else {
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
