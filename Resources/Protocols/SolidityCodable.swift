//
//  SolidityCodable.swift
//  BivrostHelper
//
//  Created by Luis Reisewitz on 10.10.17.
//  Copyright © 2017 Gnosis Ltd. All rights reserved.
//

protocol SolidityCodable {
    typealias EncodeFormat = String
    static var isDynamic: Swift.Bool { get }

    func encode() -> EncodeFormat
    static func decode(source: BaseDecoder.PartitionData) throws -> Self
}
