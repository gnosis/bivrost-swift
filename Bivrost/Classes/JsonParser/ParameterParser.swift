//
//  ParameterParser.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 13.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//
//

fileprivate typealias ParameterType = Contract.Element.ParameterType

struct ParameterParser {
    /// Parses the parameter type contained in a Input/Output dictionary.
    ///
    /// - Parameter json: Dictionary describing either an Input or an Output to 
    ///     a function or an event.
    /// - Returns: The corresponding parameter type.
    /// - Throws: Throws a BivrostError in case the json was malformed or there
    ///     was an error.
    static func parseParameterType(from json: [String: Any]) throws -> Contract.Element.ParameterType {
        guard let typeString = json[.type] as? String else {
            throw BivrostError.parameterTypeNotFound
        }
        return try parameterType(from: typeString)
    }
}


fileprivate func parameterType(from string: String) throws -> ParameterType {
    // Parsing Logic Pseudo Code:
    
    // 1. if we find an exact full string match with any "atomic" type
    //      return the matching type
    //      Note: Recursive exit
    //      possible types: address, uint, int, bool, function, bytes, string
    // 2. else if we have a number at the end,
    //      parse number
    //      split number of from rest of string
    //      get type for rest of string
    //      add our length to the remainder type, if possible
    //      possible types: bytes<M>, uint<M>, int<M>
    // 3. else if we have [] at the end,
    //      split [] off from rest of string
    //      get type for rest of string
    // 	    add our dynamic array to the remainder type, if possible
    // 	    possible types: <fixed>[]
    // 4. else if we have ] at the end (that is not covered above)
    //      reverse search for next [
    //      parse substring between into number
    // 	    get type for rest of string
    // 	    add our fixed length array to the remainder type, if possible
    //      possible types: <fixed>[<M>]
    // 5. if no valid type found (e.g. uint7 or empty string)
    //      throw BivrostError.parameterTypeInvalid
    // 6. Return detected type
    
    // Step 1:
    let possibleType = try exactMatchType(from: string)
    // Step 2:
        ?? numberSuffixMatch(from: string)
    // Step3:
        ?? matchDynamicArray(from: string)
    // Step 4:
        ?? matchFixedArray(from: string)
    
    // Step 5
    guard let foundType = possibleType else {
        throw BivrostError.parameterTypeInvalid
    }
    // Step 6:
//    guard foundType.isValid else {
//        throw BivrostError.parameterTypeInvalid
//    }
    // Step 7:
    return foundType
}

/// Types that are "atomic" can be matched exactly to these strings
fileprivate enum ExactMatchParameterType: String {
    // Static Types
    case address
    case uint
    case int
    case bool
    case function
    
    // Dynamic Types
    case bytes
    case string
}

fileprivate func exactMatchType(from string: String) -> ParameterType? {
    // Check all the exact matches by trying to create a ParameterTypeKey from it.
    switch ExactMatchParameterType(rawValue: string) {
        
    // Static Types
    case .address?:
        return .staticType(.address)
    case .uint?:
        // FIXME: this mapping might not be cool, in case "not to be used for function selector" is important
        return .staticType(.uint(bits: 256))
    case .int?:
        // FIXME: this mapping might not be cool, in case "not to be used for function selector" is important
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
        return nil
    }
}

fileprivate func numberSuffixMatch(from string: String) -> ParameterType? {
    return nil
}

/// Parses the string (backwards) and returns the dynamic array defined by the string.
///
/// - Parameter string: The type string to match.
/// - Returns: nil if not a match for dynamic array suffix.
/// - Throws: Throws if it's a match, but the wrapped type cannot be parsed or wrapped.
fileprivate func matchDynamicArray(from string: String) throws -> ParameterType? {
    // if we have [] at the end,
    //      split [] off from rest of string
    //      get type for rest of string
    //         add our dynamic array to the remainder type, if possible
    //         possible types: <fixed>[]
    
    guard string.hasSuffix("[]") else {
        return nil
    }
    let endOfStringIndex = string.endIndex
    let endOfRemainderIndex = string.index(endOfStringIndex, offsetBy: -2)
    let remainderString = String(string[string.startIndex..<endOfRemainderIndex])
    
    let type = try parameterType(from: remainderString)
    // TODO: Right now dynamic arrays cannot contain dynamic types, so make sure
    // this does not happen
    guard case .staticType(let unwrappedType) = type else {
        throw BivrostError.parameterTypeInvalid
    }
    return .dynamicType(.array(unwrappedType))
}

fileprivate func matchFixedArray(from string: String) -> ParameterType? {
    // TODO: Should only succeed when trailing brackets are not empty
    return nil
}

// MARK: - Validity Checks
extension ParameterType {
    var isValid: Bool {
        // FIXME: implement checks here
        return false
    }
}
