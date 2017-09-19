//
//  ParameterParserSpec.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 18.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//

import Quick
import Nimble
@testable import Bivrost

class ParameterParserSpec: QuickSpec {
    override func spec() {
        describe("ParameterParser") {
            it("should throw when given an empty element") {
                expect { try ParameterParser.parseParameterType(from: [:]) }
                    .to(throwError(BivrostError.parameterTypeNotFound))
            }
            
            it("should throw when given an invalid type") {
                expect { try ParameterParser.parseParameterType(from: ["type": "foo"]) }
                    .to(throwError(BivrostError.parameterTypeInvalid))
            }
            
            it("should parse dynamic arrays of exact matches correctly") {
                expect { try ParameterParser.parseParameterType(from: ["type": "uint[]"]) } == .dynamicType(.array(.uint(bits: 256)))
                expect { try ParameterParser.parseParameterType(from: ["type": "bool[]"]) } == .dynamicType(.array(.bool))
                expect { try ParameterParser.parseParameterType(from: ["type": "address[]"]) } == .dynamicType(.array(.address))
                expect { try ParameterParser.parseParameterType(from: ["type": "function[]"]) } == .dynamicType(.array(.function))
                expect { try ParameterParser.parseParameterType(from: ["type": "int[]"]) } == .dynamicType(.array(.int(bits: 256)))
            }
            
            it("should throw when parsing dynamic arrays of dynamic types") {
                expect { try ParameterParser.parseParameterType(from: ["type": "bytes[]"]) }.to(throwError(BivrostError.parameterTypeInvalid))
                expect { try ParameterParser.parseParameterType(from: ["type": "string[]"]) }.to(throwError(BivrostError.parameterTypeInvalid))
                expect { try ParameterParser.parseParameterType(from: ["type": "int[][]"]) }.to(throwError(BivrostError.parameterTypeInvalid))
            }
        }
    }
}
