//
//  SolidityTypesSpec.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 25.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//


import Quick
import Nimble
@testable import BivrostFramework
import BigInt

class SolidityTypesSpec: QuickSpec {
    override func spec() {
        describe("SolidityTypes") {
            context("Address") {
                it("should be able to parse a hex address with or without leading 0x") {
                    expect(Solidity.Address("0xFF")).toNot(beNil())
                    expect(Solidity.Address("FF")).toNot(beNil())
                }
                
            }
            context("UInt") {
                it("should not be created when the given value does not fit into 256 bits") {
                   // Random large number bigger than 2**256
                    expect(Solidity.UInt256(BigUInt("65767676766576587658679697687685765765765765765765t765765765765765765765765765765765765765765757657657657657657657657657657657657657657657657657657657657657657657657657657657657657657657658768768768768687687687876876876876876876876876876876876876876876876876876876", radix: 36)!)).to(beNil())
                }
                
                it("should encode positive numbers correctly") {
                    expect(Solidity.UInt256(BigUInt(123))?.encode()) == "000000000000000000000000000000000000000000000000000000000000007b"
                }
            }
            
            context("Int") {
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
            }
            
            context("FixedArray") {
                it("should encode multiple positive numbers correctly") {
                    let array = Solidity.FixedArray(items: [
                        Solidity.Int256(BigInt(-1))!,
                        Solidity.Int256(BigInt(123))!
                    ])
                    expect(array.encode()) == "ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000007b"
                }
            }
        }
    }
}
