//
//  SolidityContractTemplate.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 20.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//

import BigInt

protocol SolidityFunction {
    associatedtype Arguments
    associatedtype Return
    
    static var methodId: String { get }
    
    static func encodeCall(arguments: Arguments) -> String
    static func decode(returnData: String) throws -> Return
    static func decode(argumentsData: String) throws -> Arguments
}

struct Multisigwalletwithdailylimit {
    
    struct Owners: SolidityFunction {
        static let methodId = "025e7c27"
        typealias Return = Solidity.Address
        typealias Arguments = Solidity.UInt256
        
        static func encodeCall(arguments: Arguments) -> String {
            return "0x\(methodId)\(BaseEncoder.encode(arguments: arguments))"
        }
        
        static func decode(returnData: String) throws -> Return {
            let source = BaseDecoder.partition(returnData)
            
            let ret0 = try Solidity.Address.decode(source: source)
            
            return ret0
        }
        
        static func decode(argumentsData: String) throws -> Arguments {
            let source = BaseDecoder.partition(argumentsData)
            
            let ret0 = try Solidity.UInt256.decode(source: source)
            
            return ret0
        }
    }
    
    struct Removeowner: SolidityFunction {
        static let methodId = "173825d9"
        typealias Return = Void
        typealias Arguments = Solidity.Address
        
        static func encodeCall(arguments: Arguments) -> String {
            return "0x\(methodId)\(BaseEncoder.encode(arguments: arguments))"
        }
        
        static func decode(returnData: String) throws -> Return {
            let source = BaseDecoder.partition(returnData)
            
            return
        }
        
        static func decode(argumentsData: String) throws -> Arguments {
            let source = BaseDecoder.partition(argumentsData)
            
            let owner = try Solidity.Address.decode(source: source)
            
            return owner
        }
    }
    
    struct Revokeconfirmation: SolidityFunction {
        static let methodId = "20ea8d86"
        typealias Return = Void
        typealias Arguments = Solidity.UInt256
        
        static func encodeCall(arguments: Arguments) -> String {
            return "0x\(methodId)\(BaseEncoder.encode(arguments: arguments))"
        }
        
        static func decode(returnData: String) throws -> Return {
            let source = BaseDecoder.partition(returnData)
            
            return
        }
        
        static func decode(argumentsData: String) throws -> Arguments {
            let source = BaseDecoder.partition(argumentsData)
            
            let transactionId = try Solidity.UInt256.decode(source: source)
            
            return transactionId
        }
    }
    
    struct Isowner: SolidityFunction {
        static let methodId = "2f54bf6e"
        typealias Return = Solidity.Bool
        typealias Arguments = Solidity.Address
        
        static func encodeCall(arguments: Arguments) -> String {
            return "0x\(methodId)\(BaseEncoder.encode(arguments: arguments))"
        }
        
        static func decode(returnData: String) throws -> Return {
            let source = BaseDecoder.partition(returnData)
            
            let ret0 = try Solidity.Bool.decode(source: source)
            
            return ret0
        }
        
        static func decode(argumentsData: String) throws -> Arguments {
            let source = BaseDecoder.partition(argumentsData)
            
            let ret0 = try Solidity.Address.decode(source: source)
            
            return ret0
        }
    }
    
    struct Confirmations: SolidityFunction {
        static let methodId = "3411c81c"
        typealias Return = Solidity.Bool
        typealias Arguments = (arg0: Solidity.UInt256, arg1: Solidity.Address)
        
        static func encodeCall(arguments: Arguments) -> String {
            return "0x\(methodId)\(BaseEncoder.encode(arguments: arguments.arg0, arguments.arg1))"
        }
        
        static func decode(returnData: String) throws -> Return {
            let source = BaseDecoder.partition(returnData)
            
            let ret0 = try Solidity.Bool.decode(source: source)
            
            return ret0
        }
        
        static func decode(argumentsData: String) throws -> Arguments {
            let source = BaseDecoder.partition(argumentsData)
            
            let ret0 = try Solidity.UInt256.decode(source: source)
            
            let ret1 = try Solidity.Address.decode(source: source)
            
            return Arguments(ret0: ret0, ret1: ret1)
        }
    }
    
