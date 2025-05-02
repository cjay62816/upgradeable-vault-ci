// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/MyVaultV1.sol";
import "../src/MyVaultV2.sol";
import "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

contract MyVaultUpgradeableTest is Test {
    MyVaultV1 public implementation;
    MyVaultV2 public implementationV2;
    ERC1967Proxy public proxy;
    
    // Cast the proxy to our implementation type
    MyVaultV1 public vaultV1;
    MyVaultV2 public vaultV2;
    
    address public owner;
    address public admin;

    function setUp() public {
        owner = address(this);
        admin = address(0x123);
        
        // Deploy implementation
        implementation = new MyVaultV1();
        
        // Prepare initialization call
        bytes memory initData = abi.encodeWithSelector(
            MyVaultV1.initialize.selector,
            1234,
            admin
        );
        
        // Deploy proxy pointing to implementation with init data
        proxy = new ERC1967Proxy(
            address(implementation),
            initData
        );
        
        // Cast proxy to implementation type for easier interaction
        vaultV1 = MyVaultV1(address(proxy));
    }

    function testProxyDelegates() public {
        // Test that proxy correctly delegates to implementation
        assertEq(vaultV1.read(), 1234);
    }

    function testWriteThroughProxy() public {
        vm.prank(owner);
        vaultV1.write(5678);
        assertEq(vaultV1.read(), 5678);
    }

    function testUpgradeToV2() public {
        // Set a value in V1
        vm.prank(owner);
        vaultV1.write(9999);
        
        // Deploy V2 implementation
        implementationV2 = new MyVaultV2();
        
        // Upgrade the proxy to V2
        vm.prank(owner);
        (bool success, ) = address(proxy).call(
            abi.encodeWithSignature(
                "upgradeToAndCall(address,bytes)",
                address(implementationV2),
                ""
            )
        );
        require(success, "Upgrade failed");
        
        // Now cast the proxy to V2 type
        vaultV2 = MyVaultV2(address(proxy));
        
        // Check state preservation
        assertEq(vaultV2.read(), 9999);
        
        // Test V2 functionality
        vm.prank(owner);
        vaultV2.setName("MyProtocol");
        assertEq(vaultV2.name(), "MyProtocol");
    }
} 