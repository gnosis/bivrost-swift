//
//  main.swift
//  Bivrost
//
//  Created by Luis Reisewitz on 27.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//

import BivrostBase
import BigInt

print(try! Solidity.UInt256(BigUInt(1234567890)) as Any)
