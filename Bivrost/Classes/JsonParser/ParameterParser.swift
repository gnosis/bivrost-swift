//
//  ParameterParser.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 13.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//
//

import Foundation

struct ParameterParser {
    /// Parses the parameter type contained in a Input/Output dictionary.
    ///
    /// - Parameter json: Dictionary describing either an Input or an Output to 
    ///     a function or an event.
    /// - Returns: The corresponding parameter type.
    /// - Throws: Throws a BivrostError in case the json was malformed or there
    ///     was an error.
    static func parseParameterType(from json: [String: Any]) throws -> ParameterType {
        throw BivrostError.notImplemented
    }
}
