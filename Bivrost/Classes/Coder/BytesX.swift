//
//  BytesX.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 26.09.17.
//

extension Solidity {
    private class BytesXBase: SolidityEncodable {
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
            return value.encode()
        }
    }
    
    public struct Bytes1: SolidityEncodable {
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
    
    public struct Bytes32: SolidityEncodable {
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
