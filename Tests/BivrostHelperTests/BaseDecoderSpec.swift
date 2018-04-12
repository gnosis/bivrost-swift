//
//  BaseDecoderSpec.swift
//  BivrostHelperTests
//
//  Created by Luis Reisewitz on 02.10.17.
//  Copyright © 2017 Gnosis Ltd. All rights reserved.
//

import BigInt
@testable import BivrostHelper
import Foundation
import Nimble
import Quick

class BaseDecoderSpec: QuickSpec {
    override func spec() {
        describe("BaseDecoder") {
            it("should decode UInts correctly") {
                expect(try? BaseDecoder.decodeUInt(data: "0000000000000000000000000000000000000000000000000000000000000000")) == BigUInt(0)
                expect(try? BaseDecoder.decodeUInt(data: "0000000000000000000000000000000000000000000000000000000000000001")) == BigUInt(1)
                //Max unsigned integer
                expect(try? BaseDecoder.decodeUInt(data: "ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff")) == BigUInt("115792089237316195423570985008687907853269984665640564039457584007913129639935")
            }

            it("should decode Bools correctly") {
                expect(try? BaseDecoder.decodeBool(data: "0000000000000000000000000000000000000000000000000000000000000000")) == false
                expect(try? BaseDecoder.decodeBool(data: "0000000000000000000000000000000000000000000000000000000000000001")) == true
            }

            it("should decode Ints correctly") {
                expect(try? BaseDecoder.decodeInt(data: "0000000000000000000000000000000000000000000000000000000000000000")) == BigInt(0)
                expect(try? BaseDecoder.decodeInt(data: "0000000000000000000000000000000000000000000000000000000000000001")) == BigInt(1)
                expect(try? BaseDecoder.decodeInt(data: "ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff")) == BigInt(-1)
                expect(try? BaseDecoder.decodeInt(data: "000000000000000000000000000000000000000000000000000000000000007f")) == BigInt(127)
                expect(try? BaseDecoder.decodeInt(data: "ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff80")) == BigInt(-128)
            }

            it("should decode BytesX correctly") {
                expect(try? BaseDecoder.decodeBytesX(data: "0000000000000000000000000000000000000000000000000000000000000000", length: 1)) == Data(bytes: [0])
                expect(try? BaseDecoder.decodeBytesX(data: "0001000000000000000000000000000000000000000000000000000000000000", length: 2)) == Data(bytes: [0, 1])
                expect(try? BaseDecoder.decodeBytesX(data: "0001020000000000000000000000000000000000000000000000000000000000", length: 3)) == Data(bytes: [0, 1, 2])
                expect(try? BaseDecoder.decodeBytesX(data: "6461766500000000000000000000000000000000000000000000000000000000", length: 4)) == "dave".data(using: .ascii)!
            }

            it("should decode Bytes correctly") {
                expect(try? BaseDecoder.decodeBytes(source: BaseDecoder.PartitionData(data: "000000000000000000000000000000000000000000000000000000000000000d48656c6c6f2c20776f726c642100000000000000000000000000000000000000"))) == "Hello, world!".data(using: .ascii)!
                expect(try? BaseDecoder.decodeBytes(source: BaseDecoder.PartitionData(data: "00000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000"))) == Data(bytes: [0])
                expect(try? BaseDecoder.decodeBytes(source: BaseDecoder.PartitionData(data: "00000000000000000000000000000000000000000000000000000000000000020001000000000000000000000000000000000000000000000000000000000000"))) == Data(bytes: [0, 1])
                expect(try? BaseDecoder.decodeBytes(source: BaseDecoder.PartitionData(data: "00000000000000000000000000000000000000000000000000000000000000030001020000000000000000000000000000000000000000000000000000000000"))) == Data(bytes: [0, 1, 2])
                expect(try? BaseDecoder.decodeBytes(source: BaseDecoder.PartitionData(data: "00000000000000000000000000000000000000000000000000000000000000046461766500000000000000000000000000000000000000000000000000000000"))) == "dave".data(using: .ascii)!
            }

            it("should decode Strings correctly") {
                expect(try? BaseDecoder.decodeString(source: BaseDecoder.PartitionData(data: "000000000000000000000000000000000000000000000000000000000000000d48656c6c6f2c20776f726c642100000000000000000000000000000000000000"))) == "Hello, world!"
            }

            it("should decode Static Arrays correctly") {
                // Test normal decoding
                expect(try? BaseDecoder.decodeArray(data: "000000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000004560000000000000000000000000000000000000000000000000000000000000789", decoder: BaseDecoder.decodeUInt)) == [BigUInt("456", radix: 16)!, BigUInt("789", radix: 16)!]
                expect(try? BaseDecoder.decodeArray(data: "000000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000", decoder: BaseDecoder.decodeBool)) == [true, false]
                expect(try? BaseDecoder.decodeArray(data: "0000000000000000000000000000000000000000000000000000000000000000", decoder: BaseDecoder.decodeBool)) == []

                // Test invalid array decoding (size too big)
                expect { try BaseDecoder.decodeArray(data: "000000000000000000000000000000000000000000000000000000000000000300000000000000000000000000000000000000000000000000000000000004560000000000000000000000000000000000000000000000000000000000000789", decoder: BaseDecoder.decodeUInt) }.to(throwError())
            }
        }
    }
}
