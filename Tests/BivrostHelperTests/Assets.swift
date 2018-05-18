//
//  Assets.swift
//  BivrostHelperTests
//
//  Created by Luis Reisewitz on 27.09.17.
//  Copyright © 2017 Gnosis Ltd. All rights reserved.
//

struct Assets {
    static let multiSigWalletJson = """
        {
          "contractName": "MultiSigWalletWithDailyLimit",
          "abi": [
            {
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
          ],
          "unlinked_binary": "0x606060405234156200001057600080fd5b60405162001aff38038062001aff83398101604052808051820191906020018051919060200180519150505b82825b600082518260328211806200005357508181115b806200005d575080155b8062000067575081155b156200007257600080fd5b600092505b84518310156200013f57600260008685815181106200009257fe5b90602001906020020151600160a060020a0316815260208101919091526040016000205460ff1680620000e25750848381518110620000cd57fe5b90602001906020020151600160a060020a0316155b15620000ed57600080fd5b6001600260008786815181106200010057fe5b90602001906020020151600160a060020a031681526020810191909152604001600020805460ff19169115159190911790555b60019092019162000077565b60038580516200015492916020019062000170565b5060048490555b5b505050600683905550505b5050506200020b565b828054828255906000526020600020908101928215620001ca579160200282015b82811115620001ca5782518254600160a060020a031916600160a060020a03919091161782556020929092019160019091019062000191565b5b50620001d9929150620001dd565b5090565b6200020891905b80821115620001d9578054600160a060020a0319168155600101620001e4565b5090565b90565b6118e4806200021b6000396000f300606060405236156101515763ffffffff7c0100000000000000000000000000000000000000000000000000000000600035041663025e7c27811461019c578063173825d9146101ce57806320ea8d86146101ef5780632f54bf6e146102075780633411c81c1461023a5780634bc9fdc214610270578063547415251461029557806367eeba0c146102c45780636b0c932d146102e95780637065cb481461030e578063784547a71461032f5780638b51d13f146103595780639ace38c214610381578063a0e67e2b14610440578063a8abe69a146104a7578063b5dc40c31461051e578063b77bf60014610588578063ba51a6df146105ad578063c01a8c84146105c5578063c6427474146105dd578063cea0862114610654578063d74f8edd1461066c578063dc8452cd14610691578063e20056e6146106b6578063ee22610b146106dd578063f059cf2b146106f5575b5b60003411156101995733600160a060020a03167fe1fffcc4923d04b559f4d29a8bfc6cda04eb5b0d3c460751c2402c5c5cc9109c3460405190815260200160405180910390a25b5b005b34156101a757600080fd5b6101b260043561071a565b604051600160a060020a03909116815260200160405180910390f35b34156101d957600080fd5b610199600160a060020a036004351661074c565b005b34156101fa57600080fd5b6101996004356108fd565b005b341561021257600080fd5b610226600160a060020a03600435166109df565b604051901515815260200160405180910390f35b341561024557600080fd5b610226600435600160a060020a03602435166109f4565b604051901515815260200160405180910390f35b341561027b57600080fd5b610283610a14565b60405190815260200160405180910390f35b34156102a057600080fd5b61028360043515156024351515610a4e565b60405190815260200160405180910390f35b34156102cf57600080fd5b610283610abd565b60405190815260200160405180910390f35b34156102f457600080fd5b610283610ac3565b60405190815260200160405180910390f35b341561031957600080fd5b610199600160a060020a0360043516610ac9565b005b341561033a57600080fd5b610226600435610bfe565b604051901515815260200160405180910390f35b341561036457600080fd5b610283600435610c92565b60405190815260200160405180910390f35b341561038c57600080fd5b610397600435610d11565b604051600160a060020a03851681526020810184905281151560608201526080604082018181528454600260001961010060018416150201909116049183018290529060a08301908590801561042e5780601f106104035761010080835404028352916020019161042e565b820191906000526020600020905b81548152906001019060200180831161041157829003601f168201915b50509550505050505060405180910390f35b341561044b57600080fd5b610453610d45565b60405160208082528190810183818151815260200191508051906020019060200280838360005b838110156104935780820151818401525b60200161047a565b505050509050019250505060405180910390f35b34156104b257600080fd5b61045360043560243560443515156064351515610dae565b60405160208082528190810183818151815260200191508051906020019060200280838360005b838110156104935780820151818401525b60200161047a565b505050509050019250505060405180910390f35b341561052957600080fd5b610453600435610edc565b60405160208082528190810183818151815260200191508051906020019060200280838360005b838110156104935780820151818401525b60200161047a565b505050509050019250505060405180910390f35b341561059357600080fd5b61028361105e565b60405190815260200160405180910390f35b34156105b857600080fd5b610199600435611064565b005b34156105d057600080fd5b6101996004356110f2565b005b34156105e857600080fd5b61028360048035600160a060020a03169060248035919060649060443590810190830135806020601f820181900481020160405190810160405281815292919060208401838380828437509496506111e495505050505050565b60405190815260200160405180910390f35b341561065f57600080fd5b610199600435611204565b005b341561067757600080fd5b610283611261565b60405190815260200160405180910390f35b341561069c57600080fd5b610283611266565b60405190815260200160405180910390f35b34156106c157600080fd5b610199600160a060020a036004358116906024351661126c565b005b34156106e857600080fd5b61019960043561142d565b005b341561070057600080fd5b610283611653565b60405190815260200160405180910390f35b600380548290811061072857fe5b906000526020600020900160005b915054906101000a9004600160a060020a031681565b600030600160a060020a031633600160a060020a031614151561076e57600080fd5b600160a060020a038216600090815260026020526040902054829060ff16151561079757600080fd5b600160a060020a0383166000908152600260205260408120805460ff1916905591505b600354600019018210156108925782600160a060020a03166003838154811015156107e157fe5b906000526020600020900160005b9054906101000a9004600160a060020a0316600160a060020a031614156108865760038054600019810190811061082257fe5b906000526020600020900160005b9054906101000a9004600160a060020a031660038381548110151561085157fe5b906000526020600020900160005b6101000a815481600160a060020a030219169083600160a060020a03160217905550610892565b5b6001909101906107ba565b6003805460001901906108a590826117a0565b5060035460045411156108be576003546108be90611064565b5b82600160a060020a03167f8001553a916ef2f495d26a907cc54d96ed840d7bda71e73194bf5a9df7a76b9060405160405180910390a25b5b505b5050565b33600160a060020a03811660009081526002602052604090205460ff16151561092557600080fd5b600082815260016020908152604080832033600160a060020a038116855292529091205483919060ff16151561095a57600080fd5b600084815260208190526040902060030154849060ff161561097b57600080fd5b6000858152600160209081526040808320600160a060020a033316808552925291829020805460ff1916905586917ff6a317157440607f36269043eb55f1287a5a19ba2216afeab88cd46cbcfb88e9905160405180910390a35b5b505b50505b5050565b60026020526000908152604090205460ff1681565b600160209081526000928352604080842090915290825290205460ff1681565b60006007546201518001421115610a2e5750600654610a4b565b6008546006541015610a4257506000610a4b565b50600854600654035b90565b6000805b600554811015610ab557838015610a7b575060008181526020819052604090206003015460ff16155b80610a9f5750828015610a9f575060008181526020819052604090206003015460ff165b5b15610aac576001820191505b5b600101610a52565b5b5092915050565b60065481565b60075481565b30600160a060020a031633600160a060020a0316141515610ae957600080fd5b600160a060020a038116600090815260026020526040902054819060ff1615610b1157600080fd5b81600160a060020a0381161515610b2757600080fd5b6003805490506001016004546032821180610b4157508181115b80610b4a575080155b80610b53575081155b15610b5d57600080fd5b600160a060020a0385166000908152600260205260409020805460ff191660019081179091556003805490918101610b9583826117a0565b916000526020600020900160005b8154600160a060020a03808a166101009390930a8381029102199091161790915590507ff39e6e1eb0edcf53c221607b54b00cd28f3196fed0a24994dc308b8f611b682d60405160405180910390a25b5b50505b505b505b50565b600080805b600354811015610c8a5760008481526001602052604081206003805491929184908110610c2c57fe5b906000526020600020900160005b9054600160a060020a036101009290920a900416815260208101919091526040016000205460ff1615610c6e576001820191505b600454821415610c815760019250610c8a565b5b600101610c03565b5b5050919050565b6000805b600354811015610d0a5760008381526001602052604081206003805491929184908110610cbf57fe5b906000526020600020900160005b9054600160a060020a036101009290920a900416815260208101919091526040016000205460ff1615610d01576001820191505b5b600101610c96565b5b50919050565b6000602081905290815260409020805460018201546003830154600160a060020a0390921692909160029091019060ff1684565b610d4d6117f4565b6003805480602002602001604051908101604052809291908181526020018280548015610da357602002820191906000526020600020905b8154600160a060020a03168152600190910190602001808311610d85575b505050505090505b90565b610db66117f4565b610dbe6117f4565b600080600554604051805910610dd15750595b908082528060200260200182016040525b50925060009150600090505b600554811015610e6957858015610e17575060008181526020819052604090206003015460ff16155b80610e3b5750848015610e3b575060008181526020819052604090206003015460ff165b5b15610e605780838381518110610e4e57fe5b60209081029091010152600191909101905b5b600101610dee565b878703604051805910610e795750595b908082528060200260200182016040525b5093508790505b86811015610ed057828181518110610ea557fe5b906020019060200201518489830381518110610ebd57fe5b602090810290910101525b600101610e91565b5b505050949350505050565b610ee46117f4565b610eec6117f4565b6003546000908190604051805910610f015750595b908082528060200260200182016040525b50925060009150600090505b600354811015610fe45760008581526001602052604081206003805491929184908110610f4757fe5b906000526020600020900160005b9054600160a060020a036101009290920a900416815260208101919091526040016000205460ff1615610fdb576003805482908110610f9057fe5b906000526020600020900160005b9054906101000a9004600160a060020a0316838381518110610fbc57fe5b600160a060020a03909216602092830290910190910152600191909101905b5b600101610f1e565b81604051805910610ff25750595b908082528060200260200182016040525b509350600090505b818110156110555782818151811061101f57fe5b9060200190602002015184828151811061103557fe5b600160a060020a039092166020928302909101909101525b60010161100b565b5b505050919050565b60055481565b30600160a060020a031633600160a060020a031614151561108457600080fd5b60035481603282118061109657508181115b8061109f575080155b806110a8575081155b156110b257600080fd5b60048390557fa3f1ee9126a074d9326c682f561767f710e927faa811f7a99829d49dc421797a8360405190815260200160405180910390a15b5b50505b50565b33600160a060020a03811660009081526002602052604090205460ff16151561111a57600080fd5b6000828152602081905260409020548290600160a060020a0316151561113f57600080fd5b600083815260016020908152604080832033600160a060020a038116855292529091205484919060ff161561117357600080fd5b6000858152600160208181526040808420600160a060020a033316808652925292839020805460ff191690921790915586917f4a504a94899432a9846e1aa406dceb1bcfd538bb839071d49d1e5e23f5be30ef905160405180910390a36109d58561142d565b5b5b50505b505b5050565b60006111f1848484611659565b90506111fc816110f2565b5b9392505050565b30600160a060020a031633600160a060020a031614151561122457600080fd5b60068190557fc71bdc6afaf9b1aa90a7078191d4fc1adf3bf680fca3183697df6b0dc226bca28160405190815260200160405180910390a15b5b50565b603281565b60045481565b600030600160a060020a031633600160a060020a031614151561128e57600080fd5b600160a060020a038316600090815260026020526040902054839060ff1615156112b757600080fd5b600160a060020a038316600090815260026020526040902054839060ff16156112df57600080fd5b600092505b6003548310156113875784600160a060020a031660038481548110151561130757fe5b906000526020600020900160005b9054906101000a9004600160a060020a0316600160a060020a0316141561137b578360038481548110151561134657fe5b906000526020600020900160005b6101000a815481600160a060020a030219169083600160a060020a03160217905550611387565b5b6001909201916112e4565b600160a060020a03808616600081815260026020526040808220805460ff199081169091559388168252908190208054909316600117909255907f8001553a916ef2f495d26a907cc54d96ed840d7bda71e73194bf5a9df7a76b90905160405180910390a283600160a060020a03167ff39e6e1eb0edcf53c221607b54b00cd28f3196fed0a24994dc308b8f611b682d60405160405180910390a25b5b505b505b505050565b33600160a060020a0381166000908152600260205260408120549091829160ff16151561145957600080fd5b600084815260016020908152604080832033600160a060020a038116855292529091205485919060ff16151561148e57600080fd5b600086815260208190526040902060030154869060ff16156114af57600080fd5b600087815260208190526040902095506114c887610bfe565b945084806114fb57506002808701546000196101006001831615020116041580156114fb57506114fb8660010154611758565b5b5b156116445760038601805460ff191660011790558415156115275760018601546008805490910190555b85546001870154600160a060020a03909116906002880160405180828054600181600116156101000203166002900480156115a35780601f10611578576101008083540402835291602001916115a3565b820191906000526020600020905b81548152906001019060200180831161158657829003601f168201915b505091505060006040518083038185876187965a03f192505050156115f457867f33e13ecb54c3076d8e8bb8c2881800a4d972b792045ffae98fdf46df365fed7560405160405180910390a2611644565b867f526441bb6c1aba3c9a4a6ca1d6545da9c2333c8c48343ef398eb858d72b7923660405160405180910390a260038601805460ff19169055841515611644576001860154600880549190910390555b5b5b5b5b505b50505b50505050565b60085481565b600083600160a060020a038116151561167157600080fd5b600554915060806040519081016040908152600160a060020a0387168252602080830187905281830186905260006060840181905285815290819052208151815473ffffffffffffffffffffffffffffffffffffffff1916600160a060020a0391909116178155602082015181600101556040820151816002019080516116fc929160200190611818565b506060820151600391909101805460ff191691151591909117905550600580546001019055817fc0ba8fe4b176c1714197d43b9cc6bcf797a4a7461c5fe8d0ef6e184ae7601e5160405160405180910390a25b5b509392505050565b60006007546201518001421115611773574260075560006008555b6006548260085401118061178a5750600854828101105b156117975750600061179b565b5060015b919050565b8154818355818115116108f6576000838152602090206108f6918101908301611897565b5b505050565b8154818355818115116108f6576000838152602090206108f6918101908301611897565b5b505050565b60206040519081016040526000815290565b60206040519081016040526000815290565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f1061185957805160ff1916838001178555611886565b82800160010185558215611886579182015b8281111561188657825182559160200191906001019061186b565b5b50611893929150611897565b5090565b610a4b91905b80821115611893576000815560010161189d565b5090565b905600a165627a7a72305820d3211db5ffa2f29e85c3da246b6db04264f14c645ec6e960e837a0c3e65e17310029",
          "networks": {
            "4": {
              "events": {
                "0xc71bdc6afaf9b1aa90a7078191d4fc1adf3bf680fca3183697df6b0dc226bca2": {
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
                "0x4a504a94899432a9846e1aa406dceb1bcfd538bb839071d49d1e5e23f5be30ef": {
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
                "0xf6a317157440607f36269043eb55f1287a5a19ba2216afeab88cd46cbcfb88e9": {
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
                "0xc0ba8fe4b176c1714197d43b9cc6bcf797a4a7461c5fe8d0ef6e184ae7601e51": {
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
                "0x33e13ecb54c3076d8e8bb8c2881800a4d972b792045ffae98fdf46df365fed75": {
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
                "0x526441bb6c1aba3c9a4a6ca1d6545da9c2333c8c48343ef398eb858d72b79236": {
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
                "0xe1fffcc4923d04b559f4d29a8bfc6cda04eb5b0d3c460751c2402c5c5cc9109c": {
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
                "0xf39e6e1eb0edcf53c221607b54b00cd28f3196fed0a24994dc308b8f611b682d": {
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
                "0x8001553a916ef2f495d26a907cc54d96ed840d7bda71e73194bf5a9df7a76b90": {
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
                "0xa3f1ee9126a074d9326c682f561767f710e927faa811f7a99829d49dc421797a": {
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
              },
              "links": {},
              "address": "0xc6fc5e99b5d253f6eabf53fb2eab94af4e6a1444",
              "updated_at": 1502120172195
            },
            "1501773173021": {
              "events": {
                "0xc71bdc6afaf9b1aa90a7078191d4fc1adf3bf680fca3183697df6b0dc226bca2": {
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
                "0x4a504a94899432a9846e1aa406dceb1bcfd538bb839071d49d1e5e23f5be30ef": {
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
                "0xf6a317157440607f36269043eb55f1287a5a19ba2216afeab88cd46cbcfb88e9": {
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
                "0xc0ba8fe4b176c1714197d43b9cc6bcf797a4a7461c5fe8d0ef6e184ae7601e51": {
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
                "0x33e13ecb54c3076d8e8bb8c2881800a4d972b792045ffae98fdf46df365fed75": {
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
                "0x526441bb6c1aba3c9a4a6ca1d6545da9c2333c8c48343ef398eb858d72b79236": {
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
                "0xe1fffcc4923d04b559f4d29a8bfc6cda04eb5b0d3c460751c2402c5c5cc9109c": {
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
                "0xf39e6e1eb0edcf53c221607b54b00cd28f3196fed0a24994dc308b8f611b682d": {
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
                "0x8001553a916ef2f495d26a907cc54d96ed840d7bda71e73194bf5a9df7a76b90": {
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
                "0xa3f1ee9126a074d9326c682f561767f710e927faa811f7a99829d49dc421797a": {
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
              },
              "links": {},
              "address": "0x76608a542b425cba81d277f6436007add848c0af",
              "updated_at": 1501773381002
            },
            "1501780925527": {
              "events": {
                "0xc71bdc6afaf9b1aa90a7078191d4fc1adf3bf680fca3183697df6b0dc226bca2": {
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
                "0x4a504a94899432a9846e1aa406dceb1bcfd538bb839071d49d1e5e23f5be30ef": {
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
                "0xf6a317157440607f36269043eb55f1287a5a19ba2216afeab88cd46cbcfb88e9": {
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
                "0xc0ba8fe4b176c1714197d43b9cc6bcf797a4a7461c5fe8d0ef6e184ae7601e51": {
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
                "0x33e13ecb54c3076d8e8bb8c2881800a4d972b792045ffae98fdf46df365fed75": {
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
                "0x526441bb6c1aba3c9a4a6ca1d6545da9c2333c8c48343ef398eb858d72b79236": {
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
                "0xe1fffcc4923d04b559f4d29a8bfc6cda04eb5b0d3c460751c2402c5c5cc9109c": {
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
                "0xf39e6e1eb0edcf53c221607b54b00cd28f3196fed0a24994dc308b8f611b682d": {
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
                "0x8001553a916ef2f495d26a907cc54d96ed840d7bda71e73194bf5a9df7a76b90": {
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
                "0xa3f1ee9126a074d9326c682f561767f710e927faa811f7a99829d49dc421797a": {
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
              },
              "links": {},
              "address": "0xe71d2ddb3ca69a94b557695a9614d3262845ea11",
              "updated_at": 1501781178879
            },
            "1501791560079": {
              "events": {
                "0xc71bdc6afaf9b1aa90a7078191d4fc1adf3bf680fca3183697df6b0dc226bca2": {
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
                "0x4a504a94899432a9846e1aa406dceb1bcfd538bb839071d49d1e5e23f5be30ef": {
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
                "0xf6a317157440607f36269043eb55f1287a5a19ba2216afeab88cd46cbcfb88e9": {
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
                "0xc0ba8fe4b176c1714197d43b9cc6bcf797a4a7461c5fe8d0ef6e184ae7601e51": {
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
                "0x33e13ecb54c3076d8e8bb8c2881800a4d972b792045ffae98fdf46df365fed75": {
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
                "0x526441bb6c1aba3c9a4a6ca1d6545da9c2333c8c48343ef398eb858d72b79236": {
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
                "0xe1fffcc4923d04b559f4d29a8bfc6cda04eb5b0d3c460751c2402c5c5cc9109c": {
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
                "0xf39e6e1eb0edcf53c221607b54b00cd28f3196fed0a24994dc308b8f611b682d": {
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
                "0x8001553a916ef2f495d26a907cc54d96ed840d7bda71e73194bf5a9df7a76b90": {
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
                "0xa3f1ee9126a074d9326c682f561767f710e927faa811f7a99829d49dc421797a": {
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
              },
              "links": {},
              "address": "0xc6fc5e99b5d253f6eabf53fb2eab94af4e6a1444",
              "updated_at": 1501791583578
            },
            "1501848782414": {
              "events": {
                "0xc71bdc6afaf9b1aa90a7078191d4fc1adf3bf680fca3183697df6b0dc226bca2": {
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
                "0x4a504a94899432a9846e1aa406dceb1bcfd538bb839071d49d1e5e23f5be30ef": {
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
                "0xf6a317157440607f36269043eb55f1287a5a19ba2216afeab88cd46cbcfb88e9": {
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
                "0xc0ba8fe4b176c1714197d43b9cc6bcf797a4a7461c5fe8d0ef6e184ae7601e51": {
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
                "0x33e13ecb54c3076d8e8bb8c2881800a4d972b792045ffae98fdf46df365fed75": {
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
                "0x526441bb6c1aba3c9a4a6ca1d6545da9c2333c8c48343ef398eb858d72b79236": {
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
                "0xe1fffcc4923d04b559f4d29a8bfc6cda04eb5b0d3c460751c2402c5c5cc9109c": {
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
                "0xf39e6e1eb0edcf53c221607b54b00cd28f3196fed0a24994dc308b8f611b682d": {
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
                "0x8001553a916ef2f495d26a907cc54d96ed840d7bda71e73194bf5a9df7a76b90": {
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
                "0xa3f1ee9126a074d9326c682f561767f710e927faa811f7a99829d49dc421797a": {
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
              },
              "links": {},
              "address": "0xe71d2ddb3ca69a94b557695a9614d3262845ea11",
              "updated_at": 1501848894404
            },
            "1501928484063": {
              "events": {
                "0xc71bdc6afaf9b1aa90a7078191d4fc1adf3bf680fca3183697df6b0dc226bca2": {
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
                "0x4a504a94899432a9846e1aa406dceb1bcfd538bb839071d49d1e5e23f5be30ef": {
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
                "0xf6a317157440607f36269043eb55f1287a5a19ba2216afeab88cd46cbcfb88e9": {
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
                "0xc0ba8fe4b176c1714197d43b9cc6bcf797a4a7461c5fe8d0ef6e184ae7601e51": {
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
                "0x33e13ecb54c3076d8e8bb8c2881800a4d972b792045ffae98fdf46df365fed75": {
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
                "0x526441bb6c1aba3c9a4a6ca1d6545da9c2333c8c48343ef398eb858d72b79236": {
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
                "0xe1fffcc4923d04b559f4d29a8bfc6cda04eb5b0d3c460751c2402c5c5cc9109c": {
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
                "0xf39e6e1eb0edcf53c221607b54b00cd28f3196fed0a24994dc308b8f611b682d": {
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
                "0x8001553a916ef2f495d26a907cc54d96ed840d7bda71e73194bf5a9df7a76b90": {
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
                "0xa3f1ee9126a074d9326c682f561767f710e927faa811f7a99829d49dc421797a": {
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
              },
              "links": {},
              "address": "0xc6fc5e99b5d253f6eabf53fb2eab94af4e6a1444",
              "updated_at": 1501928491739
            },
            "1502111491868": {
              "events": {
                "0xc71bdc6afaf9b1aa90a7078191d4fc1adf3bf680fca3183697df6b0dc226bca2": {
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
                "0x4a504a94899432a9846e1aa406dceb1bcfd538bb839071d49d1e5e23f5be30ef": {
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
                "0xf6a317157440607f36269043eb55f1287a5a19ba2216afeab88cd46cbcfb88e9": {
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
                "0xc0ba8fe4b176c1714197d43b9cc6bcf797a4a7461c5fe8d0ef6e184ae7601e51": {
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
                "0x33e13ecb54c3076d8e8bb8c2881800a4d972b792045ffae98fdf46df365fed75": {
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
                "0x526441bb6c1aba3c9a4a6ca1d6545da9c2333c8c48343ef398eb858d72b79236": {
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
                "0xe1fffcc4923d04b559f4d29a8bfc6cda04eb5b0d3c460751c2402c5c5cc9109c": {
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
                "0xf39e6e1eb0edcf53c221607b54b00cd28f3196fed0a24994dc308b8f611b682d": {
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
                "0x8001553a916ef2f495d26a907cc54d96ed840d7bda71e73194bf5a9df7a76b90": {
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
                "0xa3f1ee9126a074d9326c682f561767f710e927faa811f7a99829d49dc421797a": {
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
              },
              "links": {},
              "address": "0xe71d2ddb3ca69a94b557695a9614d3262845ea11",
              "updated_at": 1502111525484
            },
            "1502115631623": {
              "events": {
                "0xc71bdc6afaf9b1aa90a7078191d4fc1adf3bf680fca3183697df6b0dc226bca2": {
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
                "0x4a504a94899432a9846e1aa406dceb1bcfd538bb839071d49d1e5e23f5be30ef": {
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
                "0xf6a317157440607f36269043eb55f1287a5a19ba2216afeab88cd46cbcfb88e9": {
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
                "0xc0ba8fe4b176c1714197d43b9cc6bcf797a4a7461c5fe8d0ef6e184ae7601e51": {
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
                "0x33e13ecb54c3076d8e8bb8c2881800a4d972b792045ffae98fdf46df365fed75": {
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
                "0x526441bb6c1aba3c9a4a6ca1d6545da9c2333c8c48343ef398eb858d72b79236": {
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
                "0xe1fffcc4923d04b559f4d29a8bfc6cda04eb5b0d3c460751c2402c5c5cc9109c": {
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
                "0xf39e6e1eb0edcf53c221607b54b00cd28f3196fed0a24994dc308b8f611b682d": {
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
                "0x8001553a916ef2f495d26a907cc54d96ed840d7bda71e73194bf5a9df7a76b90": {
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
                "0xa3f1ee9126a074d9326c682f561767f710e927faa811f7a99829d49dc421797a": {
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
              },
              "links": {},
              "address": "0xbe14913754d5a03c8f7c81c98c499033422898be",
              "updated_at": 1502116648349
            },
            "1502117484341": {
              "events": {
                "0xc71bdc6afaf9b1aa90a7078191d4fc1adf3bf680fca3183697df6b0dc226bca2": {
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
                "0x4a504a94899432a9846e1aa406dceb1bcfd538bb839071d49d1e5e23f5be30ef": {
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
                "0xf6a317157440607f36269043eb55f1287a5a19ba2216afeab88cd46cbcfb88e9": {
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
                "0xc0ba8fe4b176c1714197d43b9cc6bcf797a4a7461c5fe8d0ef6e184ae7601e51": {
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
                "0x33e13ecb54c3076d8e8bb8c2881800a4d972b792045ffae98fdf46df365fed75": {
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
                "0x526441bb6c1aba3c9a4a6ca1d6545da9c2333c8c48343ef398eb858d72b79236": {
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
                "0xe1fffcc4923d04b559f4d29a8bfc6cda04eb5b0d3c460751c2402c5c5cc9109c": {
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
                "0xf39e6e1eb0edcf53c221607b54b00cd28f3196fed0a24994dc308b8f611b682d": {
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
                "0x8001553a916ef2f495d26a907cc54d96ed840d7bda71e73194bf5a9df7a76b90": {
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
                "0xa3f1ee9126a074d9326c682f561767f710e927faa811f7a99829d49dc421797a": {
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
              },
              "links": {},
              "address": "0xd5d00d1ee854c49dfce2d7d28d25524a2cc083f0",
              "updated_at": 1502117570420
            },
            "1502795495352": {
              "events": {
                "0xc71bdc6afaf9b1aa90a7078191d4fc1adf3bf680fca3183697df6b0dc226bca2": {
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
                "0x4a504a94899432a9846e1aa406dceb1bcfd538bb839071d49d1e5e23f5be30ef": {
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
                "0xf6a317157440607f36269043eb55f1287a5a19ba2216afeab88cd46cbcfb88e9": {
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
                "0xc0ba8fe4b176c1714197d43b9cc6bcf797a4a7461c5fe8d0ef6e184ae7601e51": {
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
                "0x33e13ecb54c3076d8e8bb8c2881800a4d972b792045ffae98fdf46df365fed75": {
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
                "0x526441bb6c1aba3c9a4a6ca1d6545da9c2333c8c48343ef398eb858d72b79236": {
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
                "0xe1fffcc4923d04b559f4d29a8bfc6cda04eb5b0d3c460751c2402c5c5cc9109c": {
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
                "0xf39e6e1eb0edcf53c221607b54b00cd28f3196fed0a24994dc308b8f611b682d": {
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
                "0x8001553a916ef2f495d26a907cc54d96ed840d7bda71e73194bf5a9df7a76b90": {
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
                "0xa3f1ee9126a074d9326c682f561767f710e927faa811f7a99829d49dc421797a": {
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
              },
              "links": {},
              "address": "0xc6fc5e99b5d253f6eabf53fb2eab94af4e6a1444",
              "updated_at": 1502795604649
            },
            "1502798173652": {
              "events": {
                "0xc71bdc6afaf9b1aa90a7078191d4fc1adf3bf680fca3183697df6b0dc226bca2": {
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
                "0x4a504a94899432a9846e1aa406dceb1bcfd538bb839071d49d1e5e23f5be30ef": {
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
                "0xf6a317157440607f36269043eb55f1287a5a19ba2216afeab88cd46cbcfb88e9": {
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
                "0xc0ba8fe4b176c1714197d43b9cc6bcf797a4a7461c5fe8d0ef6e184ae7601e51": {
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
                "0x33e13ecb54c3076d8e8bb8c2881800a4d972b792045ffae98fdf46df365fed75": {
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
                "0x526441bb6c1aba3c9a4a6ca1d6545da9c2333c8c48343ef398eb858d72b79236": {
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
                "0xe1fffcc4923d04b559f4d29a8bfc6cda04eb5b0d3c460751c2402c5c5cc9109c": {
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
                "0xf39e6e1eb0edcf53c221607b54b00cd28f3196fed0a24994dc308b8f611b682d": {
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
                "0x8001553a916ef2f495d26a907cc54d96ed840d7bda71e73194bf5a9df7a76b90": {
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
                "0xa3f1ee9126a074d9326c682f561767f710e927faa811f7a99829d49dc421797a": {
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
              },
              "links": {},
              "address": "0xc6fc5e99b5d253f6eabf53fb2eab94af4e6a1444",
              "updated_at": 1502798380588
            },
            "1502806169152": {
              "events": {
                "0xc71bdc6afaf9b1aa90a7078191d4fc1adf3bf680fca3183697df6b0dc226bca2": {
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
                "0x4a504a94899432a9846e1aa406dceb1bcfd538bb839071d49d1e5e23f5be30ef": {
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
                "0xf6a317157440607f36269043eb55f1287a5a19ba2216afeab88cd46cbcfb88e9": {
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
                "0xc0ba8fe4b176c1714197d43b9cc6bcf797a4a7461c5fe8d0ef6e184ae7601e51": {
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
                "0x33e13ecb54c3076d8e8bb8c2881800a4d972b792045ffae98fdf46df365fed75": {
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
                "0x526441bb6c1aba3c9a4a6ca1d6545da9c2333c8c48343ef398eb858d72b79236": {
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
                "0xe1fffcc4923d04b559f4d29a8bfc6cda04eb5b0d3c460751c2402c5c5cc9109c": {
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
                "0xf39e6e1eb0edcf53c221607b54b00cd28f3196fed0a24994dc308b8f611b682d": {
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
                "0x8001553a916ef2f495d26a907cc54d96ed840d7bda71e73194bf5a9df7a76b90": {
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
                "0xa3f1ee9126a074d9326c682f561767f710e927faa811f7a99829d49dc421797a": {
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
              },
              "links": {},
              "address": "0xc6fc5e99b5d253f6eabf53fb2eab94af4e6a1444",
              "updated_at": 1502806179580
            },
            "1502880859643": {
              "events": {
                "0xc71bdc6afaf9b1aa90a7078191d4fc1adf3bf680fca3183697df6b0dc226bca2": {
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
                "0x4a504a94899432a9846e1aa406dceb1bcfd538bb839071d49d1e5e23f5be30ef": {
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
                "0xf6a317157440607f36269043eb55f1287a5a19ba2216afeab88cd46cbcfb88e9": {
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
                "0xc0ba8fe4b176c1714197d43b9cc6bcf797a4a7461c5fe8d0ef6e184ae7601e51": {
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
                "0x33e13ecb54c3076d8e8bb8c2881800a4d972b792045ffae98fdf46df365fed75": {
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
                "0x526441bb6c1aba3c9a4a6ca1d6545da9c2333c8c48343ef398eb858d72b79236": {
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
                "0xe1fffcc4923d04b559f4d29a8bfc6cda04eb5b0d3c460751c2402c5c5cc9109c": {
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
                "0xf39e6e1eb0edcf53c221607b54b00cd28f3196fed0a24994dc308b8f611b682d": {
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
                "0x8001553a916ef2f495d26a907cc54d96ed840d7bda71e73194bf5a9df7a76b90": {
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
                "0xa3f1ee9126a074d9326c682f561767f710e927faa811f7a99829d49dc421797a": {
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
              },
              "links": {},
              "address": "0x76608a542b425cba81d277f6436007add848c0af",
              "updated_at": 1502888676774
            },
            "1503501009910": {
              "events": {
                "0xc71bdc6afaf9b1aa90a7078191d4fc1adf3bf680fca3183697df6b0dc226bca2": {
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
                "0x4a504a94899432a9846e1aa406dceb1bcfd538bb839071d49d1e5e23f5be30ef": {
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
                "0xf6a317157440607f36269043eb55f1287a5a19ba2216afeab88cd46cbcfb88e9": {
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
                "0xc0ba8fe4b176c1714197d43b9cc6bcf797a4a7461c5fe8d0ef6e184ae7601e51": {
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
                "0x33e13ecb54c3076d8e8bb8c2881800a4d972b792045ffae98fdf46df365fed75": {
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
                "0x526441bb6c1aba3c9a4a6ca1d6545da9c2333c8c48343ef398eb858d72b79236": {
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
                "0xe1fffcc4923d04b559f4d29a8bfc6cda04eb5b0d3c460751c2402c5c5cc9109c": {
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
                "0xf39e6e1eb0edcf53c221607b54b00cd28f3196fed0a24994dc308b8f611b682d": {
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
                "0x8001553a916ef2f495d26a907cc54d96ed840d7bda71e73194bf5a9df7a76b90": {
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
                "0xa3f1ee9126a074d9326c682f561767f710e927faa811f7a99829d49dc421797a": {
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
              },
              "links": {},
              "address": "0xc6fc5e99b5d253f6eabf53fb2eab94af4e6a1444",
              "updated_at": 1503501049139
            },
            "1504002958171": {
              "events": {
                "0xc71bdc6afaf9b1aa90a7078191d4fc1adf3bf680fca3183697df6b0dc226bca2": {
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
                "0x4a504a94899432a9846e1aa406dceb1bcfd538bb839071d49d1e5e23f5be30ef": {
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
                "0xf6a317157440607f36269043eb55f1287a5a19ba2216afeab88cd46cbcfb88e9": {
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
                "0xc0ba8fe4b176c1714197d43b9cc6bcf797a4a7461c5fe8d0ef6e184ae7601e51": {
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
                "0x33e13ecb54c3076d8e8bb8c2881800a4d972b792045ffae98fdf46df365fed75": {
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
                "0x526441bb6c1aba3c9a4a6ca1d6545da9c2333c8c48343ef398eb858d72b79236": {
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
                "0xe1fffcc4923d04b559f4d29a8bfc6cda04eb5b0d3c460751c2402c5c5cc9109c": {
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
                "0xf39e6e1eb0edcf53c221607b54b00cd28f3196fed0a24994dc308b8f611b682d": {
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
                "0x8001553a916ef2f495d26a907cc54d96ed840d7bda71e73194bf5a9df7a76b90": {
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
                "0xa3f1ee9126a074d9326c682f561767f710e927faa811f7a99829d49dc421797a": {
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
              },
              "links": {},
              "address": "0xc6fc5e99b5d253f6eabf53fb2eab94af4e6a1444",
              "updated_at": 1504002963064
            },
            "1504004838678": {
              "events": {
                "0xc71bdc6afaf9b1aa90a7078191d4fc1adf3bf680fca3183697df6b0dc226bca2": {
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
                "0x4a504a94899432a9846e1aa406dceb1bcfd538bb839071d49d1e5e23f5be30ef": {
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
                "0xf6a317157440607f36269043eb55f1287a5a19ba2216afeab88cd46cbcfb88e9": {
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
                "0xc0ba8fe4b176c1714197d43b9cc6bcf797a4a7461c5fe8d0ef6e184ae7601e51": {
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
                "0x33e13ecb54c3076d8e8bb8c2881800a4d972b792045ffae98fdf46df365fed75": {
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
                "0x526441bb6c1aba3c9a4a6ca1d6545da9c2333c8c48343ef398eb858d72b79236": {
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
                "0xe1fffcc4923d04b559f4d29a8bfc6cda04eb5b0d3c460751c2402c5c5cc9109c": {
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
                "0xf39e6e1eb0edcf53c221607b54b00cd28f3196fed0a24994dc308b8f611b682d": {
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
                "0x8001553a916ef2f495d26a907cc54d96ed840d7bda71e73194bf5a9df7a76b90": {
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
                "0xa3f1ee9126a074d9326c682f561767f710e927faa811f7a99829d49dc421797a": {
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
              },
              "links": {},
              "address": "0xc6fc5e99b5d253f6eabf53fb2eab94af4e6a1444",
              "updated_at": 1504004885978
            },
            "1504188256225": {
              "events": {
                "0xc71bdc6afaf9b1aa90a7078191d4fc1adf3bf680fca3183697df6b0dc226bca2": {
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
                "0x4a504a94899432a9846e1aa406dceb1bcfd538bb839071d49d1e5e23f5be30ef": {
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
                "0xf6a317157440607f36269043eb55f1287a5a19ba2216afeab88cd46cbcfb88e9": {
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
                "0xc0ba8fe4b176c1714197d43b9cc6bcf797a4a7461c5fe8d0ef6e184ae7601e51": {
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
                "0x33e13ecb54c3076d8e8bb8c2881800a4d972b792045ffae98fdf46df365fed75": {
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
                "0x526441bb6c1aba3c9a4a6ca1d6545da9c2333c8c48343ef398eb858d72b79236": {
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
                "0xe1fffcc4923d04b559f4d29a8bfc6cda04eb5b0d3c460751c2402c5c5cc9109c": {
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
                "0xf39e6e1eb0edcf53c221607b54b00cd28f3196fed0a24994dc308b8f611b682d": {
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
                "0x8001553a916ef2f495d26a907cc54d96ed840d7bda71e73194bf5a9df7a76b90": {
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
                "0xa3f1ee9126a074d9326c682f561767f710e927faa811f7a99829d49dc421797a": {
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
              },
              "links": {},
              "address": "0xc6fc5e99b5d253f6eabf53fb2eab94af4e6a1444",
              "updated_at": 1504188343008
            },
            "1504862319912": {
              "events": {
                "0xc71bdc6afaf9b1aa90a7078191d4fc1adf3bf680fca3183697df6b0dc226bca2": {
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
                "0x4a504a94899432a9846e1aa406dceb1bcfd538bb839071d49d1e5e23f5be30ef": {
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
                "0xf6a317157440607f36269043eb55f1287a5a19ba2216afeab88cd46cbcfb88e9": {
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
                "0xc0ba8fe4b176c1714197d43b9cc6bcf797a4a7461c5fe8d0ef6e184ae7601e51": {
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
                "0x33e13ecb54c3076d8e8bb8c2881800a4d972b792045ffae98fdf46df365fed75": {
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
                "0x526441bb6c1aba3c9a4a6ca1d6545da9c2333c8c48343ef398eb858d72b79236": {
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
                "0xe1fffcc4923d04b559f4d29a8bfc6cda04eb5b0d3c460751c2402c5c5cc9109c": {
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
                "0xf39e6e1eb0edcf53c221607b54b00cd28f3196fed0a24994dc308b8f611b682d": {
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
                "0x8001553a916ef2f495d26a907cc54d96ed840d7bda71e73194bf5a9df7a76b90": {
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
                "0xa3f1ee9126a074d9326c682f561767f710e927faa811f7a99829d49dc421797a": {
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
              },
              "links": {},
              "address": "0xc6fc5e99b5d253f6eabf53fb2eab94af4e6a1444",
              "updated_at": 1504862431364
            },
            "1504865222106": {
              "events": {
                "0xc71bdc6afaf9b1aa90a7078191d4fc1adf3bf680fca3183697df6b0dc226bca2": {
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
                "0x4a504a94899432a9846e1aa406dceb1bcfd538bb839071d49d1e5e23f5be30ef": {
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
                "0xf6a317157440607f36269043eb55f1287a5a19ba2216afeab88cd46cbcfb88e9": {
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
                "0xc0ba8fe4b176c1714197d43b9cc6bcf797a4a7461c5fe8d0ef6e184ae7601e51": {
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
                "0x33e13ecb54c3076d8e8bb8c2881800a4d972b792045ffae98fdf46df365fed75": {
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
                "0x526441bb6c1aba3c9a4a6ca1d6545da9c2333c8c48343ef398eb858d72b79236": {
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
                "0xe1fffcc4923d04b559f4d29a8bfc6cda04eb5b0d3c460751c2402c5c5cc9109c": {
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
                "0xf39e6e1eb0edcf53c221607b54b00cd28f3196fed0a24994dc308b8f611b682d": {
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
                "0x8001553a916ef2f495d26a907cc54d96ed840d7bda71e73194bf5a9df7a76b90": {
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
                "0xa3f1ee9126a074d9326c682f561767f710e927faa811f7a99829d49dc421797a": {
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
              },
              "links": {},
              "address": "0xc6fc5e99b5d253f6eabf53fb2eab94af4e6a1444",
              "updated_at": 1504865271408
            }
          },
          "schema_version": "0.0.5",
          "updated_at": 1505131050037
        }
    """

