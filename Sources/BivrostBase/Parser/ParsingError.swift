//
//  ParsingError.swift
//  BivrostBase
//
//  Created by Luis Reisewitz on 10.10.17.
//

import Foundation

// Parser Errors
enum ParsingError: Error {
    case elementTypeInvalid
    case elementNameInvalid
    case functionInputInvalid
    case functionOutputInvalid
    case eventInputInvalid
    case parameterTypeInvalid
    case parameterTypeNotFound
    case contractNameInvalid
    case contractAbiInvalid
}
