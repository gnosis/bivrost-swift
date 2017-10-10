//
//  BytesX.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 26.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//
import Foundation

// MARK: - _BytesX
extension _DoNotUse {
    public class _BytesX {
        class var length: UInt {
            fatalError("_BytesX.length needs to be overridden.")
        }
        
        let value: Data
        
        required public init(_ value: Data) throws {
            let maxBytes = type(of: self).length
            guard value.count <= maxBytes else {
                throw BivrostError.BytesX.byteCountMismatch(max: maxBytes, actual: UInt(value.count))
            }
            self.value = value
        }
    }
}

// MARK: - SolidityCodable
extension _DoNotUse._BytesX: StaticType {
    func encode() -> SolidityCodable.EncodeFormat {
        guard value.count <= type(of: self).length else {
            fatalError("_BytesX somehow created with Data that does not fit into \(type(of: self).length) bytes.")
        }
        // If data is too small for 32bytes, right pad with 0 elements
        return value.toHexString().padToSolidity(location: .right)
    }
    
    static func decode(source: BaseDecoder.PartitionData) throws -> Self {
        guard let bytes = try? self.init(BaseDecoder.decodeBytesX(data: source.consume(), length: length)) else {
            throw BivrostError.Decoder.couldNotCreateBytesX(source: source, length: length)
        }
        return bytes
    }
}

// MARK: - Equatable
extension _DoNotUse._BytesX: Equatable {
    public static func ==(lhs: _DoNotUse._BytesX, rhs: _DoNotUse._BytesX) -> Bool {
        guard type(of: lhs).length == type(of: rhs).length else {
            return false
        }
        return lhs.value == rhs.value
    }
}

// MARK: - Reference Types
extension Solidity {
    // TODO: Manual subclasses, can be removed later.
    public final class Bytes1: _DoNotUse._BytesX {
        override class var length: UInt {
            return 1
        }
    }
    public final class Bytes2: _DoNotUse._BytesX {
        override class var length: UInt {
            return 2
        }
    }
    public final class Bytes3: _DoNotUse._BytesX {
        override class var length: UInt {
            return 3
        }
    }
    public final class Bytes4: _DoNotUse._BytesX {
        override class var length: UInt {
            return 4
        }
    }
    public final class Bytes24: _DoNotUse._BytesX {
        override class var length: UInt {
            return 24
        }
    }
    public final class Bytes32: _DoNotUse._BytesX {
        override class var length: UInt {
            return 32
        }
    }
}