    struct Calcmaxwithdraw: SolidityFunction {
        static let methodId = "4bc9fdc2"
        typealias Return = Solidity.UInt256
        typealias Arguments = Void
        
        static func encodeCall(arguments: Arguments) -> String {
            return "0x\(methodId)\(BaseEncoder.encode(arguments: arguments))"
        }
        
        static func decode(returnData: String) throws -> Return {
            let source = BaseDecoder.partition(returnData)
            
            let ret0 = try Solidity.UInt256.decode(source: source)
            
            return ret0
        }
        
        static func decode(argumentsData: String) throws -> Arguments {
            let source = BaseDecoder.partition(argumentsData)
            
            return
        }
    }
    
    struct Gettransactioncount: SolidityFunction {
        static let methodId = "54741525"
        typealias Return = Solidity.UInt256
        typealias Arguments = (pending: Solidity.Bool, executed: Solidity.Bool)
        
        static func encodeCall(arguments: Arguments) -> String {
            return "0x\(methodId)\(BaseEncoder.encode(arguments: arguments.pending, arguments.executed))"
        }
        
        static func decode(returnData: String) throws -> Return {
            let source = BaseDecoder.partition(returnData)
            
            let count = try Solidity.UInt256.decode(source: source)
            
            return count
        }
        
        static func decode(argumentsData: String) throws -> Arguments {
            let source = BaseDecoder.partition(argumentsData)
            
            let pending = try Solidity.Bool.decode(source: source)
            
            let executed = try Solidity.Bool.decode(source: source)
            
            return Arguments(pending: pending, executed: executed)
        }
    }
    
    struct Dailylimit: SolidityFunction {
        static let methodId = "67eeba0c"
        typealias Return = Solidity.UInt256
        typealias Arguments = Void
        
        static func encodeCall(arguments: Arguments) -> String {
            return "0x\(methodId)\(BaseEncoder.encode(arguments: arguments))"
        }
        
        static func decode(returnData: String) throws -> Return {
            let source = BaseDecoder.partition(returnData)
            
            let ret0 = try Solidity.UInt256.decode(source: source)
            
            return ret0
        }
        
        static func decode(argumentsData: String) throws -> Arguments {
            let source = BaseDecoder.partition(argumentsData)
            
            return
        }
    }
    
    struct Lastday: SolidityFunction {
        static let methodId = "6b0c932d"
        typealias Return = Solidity.UInt256
        typealias Arguments = Void
        
        static func encodeCall(arguments: Arguments) -> String {
            return "0x\(methodId)\(BaseEncoder.encode(arguments: arguments))"
        }
        
        static func decode(returnData: String) throws -> Return {
            let source = BaseDecoder.partition(returnData)
            
            let ret0 = try Solidity.UInt256.decode(source: source)
            
            return ret0
        }
        
        static func decode(argumentsData: String) throws -> Arguments {
            let source = BaseDecoder.partition(argumentsData)
            
            return
        }
    }
    
    struct Addowner: SolidityFunction {
        static let methodId = "7065cb48"
        typealias Return = Void
        typealias Arguments = Solidity.Address
        
        static func encodeCall(arguments: Arguments) -> String {
            return "0x\(methodId)\(BaseEncoder.encode(arguments: arguments))"
        }
        
        static func decode(returnData: String) throws -> Return {
            let source = BaseDecoder.partition(returnData)
            
            return
        }
        
        static func decode(argumentsData: String) throws -> Arguments {
            let source = BaseDecoder.partition(argumentsData)
            
            let owner = try Solidity.Address.decode(source: source)
            
            return owner
        }
    }
    
    struct Isconfirmed: SolidityFunction {
        static let methodId = "784547a7"
        typealias Return = Solidity.Bool
        typealias Arguments = Solidity.UInt256
        
        static func encodeCall(arguments: Arguments) -> String {
            return "0x\(methodId)\(BaseEncoder.encode(arguments: arguments))"
        }
        
        static func decode(returnData: String) throws -> Return {
            let source = BaseDecoder.partition(returnData)
            
            let ret0 = try Solidity.Bool.decode(source: source)
            
            return ret0
        }
        
        static func decode(argumentsData: String) throws -> Arguments {
            let source = BaseDecoder.partition(argumentsData)
            
            let transactionId = try Solidity.UInt256.decode(source: source)
            
            return transactionId
        }
    }
    
