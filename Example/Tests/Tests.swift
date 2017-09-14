// https://github.com/Quick/Quick

import Quick
import Nimble
@testable import Bivrost

class ElementJsonParserSpec: QuickSpec {
    override func spec() {
        // TODO: test more complex (arrays + nested arrays) parametertypes
        
        describe("ElementJsonParser") {

            it("should throw when given an empty element") {
                expect { try ElementJsonParser.parseContractElement(from: [:]) }
                    .to(throwError())
            }
            
            context("Fallback Function") {
                it("should parse an empty fallback element correctly with defaults") {
                    let json = ["type": "fallback"]
                    expect { try ElementJsonParser.parseContractElement(from: json) }
                        .to(beFallback { fallback in
                            expect(fallback.constant).to(equal(false))
                            expect(fallback.payable).to(equal(false))
                        })
                }
                
                it("should parse a fallback element correctly") {
                    let json: [String: Any] = ["type": "fallback", "constant": true, "payable": true]
                    expect { try ElementJsonParser.parseContractElement(from: json) }
                        .to(beFallback { fallback in
                            expect(fallback.constant).to(equal(true))
                            expect(fallback.payable).to(equal(true))
                        })
                }
            }
            
            context("Constructor Function") {
                it("should parse an empty constructor element correctly with defaults") {
                    let json = ["type": "constructor"]
                    expect { try ElementJsonParser.parseContractElement(from: json) }
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
                                               "inputs": [["name": "a", "type": "uint"]]
                    ]
                    expect { try ElementJsonParser.parseContractElement(from: json) }
                        .to(beConstructor { constructor in
                            expect(constructor.inputs.count).to(equal(1))
                            expect(constructor.inputs.first?.name).to(equal("a"))
                            expect(constructor.inputs.first?.type) == .staticType(.uint(bits: 256))
                            expect(constructor.constant).to(equal(true))
                            expect(constructor.payable).to(equal(true))
                        })
                }
            }
            
            context("Function Function") {
                it("should throw when given a function element without proper fields") {
                    let json = ["type": "function"]
                    expect { try ElementJsonParser.parseContractElement(from: json) }
                        .to(throwError())
                }
                
                it("should parse a mostly empty function element correctly with defaults") {
                    let json = ["type": "function", "name": "foo"]
                    expect { try ElementJsonParser.parseContractElement(from: json) }
                        .to(beFunction { function in
                            expect(function.inputs).to(beEmpty())
                            expect(function.outputs).to(beEmpty())
                            expect(function.constant).to(equal(false))
                            expect(function.payable).to(equal(false))
                            expect(function.name).to(equal("foo"))
                        })
                }
                
                it("should parse a function element without type correctly") {
                    let json: [String: Any] = ["name": "foo2",
                                               "constant": true,
                                               "payable": false,
                                               "inputs": [["name":"a", "type":"string"]],
                                               "outputs": [["name":"b", "type":"uint"]]
                    ]
                    expect { try ElementJsonParser.parseContractElement(from: json) }
                        .to(beFunction { function in
                            expect(function.inputs.count).to(equal(1))
                            expect(function.inputs.first?.name).to(equal("a"))
                            expect(function.inputs.first?.type) == .dynamicType(.string)
                            
                            expect(function.outputs.count).to(equal(1))
                            expect(function.outputs.first?.name).to(equal("b"))
                            expect(function.outputs.first?.type) == .staticType(.uint(bits: 256))
                            
                            expect(function.constant).to(equal(true))
                            expect(function.payable).to(equal(false))
                            expect(function.name).to(equal("foo2"))
                        })
                }
                
                it("should parse a function element with all exact parameter types correctly") {
                    let json: [String: Any] = ["name": "foo2",
                                               "constant": true,
                                               "payable": false,
                                               "inputs": [["name":"a", "type":"address"],
                                                          ["name":"b", "type":"uint"],
                                                          ["name":"c", "type":"int"],
                                                          ["name":"d", "type":"bool"],
                                                          ["name":"e", "type":"function"],
                                                          ["name":"f", "type":"bytes"],
                                                          ["name":"g", "type":"string"]],
                                               "outputs": [["name":"b", "type":"uint"]]
                    ]
                    expect { try ElementJsonParser.parseContractElement(from: json) }
                        .to(beFunction { function in
                            // Test Inputs
                            expect(function.inputs.count).to(equal(7))
                            expect(function.inputs[0].name).to(equal("a"))
                            expect(function.inputs[0].type).to(equal(.staticType(.address)))
                            expect(function.inputs[1].name).to(equal("b"))
                            expect(function.inputs[1].type).to(equal(.staticType(.uint(bits: 256))))
                            expect(function.inputs[2].name).to(equal("c"))
                            expect(function.inputs[2].type).to(equal(.staticType(.int(bits: 256))))
                            expect(function.inputs[3].name).to(equal("d"))
                            expect(function.inputs[3].type).to(equal(.staticType(.bool)))
                            expect(function.inputs[4].name).to(equal("e"))
                            expect(function.inputs[4].type).to(equal(.staticType(.function)))
                            expect(function.inputs[5].name).to(equal("f"))
                            expect(function.inputs[5].type).to(equal(.dynamicType(.bytes)))
                            expect(function.inputs[6].name).to(equal("g"))
                            expect(function.inputs[6].type).to(equal(.dynamicType(.string)))
                            // Test Output
                            expect(function.outputs.count).to(equal(1))
                            expect(function.outputs.first?.name).to(equal("b"))
                            expect(function.outputs.first?.type) == .staticType(.uint(bits: 256))
                            // Test function properties
                            expect(function.constant).to(equal(true))
                            expect(function.payable).to(equal(false))
                            expect(function.name).to(equal("foo2"))
                        })
                }
                
                
            }
            context("Event Element") {
                it("should throw when given an event element without proper fields") {
                    let json = ["type": "event"]
                    expect { try ElementJsonParser.parseContractElement(from: json) }
                        .to(throwError())
                }
                
                it("should parse a mostly empty event element correctly with defaults") {
                    let json = ["type": "event", "name": "foo"]
                    expect { try ElementJsonParser.parseContractElement(from: json) }
                        .to(beEvent { event in
                            expect(event.inputs).to(beEmpty())
                            expect(event.name).to(equal("foo"))
                            expect(event.anonymous).to(equal(false))
                        })
                }
                
                it("should parse an event element correctly") {
                    let json: [String: Any] = ["type": "event",
                                               "name": "foo2",
                                               "anonymous": true,
                                               "inputs": [["name":"a", "type":"bytes", "indexed": true]]
                    ]
                    expect { try ElementJsonParser.parseContractElement(from: json) }
                        .to(beEvent { event in
                            expect(event.inputs.count).to(equal(1))
                            expect(event.inputs.first?.name).to(equal("a"))
                            expect(event.inputs.first?.type) == .dynamicType(.bytes)
                            expect(event.inputs.first?.indexed).to(equal(true))
                            expect(event.name).to(equal("foo2"))
                            expect(event.anonymous).to(equal(true))
                        })
                }
            }
        }
    }
}

