//
//  SolidityContractTemplate.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 20.09.17.
//

import CryptoSwift
import BigInt

// MARK: - Solidity Types
public struct Solidity2 {
    // MARK: Static Types
    
    // FIXME: done
    
    public struct Address: SolidityEncodable {
        let value: Solidity.UInt160
        func encode() -> SolidityEncodable.EncodeFormat {
            return value.encode()
        }
        
        init?(_ address: String) {
            let hex = address.hasPrefix("0x") ? String(address[address.index(address.startIndex, offsetBy: 2)...]) : address
            guard let bigInt = BigUInt(hex, radix: 16),
                let uint = Solidity.UInt160(bigInt) else {
                return nil
            }
            value = uint
        }
    }
    
    private class BytesXBase: SolidityEncodable {
        let length: UInt
        let value: Data
        init?(length: UInt, value: Data) {
            guard value.count <= length else {
                return nil
            }
            self.length = length
            self.value = value
        }
        
        func encode() -> SolidityEncodable.EncodeFormat {
            guard value.count <= length else {
                fatalError("BytesXBase created with Data that does not fit into \(length) bytes.")
            }
            return value.encode()
        }
        
    }
    
    public struct Bytes1: SolidityEncodable {
        private let wrapper: BytesXBase
        
        init?(value: Data) {
            guard let wrapper = BytesXBase(length: 1, value: value) else {
                return nil
            }
            self.wrapper = wrapper
        }
        func encode() -> SolidityEncodable.EncodeFormat {
            return wrapper.encode()
        }
    }
    
    public struct Bytes32: SolidityEncodable {
        private let wrapper: BytesXBase
        
        init?(value: Data) {
            guard let wrapper = BytesXBase(length: 32, value: value) else {
                return nil
            }
            self.wrapper = wrapper
        }
        
        func encode() -> SolidityEncodable.EncodeFormat {
            return wrapper.encode()
        }
    }
    
    // MARK: Dynamic Types
}

// MARK: - Data SolidityEncodable
extension Data: SolidityEncodable {
    func encode() -> SolidityEncodable.EncodeFormat {
        // If data is too small for 32bytes, right pad with 0 elements
        return toHexString().padToSolidity(location: .right)
    }
}

protocol SolidityEncodable {
    typealias EncodeFormat = String
    func encode() -> EncodeFormat
}

struct SolidityBase {
    static func encode(arguments: SolidityEncodable...) -> SolidityEncodable.EncodeFormat {
        // FIXME: implement add dynamic types
        return arguments.map { $0.encode() }.reduce("", +)
    }
}

protocol SolidityFunction {
    associatedtype Arguments
    associatedtype Return
    
    static var methodId: String { get }
    
    static func encodeCall(arguments: Arguments) -> String
    static func decode(return: String) -> Return
    static func decode(arguments: String) -> Arguments
}

// FIXME: remove this once we have code generation going, this is just for testing
// and seeing how this can work
struct StandardToken {
    struct Approve: SolidityFunction {
        static let methodId = "095ea7b3"
        typealias Arguments = (spender: Solidity2.Address, value: Solidity.UInt256)
        typealias Return = Solidity.Bool
        
        static func encodeCall(arguments: Arguments) -> String {
            // FIXME: DONE
            return "0x\(methodId)\(SolidityBase.encode(arguments: arguments.spender, arguments.value))"
        }
        
        static func decode(return: String) -> Return {
            // FIXME: implement
            return Return(true)
        }
        static func decode(arguments: String) -> Arguments {
            // FIXME: implement
            return Arguments(spender: Solidity2.Address("FF")!, value: Solidity.UInt256(BigUInt(1))!)
        }
    }
    
    struct Example {
        static let methodId = "cdcd77c0"
        typealias Arguments = (x: Solidity.UInt32, y: Solidity.Bool)
        
        static func encodeCall(arguments: Arguments) -> String {
            return "0x\(methodId)\(SolidityBase.encode(arguments: arguments.x, arguments.y))"
        }
    }
}

extension Contract.Element.Function {
    var signature: String {
        return "\(name)(\(inputs.map { $0.type.abiRepresentation }.joined(separator: ",")))"
    }
    
    var methodId: String {
        return String(signature.sha3(.keccak256).prefix(8))
    }
}