    struct Getconfirmationcount: SolidityFunction {
        static let methodId = "8b51d13f"
        typealias Return = Solidity.UInt256
        typealias Arguments = Solidity.UInt256
        
        static func encodeCall(arguments: Arguments) -> String {
            return "0x\(methodId)\(BaseEncoder.encode(arguments: arguments))"
        }
        
        static func decode(returnData: String) throws -> Return {
            let source = BaseDecoder.partition(returnData)
            
            let count = try Solidity.UInt256.decode(source: source)
            
            return count
        }
        
        static func decode(argumentsData: String) throws -> Arguments {
            let source = BaseDecoder.partition(argumentsData)
            
            let transactionId = try Solidity.UInt256.decode(source: source)
            
            return transactionId
        }
    }
    
    struct Transactions: SolidityFunction {
        static let methodId = "9ace38c2"
        typealias Return = (destination: Solidity.Address, value: Solidity.UInt256, data: Solidity.Bytes, executed: Solidity.Bool)
        typealias Arguments = Solidity.UInt256
        
        static func encodeCall(arguments: Arguments) -> String {
            return "0x\(methodId)\(BaseEncoder.encode(arguments: arguments))"
        }
        
        static func decode(returnData: String) throws -> Return {
            let source = BaseDecoder.partition(returnData)
            
            let destination = try Solidity.Address.decode(source: source)
            
            let value = try Solidity.UInt256.decode(source: source)
            
            let data = try Solidity.Bytes.decode(source: source)
            
            let executed = try Solidity.Bool.decode(source: source)
            
            return Return(destination: destination, value: value, data: data, executed: executed)
        }
        
        static func decode(argumentsData: String) throws -> Arguments {
            let source = BaseDecoder.partition(argumentsData)
            
            let ret0 = try Solidity.UInt256.decode(source: source)
            
            return ret0
        }
    }
    
    struct Getowners: SolidityFunction {
        static let methodId = "a0e67e2b"
        typealias Return = Solidity.VariableArray<Solidity.Address>
        typealias Arguments = Void
        
        static func encodeCall(arguments: Arguments) -> String {
            return "0x\(methodId)\(BaseEncoder.encode(arguments: arguments))"
        }
        
        static func decode(returnData: String) throws -> Return {
            let source = BaseDecoder.partition(returnData)
            
            let ret0 = try Solidity.VariableArray<Solidity.Address>.decode(source: source)
            
            return ret0
        }
        
        static func decode(argumentsData: String) throws -> Arguments {
            let source = BaseDecoder.partition(argumentsData)
            
            return
        }
    }
    
    struct Gettransactionids: SolidityFunction {
        static let methodId = "a8abe69a"
        typealias Return = Solidity.VariableArray<Solidity.UInt256>
        typealias Arguments = (from: Solidity.UInt256, to: Solidity.UInt256, pending: Solidity.Bool, executed: Solidity.Bool)
        
        static func encodeCall(arguments: Arguments) -> String {
            return "0x\(methodId)\(BaseEncoder.encode(arguments: arguments.from, arguments.to, arguments.pending, arguments.executed))"
        }
        
        static func decode(returnData: String) throws -> Return {
            let source = BaseDecoder.partition(returnData)
            
            let _transactionIds = try Solidity.VariableArray<Solidity.UInt256>.decode(source: source)
            
            return _transactionIds
        }
        
        static func decode(argumentsData: String) throws -> Arguments {
            let source = BaseDecoder.partition(argumentsData)
            
            let from = try Solidity.UInt256.decode(source: source)
            
            let to = try Solidity.UInt256.decode(source: source)
            
            let pending = try Solidity.Bool.decode(source: source)
            
            let executed = try Solidity.Bool.decode(source: source)
            
            return Arguments(from: from, to: to, pending: pending, executed: executed)
        }
    }
    
    struct Getconfirmations: SolidityFunction {
        static let methodId = "b5dc40c3"
        typealias Return = Solidity.VariableArray<Solidity.Address>
        typealias Arguments = Solidity.UInt256
        
        static func encodeCall(arguments: Arguments) -> String {
            return "0x\(methodId)\(BaseEncoder.encode(arguments: arguments))"
        }
        
