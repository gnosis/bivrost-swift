//
//  Solidity.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 26.09.17.
//

/// Blanket Holder for Solidity Types
struct Solidity {}

protocol SolidityEncodable {
    typealias EncodeFormat = String
    func head() -> EncodeFormat
    func tail() -> EncodeFormat
    func encode() -> EncodeFormat
}

protocol StaticType: SolidityEncodable {}

protocol DynamicType: SolidityEncodable {}

extension StaticType {
    func head() -> SolidityEncodable.EncodeFormat {
        return encode()
    }
    func tail() -> SolidityEncodable.EncodeFormat {
        return ""
    }
}

extension DynamicType {
    func tail() -> SolidityEncodable.EncodeFormat {
        return encode()
    }
}

struct SolidityBase {
    static func encode(arguments: SolidityEncodable...) -> SolidityEncodable.EncodeFormat {
        // FIXME: this could work depending on architecture, but probably we need
        // pass the current head size or something into `head()` for the dynamic types
        let head = arguments.map { $0.head() }.reduce("", +)
        let tail = arguments.map { $0.tail() }.reduce("", +)
        return head + tail
    }
}