// MARK: - Matchers

fileprivate func beFallback(test: @escaping (Contract.Fallback) -> () = { _ in } ) -> Predicate<Contract.Element> {
    return Predicate { expression in
        let message = ExpectationMessage.expectedTo("be a Fallback object")
        if let actual = try expression.evaluate(),
            case let .fallback(fallback) = actual {
            test(fallback)
            return PredicateResult(bool: true, message: message)
        }
        return PredicateResult(bool: false, message: message)
    }
}

fileprivate func beConstructor(test: @escaping (Contract.Constructor) -> () = { _ in } ) -> Predicate<Contract.Element> {
    return Predicate { expression in
        let message = ExpectationMessage.expectedTo("be a Constructor object")
        if let actual = try expression.evaluate(),
            case let .constructor(constructor) = actual {
            test(constructor)
            return PredicateResult(bool: true, message: message)
        }
        return PredicateResult(bool: false, message: message)
    }
}

fileprivate func beFunction(test: @escaping (Contract.Function) -> () = { _ in } ) -> Predicate<Contract.Element> {
    return Predicate { expression in
        let message = ExpectationMessage.expectedTo("be a Function object")
        if let actual = try expression.evaluate(),
            case let .function(function) = actual {
            test(function)
            return PredicateResult(bool: true, message: message)
        }
        return PredicateResult(bool: false, message: message)
    }
}

fileprivate func beEvent(test: @escaping (Contract.Event) -> () = { _ in } ) -> Predicate<Contract.Element> {
    return Predicate { expression in
        let message = ExpectationMessage.expectedTo("be an Event object")
        if let actual = try expression.evaluate(),
            case let .event(event) = actual {
            test(event)
            return PredicateResult(bool: true, message: message)
        }
        return PredicateResult(bool: false, message: message)
    }
}
