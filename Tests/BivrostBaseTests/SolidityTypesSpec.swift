//
//  SolidityTypesSpec.swift
//  BivrostBaseTests
//
//  Created by Luis Reisewitz on 25.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//


import Quick
import Nimble
@testable import BivrostBase
import BigInt
import Foundation

class SolidityTypesSpec: QuickSpec {
    override func spec() {
        describe("SolidityTypes") {
            // MARK: Static Types
            context("Address") {
                it("should be able to parse a hex address with or without leading 0x") {
                    expect(Solidity.Address("0xFF")).toNot(beNil())
                    expect(Solidity.Address("FF")).toNot(beNil())
                }
                
                it("should return exactly 40 chars when encoding unpadded") {
                    expect(Solidity.Address("0xFF")?.encodeUnpadded()) == "00000000000000000000000000000000000000ff"
                    expect(Solidity.Address("0x0")?.encodeUnpadded().characters.count) == 40
                    expect(Solidity.Address("0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF")?.encodeUnpadded()) == "ffffffffffffffffffffffffffffffffffffffff"
                    expect(Solidity.Address("0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF")?.encodeUnpadded().characters.count) == 40
                }
                
                it("should return exactly 64 chars when encoding normally") {
                    expect(Solidity.Address("0xFF")?.encode()) == "00000000000000000000000000000000000000000000000000000000000000ff"
                    expect(Solidity.Address("0x0")?.encode().characters.count) == 64
                    
                    expect(Solidity.Address("0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF")?.encode()) == "000000000000000000000000ffffffffffffffffffffffffffffffffffffffff"
                    expect(Solidity.Address("0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF")?.encode().characters.count) == 64
                }
                
                it("should return nil when handling invalid address (too large)") {
                   
                    // Exactly one nibble too large (20.5 bytes)
                    expect(Solidity.Address("0xfdadadafa000000000000000000fdadadafafffff")).to(beNil())
                }
            }
            context("UIntX") {
                it("should not be created when the given value does not fit into 256 bits") {
                   // Random large number bigger than 2**256
                    expect(Solidity.UInt256(BigUInt("65767676766576587658679697687685765765765765765765t765765765765765765765765765765765765765765757657657657657657657657657657657657657657657657657657657657657657657657657657657657657657657658768768768768687687687876876876876876876876876876876876876876876876876876876", radix: 36)!)).to(beNil())
                }
                
                it("should encode positive numbers correctly") {
                    expect(Solidity.UInt256(BigUInt(123))?.encode()) == "000000000000000000000000000000000000000000000000000000000000007b"
                    expect(Solidity.UInt256(BigUInt(1))?.encode()) == "0000000000000000000000000000000000000000000000000000000000000001"
                    // Max unsigned integer
                    expect(Solidity.UInt256(BigUInt("115792089237316195423570985008687907853269984665640564039457584007913129639935")!)?.encode()) == "ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"
                }
                
                it("should encode 0 correctly") {
                    expect(Solidity.UInt8(BigUInt(0))!.encode()) == "0000000000000000000000000000000000000000000000000000000000000000"
                    expect(Solidity.UInt256(BigUInt(0))!.encode()) == "0000000000000000000000000000000000000000000000000000000000000000"
                    expect(Solidity.UInt160(BigUInt(0))!.encode()) == "0000000000000000000000000000000000000000000000000000000000000000"
                }
            }
            
            context("IntX") {
                it("should not be created when the given value does not fit into 256 bits") {
                    // Random large number bigger than 2**255
                    expect(Solidity.Int256(BigInt("65767676766576587658679697687685765765765765765765t765765765765765765765765765765765765765765757657657657657657657657657657657657657657657657657657657657657657657657657657657657657657657658768768768768687687687876876876876876876876876876876876876876876876876876876", radix: 36)!)).to(beNil())
                }
                
                it("should encode negative numbers correctly") {
                    expect(Solidity.Int256(BigInt(-1))?.encode()) == "ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"
                }
                
                it("should encode positive numbers correctly") {
                    expect(Solidity.Int8(BigInt(123))?.encode()) == "000000000000000000000000000000000000000000000000000000000000007b"
                }
                
                it("should encode 0 correctly") {
                    expect(Solidity.Int8(BigInt(0))!.encode()) == "0000000000000000000000000000000000000000000000000000000000000000"
                    expect(Solidity.Int160(BigInt(0))!.encode()) == "0000000000000000000000000000000000000000000000000000000000000000"
                    expect(Solidity.Int256(BigInt(0))!.encode()) == "0000000000000000000000000000000000000000000000000000000000000000"
                }
            }
            
            context("BytesX") {
                it("should encode byte arrays correctly") {
                    let data1 = Data([UInt8](arrayLiteral: 0))
                    expect(Solidity.Bytes1(data1)?.encode()) == "0000000000000000000000000000000000000000000000000000000000000000"
                    let data2 = Data([UInt8](arrayLiteral: 0, 1))
                    expect(Solidity.Bytes2(data2)?.encode()) == "0001000000000000000000000000000000000000000000000000000000000000"
                    let data3 = Data([UInt8](arrayLiteral: 0, 1, 2))
                    expect(Solidity.Bytes3(data3)?.encode()) == "0001020000000000000000000000000000000000000000000000000000000000"
                    let string = "dave"
                    let data4 = string.data(using: .ascii)!
                    expect(Solidity.Bytes4(data4)?.encode()) == "6461766500000000000000000000000000000000000000000000000000000000"
                }
                
                it("should return nil when given data is too big for the type") {
                    let data1 = Data([UInt8](arrayLiteral: 0, 1))
                    expect(Solidity.Bytes1(data1)?.encode()).to(beNil())
                    let data2 = Data([UInt8](arrayLiteral: 0, 1, 2))
                    expect(Solidity.Bytes2(data2)?.encode()).to(beNil())
                    let data3 = Data([UInt8](arrayLiteral: 0, 1, 2, 3))
                    expect(Solidity.Bytes3(data3)?.encode()).to(beNil())
                    let string = "davedavedavedavedavedavedavedavedavedavedavedavedavedavedavedave"
                    let data4 = string.data(using: .ascii)!
                    expect(Solidity.Bytes32(data4)?.encode()).to(beNil())
                }
                
                it("should correctly pad if given data is smaller than the capacity") {
                    let data1 = Data([UInt8](arrayLiteral: 0))
                    expect(Solidity.Bytes2(data1)?.encode()) == "0000000000000000000000000000000000000000000000000000000000000000"
                    let data2 = Data([UInt8](arrayLiteral: 0, 1))
                    expect(Solidity.Bytes3(data2)?.encode()) == "0001000000000000000000000000000000000000000000000000000000000000"
                    let data3 = Data([UInt8](arrayLiteral: 0, 1, 2))
                    expect(Solidity.Bytes4(data3)?.encode()) == "0001020000000000000000000000000000000000000000000000000000000000"
                    let string = "dave"
                    let data4 = string.data(using: .ascii)!
                    expect(Solidity.Bytes32(data4)?.encode()) == "6461766500000000000000000000000000000000000000000000000000000000"
                }
            }
            
            context("FixedArray") {
                it("should encode multiple positive numbers correctly") {
                    let array = Solidity.FixedArray([
                        Solidity.Int256(BigInt(-1))!,
                        Solidity.Int256(BigInt(123))!
                    ])
                    expect(array.encode()) == "ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000007b"
                }
                
                it("should encode a string array correctly") {
                    let strings = ["Hi", "I", "want", "to", "learn", "Solidity"]
                        .flatMap { Solidity.String($0) }
                    let type = Solidity.FixedArray(strings)
                    expect(type.encode()) == Assets.encodedFixedStringArray
                }
            }
            
            // MARK: Dynamic Types
            
            context("Bytes") {
                it("should encode byte sequences correctly") {
                    let bytes1: [UInt8] = [0, 1, 2, 3, 4, 5, 255, 220, 10, 64]
                    let data1 = Data(bytes: bytes1)
                    let type1 = Solidity.Bytes(data1)!
                    expect(type1.encode().uppercased()) == "000000000000000000000000000000000000000000000000000000000000000A000102030405FFDC0A4000000000000000000000000000000000000000000000"
                    
                    let data2 = "Hello, world!".data(using: .ascii)
                    let type2 = Solidity.Bytes(data2!)!
                    expect(type2.encode()) == "000000000000000000000000000000000000000000000000000000000000000d48656c6c6f2c20776f726c642100000000000000000000000000000000000000"
                    
                    let bytes3: [UInt8] = [0]
                    let data3 = Data(bytes: bytes3)
                    let type3 = Solidity.Bytes(data3)!
                    expect(type3.encode().uppercased()) == "00000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000"
                    
                    let bytes4: [UInt8] = [0, 1]
                    let data4 = Data(bytes: bytes4)
                    let type4 = Solidity.Bytes(data4)!
                    expect(type4.encode().uppercased()) == "00000000000000000000000000000000000000000000000000000000000000020001000000000000000000000000000000000000000000000000000000000000"
                    
                    let bytes5: [UInt8] = [0, 1, 2]
                    let data5 = Data(bytes: bytes5)
                    let type5 = Solidity.Bytes(data5)!
                    expect(type5.encode().uppercased()) == "00000000000000000000000000000000000000000000000000000000000000030001020000000000000000000000000000000000000000000000000000000000"
                    
                    let string = "dave"
                    let data6 = string.data(using: .ascii)
                    let type6 = Solidity.Bytes(data6!)!
                    expect(type6.encode().uppercased()) == "00000000000000000000000000000000000000000000000000000000000000046461766500000000000000000000000000000000000000000000000000000000"
                }
            }
            
            context("String") {
                it("should encode \"dave\" correctly") {
                    let string = "dave"
                    let type = Solidity.String(string)!
                    expect(type.encode().uppercased()) == "00000000000000000000000000000000000000000000000000000000000000046461766500000000000000000000000000000000000000000000000000000000"
                }
                
                it("should encode \"Hello, world!\" correctly") {
                    let string = "Hello, world!"
                    let type = Solidity.String(string)!
                    expect(type.encode().uppercased()) == "000000000000000000000000000000000000000000000000000000000000000d48656c6c6f2c20776f726c642100000000000000000000000000000000000000".uppercased()
                }
            }
            
            context("VariableArray") {
                it("should encode some static types correctly") {
                    let bytes = [0, 1, 2, 3, 4, 5, 255, 220, 10, 64].flatMap { Solidity.UInt8(BigUInt($0)) }
                    let array1 = Solidity.VariableArray(bytes)!
                    expect(array1.encode().uppercased()) == "000000000000000000000000000000000000000000000000000000000000000A00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000030000000000000000000000000000000000000000000000000000000000000004000000000000000000000000000000000000000000000000000000000000000500000000000000000000000000000000000000000000000000000000000000FF00000000000000000000000000000000000000000000000000000000000000DC000000000000000000000000000000000000000000000000000000000000000A0000000000000000000000000000000000000000000000000000000000000040"

                    let numbers: [Solidity.UInt32] = [Solidity.UInt32(BigUInt("456", radix: 16)!)!, Solidity.UInt32(BigUInt("789", radix: 16)!)!]
                    let array2 = Solidity.VariableArray(numbers)!
                    expect(array2.encode()) == "000000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000004560000000000000000000000000000000000000000000000000000000000000789"

                    let bools: [Solidity.Bool] = [Solidity.Bool(true), Solidity.Bool(false)]
                    let array3 = Solidity.VariableArray(bools)!
                    expect(array3.encode()) == "000000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000"

                    let empty = [Solidity.Bool]()
                    let array4 = Solidity.VariableArray(empty)!
                    expect(array4.encode()) == "0000000000000000000000000000000000000000000000000000000000000000"
                }

                it("should encode a string array correctly") {
                    let strings = ["Hi", "I", "want", "to", "learn", "Solidity"]
                        .flatMap { Solidity.String($0) }
                    let type = Solidity.VariableArray(strings)!
                    expect(type.encode()) == Assets.encodedVariableStringArray
                }
                
                it("should decode a string array correctly") {
                    let strings = ["Hi", "I", "want", "to", "learn", "Solidity"]
                        .flatMap { Solidity.String($0) }
                    let expectedType = Solidity.VariableArray(strings)!
                    
                    let source = BaseDecoder.PartitionData(data: Assets.encodedVariableStringArray)
                    expect { try Solidity.VariableArray<Solidity.String>.decode(source: source) } == expectedType
                }
                
                it("should decode some static types correctly") {
                    let uints = [0, 4, 3423, 242323, 334934, 273, 0, 127, 128, 255, 383838383833].flatMap { Solidity.UInt256($0) }
                    let expectedType = Solidity.VariableArray(uints)
                    expect { try Solidity.VariableArray<Solidity.UInt256>.decode(source: BaseDecoder.PartitionData(data: "000000000000000000000000000000000000000000000000000000000000000b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000040000000000000000000000000000000000000000000000000000000000000d5f000000000000000000000000000000000000000000000000000000000003b2930000000000000000000000000000000000000000000000000000000000051c5600000000000000000000000000000000000000000000000000000000000001110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007f000000000000000000000000000000000000000000000000000000000000008000000000000000000000000000000000000000000000000000000000000000ff000000000000000000000000000000000000000000000000000000595e8ceed9")) } == expectedType
                    
                    let bytes = [0, 1, 2, 3, 4, 5, 255, 220, 10, 64].flatMap { Solidity.UInt8(BigUInt($0)) }
                    let array1 = Solidity.VariableArray(bytes)!
                    expect { Solidity.VariableArray<Solidity.UInt8>.decode(source: BaseDecoder.PartitionData(data: "000000000000000000000000000000000000000000000000000000000000000A00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000030000000000000000000000000000000000000000000000000000000000000004000000000000000000000000000000000000000000000000000000000000000500000000000000000000000000000000000000000000000000000000000000FF00000000000000000000000000000000000000000000000000000000000000DC000000000000000000000000000000000000000000000000000000000000000A0000000000000000000000000000000000000000000000000000000000000040")) } == array1
                    
                    let numbers: [Solidity.UInt32] = [Solidity.UInt32(BigUInt("456", radix: 16)!)!, Solidity.UInt32(BigUInt("789", radix: 16)!)!]
                    let array2 = Solidity.VariableArray(numbers)!
                    expect { Solidity.VariableArray<Solidity.UInt32>.decode(source: BaseDecoder.PartitionData(data: "000000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000004560000000000000000000000000000000000000000000000000000000000000789")) } == array2
                    
                    let bools: [Solidity.Bool] = [Solidity.Bool(true), Solidity.Bool(false)]
                    let array3 = Solidity.VariableArray(bools)!
                    expect { Solidity.VariableArray<Solidity.Bool>.decode(source: BaseDecoder.PartitionData(data: "000000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000")) } == array3
                    
                    let empty = [Solidity.Bool]()
                    let array4 = Solidity.VariableArray(empty)!
                    expect(expect { Solidity.VariableArray<Solidity.Bool>.decode(source: BaseDecoder.PartitionData(data: "0000000000000000000000000000000000000000000000000000000000000000")) } == array4
                }
            }
            
            context("Function") {
                it("should reject invalid function selectors") {
                    let testAddress = Solidity.Address("0xFF")!
                    // Function selector too small (only 4 chars/ 2 bytes)
                    expect(Solidity.Function("0000", at: testAddress)).to(beNil())
                    // Function selector too long (9 chars/ 4.5 bytes)
                    expect(Solidity.Function("000000000", at: testAddress)).to(beNil())
                    // Function selector empty
                    expect(Solidity.Function("", at: testAddress)).to(beNil())
                }
                
                it("should encode correctly") {
                    let testAddress = Solidity.Address("0xFF")!
                    let functionSelector = "095ea7b3"
                    // Address encoded as 20 bytes, then 4 bytes function selector,
                    // then padding to 32 bytes on the right
                    let testString = "00000000000000000000000000000000000000ff\(functionSelector)0000000000000000"
                        expect(Solidity.Function(functionSelector, at: testAddress)?.encode()) == testString
                }
            }
        }
    }
}
