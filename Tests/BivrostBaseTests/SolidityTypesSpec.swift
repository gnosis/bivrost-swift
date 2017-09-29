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
                    expect(Solidity.Bytes1(value: data1)?.encode()) == "0000000000000000000000000000000000000000000000000000000000000000"
                    let data2 = Data([UInt8](arrayLiteral: 0, 1))
                    expect(Solidity.Bytes2(value: data2)?.encode()) == "0001000000000000000000000000000000000000000000000000000000000000"
                    let data3 = Data([UInt8](arrayLiteral: 0, 1, 2))
                    expect(Solidity.Bytes3(value: data3)?.encode()) == "0001020000000000000000000000000000000000000000000000000000000000"
                    let string = "dave"
                    let data4 = string.data(using: .ascii)!
                    expect(Solidity.Bytes4(value: data4)?.encode()) == "6461766500000000000000000000000000000000000000000000000000000000"
                }
                
                it("should return nil when given data is too big for the type") {
                    let data1 = Data([UInt8](arrayLiteral: 0, 1))
                    expect(Solidity.Bytes1(value: data1)?.encode()).to(beNil())
                    let data2 = Data([UInt8](arrayLiteral: 0, 1, 2))
                    expect(Solidity.Bytes2(value: data2)?.encode()).to(beNil())
                    let data3 = Data([UInt8](arrayLiteral: 0, 1, 2, 3))
                    expect(Solidity.Bytes3(value: data3)?.encode()).to(beNil())
                    let string = "davedavedavedavedavedavedavedavedavedavedavedavedavedavedavedave"
                    let data4 = string.data(using: .ascii)!
                    expect(Solidity.Bytes32(value: data4)?.encode()).to(beNil())
                }
                
                it("should correctly pad if given data is smaller than the capacity") {
                    let data1 = Data([UInt8](arrayLiteral: 0))
                    expect(Solidity.Bytes2(value: data1)?.encode()) == "0000000000000000000000000000000000000000000000000000000000000000"
                    let data2 = Data([UInt8](arrayLiteral: 0, 1))
                    expect(Solidity.Bytes3(value: data2)?.encode()) == "0001000000000000000000000000000000000000000000000000000000000000"
                    let data3 = Data([UInt8](arrayLiteral: 0, 1, 2))
                    expect(Solidity.Bytes4(value: data3)?.encode()) == "0001020000000000000000000000000000000000000000000000000000000000"
                    let string = "dave"
                    let data4 = string.data(using: .ascii)!
                    expect(Solidity.Bytes32(value: data4)?.encode()) == "6461766500000000000000000000000000000000000000000000000000000000"
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
            }
        }
    }
}
