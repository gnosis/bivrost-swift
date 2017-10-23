//
//  ContractTemplateModelSpec.swift
//  BivrostKitTests
//
//  Created by Luis Reisewitz on 23.10.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//


import Foundation
import Quick
import Nimble
@testable import BivrostKit

class ContractTemplateModelSpec: QuickSpec {
    override func spec() {
        describe("ContractTemplateModel") {
            it("should append method ids to generated function names in case of duplicates") {
                let json = jsonDict(from: Assets.duplicateMethodJson)
                let contract = try! ContractParser.parseContract(from: json)
                let model = ContractTemplateModel(contract: contract)
                model.functions.forEach {
                    expect($0.name).to(contain($0.methodId))
                }
            }
            
            it("should not append method ids to generated function names in case of no duplicates") {
                let json = jsonDict(from: Assets.standardTokenJson)
                let contract = try! ContractParser.parseContract(from: json)
                let model = ContractTemplateModel(contract: contract)
                model.functions.forEach {
                    expect($0.name).toNot(contain($0.methodId))
                }
            }
        }
    }
    
}

fileprivate func jsonDict(from jsonString: String) -> [String: Any] {
    return try! JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: []) as! [String: Any]
}
