//
//  TypeGenerator.swift
//  BivrostKit
//
//  Created by Luis Reisewitz on 10.10.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//

import Stencil

struct TypeGenerator {
    static func generateUIntX() throws {
        let bitWidths = (1...256).filter { $0 % 8 == 0 }
        let template = Template(templateString: Templates.UIntX)
        let uints = try template.render(["bitWidths": bitWidths])
        print(uints)
    }
    
    static func generateIntX() throws {
        let bitWidths = (1...256).filter { $0 % 8 == 0 }
        let template = Template(templateString: Templates.IntX)
        let ints = try template.render(["bitWidths": bitWidths])
        print(ints)
    }
    
    static func generateBytesX() throws {
        let lengths = Array(1...32)
        let template = Template(templateString: Templates.BytesX)
        let bytes = try template.render(["lengths": lengths])
        print(bytes)
    }
    
    static func generateArrayX() throws {
        let lengths = Array(0...256)
        let template = Template(templateString: Templates.ArrayX)
        let bytes = try template.render(["lengths": lengths])
        print(bytes)
    }
}
