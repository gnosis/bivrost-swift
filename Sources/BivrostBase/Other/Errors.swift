//
//  Errors.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 12.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//
//

import Foundation
import BigInt

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
        case contractNameInvalid
        case contractAbiInvalid
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
        case couldNotCreateBytesX(source: BaseDecoder.PartitionData, length: UInt)
        case couldNotCreateInt(source: BaseDecoder.PartitionData, bits: UInt)
        case couldNotCreateUInt(source: BaseDecoder.PartitionData, bits: UInt)
        case couldNotCreateAddress(source: BaseDecoder.PartitionData)
        case couldNotCreateVariableArray(source: BaseDecoder.PartitionData)
    }
    
    enum ArrayX: Error {
        case itemCountMismatch(expected: UInt, actual: UInt)
    }
    
    enum BytesX: Error {
        case byteCountMismatch(max: UInt, actual: UInt)
    }
    
    enum Address: Error {
        case invalidAddress(String)
        case invalidBigUInt(BigUInt)
    }
    
    enum Function: Error {
        case invalidFunctionSelector(String)
    }
    
    enum UIntX: Error {
        case bitWidthMismatch(max: UInt, actual: UInt)
    }
    
    enum IntX: Error {
        case bitWidthMismatch(max: UInt, actual: UInt)
    }
}
