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
    enum Parser: Error {
        case elementTypeInvalid
        case elementNameInvalid
        case functionInputInvalid
        case functionOutputInvalid
        case eventInputInvalid
        case parameterTypeInvalid
        case parameterTypeNotFound
    }
    
    case notImplemented
    
    enum Decoder: Error {
        // Decoding
        case invalidBool(hex: String)
        case invalidUInt(hex: String)
        case invalidInt(hex: String)
        case invalidBytesX(hex: String, capacity: UInt)
        case invalidBytesLength(hex: String)
        case invalidStringEncoding(data: Data)
        case invalidArrayLength(hex: String)
        // Creating Objects
        case couldNotCreateString(source: BaseDecoder.PartitionData)
        case couldNotCreateBytes(source: BaseDecoder.PartitionData)
        case couldNotCreateInt(source: BaseDecoder.PartitionData, bits: UInt)
        case couldNotCreateUInt(source: BaseDecoder.PartitionData, bits: UInt)
        case couldNotCreateAddress(source: BaseDecoder.PartitionData)
    }
    
}
