//
//  ContractTemplate.swift
//  BivrostKit
//
//  Created by Luis Reisewitz on 11.10.17.
//

import BigInt

extension Templates {
    static let Contract = """

        struct {{ contract.name|capitalize }} {
            {% for function in contract.functions %}
            
            struct {{ function.name|capitalize }}: SolidityFunction {
                static let methodId = "{{ function.methodId }}"
                
                {% if function.outputs.count == 1 %}
                  typealias Return = {{ function.outputs[0].type }}
                {% else %}
                  typealias Return = (
                    {% for output in function.outputs %}
                      {{ output.name }}: {{ output.type }}
                      {% if not forloop.last %},{% endif %}
                    {% empty %}
                      Void
                    {% endfor %}
                  )
                {% endif %}
                
                {% if function.inputs.count == 1 %}
                  typealias Arguments = {{ function.inputs[0].type }}
                {% else %}
                  typealias Arguments = (
                    {% for input in function.inputs.returns %}
                      {{ input.name }}: {{ input.type }}
                      {% if not forloop.last %},{% endif %}
                    {% empty %}
                      Void
                    {% endfor %}
                  )
                {% endif %}
            }
            
            {% endfor %}
        }
    """
}
struct StandardToken {
    struct Approve: SolidityFunction {
        static let methodId = "095ea7b3"
        typealias Arguments = (spender: Solidity.Address, value: Solidity.UInt256)
        typealias Return = Solidity.Bool
        
        static func encodeCall(arguments: Arguments) -> String {
            return "0x\(methodId)\(BaseEncoder.encode(arguments: arguments.spender, arguments.value))"
        }
        
        static func decode(returnData: String) throws -> Return {
            let source = BaseDecoder.partition(returnData)
            
            let ret0 = try Solidity.Bool.decode(source: source)
            
            // NOTE: There are no 1-element tuples in Swift, so we need to directly
            // return the only value.
            return ret0
        }
        
        static func decode(argumentsData: String) throws -> Arguments {
            let source = BaseDecoder.partition(argumentsData)
            
            let spender = try Solidity.Address.decode(source: source)
            let value = try Solidity.UInt256.decode(source: source)
            
            return Arguments(spender: spender, value: value)
        }
    }
    
    struct TotalSupply: SolidityFunction {
        static var methodId = "18160ddd"
        typealias Arguments = Void
        typealias Return = Solidity.UInt256
        
        // TODO: method needs to be called like this: encodeCall(arguments: ())
        static func encodeCall(arguments: Arguments) -> String {
            // TODO: There are no 1-element tuples in Swift, so we need to directly
            // encode the only value (in this case it's also Void).
            return "0x\(methodId)\(BaseEncoder.encode(arguments: arguments))"
        }
        
        static func decode(returnData: String) throws -> Return {
            let source = BaseDecoder.partition(returnData)
            
            let ret0 = try Solidity.UInt256.decode(source: source)
            
            // TODO: There are no 1-element tuples in Swift, so we need to directly
            // return the only value.
            return ret0
        }
        
        static func decode(argumentsData: String) throws -> Void {
            // TODO: Void arguments cannot be decoded, method needs to be empty
            return
        }
    }
    
    struct TransferFrom: SolidityFunction {
        static var methodId = "23b872dd"
        typealias Arguments = (from: Solidity.Address, to: Solidity.Address, value: Solidity.UInt256)
        typealias Return = Solidity.Bool
        
        static func encodeCall(arguments: Arguments) -> String {
            return "0x\(methodId)\(BaseEncoder.encode(arguments: arguments.from, arguments.to, arguments.value))"
        }
        
        static func decode(returnData: String) throws -> Return {
            let source = BaseDecoder.partition(returnData)
            
            let ret0 = try Solidity.Bool.decode(source: source)
            
            // TODO: There are no 1-element tuples in Swift, so we need to directly
            // return the only value.
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
    
    struct BalanceOf: SolidityFunction {
        static var methodId = "70a08231"
        // TODO: Named single arguments cannot have the name, as named single element tuples are not allowed
        typealias Arguments = Solidity.Address
        typealias Return = Solidity.UInt256
        
        static func encodeCall(arguments: Arguments) -> String {
            // TODO: There are no 1-element tuples in Swift, so we need to directly
            // encode the only value.
            return "0x\(methodId)\(BaseEncoder.encode(arguments: arguments))"
        }
        
        static func decode(returnData: String) throws -> Return {
            let source = BaseDecoder.partition(returnData)
            
            let ret0 = try Solidity.UInt256.decode(source: source)
            
            return ret0
        }
        
        static func decode(argumentsData: String) throws -> Arguments {
            let source = BaseDecoder.partition(argumentsData)
            
            // TODO: We know the argument name here, although we cannot use it in other places
            let owner = try Solidity.Address.decode(source: source)
            
            return owner
        }
    }
    
    struct Transfer: SolidityFunction {
        static var methodId = "a9059cbb"
        typealias Arguments = (to: Solidity.Address, value: Solidity.UInt256)
        typealias Return = Solidity.Bool
        
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
        static var methodId = "dd62ed3e"
        typealias Arguments = (owner: Solidity.Address, spender: Solidity.Address)
        typealias Return = Solidity.Bool
        
        static func encodeCall(arguments: Arguments) -> String {
            return "0x\(methodId)\(BaseEncoder.encode(arguments: arguments.owner, arguments.spender))"
        }
        
        static func decode(returnData: String) throws -> Return {
            let source = BaseDecoder.partition(returnData)
            
            let ret0 = try Solidity.Bool.decode(source: source)
            
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
