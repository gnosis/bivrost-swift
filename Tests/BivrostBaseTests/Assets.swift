//
//  Assets.swift
//  BivrostBaseTests
//
//  Created by Luis Reisewitz on 27.09.17.
//  Copyright © 2017 Gnosis. All rights reserved.
//

struct Assets {
    static let multiSigWalletAbiJson = """
        [{
          "constant": true,
          "inputs": [
            {
              "name": "",
              "type": "uint256"
            }
          ],
          "name": "owners",
          "outputs": [
            {
              "name": "",
              "type": "address"
            }
          ],
          "payable": false,
          "type": "function"
        },
        {
          "constant": false,
          "inputs": [
            {
              "name": "owner",
              "type": "address"
            }
          ],
          "name": "removeOwner",
          "outputs": [],
          "payable": false,
          "type": "function"
        },
        {
          "constant": false,
          "inputs": [
            {
              "name": "transactionId",
              "type": "uint256"
            }
          ],
          "name": "revokeConfirmation",
          "outputs": [],
          "payable": false,
          "type": "function"
        },
        {
          "constant": true,
          "inputs": [
            {
              "name": "",
              "type": "address"
            }
          ],
          "name": "isOwner",
          "outputs": [
            {
              "name": "",
              "type": "bool"
            }
          ],
          "payable": false,
          "type": "function"
        },
        {
          "constant": true,
          "inputs": [
            {
              "name": "",
              "type": "uint256"
            },
            {
              "name": "",
              "type": "address"
            }
          ],
          "name": "confirmations",
          "outputs": [
            {
              "name": "",
              "type": "bool"
            }
          ],
          "payable": false,
          "type": "function"
        },
        {
          "constant": true,
          "inputs": [],
          "name": "calcMaxWithdraw",
          "outputs": [
            {
              "name": "",
              "type": "uint256"
            }
          ],
          "payable": false,
          "type": "function"
        },
        {
          "constant": true,
          "inputs": [
            {
              "name": "pending",
              "type": "bool"
            },
            {
              "name": "executed",
              "type": "bool"
            }
          ],
          "name": "getTransactionCount",
          "outputs": [
            {
              "name": "count",
              "type": "uint256"
            }
          ],
          "payable": false,
          "type": "function"
        },
        {
          "constant": true,
          "inputs": [],
          "name": "dailyLimit",
          "outputs": [
            {
              "name": "",
              "type": "uint256"
            }
          ],
          "payable": false,
          "type": "function"
        },
        {
          "constant": true,
          "inputs": [],
          "name": "lastDay",
          "outputs": [
            {
              "name": "",
              "type": "uint256"
            }
          ],
          "payable": false,
          "type": "function"
        },
        {
          "constant": false,
          "inputs": [
            {
              "name": "owner",
              "type": "address"
            }
          ],
          "name": "addOwner",
          "outputs": [],
          "payable": false,
          "type": "function"
        },
        {
          "constant": true,
          "inputs": [
            {
              "name": "transactionId",
              "type": "uint256"
            }
          ],
          "name": "isConfirmed",
          "outputs": [
            {
              "name": "",
              "type": "bool"
            }
          ],
          "payable": false,
          "type": "function"
        },
        {
          "constant": true,
          "inputs": [
            {
              "name": "transactionId",
              "type": "uint256"
            }
          ],
          "name": "getConfirmationCount",
          "outputs": [
            {
              "name": "count",
              "type": "uint256"
            }
          ],
          "payable": false,
          "type": "function"
        },
        {
          "constant": true,
          "inputs": [
            {
              "name": "",
              "type": "uint256"
            }
          ],
          "name": "transactions",
          "outputs": [
            {
              "name": "destination",
              "type": "address"
            },
            {
              "name": "value",
              "type": "uint256"
            },
            {
              "name": "data",
              "type": "bytes"
            },
            {
              "name": "executed",
              "type": "bool"
            }
          ],
          "payable": false,
          "type": "function"
        },
        {
          "constant": true,
          "inputs": [],
          "name": "getOwners",
          "outputs": [
            {
              "name": "",
              "type": "address[]"
            }
          ],
          "payable": false,
          "type": "function"
        },
        {
          "constant": true,
          "inputs": [
            {
              "name": "from",
              "type": "uint256"
            },
            {
              "name": "to",
              "type": "uint256"
            },
            {
              "name": "pending",
              "type": "bool"
            },
            {
              "name": "executed",
              "type": "bool"
            }
          ],
          "name": "getTransactionIds",
          "outputs": [
            {
              "name": "_transactionIds",
              "type": "uint256[]"
            }
          ],
          "payable": false,
          "type": "function"
        },
        {
          "constant": true,
          "inputs": [
            {
              "name": "transactionId",
              "type": "uint256"
            }
          ],
          "name": "getConfirmations",
          "outputs": [
            {
              "name": "_confirmations",
              "type": "address[]"
            }
          ],
          "payable": false,
          "type": "function"
        },
        {
          "constant": true,
          "inputs": [],
          "name": "transactionCount",
          "outputs": [
            {
              "name": "",
              "type": "uint256"
            }
          ],
          "payable": false,
          "type": "function"
        },
        {
          "constant": false,
          "inputs": [
            {
              "name": "_required",
              "type": "uint256"
            }
          ],
          "name": "changeRequirement",
          "outputs": [],
          "payable": false,
          "type": "function"
        },
        {
          "constant": false,
          "inputs": [
            {
              "name": "transactionId",
              "type": "uint256"
            }
          ],
          "name": "confirmTransaction",
          "outputs": [],
          "payable": false,
          "type": "function"
        },
        {
          "constant": false,
          "inputs": [
            {
              "name": "destination",
              "type": "address"
            },
            {
              "name": "value",
              "type": "uint256"
            },
            {
              "name": "data",
              "type": "bytes"
            }
          ],
          "name": "submitTransaction",
          "outputs": [
            {
              "name": "transactionId",
              "type": "uint256"
            }
          ],
          "payable": false,
          "type": "function"
        },
        {
          "constant": false,
          "inputs": [
            {
              "name": "_dailyLimit",
              "type": "uint256"
            }
          ],
          "name": "changeDailyLimit",
          "outputs": [],
          "payable": false,
          "type": "function"
        },
        {
          "constant": true,
          "inputs": [],
          "name": "MAX_OWNER_COUNT",
          "outputs": [
            {
              "name": "",
              "type": "uint256"
            }
          ],
          "payable": false,
          "type": "function"
        },
        {
          "constant": true,
          "inputs": [],
          "name": "required",
          "outputs": [
            {
              "name": "",
              "type": "uint256"
            }
          ],
          "payable": false,
          "type": "function"
        },
        {
          "constant": false,
          "inputs": [
            {
              "name": "owner",
              "type": "address"
            },
            {
              "name": "newOwner",
              "type": "address"
            }
          ],
          "name": "replaceOwner",
          "outputs": [],
          "payable": false,
          "type": "function"
        },
        {
          "constant": false,
          "inputs": [
            {
              "name": "transactionId",
              "type": "uint256"
            }
          ],
          "name": "executeTransaction",
          "outputs": [],
          "payable": false,
          "type": "function"
        },
        {
          "constant": true,
          "inputs": [],
          "name": "spentToday",
          "outputs": [
            {
              "name": "",
              "type": "uint256"
            }
          ],
          "payable": false,
          "type": "function"
        },
        {
          "inputs": [
            {
              "name": "_owners",
              "type": "address[]"
            },
            {
              "name": "_required",
              "type": "uint256"
            },
            {
              "name": "_dailyLimit",
              "type": "uint256"
            }
          ],
          "payable": false,
          "type": "constructor"
        },
        {
          "payable": true,
          "type": "fallback"
        },
        {
          "anonymous": false,
          "inputs": [
            {
              "indexed": false,
              "name": "dailyLimit",
              "type": "uint256"
            }
          ],
          "name": "DailyLimitChange",
          "type": "event"
        },
        {
          "anonymous": false,
          "inputs": [
            {
              "indexed": true,
              "name": "sender",
              "type": "address"
            },
            {
              "indexed": true,
              "name": "transactionId",
              "type": "uint256"
            }
          ],
          "name": "Confirmation",
          "type": "event"
        },
        {
          "anonymous": false,
          "inputs": [
            {
              "indexed": true,
              "name": "sender",
              "type": "address"
            },
            {
              "indexed": true,
              "name": "transactionId",
              "type": "uint256"
            }
          ],
          "name": "Revocation",
          "type": "event"
        },
        {
          "anonymous": false,
          "inputs": [
            {
              "indexed": true,
              "name": "transactionId",
              "type": "uint256"
            }
          ],
          "name": "Submission",
          "type": "event"
        },
        {
          "anonymous": false,
          "inputs": [
            {
              "indexed": true,
              "name": "transactionId",
              "type": "uint256"
            }
          ],
          "name": "Execution",
          "type": "event"
        },
        {
          "anonymous": false,
          "inputs": [
            {
              "indexed": true,
              "name": "transactionId",
              "type": "uint256"
            }
          ],
          "name": "ExecutionFailure",
          "type": "event"
        },
        {
          "anonymous": false,
          "inputs": [
            {
              "indexed": true,
              "name": "sender",
              "type": "address"
            },
            {
              "indexed": false,
              "name": "value",
              "type": "uint256"
            }
          ],
          "name": "Deposit",
          "type": "event"
        },
        {
          "anonymous": false,
          "inputs": [
            {
              "indexed": true,
              "name": "owner",
              "type": "address"
            }
          ],
          "name": "OwnerAddition",
          "type": "event"
        },
        {
          "anonymous": false,
          "inputs": [
            {
              "indexed": true,
              "name": "owner",
              "type": "address"
            }
          ],
          "name": "OwnerRemoval",
          "type": "event"
        },
        {
          "anonymous": false,
          "inputs": [
            {
              "indexed": false,
              "name": "required",
              "type": "uint256"
            }
          ],
          "name": "RequirementChange",
          "type": "event"
        }
      ]
    """
    
