//
//  UIntXTemplate.swift
//  BivrostKit
//
//  Created by Luis Reisewitz on 10.10.17.
//

extension Templates {
    static let UIntX = """
        extension Solidity {
        {% for bitWidth in bitWidths %}
            final class UInt{{ bitWidth }}: _DoNotUse._UIntX {
                override class var bitWidth: UInt {
                    return {{ bitWidth }}
                }
            }
        {% endfor %}
        }

        """
}
