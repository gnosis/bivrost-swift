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

/// Denotes any type that has a fixed length.
enum StaticType {
    /// uint<M>: unsigned integer type of M bits, 0 < M <= 256, M % 8 == 0. e.g. uint32, uint8, uint256.
    case uint(bits: Int)
    /// int<M>: two's complement signed integer type of M bits, 0 < M <= 256, M % 8 == 0.
    case int(bits: Int)
    /// address: equivalent to uint160, except for the assumed interpretation and language typing.
    case address
    //    /// uint, int: synonyms for uint256, int256 respectively (not to be used for computing the function selector).
    //    case uint, int  // NOT NEEDED, MAP TO UINT(LENGTH)
    /// bool: equivalent to uint8 restricted to the values 0 and 1
    case bool
    /// bytes<M>: binary type of M bytes, 0 < M <= 32.
    case bytes(length: Int)
    /// function: equivalent to bytes24: an address, followed by a function selector
    case function
    /// <type>[M]: a fixed-length array of the given fixed-length type.
    indirect case array(StaticType, length: Int)
}

/// Denotes any type that has a variable length.
enum DynamicType {
    /// bytes: dynamic sized byte sequence.
    case bytes
    /// string: dynamic sized unicode string assumed to be UTF-8 encoded.
    case string
    /// <type>[]: a variable-length array of the given fixed-length type.
    case array(StaticType)
}

/// Specifies the type that a parameter in a contract has.
enum ParameterType {
    case dynamicType(DynamicType)
    case staticType(StaticType)
}
