// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/MyVaultV3.sol"; // VaultV1 likely aliases MyVaultV3 in your setup
import "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

contract DeployVaultV1 is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY"); // ✅ uses GitHub secret
        vm.startBroadcast(deployerPrivateKey);

        VaultV1 vaultV1 = new VaultV1();
        console.log("VaultV1 implementation deployed at:", address(vaultV1));

        ERC1967Proxy proxy = new ERC1967Proxy(
            address(vaultV1),
            abi.encodeWithSelector(VaultV1.initialize.selector)
        );
        console.log("Proxy deployed at:", address(proxy));

        vm.stopBroadcast();
    }
}