// https://github.com/Quick/Quick

import Quick
import Nimble
@testable import Bivrost

class JsonParserSpec: QuickSpec {
    override func spec() {
        describe("JsonParser") {

            // NOT USEFUL RIGHT NOW
            it("should throw when given an empty contract or element") {
                expect { try ContractJSONParser.parseContractElement(from: [:]) }
                    .to(throwError())
                expect { try ContractJSONParser.parseContract(from: [[:]]) }
                    .to(throwError())
            }
            
            context("Fallback Function") {
                it("should parse an empty fallback element correctly with defaults") {
                    let json = ["type": "fallback"]
                    expect { try ContractJSONParser.parseContractElement(from: json) }
                        .to(beFallback { fallback in
                            expect(fallback.constant).to(equal(false))
                            expect(fallback.payable).to(equal(false))
                        })
                }
                
                it("should parse a fallback element correctly") {
                    let json: [String: Any] = ["type": "fallback", "constant": true, "payable": true]
                    expect { try ContractJSONParser.parseContractElement(from: json) }
                        .to(beFallback { fallback in
                            expect(fallback.constant).to(equal(true))
                            expect(fallback.payable).to(equal(true))
                        })
                }
            }
            
            context("Constructor Function") {
                it("should parse an empty constructor element correctly with defaults") {
                    let json = ["type": "constructor"]
                    expect { try ContractJSONParser.parseContractElement(from: json) }
                        .to(beConstructor { constructor in
                            expect(constructor.inputs).to(beEmpty())
                            expect(constructor.constant).to(equal(false))
                            expect(constructor.payable).to(equal(false))
                        })
                }
                
                it("should parse a constructor element correctly") {
                    let json: [String: Any] = ["type": "constructor",
                                               "constant": true,
                                               "payable": true,
                                               "inputs": [["name":"a", "type":"uint256"]]
                    ]
                    expect { try ContractJSONParser.parseContractElement(from: json) }
                        .to(beConstructor { constructor in
                            expect(constructor.inputs.count).to(equal(1))
                            expect(constructor.inputs.first?.name).to(equal("a"))
                            expect(constructor.inputs.first?.type).to(equal(Contract.ParameterType.uint256))
                            expect(constructor.constant).to(equal(true))
                            expect(constructor.payable).to(equal(true))
                        })
                }
            }
            
            context("Function Function") {
                it("should throw when given a function element without proper fields") {
                    let json = ["type": "function"]
                    expect { try ContractJSONParser.parseContractElement(from: json) }
                        .to(throwError())
                }
                
                it("should parse a mostly empty function element correctly with defaults") {
                    let json = ["type": "function", "name": "foo"]
                    expect { try ContractJSONParser.parseContractElement(from: json) }
                        .to(beFunction { function in
                            expect(function.inputs).to(beEmpty())
                            expect(function.outputs).to(beEmpty())
                            expect(function.constant).to(equal(false))
                            expect(function.payable).to(equal(false))
                            expect(function.name).to(equal("foo"))
                        })
                }
                
                it("should parse a function element without type correctly") {
                    // TODO: test more parametertypes
                    let json: [String: Any] = ["name": "foo2",
                                               "constant": true,
                                               "payable": false,
                                               "inputs": [["name":"a", "type":"uint256"]],
                                               "outputs": [["name":"b", "type":"uint256"]]
                    ]
                    expect { try ContractJSONParser.parseContractElement(from: json) }
                        .to(beFunction { function in
                            expect(function.inputs.count).to(equal(1))
                            expect(function.inputs.first?.name).to(equal("a"))
                            expect(function.inputs.first?.type).to(equal(Contract.ParameterType.uint256))
                            
                            expect(function.outputs.count).to(equal(1))
                            expect(function.outputs.first?.name).to(equal("b"))
                            expect(function.outputs.first?.type).to(equal(Contract.ParameterType.uint256))
                            
                            expect(function.constant).to(equal(true))
                            expect(function.payable).to(equal(false))
                            expect(function.name).to(equal("foo2"))
                        })
                }
            }
            context("Event Element") {
                it("should throw when given an event element without proper fields") {
                    let json = ["type": "event"]
                    expect { try ContractJSONParser.parseContractElement(from: json) }
                        .to(throwError())
                }
                
                it("should parse a mostly empty event element correctly with defaults") {
                    let json = ["type": "event", "name": "foo"]
                    expect { try ContractJSONParser.parseContractElement(from: json) }
                        .to(beEvent { event in
                            expect(event.inputs).to(beEmpty())
                            expect(event.name).to(equal("foo"))
                            expect(event.anonymous).to(equal(false))
                        })
                }
                
                it("should parse an event element correctly") {
                    // TODO: test more parametertypes
                    let json: [String: Any] = ["type": "event",
                                               "name": "foo2",
                                               "anonymous": true,
                                               "inputs": [["name":"a", "type":"uint256", "indexed": true]]
                    ]
                    expect { try ContractJSONParser.parseContractElement(from: json) }
                        .to(beEvent { event in
                            expect(event.inputs.count).to(equal(1))
                            expect(event.inputs.first?.name).to(equal("a"))
                            expect(event.inputs.first?.type).to(equal(Contract.ParameterType.uint256))
                            expect(event.inputs.first?.indexed).to(equal(true))
                            
                            expect(event.name).to(equal("foo2"))
                            expect(event.anonymous).to(equal(true))
                        })
                }
            }
        }
    }
}

// MARK: Matchers

func beFallback(test: @escaping (Contract.Fallback) -> () = { _ in } ) -> MatcherFunc<Contract.Element> {
    return MatcherFunc { expression, message in
        message.postfixMessage = "be a Fallback object"
        if let actual = try expression.evaluate(),
            case let .fallback(fallback) = actual {
            test(fallback)
            return true
        }
        return false
    }
}

func beConstructor(test: @escaping (Contract.Constructor) -> () = { _ in } ) -> MatcherFunc<Contract.Element> {
    return MatcherFunc { expression, message in
        message.postfixMessage = "be a Constructor object"
        if let actual = try expression.evaluate(),
            case let .constructor(constructor) = actual {
            test(constructor)
            return true
        }
        return false
    }
}

func beFunction(test: @escaping (Contract.Function) -> () = { _ in } ) -> MatcherFunc<Contract.Element> {
    return MatcherFunc { expression, message in
        message.postfixMessage = "be a Function object"
        if let actual = try expression.evaluate(),
            case let .function(function) = actual {
            test(function)
            return true
        }
        return false
    }
}

func beEvent(test: @escaping (Contract.Event) -> () = { _ in } ) -> MatcherFunc<Contract.Element> {
    return MatcherFunc { expression, message in
        message.postfixMessage = "be an Event object"
        if let actual = try expression.evaluate(),
            case let .event(event) = actual {
            test(event)
            return true
        }
        return false
    }
}