    static let standardTokenJson = """
        {
          "contractName": "StandardToken",
          "abi": [
            {
              "constant": false,
              "inputs": [
                {
                  "name": "spender",
                  "type": "address"
                },
                {
                  "name": "value",
                  "type": "uint256"
                }
              ],
              "name": "approve",
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
                  "name": "from",
                  "type": "address"
                },
                {
                  "name": "to",
                  "type": "address"
                },
                {
                  "name": "value",
                  "type": "uint256"
                }
              ],
              "name": "transferFrom",
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
                  "name": "owner",
                  "type": "address"
                }
              ],
              "name": "balanceOf",
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
                  "name": "to",
                  "type": "address"
                },
                {
                  "name": "value",
                  "type": "uint256"
                }
              ],
              "name": "transfer",
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
                  "name": "owner",
                  "type": "address"
                },
                {
                  "name": "spender",
                  "type": "address"
                }
              ],
              "name": "allowance",
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
          ],
          "unlinked_binary": "0x6060604052341561000f57600080fd5b5b61069d8061001f6000396000f3006060604052361561005c5763ffffffff60e060020a600035041663095ea7b3811461006157806318160ddd1461009757806323b872dd146100bc57806370a08231146100f8578063a9059cbb14610129578063dd62ed3e1461015f575b600080fd5b341561006c57600080fd5b610083600160a060020a0360043516602435610196565b604051901515815260200160405180910390f35b34156100a257600080fd5b6100aa610203565b60405190815260200160405180910390f35b34156100c757600080fd5b610083600160a060020a036004358116906024351660443561020a565b604051901515815260200160405180910390f35b341561010357600080fd5b6100aa600160a060020a036004351661047a565b60405190815260200160405180910390f35b341561013457600080fd5b610083600160a060020a0360043516602435610499565b604051901515815260200160405180910390f35b341561016a57600080fd5b6100aa600160a060020a0360043581169060243516610644565b60405190815260200160405180910390f35b600160a060020a03338116600081815260016020908152604080832094871680845294909152808220859055909291907f8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b9259085905190815260200160405180910390a35060015b92915050565b6002545b90565b600160a060020a0383166000908152602081905260408082205473__Math__________________________________9163e31c71c4919085908590516020015260405160e060020a63ffffffff85160281526004810192909252602482015260440160206040518083038186803b151561028357600080fd5b6102c65a03f4151561029457600080fd5b5050506040518051905015806103475750600160a060020a0380851660009081526001602090815260408083203390941683529290528181205473__Math__________________________________9263e31c71c4928691516020015260405160e060020a63ffffffff85160281526004810192909252602482015260440160206040518083038186803b151561032a57600080fd5b6102c65a03f4151561033b57600080fd5b50505060405180519050155b806103e15750600160a060020a0383166000908152602081905260408082205473__Math__________________________________92634e30a66c92869190516020015260405160e060020a63ffffffff85160281526004810192909252602482015260440160206040518083038186803b15156103c457600080fd5b6102c65a03f415156103d557600080fd5b50505060405180519050155b156103ee57506000610473565b600160a060020a03808516600081815260208181526040808320805488900390556001825280832033861684528252808320805488900390559387168083529082905290839020805486019055917fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef9085905190815260200160405180910390a35060015b9392505050565b600160a060020a0381166000908152602081905260409020545b919050565b600160a060020a0333166000908152602081905260408082205473__Math__________________________________9163e31c71c4919085908590516020015260405160e060020a63ffffffff85160281526004810192909252602482015260440160206040518083038186803b151561051257600080fd5b6102c65a03f4151561052357600080fd5b5050506040518051905015806105c85750600160a060020a0383166000908152602081905260408082205473__Math__________________________________92634e30a66c92869190516020015260405160e060020a63ffffffff85160281526004810192909252602482015260440160206040518083038186803b15156105ab57600080fd5b6102c65a03f415156105bc57600080fd5b50505060405180519050155b156105d5575060006101fd565b600160a060020a033381166000818152602081905260408082208054879003905592861680825290839020805486019055917fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef9085905190815260200160405180910390a35060015b92915050565b600160a060020a038083166000908152600160209081526040808320938516835292905220545b929150505600a165627a7a72305820334df90e529fa115c58eb81985540c8bb32221b14b9f3d6f606074deb05177210029",
          "networks": {},
          "schema_version": "0.0.5",
          "updated_at": 1503002247547
        }

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
