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
    fileprivate class BytesXBase {
        let length: UInt
        let value: Data
        
        init?(length: UInt, value: Data) {
            guard value.count <= length else {
                return nil
            }
            self.length = length
            self.value = value
        }
    }
}

// MARK: - BytesXBase StaticType
extension Solidity.BytesXBase: StaticType {
    func encode() -> SolidityEncodable.EncodeFormat {
        guard value.count <= length else {
            fatalError("BytesXBase somehow created with Data that does not fit into \(length) bytes.")
        }
        // If data is too small for 32bytes, right pad with 0 elements
        return value.toHexString().padToSolidity(location: .right)
    }
}

// MARK: - BytesXBase
extension Solidity {
    public struct Bytes1 {
        private let wrapper: BytesXBase
        
        init?(_ value: Data) {
            guard let wrapper = BytesXBase(length: 1, value: value) else {
                return nil
            }
            self.wrapper = wrapper
        }
    }
}

// MARK: - Bytes1 StaticType
extension Solidity.Bytes1: StaticType {
    func encode() -> SolidityEncodable.EncodeFormat {
        return wrapper.encode()
    }
}

// MARK: - Bytes2
extension Solidity {
    public struct Bytes2 {
        private let wrapper: BytesXBase
        
        init?(_ value: Data) {
            guard let wrapper = BytesXBase(length: 2, value: value) else {
                return nil
            }
            self.wrapper = wrapper
        }
    }
}

// MARK: - Bytes2 StaticType
extension Solidity.Bytes2: StaticType {
    func encode() -> SolidityEncodable.EncodeFormat {
        return wrapper.encode()
    }
}

// MARK: - Bytes3
extension Solidity {
    public struct Bytes3 {
        private let wrapper: BytesXBase
        
        init?(_ value: Data) {
            guard let wrapper = BytesXBase(length: 3, value: value) else {
                return nil
            }
            self.wrapper = wrapper
        }
    }
}

// MARK: - Bytes3 StaticType
extension Solidity.Bytes3: StaticType {
    func encode() -> SolidityEncodable.EncodeFormat {
        return wrapper.encode()
    }
}

// MARK: - Bytes4
extension Solidity {
    public struct Bytes4 {
        private let wrapper: BytesXBase
        
        init?(_ value: Data) {
            guard let wrapper = BytesXBase(length: 4, value: value) else {
                return nil
            }
            self.wrapper = wrapper
        }
    }
}

// MARK: - Bytes4 StaticType
extension Solidity.Bytes4: StaticType {
    func encode() -> SolidityEncodable.EncodeFormat {
        return wrapper.encode()
    }
}

// MARK: - Bytes24
extension Solidity {
    public struct Bytes24 {
        private let wrapper: BytesXBase
        
        init?(_ value: Data) {
            guard let wrapper = BytesXBase(length: 24, value: value) else {
                return nil
            }
            self.wrapper = wrapper
        }
    }
}

// MARK: - Bytes32 StaticType
extension Solidity.Bytes24: StaticType {
    func encode() -> SolidityEncodable.EncodeFormat {
        return wrapper.encode()
    }
}

// MARK: - Bytes32
extension Solidity {
    public struct Bytes32 {
        private let wrapper: BytesXBase
        
        init?(_ value: Data) {
            guard let wrapper = BytesXBase(length: 32, value: value) else {
                return nil
            }
            self.wrapper = wrapper
        }
    }
}

// MARK: - Bytes32 StaticType
extension Solidity.Bytes32: StaticType {
    func encode() -> SolidityEncodable.EncodeFormat {
        return wrapper.encode()
    }
}
