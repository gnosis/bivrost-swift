//
//  BaseEncoderSpec.swift
//  BivrostBaseTests
//
//  Created by Luis Reisewitz on 25.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//

import Quick
import Nimble
@testable import BivrostBase
import BigInt

class BaseEncoderSpec: QuickSpec {
    override func spec() {
        describe("BaseEncoder") {
            it("should encode call with static types correctly") {
                expect(StandardToken.Example.encodeCall(arguments: (x: Solidity.UInt32(69)!, y: Solidity.Bool(true)))) == "0xcdcd77c000000000000000000000000000000000000000000000000000000000000000450000000000000000000000000000000000000000000000000000000000000001"
            }
        }
    }
}
