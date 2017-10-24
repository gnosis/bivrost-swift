//
//  Bool.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 26.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//

import BigInt

extension Solidity {
    public struct Bool {
        private let wrapper: UInt8

        init(_ value: Swift.Bool) {
            guard let wrapper = try? UInt8(BigUInt(value ? 1 : 0)) else {
                fatalError("Solidity.Bool could not be created with value of \(value). This should not happen.")
            }
            self.wrapper = wrapper
        }
    }
}

// MARK: - StaticType
extension Solidity.Bool: StaticType {
    func encode() -> SolidityCodable.EncodeFormat {
        return wrapper.encode()
    }

    static func decode(source: BaseDecoder.PartitionData) throws -> Solidity.Bool {
        return try Solidity.Bool(BaseDecoder.decodeBool(data: source.consume()))
    }
}

extension Solidity.Bool: Equatable {
    public static func ==(lhs: Solidity.Bool, rhs: Solidity.Bool) -> Bool {
        return lhs.wrapper == rhs.wrapper
    }
}