    static let testTokenAbiJson = """
        [{
          "constant": true,
          "inputs": [],
          "name": "name",
          "outputs": [
            {
              "name": "",
              "type": "string"
            }
          ],
          "payable": false,
          "type": "function"
        },
        {
          "constant": false,
          "inputs": [
            {
              "name": "_spender",
              "type": "address"
            },
            {
              "name": "_value",
              "type": "uint256"
            }
          ],
          "name": "approve",
          "outputs": [
            {
              "name": "success",
              "type": "bool"
            }
          ],
          "payable": false,
          "type": "function"
        },
        {
          "constant": true,
          "inputs": [],
          "name": "totalSupply",
          "outputs": [
            {
              "name": "",
              "type": "uint256"
            }
          ],
          "payable": false,
          "type": "function"
        },
        {
          "constant": false,
          "inputs": [
            {
              "name": "_from",
              "type": "address"
            },
            {
              "name": "_to",
              "type": "address"
            },
            {
              "name": "_value",
              "type": "uint256"
            }
          ],
          "name": "transferFrom",
          "outputs": [
            {
              "name": "success",
              "type": "bool"
            }
          ],
          "payable": false,
          "type": "function"
        },
        {
          "constant": true,
          "inputs": [],
          "name": "decimals",
          "outputs": [
            {
              "name": "",
              "type": "uint8"
            }
          ],
          "payable": false,
          "type": "function"
        },
        {
          "constant": false,
          "inputs": [
            {
              "name": "_to",
              "type": "address"
            },
            {
              "name": "_value",
              "type": "uint256"
            }
          ],
          "name": "issueTokens",
          "outputs": [],
          "payable": false,
          "type": "function"
        },
        {
          "constant": true,
          "inputs": [
            {
              "name": "_owner",
              "type": "address"
            }
          ],
          "name": "balanceOf",
          "outputs": [
            {
              "name": "balance",
              "type": "uint256"
            }
          ],
          "payable": false,
          "type": "function"
        },
        {
          "constant": true,
          "inputs": [],
          "name": "symbol",
          "outputs": [
            {
              "name": "",
              "type": "string"
            }
          ],
          "payable": false,
          "type": "function"
        },
        {
          "constant": false,
          "inputs": [
            {
              "name": "_to",
              "type": "address"
            },
            {
              "name": "_value",
              "type": "uint256"
            }
          ],
          "name": "transfer",
          "outputs": [
            {
              "name": "success",
              "type": "bool"
            }
          ],
          "payable": false,
          "type": "function"
        },
        {
          "constant": true,
          "inputs": [
            {
              "name": "_owner",
              "type": "address"
            },
            {
              "name": "_spender",
              "type": "address"
            }
          ],
          "name": "allowance",
          "outputs": [
            {
              "name": "remaining",
              "type": "uint256"
            }
          ],
          "payable": false,
          "type": "function"
        },
        {
          "anonymous": false,
          "inputs": [
            {
              "indexed": true,
              "name": "from",
              "type": "address"
            },
            {
              "indexed": true,
              "name": "to",
              "type": "address"
            },
            {
              "indexed": false,
              "name": "value",
              "type": "uint256"
            }
          ],
          "name": "Transfer",
          "type": "event"
        },
        {
          "anonymous": false,
          "inputs": [
            {
              "indexed": true,
              "name": "owner",
              "type": "address"
            },
            {
              "indexed": true,
              "name": "spender",
              "type": "address"
            },
            {
              "indexed": false,
              "name": "value",
              "type": "uint256"
            }
          ],
          "name": "Approval",
          "type": "event"
        }
      ]
    """
    
