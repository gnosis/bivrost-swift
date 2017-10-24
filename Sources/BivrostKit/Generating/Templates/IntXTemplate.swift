//
//  IntXTemplate.swift
//  BivrostKit
//
//  Created by Luis Reisewitz on 10.10.17.
//

extension Templates {
    static let IntX = """
        extension Solidity {
        {% for bitWidth in bitWidths %}
            final class Int{{ bitWidth }}: _DoNotUse._IntX {
                override class var bitWidth: UInt {
                    return {{ bitWidth }}
                }
            }
        {% endfor %}
        }

        """
}
