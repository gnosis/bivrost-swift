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
    func pad(toMultipleOf multiple: Int, character: Character) -> String {
        let originalLength = self.characters.count
        let desiredLength = ((originalLength - 1)|(multiple - 1)) + 1
        let paddingLength = desiredLength - originalLength
        let padding = String(repeating: character, count: paddingLength)
        return padding + self
    }
    
    func padToSolidity(character: Character = "0") -> String {
        return pad(toMultipleOf: solidityHexStringPad, character: character)
    }
}
