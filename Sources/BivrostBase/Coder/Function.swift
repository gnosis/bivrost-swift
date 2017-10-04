//
//  Function.swift
//  BivrostPackageDescription
//
//  Created by Luis Reisewitz on 01.10.17.
//

extension Solidity {
    struct Function {
        let address: Address
        let functionSelector: Swift.String
        
        /// Represents a function to be called on any contract. Function selector
        /// has to be passed as a hex string with exactly 8 characters (4 bytes).
        /// Refer to https://github.com/ethereum/wiki/wiki/Ethereum-Contract-ABI#function-selector
        /// for information on how to create one.
        ///
        /// - Parameters:
        ///   - functionSelector: The encoded function selector.
        ///     4 Bytes/8 Characters. Example: 095ea7b3
        ///   - address: The address of the contract to be called.
        init?(_ functionSelector: Swift.String, at address: Address) {
            guard functionSelector.characters.count == 8 else {
                return nil
            }
            self.address = address
            self.functionSelector = functionSelector
        }
    }
}

// MARK: - StaticType
extension Solidity.Function: StaticType {
    func encode() -> SolidityEncodable.EncodeFormat {
        // Address string padded to 20 bytes
        let addressHex = address.encodeUnpadded()
        
        let unPaddedString = addressHex + functionSelector
        return unPaddedString.padToSolidity(location: .right)
    }
    
    static func decode(source: BaseDecoder.PartitionData) throws -> Solidity.Function {
        throw BivrostError.notImplemented
    }
}
