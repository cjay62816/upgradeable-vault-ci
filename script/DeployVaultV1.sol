// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/MyVaultV3.sol";
import "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

contract DeployVaultV1 is Script {
    function run() external {
        // Start broadcast with the private key
        uint256 deployerPrivateKey = 0xd8d01fe50dd8aa29cd7cd42b00643042cef4afa4ae7ad6fa76e967ec16432a30;
        vm.startBroadcast(deployerPrivateKey);

        // Deploy VaultV1 implementation
        VaultV1 vaultV1 = new VaultV1();
        console.log("VaultV1 implementation deployed at:", address(vaultV1));

        // Deploy proxy
        ERC1967Proxy proxy = new ERC1967Proxy(
            address(vaultV1),
            abi.encodeWithSelector(VaultV1.initialize.selector)
        );
        console.log("Proxy deployed at:", address(proxy));

        vm.stopBroadcast();
    }
} 