        static func decode(returnData: String) throws -> Return {
            let source = BaseDecoder.partition(returnData)
            
            let _confirmations = try Solidity.VariableArray<Solidity.Address>.decode(source: source)
            
            return _confirmations
        }
        
        static func decode(argumentsData: String) throws -> Arguments {
            let source = BaseDecoder.partition(argumentsData)
            
            let transactionId = try Solidity.UInt256.decode(source: source)
            
            return transactionId
        }
    }
    
    struct Transactioncount: SolidityFunction {
        static let methodId = "b77bf600"
        typealias Return = Solidity.UInt256
        typealias Arguments = Void
        
        static func encodeCall(arguments: Arguments) -> String {
            return "0x\(methodId)\(BaseEncoder.encode(arguments: arguments))"
        }
        
        static func decode(returnData: String) throws -> Return {
            let source = BaseDecoder.partition(returnData)
            
            let ret0 = try Solidity.UInt256.decode(source: source)
            
            return ret0
        }
        
        static func decode(argumentsData: String) throws -> Arguments {
            let source = BaseDecoder.partition(argumentsData)
            
            return
        }
    }
    
    struct Changerequirement: SolidityFunction {
        static let methodId = "ba51a6df"
        typealias Return = Void
        typealias Arguments = Solidity.UInt256
        
        static func encodeCall(arguments: Arguments) -> String {
            return "0x\(methodId)\(BaseEncoder.encode(arguments: arguments))"
        }
        
        static func decode(returnData: String) throws -> Return {
            let source = BaseDecoder.partition(returnData)
            
            return
        }
        
        static func decode(argumentsData: String) throws -> Arguments {
            let source = BaseDecoder.partition(argumentsData)
            
            let _required = try Solidity.UInt256.decode(source: source)
            
            return _required
        }
    }
    
    struct Confirmtransaction: SolidityFunction {
        static let methodId = "c01a8c84"
        typealias Return = Void
        typealias Arguments = Solidity.UInt256
        
        static func encodeCall(arguments: Arguments) -> String {
            return "0x\(methodId)\(BaseEncoder.encode(arguments: arguments))"
        }
        
        static func decode(returnData: String) throws -> Return {
            let source = BaseDecoder.partition(returnData)
            
            return
        }
        
        static func decode(argumentsData: String) throws -> Arguments {
            let source = BaseDecoder.partition(argumentsData)
            
            let transactionId = try Solidity.UInt256.decode(source: source)
            
            return transactionId
        }
    }
    
    struct Submittransaction: SolidityFunction {
        static let methodId = "c6427474"
        typealias Return = Solidity.UInt256
        typealias Arguments = (destination: Solidity.Address, value: Solidity.UInt256, data: Solidity.Bytes)
        
        static func encodeCall(arguments: Arguments) -> String {
            return "0x\(methodId)\(BaseEncoder.encode(arguments: arguments.destination, arguments.value, arguments.data))"
        }
        
        static func decode(returnData: String) throws -> Return {
            let source = BaseDecoder.partition(returnData)
            
            let transactionId = try Solidity.UInt256.decode(source: source)
            
            return transactionId
        }
        
        static func decode(argumentsData: String) throws -> Arguments {
            let source = BaseDecoder.partition(argumentsData)
            
            let destination = try Solidity.Address.decode(source: source)
            
            let value = try Solidity.UInt256.decode(source: source)
            
            let data = try Solidity.Bytes.decode(source: source)
            
            return Arguments(destination: destination, value: value, data: data)
        }
    }
    
    struct Changedailylimit: SolidityFunction {
        static let methodId = "cea08621"
        typealias Return = Void
        typealias Arguments = Solidity.UInt256
        
        static func encodeCall(arguments: Arguments) -> String {
            return "0x\(methodId)\(BaseEncoder.encode(arguments: arguments))"
        }
        
        static func decode(returnData: String) throws -> Return {
            let source = BaseDecoder.partition(returnData)
            
            return
        }
        
        static func decode(argumentsData: String) throws -> Arguments {
            let source = BaseDecoder.partition(argumentsData)
            
            let _dailyLimit = try Solidity.UInt256.decode(source: source)
            
            return _dailyLimit
        }
    }
    
    struct Max_Owner_Count: SolidityFunction {
        static let methodId = "d74f8edd"
        typealias Return = Solidity.UInt256
        typealias Arguments = Void
        
