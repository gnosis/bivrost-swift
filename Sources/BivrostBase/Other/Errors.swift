//
//  Errors.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 12.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//
//

import Foundation

enum BivrostError: Error {
    // Parser Errors
    
    case elementTypeInvalid
    case elementNameInvalid
    case functionInputInvalid
    case functionOutputInvalid
    case eventInputInvalid
    case parameterTypeInvalid
    case parameterTypeNotFound
    
    case notImplemented
    
    // Decoder Errors
    case invalidBool(hex: String)
    case invalidUInt(hex: String)
    case invalidInt(hex: String)
    case invalidBytesX(hex: String, capacity: Int)
    case invalidBytesLength(hex: String)
    case invalidStringEncoding(data: Data)
    case invalidArrayLength(hex: String)
}
