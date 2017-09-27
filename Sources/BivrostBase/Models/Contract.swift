//
//  Contract.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 12.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//
//

/// Describes the interface of an Ethereum/Solidity Contract
struct Contract {
    let elements: [Element]
    
    enum Element {
        case function(Function)
        case constructor(Constructor)
        case fallback(Fallback)
        case event(Event)
        
        struct Function {
            let name: String
            let inputs: [Input]
            let outputs: [Output]
            let constant: Bool
            let payable: Bool
            
            struct Output {
                /// FunctionOutput names can also be empty strings.
                let name: String
                let type: ParameterType
            }
            
            struct Input {
                let name: String
                let type: ParameterType
            }
        }
        
        struct Constructor {
            let inputs: [Function.Input]
            let constant: Bool
            let payable: Bool
        }
        
        struct Fallback {
            let constant: Bool
            let payable: Bool
        }
        
        struct Event {
            let name: String
            let inputs: [Input]
            let anonymous: Bool
            
            struct Input {
                let name: String
                let type: ParameterType
                let indexed: Bool
            }
        }
        
        /// Specifies the type that parameters in a contract have.
        enum ParameterType {
            case dynamicType(DynamicType)
            case staticType(StaticType)
            
            /// Denotes any type that has a fixed length.
            enum StaticType {
                /// uint<M>: unsigned integer type of M bits, 0 < M <= 256, M % 8 == 0. e.g. uint32, uint8, uint256.
                case uint(bits: Int)
                /// int<M>: two's complement signed integer type of M bits, 0 < M <= 256, M % 8 == 0.
                case int(bits: Int)
                /// address: equivalent to uint160, except for the assumed interpretation and language typing.
                case address
                /// bool: equivalent to uint8 restricted to the values 0 and 1
                case bool
                /// bytes<M>: binary type of M bytes, 0 < M <= 32.
                case bytes(length: Int)
                /// function: equivalent to bytes24: an address, followed by a function selector
                case function
                /// <type>[M]: a fixed-length array of the given fixed-length type.
                indirect case array(StaticType, length: Int)
                
                // The specification also defines the following types:
                // uint, int: synonyms for uint256, int256 respectively (not to be used for computing the function selector).
                // We do not include these in this enum, as we will just be mapping those
                // to .uint(bits: 256) and .int(bits: 256) directly.
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
        }
    }
}

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
