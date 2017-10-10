//
//  IntX.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 26.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//

import BigInt

// MARK: - _UIntX
extension _DoNotUse {
    public class _IntX {
        /// Content of the Int
        let value: BigInt
        /// Specifies how wide this int is
        class var bitWidth: UInt {
            fatalError("_IntX.bitWidth needs to be overridden.")
        }
        
        required public init(_ int: BigInt) throws {
            let bits = type(of: self).bitWidth
            guard int.bitWidth <= bits else {
                throw BivrostError.IntX.bitWidthMismatch(max: bits, actual: UInt(int.bitWidth))
            }
            value = int
        }
    }
}

// MARK: - SolidityCodable
extension _DoNotUse._IntX: StaticType {
    func encode() -> SolidityCodable.EncodeFormat {
        guard value.bitWidth <= type(of: self).bitWidth else {
            fatalError("_IntX somehow created with value that does not fit into \(type(of: self).bitWidth) bits.")
        }
        // BigInt returns an empty Data when serializing '0' which will be
        // turned into the empty string. Check early here to guarantee that
        // we actually return 32bytes of 0.
        guard value.signum() != 0 else {
            return "0".padToSolidity()
        }
        let padCharacter: Character = value.sign == .plus ? "0" : "F"
        return value.serialize().toHexString().padToSolidity(character: padCharacter).lowercased()
    }
    
    static func decode(source: BaseDecoder.PartitionData) throws -> Self {
        guard let int = try? self.init(BaseDecoder.decodeInt(data: source.consume())) else {
            throw BivrostError.Decoder.couldNotCreateInt(source: source, bits: bitWidth)
        }
        return int
    }
}

// MARK: - Equatable
extension _DoNotUse._IntX: Equatable {
    public static func ==(lhs: _DoNotUse._IntX, rhs: _DoNotUse._IntX) -> Bool {
        guard type(of: lhs).bitWidth == type(of: rhs).bitWidth else {
            return false
        }
        return lhs.value == rhs.value
    }
}

// MARK: - Reference Types
extension Solidity {
    // TODO: Manual subclasses, can be removed later.
    public final class Int8: _DoNotUse._IntX {
        override class var bitWidth: UInt {
            return 8
        }
    }
    public final class Int32: _DoNotUse._IntX {
        override class var bitWidth: UInt {
            return 32
        }
    }
    public final class Int160: _DoNotUse._IntX {
        override class var bitWidth: UInt {
            return 160
        }
    }
    public final class Int256: _DoNotUse._IntX {
        override class var bitWidth: UInt {
            return 256
        }
    }
}
