//
//  BytesX.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 26.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//
import Foundation

// MARK: - BytesXBase
extension Solidity {
    class BytesXBase {
        let length: UInt
        let value: Data
        
        init?(length: UInt, value: Data) {
            guard value.count <= length else {
                return nil
            }
            self.length = length
            self.value = value
        }
        
        func encode() -> SolidityCodable.EncodeFormat {
            guard value.count <= length else {
                fatalError("BytesXBase somehow created with Data that does not fit into \(length) bytes.")
            }
            // If data is too small for 32bytes, right pad with 0 elements
            return value.toHexString().padToSolidity(location: .right)
        }
    }
}

extension Solidity.BytesXBase: Equatable {
    public static func ==(lhs: Solidity.BytesXBase, rhs: Solidity.BytesXBase) -> Bool {
        return lhs.length == rhs.length && lhs.value == rhs.value
    }
}

protocol SolidityBytesXType: StaticType, Equatable {
    static var bytes: UInt { get }
    var wrapper: Solidity.BytesXBase { get }
    init?(_ value: Data)
}

extension SolidityBytesXType {
    func encode() -> SolidityCodable.EncodeFormat {
        return wrapper.encode()
    }
    
    static func decode(source: BaseDecoder.PartitionData) throws -> Self {
        guard let bytes = try Self.init(BaseDecoder.decodeBytesX(data: source.consume(), length: bytes)) else {
            throw BivrostError.notImplemented
        }
        return bytes
    }
}

extension SolidityBytesXType {
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.wrapper == rhs.wrapper
    }
}

// MARK: - BytesXBase
extension Solidity {
    public struct Bytes1: SolidityBytesXType {
        let wrapper: BytesXBase
        static let bytes: UInt = 1
        
        init?(_ value: Data) {
            guard let wrapper = BytesXBase(length: type(of: self).bytes, value: value) else {
                return nil
            }
            self.wrapper = wrapper
        }
    }
}

// MARK: - Bytes2
extension Solidity {
    public struct Bytes2: SolidityBytesXType {
        let wrapper: BytesXBase
        static let bytes: UInt = 2
        
        init?(_ value: Data) {
            guard let wrapper = BytesXBase(length: type(of: self).bytes, value: value) else {
                return nil
            }
            self.wrapper = wrapper
        }
    }
}

// MARK: - Bytes3
extension Solidity {
    public struct Bytes3: SolidityBytesXType {
        let wrapper: BytesXBase
        static let bytes: UInt = 3
        
        init?(_ value: Data) {
            guard let wrapper = BytesXBase(length: type(of: self).bytes, value: value) else {
                return nil
            }
            self.wrapper = wrapper
        }
    }
}

// MARK: - Bytes4
extension Solidity {
    public struct Bytes4: SolidityBytesXType {
        let wrapper: BytesXBase
        static let bytes: UInt = 4
        
        init?(_ value: Data) {
            guard let wrapper = BytesXBase(length: type(of: self).bytes, value: value) else {
                return nil
            }
            self.wrapper = wrapper
        }
    }
}

// MARK: - Bytes24
extension Solidity {
    public struct Bytes24: SolidityBytesXType {
        let wrapper: BytesXBase
        static let bytes: UInt = 24
        
        init?(_ value: Data) {
            guard let wrapper = BytesXBase(length: type(of: self).bytes, value: value) else {
                return nil
            }
            self.wrapper = wrapper
        }
    }
}

// MARK: - Bytes32
extension Solidity {
    public struct Bytes32: SolidityBytesXType {
        let wrapper: BytesXBase
        static let bytes: UInt = 32
        
        init?(_ value: Data) {
            guard let wrapper = BytesXBase(length: type(of: self).bytes, value: value) else {
                return nil
            }
            self.wrapper = wrapper
        }
    }
}
