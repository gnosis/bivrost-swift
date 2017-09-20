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
                expect { try ParameterParser.parseParameterType(from: ["type": "uint 32"]) }
                        .to(throwError(BivrostError.parameterTypeInvalid))
                expect { try ParameterParser.parseParameterType(from: ["type": "uint [ 16]"]) }
                    .to(throwError(BivrostError.parameterTypeInvalid))
                expect { try ParameterParser.parseParameterType(from: ["type": "uint [32]"]) }
                    .to(throwError(BivrostError.parameterTypeInvalid))
                expect { try ParameterParser.parseParameterType(from: ["type": "uint16[32]  "]) }
                    .to(throwError(BivrostError.parameterTypeInvalid))
            }
            
            context("dynamic arrays") {
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
            
            context("fixed length arrays") {
                it("should parse fixed arrays of exact matches correctly") {
                    expect { try ParameterParser.parseParameterType(from: ["type": "uint[16]"]) } == .staticType(.array(.uint(bits: 256), length: 16))
                    expect { try ParameterParser.parseParameterType(from: ["type": "bool[22]"]) } == .staticType(.array(.bool, length: 22))
                    expect { try ParameterParser.parseParameterType(from: ["type": "address[32]"]) } == .staticType(.array(.address, length: 32))
                    expect { try ParameterParser.parseParameterType(from: ["type": "function[1]"]) } == .staticType(.array(.function, length: 1))
                    expect { try ParameterParser.parseParameterType(from: ["type": "int[5]"]) } == .staticType(.array(.int(bits: 256), length: 5))
                }
                
                it("should throw when parsing fixed arrays of dynamic types") {
                    expect { try ParameterParser.parseParameterType(from: ["type": "bytes[16]"]) }.to(throwError(BivrostError.parameterTypeInvalid))
                    expect { try ParameterParser.parseParameterType(from: ["type": "string[5]"]) }.to(throwError(BivrostError.parameterTypeInvalid))
                    expect { try ParameterParser.parseParameterType(from: ["type": "int[][19]"]) }.to(throwError(BivrostError.parameterTypeInvalid))
                }
                
                it("should parse nested fixed arrays of exact matches correctly") {
                    expect { try ParameterParser.parseParameterType(from: ["type": "uint[16][32]"]) } == .staticType(.array(.array(.uint(bits: 256), length: 16), length: 32))
                    expect { try ParameterParser.parseParameterType(from: ["type": "bool[22][5]"]) } == .staticType(.array(.array(.bool, length: 22), length: 5))
                    expect { try ParameterParser.parseParameterType(from: ["type": "address[32][7]"]) } == .staticType(.array(.array(.address, length: 32), length: 7))
                    expect { try ParameterParser.parseParameterType(from: ["type": "function[1][1]"]) } == .staticType(.array(.array(.function, length: 1), length: 1))
                    expect { try ParameterParser.parseParameterType(from: ["type": "int[5][9]"]) } == .staticType(.array(.array(.int(bits: 256), length: 5), length: 9))
                }
            }
            
            context("number types") {
                it("should parse lengths of exact matches correctly") {
                    expect { try ParameterParser.parseParameterType(from: ["type": "uint16"]) } == .staticType(.uint(bits: 16))
                    expect { try ParameterParser.parseParameterType(from: ["type": "int64"]) } == .staticType(.int(bits: 64))
                    expect { try ParameterParser.parseParameterType(from: ["type": "bytes3"]) } == .staticType(.bytes(length: 3))
                }
                
                it("should throw when parsing non-length types with length") {
                    expect { try ParameterParser.parseParameterType(from: ["type": "address16"]) }.to(throwError(BivrostError.parameterTypeInvalid))
                    expect { try ParameterParser.parseParameterType(from: ["type": "int[16]16"]) }.to(throwError(BivrostError.parameterTypeInvalid))
                    expect { try ParameterParser.parseParameterType(from: ["type": "function16"]) }.to(throwError(BivrostError.parameterTypeInvalid))
                    expect { try ParameterParser.parseParameterType(from: ["type": "foo16"]) }.to(throwError(BivrostError.parameterTypeInvalid))
                    expect { try ParameterParser.parseParameterType(from: ["type": "bool32"]) }.to(throwError(BivrostError.parameterTypeInvalid))
                }
                
                it("should throw when parsing length types with invalid length") {
                    expect { try ParameterParser.parseParameterType(from: ["type": "uint0"]) }.to(throwError(BivrostError.parameterTypeInvalid))
                    expect { try ParameterParser.parseParameterType(from: ["type": "uint257"]) }.to(throwError(BivrostError.parameterTypeInvalid))
                    expect { try ParameterParser.parseParameterType(from: ["type": "uint9"]) }.to(throwError(BivrostError.parameterTypeInvalid))
                    expect { try ParameterParser.parseParameterType(from: ["type": "uint7"]) }.to(throwError(BivrostError.parameterTypeInvalid))
                    expect { try ParameterParser.parseParameterType(from: ["type": "int257"]) }.to(throwError(BivrostError.parameterTypeInvalid))
                    expect { try ParameterParser.parseParameterType(from: ["type": "int9"]) }.to(throwError(BivrostError.parameterTypeInvalid))
                    expect { try ParameterParser.parseParameterType(from: ["type": "int7"]) }.to(throwError(BivrostError.parameterTypeInvalid))
                    expect { try ParameterParser.parseParameterType(from: ["type": "int2000"]) }.to(throwError(BivrostError.parameterTypeInvalid))
                    expect { try ParameterParser.parseParameterType(from: ["type": "uint2000"]) }.to(throwError(BivrostError.parameterTypeInvalid))
                    expect { try ParameterParser.parseParameterType(from: ["type": "bytes64"]) }.to(throwError(BivrostError.parameterTypeInvalid))
                    expect { try ParameterParser.parseParameterType(from: ["type": "bytes0"]) }.to(throwError(BivrostError.parameterTypeInvalid))
                    expect { try ParameterParser.parseParameterType(from: ["type": "bytes000"]) }.to(throwError(BivrostError.parameterTypeInvalid))
                    expect { try ParameterParser.parseParameterType(from: ["type": "uint17[]"]) }.to(throwError(BivrostError.parameterTypeInvalid))
                    expect { try ParameterParser.parseParameterType(from: ["type": "int33[16][16]"]) }.to(throwError(BivrostError.parameterTypeInvalid))
                    expect { try ParameterParser.parseParameterType(from: ["type": "uint0016"]) }.to(throwError(BivrostError.parameterTypeInvalid))
                }
            }
        }
    }
}
