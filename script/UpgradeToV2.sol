// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/MyVaultV3.sol";
import "@openzeppelin/contracts/proxy/utils/UUPSUpgradeable.sol";

contract UpgradeToV2 is Script {
    // Current proxy address
    address constant PROXY = 0x583aeD8c56ced0575920D9C5D8Be9686bD0bA195;

    function run() external {
        uint256 deployerPrivateKey = 0xd8d01fe50dd8aa29cd7cd42b00643042cef4afa4ae7ad6fa76e967ec16432a30;
        vm.startBroadcast(deployerPrivateKey);

        // Deploy new V2 implementation
        console.log("Deploying new V2 implementation...");
        VaultV2 vaultV2 = new VaultV2();
        console.log("V2 implementation deployed at:", address(vaultV2));

        // Upgrade to V2 implementation
        console.log("Upgrading proxy to V2 implementation...");
        UUPSUpgradeable(PROXY).upgradeToAndCall(
            address(vaultV2),
            "" // No initialization data needed
        );
        console.log("Upgrade complete. Proxy now points to V2:", address(vaultV2));

        // Verify V2 functionality
        uint256 value = VaultV2(PROXY).storedValue();
        string memory version = VaultV2(PROXY).version();
        console.log("Current stored value:", value);
        console.log("Contract version:", version);

        vm.stopBroadcast();
    }
}
