// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/MyVaultV3.sol";
import "@openzeppelin/contracts/proxy/utils/UUPSUpgradeable.sol";

contract RollbackToV1 is Script {
    // Current proxy address
    address constant PROXY = 0x583aeD8c56ced0575920D9C5D8Be9686bD0bA195;
    // Original V1 implementation
    address constant V1_IMPL = 0x67AEc4c9C332C6886F68f9613E1f2a5Fc2E1eEcC;

    function run() external {
        uint256 deployerPrivateKey = 0xd8d01fe50dd8aa29cd7cd42b00643042cef4afa4ae7ad6fa76e967ec16432a30;
        vm.startBroadcast(deployerPrivateKey);

        // Roll back to V1 implementation
        console.log("Rolling back proxy to V1 implementation...");
        UUPSUpgradeable(PROXY).upgradeToAndCall(
            V1_IMPL,
            "" // No initialization data needed
        );
        console.log("Rollback complete. Proxy now points to V1:", V1_IMPL);

        // Try to read storedValue to verify V1 functionality
        uint256 value = VaultV1(PROXY).storedValue();
        console.log("Current stored value:", value);

        vm.stopBroadcast();
    }
}
