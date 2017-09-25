//
//  SolidityContractTemplate.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 20.09.17.
//

import CryptoSwift
import BigInt

private let solidityBytesPad = 32
private let solidityHexStringPad = solidityBytesPad * 2

// MARK: - Solidity Types
public struct Solidity {
    // MARK: Static Types
    public struct Address: SolidityEncodable {
        func encode() -> EncodeFormat {
            // FIXME: implement
            return ""
        }
    }
    
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
            return UInt256(value: BigUInt(value)).encode()
        }
    }
    
    public struct UInt32: SolidityEncodable {
        let value: Swift.UInt32
        func encode() -> SolidityEncodable.EncodeFormat {
            return UInt256(value: BigUInt(value)).encode()
        }
    }
    
    // FIXME: done
    public struct UInt256: SolidityEncodable {
        let value: BigUInt
        func encode() -> EncodeFormat {
            return value.serialize().toHexString().padToSolidity()
        }
    }
    

    
    // MARK: Dynamic Types
}

extension String {
    func pad(toMultipleOf multiple: Int, character: Character) -> String {
        let originalLength = self.characters.count
        let desiredLength = ((originalLength - 1)|(multiple - 1)) + 1
        let paddingLength = desiredLength - originalLength
        let padding = String(repeating: character, count: paddingLength)
        return padding + self
    }
    
    func padToSolidity(character: Character = "0") -> String {
        return pad(toMultipleOf: solidityHexStringPad, character: character)
        
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
            return Arguments(spender: Solidity.Address(), value: Solidity.UInt256(value: BigUInt(1)))
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
