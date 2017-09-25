//
//  SolidityContractTemplate.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 20.09.17.
//

import CryptoSwift
import BigInt

// MARK: - Solidity Types
public struct Solidity {
    // MARK: Static Types
    
    // FIXME: done
    public struct Bool: SolidityEncodable {
        let value: Swift.Bool
        func encode() -> EncodeFormat {
            return UInt8(value: value ? 1 : 0).encode()
        }
    }
    
    // FIXME: done
    public struct UInt8: SolidityEncodable {
        let value: Swift.UInt8
        func encode() -> EncodeFormat {
            return UInt256(trustedUInt: BigUInt(value)).encode()
        }
    }
    
    public struct UInt16: SolidityEncodable {
        let value: Swift.UInt16
        func encode() -> SolidityEncodable.EncodeFormat {
            return UInt256(trustedUInt: BigUInt(value)).encode()
        }
    }

    // FIXME: implement/generate more uint types
    public struct UInt32: SolidityEncodable {
        let value: Swift.UInt32
        func encode() -> SolidityEncodable.EncodeFormat {
            return UInt256(trustedUInt: BigUInt(value)).encode()
            
        }
    }
    
    // FIXME: done
    public struct UInt256: SolidityEncodable {
        let value: BigUInt
        func encode() -> EncodeFormat {
            return value.serialize().toHexString().padToSolidity()
        }
        
        public init?(_ bigUint: BigUInt) {
            guard bigUint.bitWidth <= 256 else {
                return nil
            }
            value = bigUint
        }
        
        init(trustedUInt: BigUInt) {
            guard trustedUInt.bitWidth <= 256 else {
                fatalError("UInt256 created with a BigUInt that does not fit into 256 bits.")
            }
            value = trustedUInt
        }
    }
    
    public struct UInt160: SolidityEncodable {
        let value: BigUInt
        func encode() -> EncodeFormat {
            return UInt256(trustedUInt: value).encode()
        }
        
        // FIXME: this can be parametrized with the bit length and stuff
        public init?(_ bigUint: BigUInt) {
            guard bigUint.bitWidth <= 160 else {
                return nil
            }
            value = bigUint
        }
    }
    
    public struct Address: SolidityEncodable {
        let value: UInt160
        func encode() -> SolidityEncodable.EncodeFormat {
            return value.encode()
        }
        
        init?(_ address: String) {
            let hex = address.hasPrefix("0x") ? String(address[address.index(address.startIndex, offsetBy: 2)...]) : address
            guard let bigInt = BigUInt(hex, radix: 16),
                let uint = UInt160(bigInt) else {
                return nil
            }
            value = uint
        }
    }
    
    // MARK: Dynamic Types
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

struct StandardToken {
    struct Approve: SolidityFunction {
        static let methodId = "095ea7b3"
        typealias Arguments = (spender: Solidity.Address, value: Solidity.UInt256)
        typealias Return = Solidity.Bool
        
        static func encodeCall(arguments: Arguments) -> String {
            // FIXME: DONE
            return "0x\(methodId)\(SolidityBase.encode(arguments: arguments.spender, arguments.value))"
        }
        
        static func decode(return: String) -> Return {
            // FIXME: implement
            return Return(value: true)
        }
        static func decode(arguments: String) -> Arguments {
            // FIXME: implement
            return Arguments(spender: Solidity.Address("FF")!, value: Solidity.UInt256(BigUInt(1))!)
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
