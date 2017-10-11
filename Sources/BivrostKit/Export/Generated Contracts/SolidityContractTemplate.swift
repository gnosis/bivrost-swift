//
//  SolidityContractTemplate.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 20.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//

import BigInt

protocol SolidityFunction {
    associatedtype Arguments
    associatedtype Return
    
    static var methodId: String { get }
    
    static func encodeCall(arguments: Arguments) -> String
    static func decode(returnData: String) throws -> Return
    static func decode(argumentsData: String) throws -> Arguments
}
