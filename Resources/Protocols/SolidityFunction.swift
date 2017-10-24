//
//  SolidityFunction.swift
//  BivrostHelper
//
//  Created by Luis Reisewitz on 12.10.17.
//

protocol SolidityFunction {
    associatedtype Arguments
    associatedtype Return

    static var methodId: String { get }

    static func encodeCall(arguments: Arguments) -> String
    static func decode(returnData: String) throws -> Return
    static func decode(argumentsData: String) throws -> Arguments
}
