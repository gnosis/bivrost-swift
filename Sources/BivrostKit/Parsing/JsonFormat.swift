//
//  JsonFormat.swift
//  BivrostKit
//
//  Created by Luis Reisewitz on 08.11.17.
//

typealias JsonDict = [String: Any]

public enum JsonFormat: String {
    case truffle3 = "truffle3"
    case solc0_4 = "solc0.4"
}

extension JsonFormat {
    var parserType: ContractParser.Type {
        switch self {
        case .truffle3:
            return Truffle3ContractParser.self
        case .solc0_4:
            fatalError("Json Format \(self.rawValue) is not yet supported.")
        }
    }
}
