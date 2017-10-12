//
//  ContractTemplate.swift
//  BivrostKit
//
//  Created by Luis Reisewitz on 11.10.17.
//

import BigInt

extension Templates {
    static let Contract = """
        //
        //  {{ contract.name }}.swift
        //
        //  Generated by Bivrost at {{ timestamp }}.
        //

        struct {{ contract.name }} {
            {% for function in contract.functions %}
            struct {{ function.name }}: SolidityFunction {
                static let methodId = "{{ function.methodId }}"
                typealias Return = {{ function.output }}
                typealias Arguments = {{ function.input }}
                
                static func encodeCall(arguments: Arguments) -> String {
                    return "0x\\(methodId)\\(BaseEncoder.encode(arguments: {{ function.encodeArguments }}))"
                }
                
                static func decode(returnData: String) throws -> Return {
                    let source = BaseDecoder.partition(returnData)
                    {% for decodedType in function.decodeReturnTypes %}
                    let {{ decodedType.name }} = try {{ decodedType.type }}.decode(source: source)
                    {% endfor %}
                    return {{ function.decodeReturnReturnValue }}
                }
                
                static func decode(argumentsData: String) throws -> Arguments {
                    let source = BaseDecoder.partition(argumentsData)
                    {% for decodedType in function.decodeArgumentsTypes %}
                    let {{ decodedType.name }} = try {{ decodedType.type }}.decode(source: source)
                    {% endfor %}
                    return {{ function.decodeArgumentsReturnValue }}
                }
            }
            {% endfor %}
        }
        """
}
