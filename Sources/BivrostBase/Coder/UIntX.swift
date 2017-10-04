//
//  UIntX.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 26.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//

import BigInt

extension Solidity {
    class UIntXBase {
        let value: BigUInt
        let bitWidth: UInt
        
        public init?(bits: UInt, bigUint: BigUInt) {
            guard bigUint.bitWidth <= bits else {
                return nil
            }
            value = bigUint
            bitWidth = bits
        }
        
        func encode() -> SolidityCodable.EncodeFormat {
            return BaseEncoder.encodeUnPadded(uint: value, bitWidth: bitWidth).padToSolidity()
        }
    }
}

extension Solidity.UIntXBase: Equatable {
    public static func ==(lhs: Solidity.UIntXBase, rhs: Solidity.UIntXBase) -> Bool {
        return lhs.bitWidth == rhs.bitWidth && lhs.value == rhs.value
    }
}

protocol SolidityUIntType: StaticType, Equatable {
    static var bits: UInt { get }
    var wrapper: Solidity.UIntXBase { get }
    init?(_ value: BigUInt)
}

extension SolidityUIntType {
    func encode() -> SolidityCodable.EncodeFormat {
        return wrapper.encode()
    }
    
    static func decode(source: BaseDecoder.PartitionData) throws -> Self {
        guard let uint = try Self.init(BaseDecoder.decodeUInt(data: source.consume())) else {
            throw BivrostError.Decoder.couldNotCreateUInt(source: source, bits: bits)
        }
        return uint
    }
}

extension SolidityUIntType {
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.wrapper == rhs.wrapper
    }
}

extension Solidity {
    public struct UInt8: SolidityUIntType {
        let wrapper: UIntXBase
        static var bits: UInt = 8
        
        public init?(_ value: BigUInt) {
            guard let wrapper = UIntXBase(bits: type(of: self).bits, bigUint: value) else {
                return nil
            }
            self.wrapper = wrapper
        }
    }
}

extension Solidity {
    public struct UInt32: SolidityUIntType {
        let wrapper: UIntXBase
        static var bits: UInt = 32
        
        public init?(_ value: BigUInt) {
            guard let wrapper = UIntXBase(bits: type(of: self).bits, bigUint: value) else {
                return nil
            }
            self.wrapper = wrapper
        }
    }
}

extension Solidity {
    public struct UInt128: SolidityUIntType {
        let wrapper: UIntXBase
        static var bits: UInt = 128
        
        public init?(_ value: BigUInt) {
            guard let wrapper = UIntXBase(bits: type(of: self).bits, bigUint: value) else {
                return nil
            }
            self.wrapper = wrapper
        }
    }
}

extension Solidity {
    public struct UInt160: SolidityUIntType {
        let wrapper: UIntXBase
        static var bits: UInt = 160
        
        public init?(_ value: BigUInt) {
            guard let wrapper = UIntXBase(bits: type(of: self).bits, bigUint: value) else {
                return nil
            }
            self.wrapper = wrapper
        }
    }
}

extension Solidity {
    public struct UInt256: SolidityUIntType {
        let wrapper: UIntXBase
        static var bits: UInt = 256
        
        public init?(_ value: BigUInt) {
            guard let wrapper = UIntXBase(bits: type(of: self).bits, bigUint: value) else {
                return nil
            }
            self.wrapper = wrapper
        }
    }
}
