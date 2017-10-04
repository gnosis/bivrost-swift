//
//  IntX.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 26.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//

import BigInt

extension Solidity {
    struct IntXBase {
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

protocol SolidityIntType: StaticType {
    static var bits: UInt { get }
    var wrapper: Solidity.IntXBase { get }
    init?(_ value: BigInt)
}

extension SolidityIntType {
    func encode() -> SolidityEncodable.EncodeFormat {
        return wrapper.encode()
    }
    
    static func decode(source: BaseDecoder.PartitionData) throws -> Self {
        guard let int = try Self.init(BaseDecoder.decodeInt(data: source.consume())) else {
            throw BivrostError.Decoder.couldNotCreateInt(source: source, bits: bits)
        }
        return int
    }
}

extension Solidity {
    public struct Int8: SolidityIntType {
        let wrapper: Solidity.IntXBase
        static var bits: UInt = 8
        
        init?(_ value: BigInt) {
            guard let wrapper = Solidity.IntXBase(bits: type(of: self).bits, bigInt: value) else {
                return nil
            }
            self.wrapper = wrapper
        }
    }
}

extension Solidity {
    public struct Int16: SolidityIntType {
        let wrapper: Solidity.IntXBase
        static var bits: UInt = 16
        
        init?(_ value: BigInt) {
            guard let wrapper = Solidity.IntXBase(bits: type(of: self).bits, bigInt: value) else {
                return nil
            }
            self.wrapper = wrapper
        }
    }
}

extension Solidity {
    public struct Int160: SolidityIntType {
        let wrapper: Solidity.IntXBase
        static var bits: UInt = 160
        
        init?(_ value: BigInt) {
            guard let wrapper = Solidity.IntXBase(bits: type(of: self).bits, bigInt: value) else {
                return nil
            }
            self.wrapper = wrapper
        }
    }
}

extension Solidity {
    public struct Int256: SolidityIntType {
        let wrapper: Solidity.IntXBase
        static var bits: UInt = 256
        
        init?(_ value: BigInt) {
            guard let wrapper = Solidity.IntXBase(bits: type(of: self).bits, bigInt: value) else {
                return nil
            }
            self.wrapper = wrapper
        }
    }
}
