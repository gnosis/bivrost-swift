//
//  ParameterType.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 13.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//
//

import Foundation

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
