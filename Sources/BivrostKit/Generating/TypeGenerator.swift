//
//  TypeGenerator.swift
//  BivrostKit
//
//  Created by Luis Reisewitz on 10.10.17.
//  Copyright © 2017 Gnosis Ltd. All rights reserved.
//

import StencilSwiftKit

struct TypeGenerator {
    static func generateUIntX() throws -> String {
        let bitWidths = (1...256).filter { $0 % 8 == 0 }
        let template = StencilSwiftTemplate(templateString: Templates.UIntX)
        let uints = try template.render(["bitWidths": bitWidths])
        return uints
    }
    
    static func generateIntX() throws -> String {
        let bitWidths = (1...256).filter { $0 % 8 == 0 }
        let template = StencilSwiftTemplate(templateString: Templates.IntX)
        let ints = try template.render(["bitWidths": bitWidths])
        return ints
    }
    
    static func generateBytesX() throws -> String {
        let lengths = Array(1...32)
        let template = StencilSwiftTemplate(templateString: Templates.BytesX)
        let bytes = try template.render(["lengths": lengths])
        return bytes
    }
    
    static func generateArrayX() throws -> String {
        let lengths = Array(0...256)
        let template = StencilSwiftTemplate(templateString: Templates.ArrayX)
        let arrays = try template.render(["lengths": lengths])
        return arrays
    }
}
