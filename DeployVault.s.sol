// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "uups-vault-foundry/src/MyVaultV1.sol";

contract DeployVault is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address admin = vm.addr(deployerPrivateKey);

        vm.startBroadcast(deployerPrivateKey);

        MyVaultV1 vault = new MyVaultV1();
        vault.initialize(1234, admin);

        console.log("Vault deployed at:", address(vault));
        console.log("Admin address:", admin);
        
        vm.stopBroadcast();
    }
} 