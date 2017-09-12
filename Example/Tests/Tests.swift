// https://github.com/Quick/Quick

import Quick
import Nimble
@testable import Bivrost

class TableOfContentsSpec: QuickSpec {
    override func spec() {
        describe("JSONParser") {

            // NOT USEFUL RIGHT NOW
//            it("should throw when given an empty contract or element") {
//                expect { try ContractJSONParser.parseContractElement(from: [:]) }
//                    .to(throwError())
//                expect { try ContractJSONParser.parseContract(from: [[:]]) }
//                    .to(throwError())
//            }
            
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
                it("should parse an empty fallback element correctly with defaults") {
                    let json = ["type": "constructor"]
                    expect { try ContractJSONParser.parseContractElement(from: json) }
                        .to(beConstructor { constructor in
                            expect(constructor.inputs).to(beEmpty())
                            expect(constructor.constant).to(equal(false))
                            expect(constructor.payable).to(equal(false))
                        })
                }
                
                it("should parse a fallback element correctly") {
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