        static func encodeCall(arguments: Arguments) -> String {
            return "0x\(methodId)\(BaseEncoder.encode(arguments: arguments))"
        }
        
        static func decode(returnData: String) throws -> Return {
            let source = BaseDecoder.partition(returnData)
            
            let ret0 = try Solidity.UInt256.decode(source: source)
            
            return ret0
        }
        
        static func decode(argumentsData: String) throws -> Arguments {
            let source = BaseDecoder.partition(argumentsData)
            
            return
        }
    }
    
    struct Required: SolidityFunction {
        static let methodId = "dc8452cd"
        typealias Return = Solidity.UInt256
        typealias Arguments = Void
        
        static func encodeCall(arguments: Arguments) -> String {
            return "0x\(methodId)\(BaseEncoder.encode(arguments: arguments))"
        }
        
        static func decode(returnData: String) throws -> Return {
            let source = BaseDecoder.partition(returnData)
            
            let ret0 = try Solidity.UInt256.decode(source: source)
            
            return ret0
        }
        
        static func decode(argumentsData: String) throws -> Arguments {
            let source = BaseDecoder.partition(argumentsData)
            
            return
        }
    }
    
    struct Replaceowner: SolidityFunction {
        static let methodId = "e20056e6"
        typealias Return = Void
        typealias Arguments = (owner: Solidity.Address, newOwner: Solidity.Address)
        
        static func encodeCall(arguments: Arguments) -> String {
            return "0x\(methodId)\(BaseEncoder.encode(arguments: arguments.owner, arguments.newOwner))"
        }
        
        static func decode(returnData: String) throws -> Return {
            let source = BaseDecoder.partition(returnData)
            
            return
        }
        
        static func decode(argumentsData: String) throws -> Arguments {
            let source = BaseDecoder.partition(argumentsData)
            
            let owner = try Solidity.Address.decode(source: source)
            
            let newOwner = try Solidity.Address.decode(source: source)
            
            return Arguments(owner: owner, newOwner: newOwner)
        }
    }
    
    struct Executetransaction: SolidityFunction {
        static let methodId = "ee22610b"
        typealias Return = Void
        typealias Arguments = Solidity.UInt256
        
        static func encodeCall(arguments: Arguments) -> String {
            return "0x\(methodId)\(BaseEncoder.encode(arguments: arguments))"
        }
        
        static func decode(returnData: String) throws -> Return {
            let source = BaseDecoder.partition(returnData)
            
            return
        }
        
        static func decode(argumentsData: String) throws -> Arguments {
            let source = BaseDecoder.partition(argumentsData)
            
            let transactionId = try Solidity.UInt256.decode(source: source)
            
            return transactionId
        }
    }
    
    struct Spenttoday: SolidityFunction {
        static let methodId = "f059cf2b"
        typealias Return = Solidity.UInt256
        typealias Arguments = Void
        
        static func encodeCall(arguments: Arguments) -> String {
            return "0x\(methodId)\(BaseEncoder.encode(arguments: arguments))"
        }
        
        static func decode(returnData: String) throws -> Return {
            let source = BaseDecoder.partition(returnData)
            
            let ret0 = try Solidity.UInt256.decode(source: source)
            
            return ret0
        }
        
        static func decode(argumentsData: String) throws -> Arguments {
            let source = BaseDecoder.partition(argumentsData)
            
            return
        }
    }
    
}

struct Standardtoken {
    
    struct Approve: SolidityFunction {
        static let methodId = "095ea7b3"
        typealias Return = Solidity.Bool
        typealias Arguments = (spender: Solidity.Address, value: Solidity.UInt256)
        
        static func encodeCall(arguments: Arguments) -> String {
            return "0x\(methodId)\(BaseEncoder.encode(arguments: arguments.spender, arguments.value))"
        }
        
        static func decode(returnData: String) throws -> Return {
            let source = BaseDecoder.partition(returnData)
            
            let ret0 = try Solidity.Bool.decode(source: source)
            
            return ret0
        }
        
        static func decode(argumentsData: String) throws -> Arguments {
            let source = BaseDecoder.partition(argumentsData)
            
            let spender = try Solidity.Address.decode(source: source)
            
            let value = try Solidity.UInt256.decode(source: source)
            
            return Arguments(spender: spender, value: value)
        }
    }
    
