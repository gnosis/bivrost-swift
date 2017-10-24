//
//  ArrayXTemplate.swift
//  BivrostKit
//
//  Created by Luis Reisewitz on 10.10.17.
//

extension Templates {
    static let ArrayX = """
        extension Solidity {
        {% for length in lengths %}
            final class Array{{ length }}<T: SolidityCodable & Equatable>: _DoNotUse._ArrayX<T> {
                override class var length: UInt {
                    return {{ length }}
                }
            }
        {% endfor %}
        }

        """
}
