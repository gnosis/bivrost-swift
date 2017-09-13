//
//  ContractJSONParser.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 12.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//
//

import Foundation

fileprivate typealias FunctionInput = Contract.FunctionInput
fileprivate typealias FunctionOutput = Contract.FunctionOutput
fileprivate typealias EventInput = Contract.EventInput

enum JSONKey: String {
    case type
    case name
    case inputs
    case outputs
    case constant
    case payable
    case anonymous
    case indexed
}

extension Dictionary where Key == String {
    subscript(key: JSONKey) -> Value? {
        get {
            return self[key.rawValue]
        }
        set {
            self[key.rawValue] = newValue
        }
    }
}

struct ContractJSONParser {
    static func parseContract(from json: [[String: Any]]) throws -> Contract {
        throw BivrostError.notImplemented
    }
    
    static func parseContractElement(from json: [String: Any]) throws -> Contract.Element {
        // `type` can be omitted, defaulting to "function"
        let typeString = json[.type] as? String ?? "function"
        
        guard let type = Contract.ElementType(rawValue: typeString) else {
            throw BivrostError.elementTypeInvalid
        }
        return try parseElement(with: type, from: json)
    }
}

// MARK: - Private Element Parsing
extension ContractJSONParser {
    fileprivate static func parseElement(with type: Contract.ElementType, from json: [String: Any]) throws -> Contract.Element {
        switch type {
        case .function:
            return .function(try parseFunction(from: json))
        case .constructor:
            return .constructor(try parseConstructor(from: json))
        case .fallback:
            return .fallback(try parseFallback(from: json))
        case .event:
            return .event(try parseEvent(from: json))
        }
    }
    
    fileprivate static func parseFunction(from json: [String: Any]) throws -> Contract.Function {
        let constant = parseConstant(from: json)
        let payable = parsePayable(from: json)
        let inputs = try parseFunctionInputs(from: json)
        let outputs = try parseFunctionOutputs(from: json)
        let name = try parseName(from: json)
        
        return Contract.Function(name: name, inputs: inputs, outputs: outputs, constant: constant, payable: payable)
    }
    
    fileprivate static func parseConstructor(from json: [String: Any]) throws -> Contract.Constructor {
        let constant = parseConstant(from: json)
        let payable = parsePayable(from: json)
        let inputs = try parseFunctionInputs(from: json)
        
        return Contract.Constructor(inputs: inputs, constant: constant, payable: payable)
    }
    
    fileprivate static func parseFallback(from json: [String: Any]) throws -> Contract.Fallback {
        let constant = parseConstant(from: json)
        let payable = parsePayable(from: json)
        return Contract.Fallback(constant: constant, payable: payable)
    }
    
    fileprivate static func parseEvent(from json: [String: Any]) throws -> Contract.Event {
        let name = try parseName(from: json)
        let inputs = try parseEventInputs(from: json)
        let anonymous = parseAnonymous(from: json)
        
        return Contract.Event(name: name, inputs: inputs, anonymous: anonymous)
    }
    
    private static func parseName(from json: [String: Any]) throws -> String {
        guard let name = json[.name] as? String else {
            throw BivrostError.elementNameInvalid
        }
        return name
    }
}

// MARK: - Private Function Field parsing
extension ContractJSONParser {
    fileprivate static func parseConstant(from json: [String: Any]) -> Bool {
        return json[.constant] as? Bool ?? false
    }
    
    fileprivate static func parsePayable(from json: [String: Any]) -> Bool {
        return json[.payable] as? Bool ?? false
    }
    
    fileprivate static func parseFunctionInputs(from json: [String: Any]) throws -> [FunctionInput] {
        guard let jsonInputs = json[.inputs] as? [[String: Any]] else {
            return []
        }
        return try jsonInputs.flatMap { try ContractJSONParser.parseFunctionInput(from: $0) }
    }
    
    private static func parseFunctionInput(from json: [String: Any]) throws -> FunctionInput {
        guard let name = json[.name] as? String,
            let typeString = json[.type] as? String,
            let type = Contract.ParameterType(rawValue: typeString) else {
                throw BivrostError.functionInputInvalid
        }
        return FunctionInput(name: name, type: type)
    }
    
    fileprivate static func parseFunctionOutputs(from json: [String: Any]) throws -> [FunctionOutput] {
        guard let jsonOutputs = json[.outputs] as? [[String: Any]] else {
            return []
        }
        return try jsonOutputs.flatMap { try ContractJSONParser.parseFunctionOutput(from: $0) }
    }
    
    private static func parseFunctionOutput(from json: [String: Any]) throws -> FunctionOutput {
        guard let name = json[.name] as? String,
            let typeString = json[.type] as? String,
            let type = Contract.ParameterType(rawValue: typeString) else {
                throw BivrostError.functionOutputInvalid
        }
        return FunctionOutput(name: name, type: type)
    }
    
}

// MARK: - Private Event Field Parsing
extension ContractJSONParser {
    fileprivate static func parseAnonymous(from json: [String: Any]) -> Bool {
        return json[.anonymous] as? Bool ?? false
    }
    
    /// Returns a list of event inputs from a json dictionary representing a 
    /// single contract element.
    ///
    /// - Parameter json: Should include the key `inputs` on a top level.
    /// - Returns: A list of event inputs mapped from that json.
    /// - Throws: Throws if at least one of these inputs was malformed.
    fileprivate static func parseEventInputs(from json: [String: Any]) throws -> [EventInput] {
        guard let jsonInputs = json[.inputs] as? [[String: Any]] else {
            return []
        }
        return try jsonInputs.flatMap { try ContractJSONParser.parseEventInput(from: $0) }
    }
    
    private static func parseEventInput(from json: [String: Any]) throws -> EventInput {
        guard let name = json[.name] as? String,
            let typeString = json[.type] as? String,
            let type = Contract.ParameterType(rawValue: typeString),
            let indexed = json[.indexed] as? Bool else {
                throw BivrostError.eventInputInvalid
        }
        return EventInput(name: name, type: type, indexed: indexed)
    }
    
}
