//
//  JsonParserSpec.swift
//  BivrostBaseTests
//
//  Created by Luis Reisewitz on 19.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import BivrostBase

class JsonParserSpec: QuickSpec {
    override func spec() {
        describe("JsonParser") {
            it("should not throw when parsing MultiSigWalletWithDailyLimit-Abi.json") {
                let json = jsonArray(from: Assets.multiSigWalletAbiJson)
                expect { try JsonParser.parseContract(from: json) }.toNot(throwError())
            }
            
            it("should not throw when parsing TestToken-Abi") {
                let json = jsonArray(from: Assets.testTokenAbiJson)
                expect { try JsonParser.parseContract(from: json) }.toNot(throwError())
            }
        }
    }
}

fileprivate func jsonArray(from jsonString: String) -> [[String: Any]] {
    return try! JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: []) as! [[String: Any]]
}
