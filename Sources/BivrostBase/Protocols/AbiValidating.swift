//
//  AbiValidating.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 19.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//

protocol AbiValidating {
    /// Returns if the internal represented state is valid for usage in Ethereum ABI.
    var isValid: Bool { get }
}
