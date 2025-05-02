// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/MyVaultV3.sol";
import "@openzeppelin/contracts/proxy/utils/UUPSUpgradeable.sol";

contract DeployMyVaultV2 is Script {
    function run() external {
        // Address of the proxy we want to upgrade
        address proxyAddress = 0x583aeD8c56ced0575920D9C5D8Be9686bD0bA195;
        
        // Start broadcast with the private key
        uint256 deployerPrivateKey = 0xd8d01fe50dd8aa29cd7cd42b00643042cef4afa4ae7ad6fa76e967ec16432a30;
        vm.startBroadcast(deployerPrivateKey);

        // Deploy VaultV2 implementation
        VaultV2 vaultV2 = new VaultV2();
        console.log("VaultV2 implementation deployed at:", address(vaultV2));

        // Upgrade proxy to point to the new implementation
        UUPSUpgradeable(proxyAddress).upgradeToAndCall(
            address(vaultV2),
            ""  // No initialization data needed
        );
        console.log("Proxy upgraded to VaultV2");

        // Set vault name to verify upgrade
        VaultV2(proxyAddress).setVaultName("MyUpgradedVault");
        console.log("Vault name set");

        vm.stopBroadcast();
    }
}