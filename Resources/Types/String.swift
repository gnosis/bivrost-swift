//
//  String.swift
//  BivrostHelper
//
//  Created by Luis Reisewitz on 28.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//

public extension Solidity {
    struct String {
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

    func encode() -> SolidityCodable.EncodeFormat {
        return wrapper.encode()
    }
}

extension Solidity.String: Equatable {
    public static func == (lhs: Solidity.String, rhs: Solidity.String) -> Bool {
        return lhs.wrapper == rhs.wrapper
    }
}
