//
//  StaticType.swift
//  BivrostKit
//
//  Created by Luis Reisewitz on 10.10.17.
//

/// To be used as a marker protocol as to not always have to add the `isDynamic` var.
/// Can only be used if the type is always static.
protocol StaticType: SolidityCodable {}
extension StaticType {
    static var isDynamic: Bool {
        return false
    }
}
