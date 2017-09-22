//
//  SolidityContractTemplate.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 20.09.17.
//

import CryptoSwift

struct Solidity {
    struct Address: SolidityEncodable {
        
    }
    
    struct UInt256: SolidityEncodable {
        
    }
    
    struct Bool: SolidityEncodable {
        
    }
}

protocol SolidityEncodable {
    
}

struct SolidityBase {
    static func encode(arguments: SolidityEncodable...) -> String {
        
        // FIXME: implement
        return ""
    }
}
struct StandardToken {
    struct Approve {
        static let methodId = "095ea7b3"
        typealias Arguments = (spender: Solidity.Address, value: Solidity.UInt256)
        typealias Return = Solidity.Bool
        
        static func encodeCall(arguments: Arguments) -> String {
            // FIXME: DONE
            return "0x\(methodId)\(SolidityBase.encode(arguments: arguments.spender, arguments.value))"
        }
        
        static func decode(return: String) -> Return {
            // FIXME: bla
            return Return()
        }
        static func decode(arguments: String) -> Arguments {
            // FIXME: implement
            return Arguments(spender: Solidity.Address(), value: Solidity.UInt256())
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
