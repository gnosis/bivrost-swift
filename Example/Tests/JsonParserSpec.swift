//
//  JsonParserSpec.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 19.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//

import Quick
import Nimble
@testable import Bivrost

class JsonParserSpec: QuickSpec {
    override func spec() {
        describe("JsonParser") {
            it("should not throw when parsing MultiSigWalletWithDailyLimit-Abi.json") {
                let filename = "MultiSigWalletWithDailyLimit-Abi"
                let json = jsonArray(from: filename)
                expect { try JsonParser.parseContract(from: json) }.toNot(throwError())
            }
            
            it("should not throw when parsing TestToken-Abi") {
                let filename = "TestToken-Abi"
                let json = jsonArray(from: filename)
                expect { try JsonParser.parseContract(from: json) }.toNot(throwError())
            }
        }
    }
}

fileprivate func jsonArray(from jsonFileName: String) -> [[String: Any]] {
    let url = Bundle(for: JsonParserSpec.self).url(forResource: jsonFileName, withExtension: ".json")
    return try! JSONSerialization.jsonObject(with: Data.init(contentsOf: url!, options: []), options: []) as! [[String: Any]]
}
