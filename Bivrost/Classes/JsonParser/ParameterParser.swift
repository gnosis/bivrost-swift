//
//  ParameterParser.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 13.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//
//

import Foundation

fileprivate enum ExactMatchParameterType: String {
    // Exact String Matches
    case address
    case uint
    case int
    case bool
    case function
    case bytes
    case string
}

struct ParameterParser {
    /// Parses the parameter type contained in a Input/Output dictionary.
    ///
    /// - Parameter json: Dictionary describing either an Input or an Output to 
    ///     a function or an event.
    /// - Returns: The corresponding parameter type.
    /// - Throws: Throws a BivrostError in case the json was malformed or there
    ///     was an error.
    static func parseParameterType(from json: [String: Any]) throws -> ParameterType {
        guard let typeString = json[.type] as? String else {
            throw BivrostError.parameterTypeInvalid
        }
        return try parameterType(from: typeString)
    }
    
    static func parameterType(from string: String) throws -> ParameterType {
        // Check all the exact matches first by trying to create a ParameterTypeKey from it.
        switch ExactMatchParameterType(rawValue: string) {
        
        // Static Types
        case .address?:
            return .staticType(.address)
        case .uint?:
            return .staticType(.uint(bits: 256))
        case .int?:
            return .staticType(.int(bits: 256))
        case .bool?:
            return .staticType(.bool)
        case .function?:
            return .staticType(.function)
            
        // Dynamic Types
        case .bytes?:
            return .dynamicType(.bytes)
        case .string?:
            return .dynamicType(.string)
        default:
            // We have a more complicated type. Continue parsing below.
            break
        }
        
        // We have not handled arrays yet, abort mission.
        throw BivrostError.notImplemented
    }
}
