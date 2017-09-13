//
//  Contract.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 12.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//
//

import Foundation

struct Contract {
    let elements: [Element]
    
    struct Constructor {
        let inputs: [FunctionInput]
        let constant: Bool
        let payable: Bool
    }
    
    struct Fallback {
        let constant: Bool
        let payable: Bool
    }
    
    struct Function {
        let name: String
        let inputs: [FunctionInput]
        let outputs: [FunctionOutput]
        let constant: Bool
        let payable: Bool
    }
    
    struct FunctionInput {
        let name: String
        let type: ParameterType
    }
    
    struct FunctionOutput {
        // TODO: find out if this is correct
        let name: String
        let type: ParameterType
    }
    
    struct EventInput {
        let name: String
        let type: ParameterType
        let indexed: Bool
    }
    
    struct Event {
        let name: String
        let inputs: [EventInput]
        let anonymous: Bool
    }
    
    enum Element {
        case function(Function)
        case constructor(Constructor)
        case fallback(Fallback)
        case event(Event)
    }
}
