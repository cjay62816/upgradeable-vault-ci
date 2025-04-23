// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/MyVaultV1.sol";
import "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

contract DeployUUPSVault is Script {
    function run() external {
        // Get deployment private key from env
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address admin = vm.addr(deployerPrivateKey);

        // Start broadcasting
        vm.startBroadcast(deployerPrivateKey);

        // Deploy implementation
        MyVaultV1 implementation = new MyVaultV1();
        
        // Prepare initialization data
        bytes memory initData = abi.encodeWithSelector(
            MyVaultV1.initialize.selector,
            1234, // Initial value
            admin  // Admin address
        );
        
        // Deploy proxy
        ERC1967Proxy proxy = new ERC1967Proxy(
            address(implementation),
            initData
        );

        // Log addresses
        console.log("Implementation deployed to:", address(implementation));
        console.log("Proxy deployed to:", address(proxy));
        console.log("Admin address:", admin);
        
        vm.stopBroadcast();
    }
} 