    /// Encoded string[6] with contents
    /// ["Hi", "I", "want", "to", "learn", "Solidity"]
    static let encodedFixedStringArray = "" +
        // Location of String "Hi"
        "00000000000000000000000000000000000000000000000000000000000000c0" +
        // Location of String "I"
        "0000000000000000000000000000000000000000000000000000000000000100" +
        // Location of String "want"
        "0000000000000000000000000000000000000000000000000000000000000140" +
        // Location of String "to"
        "0000000000000000000000000000000000000000000000000000000000000180" +
        // Location of String "learn"
        "00000000000000000000000000000000000000000000000000000000000001c0" +
        // Location of String "Solidity"
        "0000000000000000000000000000000000000000000000000000000000000200" +
        
        // Length of "Hi"
        "0000000000000000000000000000000000000000000000000000000000000002" +
        // Byte string of "Hi"
        "4869000000000000000000000000000000000000000000000000000000000000" +
        
        // Length of "I"
        "0000000000000000000000000000000000000000000000000000000000000001" +
        // Byte string of "I"
        "4900000000000000000000000000000000000000000000000000000000000000" +
        
        // Length of "want"
        "0000000000000000000000000000000000000000000000000000000000000004" +
        // Byte string of "Want"
        "77616e7400000000000000000000000000000000000000000000000000000000" +
        
        // Length of "to"
        "0000000000000000000000000000000000000000000000000000000000000002" +
        // Byte string of "to"
        "746f000000000000000000000000000000000000000000000000000000000000" +
        
        // Length of "learn"
        "0000000000000000000000000000000000000000000000000000000000000005" +
        // Byte string of "learn"
        "6c6561726e000000000000000000000000000000000000000000000000000000" +
        
        // Length of "Solidity"
        "0000000000000000000000000000000000000000000000000000000000000008" +
        // Byte string of "Solidity"
        "536f6c6964697479000000000000000000000000000000000000000000000000"
    
    /// Encoded string[] with contents
    /// ["Hi", "I", "want", "to", "learn", "Solidity"]
    static let encodedVariableStringArray = "" +
        // Array length
        "0000000000000000000000000000000000000000000000000000000000000006" +
        encodedFixedStringArray

}
