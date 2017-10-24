//
//  DynamicType.swift
//  BivrostHelper
//
//  Created by Luis Reisewitz on 10.10.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//

/// To be used as a marker protocol as to not always have to add the `isDynamic` var.
/// Can only be used if the type is always dynamic.
protocol DynamicType: SolidityCodable {}
extension DynamicType {
    static var isDynamic: Bool {
        return true
    }
}
