//
//  String.swift
//  BivrostBase
//
//  Created by Luis Reisewitz on 28.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//

extension Solidity {
    public struct String {
        let wrapper: Solidity.Bytes
        
        init?(_ value: Swift.String) {
            guard let data = value.data(using: .utf8),
                let bytes = Solidity.Bytes(data) else {
                return nil
            }
            self.wrapper = bytes
        }
    }
}

// MARK: - DynamicType
extension Solidity.String: DynamicType {
    static func decode(source: BaseDecoder.PartitionData) throws -> Solidity.String {
        guard let string = try Solidity.String(BaseDecoder.decodeString(source: source)) else {
            throw BivrostError.Decoder.couldNotCreateString(source: source)
        }
        return string
    }
    
    func encode() -> SolidityEncodable.EncodeFormat {
        return wrapper.encode()
    }
}
