//
//  StringExtension.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 19.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//

import Foundation

// MARK: - Search Helpers
extension String {
    func lastIndex(of char: Character) -> Index? {
        guard let range = range(of: String(char), options: .backwards) else {
            return nil
        }
        return range.lowerBound
    }
    
    func index(of char: Character) -> Index? {
        guard let range = range(of: String(char)) else {
            return nil
        }
        return range.lowerBound
    }
    
    func endIndex(startDistance distance: Int) -> String.Index {
        return index(startIndex, offsetBy: distance)
    }
}

// MARK: - Range Helpers
extension String {
    var fullRange: Range<Index> {
        return startIndex..<endIndex
    }
    
    var fullNSRange: NSRange {
        return NSRange(fullRange, in: self)
    }
}

private let solidityLineLengthBytes = 32
private let solidityLineLengthHexString = solidityLineLengthBytes * 2

// MARK: - Solidity Helpers
extension String {
    enum PadLocation {
        case left
        case right
    }
    
    func pad(toMultipleOf multiple: Int, character: Character, location: PadLocation) -> String {
        let originalLength = self.characters.count
        let desiredLength = ((originalLength - 1)|(multiple - 1)) + 1
        let paddingLength = desiredLength - originalLength
        let padding = String(repeating: character, count: paddingLength)
        return location == .left ? padding + self : self + padding
    }
    
    /// Pads a given string to a multiple of 64 characters. Meant to be used for
    /// padding a hex string to multiples of 32 bytes.
    ///
    /// - Parameters:
    ///   - character: Character to use for padding. Defaults to '0'.
    ///   - location: Where to apply the padding. Defaults to .left.
    /// - Returns: The padded string so that string.characters.count % 64 == 0.
    func padToSolidity(character: Character = "0", location: PadLocation = .left) -> String {
        return pad(toMultipleOf: solidityLineLengthHexString, character: character, location: location)
    }
    
    func splitSolidityLines() -> [String] {
        return splitByLength(solidityLineLengthHexString)
    }
}

extension String {
    fileprivate func splitByLength(_ length: Int) -> [String] {
        var result = [String]()
        var collectedCharacters = [Character]()
        collectedCharacters.reserveCapacity(length)
        var count = 0
        
        for character in self.characters {
            collectedCharacters.append(character)
            count += 1
            if (count == length) {
                // Reached the desired length
                count = 0
                result.append(String(collectedCharacters))
                collectedCharacters.removeAll(keepingCapacity: true)
            }
        }
        
        // Append the remainder
        if !collectedCharacters.isEmpty {
            result.append(String(collectedCharacters))
        }
        
        return result
    }
}
