//
//  AbiValidating.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 19.09.17.
//

protocol AbiValidating {
    /// Returns if the internal represented state is valid for usage in Ethereum ABI.
    var isValid: Bool { get }
}
