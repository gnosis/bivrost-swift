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
    func encode() -> EncodeFormat
    var isDynamic: Bool { get }
}

protocol StaticType: SolidityEncodable {}
protocol DynamicType: SolidityEncodable {}

extension StaticType {
    var isDynamic: Bool {
        return false
    }
}

extension DynamicType {
    var isDynamic: Bool {
        return true
    }
}

struct SolidityBase {
    static func encode(arguments: SolidityEncodable...) -> SolidityEncodable.EncodeFormat {
        // FIXME: implement add dynamic types
        return arguments.map { $0.encode() }.reduce("", +)
    }
}
