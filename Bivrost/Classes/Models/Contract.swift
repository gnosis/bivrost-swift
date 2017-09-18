//
//  Contract.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 12.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//
//

import Foundation

/// Describes the interface of an Ethereum/Solidity Contract
struct Contract {
    let elements: [Element]
}

// MARK: - Element
extension Contract {
    enum Element {
        case function(Function)
        case constructor(Constructor)
        case fallback(Fallback)
        case event(Event)
    }
}

// MARK: - Function
extension Contract.Element {
    struct Function {
        let name: String
        let inputs: [Input]
        let outputs: [Output]
        let constant: Bool
        let payable: Bool
        
        struct Output {
            /// FunctionOutput names can also be empty strings.
            let name: String
            let type: ParameterType
        }
        
        struct Input {
            let name: String
            let type: ParameterType
        }
    }
    
    struct Constructor {
        let inputs: [Function.Input]
        let constant: Bool
        let payable: Bool
    }
    
    struct Fallback {
        let constant: Bool
        let payable: Bool
    }
}

// MARK: - Event
extension Contract.Element {
    struct Event {
        let name: String
        let inputs: [Input]
        let anonymous: Bool
        
        struct Input {
            let name: String
            let type: ParameterType
            let indexed: Bool
        }
    }
}
