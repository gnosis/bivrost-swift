//
//  ContractParserSpec.swift
//  BivrostKitTests
//
//  Created by Luis Reisewitz on 19.09.17.
//  Copyright © 2017 Gnosis Ltd. All rights reserved.
//

@testable import BivrostKit
import Foundation
import Nimble
import Quick

class ContractParserSpec: QuickSpec {
    override func spec() {
        describe("ContractParser") {
            it("should not throw when parsing MultiSigWalletWithDailyLimit.json") {
                let json = jsonDict(from: Assets.multiSigWalletJson)
                expect { try ContractParser.parseContract(from: json) }.toNot(throwError())
                expect { (try ContractParser.parseContract(from: json)).name } == "MultiSigWalletWithDailyLimit"
            }

            it("should not throw when parsing StandardToken") {
                let json = jsonDict(from: Assets.standardTokenJson)
                expect { try ContractParser.parseContract(from: json) }.toNot(throwError())
                expect { (try ContractParser.parseContract(from: json)).name } == "StandardToken"
            }
        }
    }
}

private func jsonDict(from jsonString: String) -> [String: Any] {
    return try! JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: []) as! [String: Any]
}
