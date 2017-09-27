//
//  ParameterType.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 13.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//
//

// Based on https://github.com/ethereum/wiki/wiki/Ethereum-Contract-ABI#types

// MARK: - DynamicType Equatable

extension Contract.Element.ParameterType.DynamicType: Equatable {
    public static func ==(lhs: Contract.Element.ParameterType.DynamicType, rhs: Contract.Element.ParameterType.DynamicType) -> Bool {
        switch (lhs, rhs) {
        case (.bytes, .bytes):
            return true
        case (.string, .string):
            return true
        case (.array(let value1), .array(let value2)):
            return value1 == value2
        default:
            return false
        }
    }
}

// MARK: - StaticType Equatable
extension Contract.Element.ParameterType.StaticType: Equatable {
    public static func ==(lhs: Contract.Element.ParameterType.StaticType, rhs: Contract.Element.ParameterType.StaticType) -> Bool {
        switch (lhs, rhs) {
        case let (.uint(length1), .uint(length2)):
            return length1 == length2
        case let (.int(length1), .int(length2)):
            return length1 == length2
        case (.address, .address):
            return true
        case (.bool, .bool):
            return true
        case let (.bytes(length1), .bytes(length2)):
            return length1 == length2
        case (.function, .function):
            return true
        case let (.array(type1, length1), .array(type2, length2)):
            return type1 == type2 && length1 == length2
        default:
            return false
        }
    }
}

// MARK: - ParameterType Equatable
extension Contract.Element.ParameterType: Equatable {
    public static func ==(lhs: Contract.Element.ParameterType, rhs: Contract.Element.ParameterType) -> Bool {
        switch (lhs, rhs) {
        case (.dynamicType(let value1), .dynamicType(let value2)):
            return value1 == value2
        case (.staticType(let value1), .staticType(let value2)):
            return value1 == value2
        default:
            return false
        }
    }
}

// MARK: - ParameterType Validity
extension Contract.Element.ParameterType: AbiValidating {
    var isValid: Bool {
        switch self {
        case .staticType(let type):
            return type.isValid
        case .dynamicType(let type):
            return type.isValid
        }
    }
}

// MARK: - ParameterType.StaticType Validity
extension Contract.Element.ParameterType.StaticType: AbiValidating {
    var isValid: Bool {
        switch self {
        case .uint(let bits), .int(let bits):
            return bits > 0 && bits <= 256 && bits % 8 == 0
        case .bytes(let length):
            return length > 0 && length <= 32
        case let .array(type, _):
            return type.isValid
        default:
            return true
        }
    }
}

// MARK: - ParameterType.DynamicType Validity
extension Contract.Element.ParameterType.DynamicType: AbiValidating {
    var isValid: Bool {
        // Right now we cannot create invalid dynamic types.
        return true
    }
}
