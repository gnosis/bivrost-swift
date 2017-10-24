//
//  ElementJsonParserSpec.swift
//  BivrostKitTests
//
//  Created by Luis Reisewitz on 10.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//
//

@testable import BivrostKit
import Nimble
import Quick

private typealias Element = Contract.Element

class ElementJsonParserSpec: QuickSpec {
    override func spec() {
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
                            expect(fallback.constant) == false
                            expect(fallback.payable) == false
                        })
                }

                it("should parse a fallback element correctly") {
                    let json: [String: Any] = ["type": "fallback", "constant": true, "payable": true]
                    expect { try ElementJsonParser.parseContractElement(from: json) }
                        .to(beFallback { fallback in
                            expect(fallback.constant) == true
                            expect(fallback.payable) == true
                        })
                }
            }

            context("Constructor Function") {
                it("should parse an empty constructor element correctly with defaults") {
                    let json = ["type": "constructor"]
                    expect { try ElementJsonParser.parseContractElement(from: json) }
                        .to(beConstructor { constructor in
                            expect(constructor.inputs).to(beEmpty())
                            expect(constructor.constant) == false
                            expect(constructor.payable) == false
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
                            expect(constructor.inputs.count) == 1
                            expect(constructor.inputs.first?.name) == "a"
                            expect(constructor.inputs.first?.type) == .staticType(.uint(bits: 256))
                            expect(constructor.constant) == true
                            expect(constructor.payable) == true
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
                            expect(function.constant) == false
                            expect(function.payable) == false
                            expect(function.name) == "foo"
                            expect(function.signature) == "foo()"
                            expect(function.methodId) == "c2985578"
                        })
                }

                it("should parse a function element without type correctly") {
                    let json: [String: Any] = ["name": "foo2",
                                               "constant": true,
                                               "payable": false,
                                               "inputs": [["name": "a", "type": "string"]],
                                               "outputs": [["name": "b", "type": "uint"]]
                    ]
                    expect { try ElementJsonParser.parseContractElement(from: json) }
                        .to(beFunction { function in
                            expect(function.inputs.count) == 1
                            expect(function.inputs.first?.name) == "a"
                            expect(function.inputs.first?.type) == .dynamicType(.string)

                            expect(function.outputs.count) == 1
                            expect(function.outputs.first?.name) == "b"
                            expect(function.outputs.first?.type) == .staticType(.uint(bits: 256))

                            expect(function.constant) == true
                            expect(function.payable) == false
                            expect(function.name) == "foo2"
                            expect(function.signature) == "foo2(string)"
                            expect(function.methodId) == "bfe4a119"
                        })
                }

                it("should parse a function element with all exact parameter types correctly") {
                    let json: [String: Any] = ["name": "foo2",
                                               "constant": true,
                                               "payable": false,
                                               "inputs": [["name": "a", "type": "address"],
                                                          ["name": "b", "type": "uint"],
                                                          ["name": "c", "type": "int"],
                                                          ["name": "d", "type": "bool"],
                                                          ["name": "e", "type": "function"],
                                                          ["name": "f", "type": "bytes"],
                                                          ["name": "g", "type": "string"]],
                                               "outputs": [["name": "b", "type": "uint"]]
                    ]
                    expect { try ElementJsonParser.parseContractElement(from: json) }
                        .to(beFunction { function in
                            // Test Inputs
                            expect(function.inputs.count) == 7
                            expect(function.inputs[0].name) == "a"
                            expect(function.inputs[0].type) == .staticType(.address)
                            expect(function.inputs[1].name) == "b"
                            expect(function.inputs[1].type) == .staticType(.uint(bits: 256))
                            expect(function.inputs[2].name) == "c"
                            expect(function.inputs[2].type) == .staticType(.int(bits: 256))
                            expect(function.inputs[3].name) == "d"
                            expect(function.inputs[3].type) == .staticType(.bool)
                            expect(function.inputs[4].name) == "e"
                            expect(function.inputs[4].type) == .staticType(.function)
                            expect(function.inputs[5].name) == "f"
                            expect(function.inputs[5].type) == .dynamicType(.bytes)
                            expect(function.inputs[6].name) == "g"
                            expect(function.inputs[6].type) == .dynamicType(.string)
                            // Test Output
                            expect(function.outputs.count) == 1
                            expect(function.outputs.first?.name) == "b"
                            expect(function.outputs.first?.type) == .staticType(.uint(bits: 256))
                            // Test function properties
                            expect(function.constant) == true
                            expect(function.payable) == false
                            expect(function.name) == "foo2"
                            expect(function.signature) == "foo2(address,uint256,int256,bool,function,bytes,string)"
                            expect(function.methodId) == "ebd557ad"
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
                            expect(event.name) == "foo"
                            expect(event.anonymous) == false
                        })
                }

                it("should parse an event element correctly") {
                    let json: [String: Any] = ["type": "event",
                                               "name": "foo2",
                                               "anonymous": true,
                                               "inputs": [["name": "a", "type": "bytes", "indexed": true]]
                    ]
                    expect { try ElementJsonParser.parseContractElement(from: json) }
                        .to(beEvent { event in
                            expect(event.inputs.count) == 1
                            expect(event.inputs.first?.name) == "a"
                            expect(event.inputs.first?.type) == .dynamicType(.bytes)
                            expect(event.inputs.first?.indexed) == true
                            expect(event.name) == "foo2"
                            expect(event.anonymous) == true
                        })
                }
            }
        }
    }
}

// MARK: - Matchers

private func beFallback(test: @escaping (Element.Fallback) -> Void = { _ in }) -> Predicate<Element> {
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

private func beConstructor(test: @escaping (Element.Constructor) -> Void = { _ in }) -> Predicate<Element> {
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

private func beFunction(test: @escaping (Element.Function) -> Void = { _ in }) -> Predicate<Element> {
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

private func beEvent(test: @escaping (Element.Event) -> Void = { _ in }) -> Predicate<Element> {
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
