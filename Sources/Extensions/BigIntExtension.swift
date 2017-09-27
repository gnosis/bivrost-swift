//
//  BigIntExtension.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 26.09.17.
//

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
}
