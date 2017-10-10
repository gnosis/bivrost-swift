//
//  SolidityCodable.swift
//  BivrostKit
//
//  Created by Luis Reisewitz on 10.10.17.
//

protocol SolidityCodable {
    typealias EncodeFormat = String
    static var isDynamic: Swift.Bool { get }
    
    func encode() -> EncodeFormat
    static func decode(source: BaseDecoder.PartitionData) throws -> Self
}
