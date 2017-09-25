//
//  SolidityBaseSpec.swift
//  Bivrost_Tests
//
//  Created by Luis Reisewitz on 25.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//

import Quick
import Nimble
@testable import Bivrost

class SolidityBaseSpec: QuickSpec {
    override func spec() {
        describe("SolidityBaseSpec") {
            it("should encode Example call with static types correctly") {
                expect(StandardToken.Example.encodeCall(arguments: (x: Solidity.UInt32(value: 69), y: Solidity.Bool(value: true)))) == "0xcdcd77c000000000000000000000000000000000000000000000000000000000000000450000000000000000000000000000000000000000000000000000000000000001"
            }
        }
    }
}
