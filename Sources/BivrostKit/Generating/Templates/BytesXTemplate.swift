//
//  BytesXTemplate.swift
//  BivrostKit
//
//  Created by Luis Reisewitz on 10.10.17.
//

extension Templates {
    static let BytesX = """
        extension Solidity {
            {% for length in lengths %}
            public final class Bytes{{ length }}: _DoNotUse._BytesX {
                override class var length: UInt {
                    return {{ length }}
                }
            }
            {% endfor %}
        }
    """
}
