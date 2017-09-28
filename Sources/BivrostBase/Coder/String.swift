//
//  String.swift
//  BivrostBase
//
//  Created by Luis Reisewitz on 28.09.17.
//


extension Solidity {
    public struct String: DynamicType {
        let wrapper: Solidity.Bytes
        
        init?(_ value: Swift.String) {
            guard let data = value.data(using: .utf8),
                let bytes = Solidity.Bytes(data) else {
                return nil
            }
            self.wrapper = bytes
        }
        
        func head() -> SolidityEncodable.EncodeFormat {
            // FIXME: implement
            return ""
        }
        
        func encode() -> SolidityEncodable.EncodeFormat {
            return wrapper.encode()
        }
    }
}
