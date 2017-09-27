//
//  Errors.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 12.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//
//

enum BivrostError: Error {
    case elementTypeInvalid
    case elementNameInvalid
    case functionInputInvalid
    case functionOutputInvalid
    case eventInputInvalid
    case notImplemented
    case parameterTypeInvalid
    case parameterTypeNotFound
}
