//
//  SolidityContractTemplate.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 20.09.17.
//

import CryptoSwift
import BigInt

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
        typealias Arguments = (spender: Solidity.Address, value: Solidity.UInt256)
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
