//
//  StringExtension.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 19.09.17.
//

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

private let solidityBytesPad = 32
private let solidityHexStringPad = solidityBytesPad * 2

// MARK: - Solidity Helpers
extension String {
    enum PadLocation {
        case left
        case right
    }
    
    fileprivate func pad(toMultipleOf multiple: Int, character: Character, location: PadLocation) -> String {
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
        return pad(toMultipleOf: solidityHexStringPad, character: character, location: location)
    }
}
