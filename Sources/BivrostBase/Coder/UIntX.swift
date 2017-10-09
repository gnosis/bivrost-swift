//
//  UIntX.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 26.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//

import BigInt

// MARK: - _UIntX
extension _DoNotUse {
    public class _UIntX {
        /// Content of the UInt
        let value: BigUInt
        /// Specifies how wide this uint is
        class var bitWidth: UInt {
            fatalError("_UIntX.bitWidth needs to be overridden.")
        }
        
        required public init(_ uint: BigUInt) throws {
            let bits = type(of: self).bitWidth
            guard uint.bitWidth <= bits else {
                throw BivrostError.UIntX.bitWidthMismatch(max: bits, actual: UInt(uint.bitWidth))
            }
            value = uint
        }
    }
}

// MARK: - SolidityCodable
extension _DoNotUse._UIntX: StaticType {
    func encode() -> SolidityCodable.EncodeFormat {
        guard value.bitWidth <= type(of: self).bitWidth else {
            fatalError("_UIntX somehow created with value that does not fit into \(type(of: self).bitWidth) bits.")
        }
        return BaseEncoder.encodeUnPadded(uint: value, bitWidth: type(of: self).bitWidth).padToSolidity()
    }
    
    static func decode(source: BaseDecoder.PartitionData) throws -> Self {
        guard let uint = try? self.init(BaseDecoder.decodeUInt(data: source.consume())) else {
            throw BivrostError.Decoder.couldNotCreateUInt(source: source, bits: bitWidth)
        }
        return uint
    }
}

// MARK: - Equatable
extension _DoNotUse._UIntX: Equatable {
    public static func ==(lhs: _DoNotUse._UIntX, rhs: _DoNotUse._UIntX) -> Bool {
        guard type(of: lhs).bitWidth == type(of: rhs).bitWidth else {
            return false
        }
        return lhs.value == rhs.value
    }
}

// MARK: - Reference Types
extension Solidity {
    public final class UInt8: _DoNotUse._UIntX {
        override class var bitWidth: UInt {
            return 8
        }
    }
    public final class UInt32: _DoNotUse._UIntX {
        override class var bitWidth: UInt {
            return 32
        }
    }
    public final class UInt160: _DoNotUse._UIntX {
        override class var bitWidth: UInt {
            return 160
        }
    }
    public final class UInt256: _DoNotUse._UIntX {
        override class var bitWidth: UInt {
            return 256
        }
    }
}