    struct Totalsupply: SolidityFunction {
        static let methodId = "18160ddd"
        typealias Return = Solidity.UInt256
        typealias Arguments = Void
        
        static func encodeCall(arguments: Arguments) -> String {
            return "0x\(methodId)\(BaseEncoder.encode(arguments: arguments))"
        }
        
        static func decode(returnData: String) throws -> Return {
            let source = BaseDecoder.partition(returnData)
            
            let ret0 = try Solidity.UInt256.decode(source: source)
            
            return ret0
        }
        
        static func decode(argumentsData: String) throws -> Arguments {
            let source = BaseDecoder.partition(argumentsData)
            
            return
        }
    }
    
    struct Transferfrom: SolidityFunction {
        static let methodId = "23b872dd"
        typealias Return = Solidity.Bool
        typealias Arguments = (from: Solidity.Address, to: Solidity.Address, value: Solidity.UInt256)
        
        static func encodeCall(arguments: Arguments) -> String {
            return "0x\(methodId)\(BaseEncoder.encode(arguments: arguments.from, arguments.to, arguments.value))"
        }
        
        static func decode(returnData: String) throws -> Return {
            let source = BaseDecoder.partition(returnData)
            
            let ret0 = try Solidity.Bool.decode(source: source)
            
            return ret0
        }
        
        static func decode(argumentsData: String) throws -> Arguments {
            let source = BaseDecoder.partition(argumentsData)
            
            let from = try Solidity.Address.decode(source: source)
            
            let to = try Solidity.Address.decode(source: source)
            
            let value = try Solidity.UInt256.decode(source: source)
            
            return Arguments(from: from, to: to, value: value)
        }
    }
    
    struct Balanceof: SolidityFunction {
        static let methodId = "70a08231"
        typealias Return = Solidity.UInt256
        typealias Arguments = Solidity.Address
        
        static func encodeCall(arguments: Arguments) -> String {
            return "0x\(methodId)\(BaseEncoder.encode(arguments: arguments))"
        }
        
        static func decode(returnData: String) throws -> Return {
            let source = BaseDecoder.partition(returnData)
            
            let ret0 = try Solidity.UInt256.decode(source: source)
            
            return ret0
        }
        
        static func decode(argumentsData: String) throws -> Arguments {
            let source = BaseDecoder.partition(argumentsData)
            
            let owner = try Solidity.Address.decode(source: source)
            
            return owner
        }
    }
    
    struct Transfer: SolidityFunction {
        static let methodId = "a9059cbb"
        typealias Return = Solidity.Bool
        typealias Arguments = (to: Solidity.Address, value: Solidity.UInt256)
        
        static func encodeCall(arguments: Arguments) -> String {
            return "0x\(methodId)\(BaseEncoder.encode(arguments: arguments.to, arguments.value))"
        }
        
        static func decode(returnData: String) throws -> Return {
            let source = BaseDecoder.partition(returnData)
            
            let ret0 = try Solidity.Bool.decode(source: source)
            
            return ret0
        }
        
        static func decode(argumentsData: String) throws -> Arguments {
            let source = BaseDecoder.partition(argumentsData)
            
            let to = try Solidity.Address.decode(source: source)
            
            let value = try Solidity.UInt256.decode(source: source)
            
            return Arguments(to: to, value: value)
        }
    }
    
    struct Allowance: SolidityFunction {
        static let methodId = "dd62ed3e"
        typealias Return = Solidity.UInt256
        typealias Arguments = (owner: Solidity.Address, spender: Solidity.Address)
        
        static func encodeCall(arguments: Arguments) -> String {
            return "0x\(methodId)\(BaseEncoder.encode(arguments: arguments.owner, arguments.spender))"
        }
        
        static func decode(returnData: String) throws -> Return {
            let source = BaseDecoder.partition(returnData)
            
            let ret0 = try Solidity.UInt256.decode(source: source)
            
            return ret0
        }
        
        static func decode(argumentsData: String) throws -> Arguments {
            let source = BaseDecoder.partition(argumentsData)
            
            let owner = try Solidity.Address.decode(source: source)
            
            let spender = try Solidity.Address.decode(source: source)
            
            return Arguments(owner: owner, spender: spender)
        }
    }
    
}
