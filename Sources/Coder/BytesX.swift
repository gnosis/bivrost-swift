//
//  BytesX.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 26.09.17.
//

extension Solidity {
    private class BytesXBase: StaticType {
        let length: UInt
        let value: Data
        
        init?(length: UInt, value: Data) {
            guard value.count <= length else {
                return nil
            }
            self.length = length
            self.value = value
        }
        
        func encode() -> SolidityEncodable.EncodeFormat {
            guard value.count <= length else {
                fatalError("BytesXBase somehow created with Data that does not fit into \(length) bytes.")
            }
            // If data is too small for 32bytes, right pad with 0 elements
            return value.toHexString().padToSolidity(location: .right)
        }
    }
    
    public struct Bytes1: StaticType {
        private let wrapper: BytesXBase
        
        init?(value: Data) {
            guard let wrapper = BytesXBase(length: 1, value: value) else {
                return nil
            }
            self.wrapper = wrapper
        }
        func encode() -> SolidityEncodable.EncodeFormat {
            return wrapper.encode()
        }
    }
    
    public struct Bytes32: StaticType {
        private let wrapper: BytesXBase
        
        init?(value: Data) {
            guard let wrapper = BytesXBase(length: 32, value: value) else {
                return nil
            }
            self.wrapper = wrapper
        }
        
        func encode() -> SolidityEncodable.EncodeFormat {
            return wrapper.encode()
        }
    }
}
