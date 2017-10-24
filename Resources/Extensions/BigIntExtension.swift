//
//  BigIntExtension.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 26.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//

import Foundation
import BigInt

extension BigInt {
    /// Returns the binary data for the two's complement.
    ///
    /// - Returns: This number in two's complement.
    func serialize() -> Data {
        guard sign == .minus else {
            return magnitude.serialize()
        }
        return ((~magnitude) + 1).serialize()
    }

    init?(twosComplementHex: String) {
        let lowercase = twosComplementHex.lowercased()
        // Check if we have a negative number, else just return
        guard lowercase.hasPrefix("8") ||
            lowercase.hasPrefix("9") ||
            lowercase.hasPrefix("a") ||
            lowercase.hasPrefix("b") ||
            lowercase.hasPrefix("c") ||
            lowercase.hasPrefix("d") ||
            lowercase.hasPrefix("e") ||
            lowercase.hasPrefix("f") else {
                self.init(lowercase, radix: 16)
                return
        }

        guard let uint = BigUInt(lowercase, radix: 16) else {
            return nil
        }
        let adjustedUInt = uint - 1
        let invertedUInt = ~adjustedUInt
        self.init(sign: .minus, magnitude: invertedUInt)
    }
}
