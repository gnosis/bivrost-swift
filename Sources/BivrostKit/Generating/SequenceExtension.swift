//
//  SequenceExtension.swift
//  BivrostKit
//
//  Created by Luis Reisewitz on 23.10.17.
//

// From https://stackoverflow.com/a/31220067/972993

public extension Sequence {
    func group<U: Hashable>(by key: (Iterator.Element) -> U) -> [U:[Iterator.Element]] {
        var categories: [U: [Iterator.Element]] = [:]
        for element in self {
            let key = key(element)
            if case nil = categories[key]?.append(element) {
                categories[key] = [element]
            }
        }
        return categories
    }
}
