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

                {% if function.hasEmptyDecodeReturnFunction %}
                static func decode(returnData: String) throws -> Return {}
                {% else %}
                static func decode(returnData: String) throws -> Return {
                    let source = BaseDecoder.partition(returnData)
                    // Static Types & Location
                    {% for decodedType in function.decodeReturnTypes %}
                        {% if decodedType.isDynamic %}
                    // Ignore location for dynamic type
                    _ = try source.consume()
                        {% else %}
                    let {{ decodedType.name }} = try {{ decodedType.type }}.decode(source: source)
                        {% endif %}
                    {% endfor %}
                    // Dynamic Types
                    {% for decodedType in function.decodeReturnTypes %}
                        {% if decodedType.isDynamic %}
                    let {{ decodedType.name }} = try {{ decodedType.type }}.decode(source: source)
                        {% endif %}
                    {% endfor %}
                    return {{ function.decodeReturnReturnValue }}
                }
                {% endif %}

                {% if function.hasEmptyDecodeArgumentsFunction %}
                static func decode(argumentsData: String) throws -> Arguments {}
                {% else %}
                static func decode(argumentsData: String) throws -> Arguments {
                    let source = BaseDecoder.partition(argumentsData)
                    // Static Types & Location
                    {% for decodedType in function.decodeArgumentsTypes %}
                        {% if decodedType.isDynamic %}
                    // Ignore location for dynamic type
                    _ = try source.consume()
                        {% else %}
                    let {{ decodedType.name }} = try {{ decodedType.type }}.decode(source: source)
                        {% endif %}
                    {% endfor %}
                    // Dynamic Types
                    {% for decodedType in function.decodeArgumentsTypes %}
                        {% if decodedType.isDynamic %}
                    let {{ decodedType.name }} = try {{ decodedType.type }}.decode(source: source)
                        {% endif %}
                    {% endfor %}
                    return {{ function.decodeArgumentsReturnValue }}
                }
                {% endif %}
            }
            {% endfor %}
        }

        """
}
