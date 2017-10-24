//
//  DataExtension.swift
//  BivrostHelper
//
//  Created by Luis Reisewitz on 01.10.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//

import Foundation

// Extension taken from https://stackoverflow.com/a/40278391/972993 (with slight modifications)

extension Data {
    init?(fromHexEncodedString string: String) {

        // Convert 0 ... 9, a ... f, A ...F to their decimal value,
        // return nil for all other input characters
        func decode(nibble: UInt16) -> UInt8? {
            switch nibble {
            case 0x30 ... 0x39:
                return UInt8(nibble - 0x30)
            case 0x41 ... 0x46:
                return UInt8(nibble - 0x41 + 10)
            case 0x61 ... 0x66:
                return UInt8(nibble - 0x61 + 10)
            default:
                return nil
            }
        }

        self.init(capacity: string.utf16.count / 2)
        var even = true
        var byte: UInt8 = 0
        for codePoint in string.utf16 {
            guard let val = decodeNibble(u: codePoint) else { return nil }
            if even {
                byte = val << 4
            } else {
                byte += val
                self.append(byte)
            }
            even = !even
        }
        guard even else { return nil }
    }

    func hexEncodedString() -> String {
        return map { String(format: "%02hhx", $0) }.joined()
    }
}
