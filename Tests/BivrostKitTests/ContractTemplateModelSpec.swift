//
//  ContractTemplateModelSpec.swift
//  BivrostKitTests
//
//  Created by Luis Reisewitz on 23.10.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//

@testable import BivrostKit
import Foundation
import Nimble
import Quick

class ContractTemplateModelSpec: QuickSpec {
    override func spec() {
        describe("ContractTemplateModel") {
            it("should append method ids to generated function names in case of duplicates") {
                let json = jsonDict(from: Assets.duplicateMethodJsonTruffle3)
                // Doesnt matter that parser we use here, as we test the TemplateModel
                let contract = try! Truffle3ContractParser.parseContract(from: json)

                let model = ContractTemplateModel(contract: contract)
                model.functions.forEach {
                    expect($0.name).to(contain($0.methodId))
                }
            }

            it("should not append method ids to generated function names in case of no duplicates") {
                let json = jsonDict(from: Assets.standardTokenJsonTruffle3)
                // Doesnt matter that parser we use here, as we test the TemplateModel
                let contract = try! Truffle3ContractParser.parseContract(from: json)
                
                let model = ContractTemplateModel(contract: contract)
                model.functions.forEach {
                    expect($0.name).toNot(contain($0.methodId))
                }
            }
        }
    }

}

private func jsonDict(from jsonString: String) -> [String: Any] {
    return try! JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: []) as! [String: Any]
}
