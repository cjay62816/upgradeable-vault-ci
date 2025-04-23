// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/MyVaultV1.sol";
import "../src/MyVaultV2.sol";
import "@openzeppelin/proxy/ERC1967/ERC1967Proxy.sol";

contract MyVaultTest is Test {
    MyVaultV1 public vaultV1;
    MyVaultV2 public vaultV2;
    ERC1967Proxy public proxy;
    address public admin = address(1);

    function setUp() public {
        // Deploy V1 implementation
        vaultV1 = new MyVaultV1();
        
        // Deploy proxy pointing to V1
        bytes memory data = abi.encodeWithSelector(MyVaultV1.initialize.selector, admin);
        proxy = new ERC1967Proxy(address(vaultV1), data);
        
        // Initialize proxy as V1
        vaultV1 = MyVaultV1(address(proxy));
    }

    function testInitialValue() public {
        assertEq(vaultV1.getValue(), 0);
    }

    function testWriteValue() public {
        vm.prank(admin);
        vaultV1.setValue(42);
        assertEq(vaultV1.getValue(), 42);
    }

    function testUpgradeToV2() public {
        // Deploy V2 implementation
        vaultV2 = new MyVaultV2();
        
        // Upgrade proxy to V2
        vm.prank(admin);
        vaultV1.upgradeTo(address(vaultV2));
        
        // Cast proxy to V2
        vaultV2 = MyVaultV2(address(proxy));
        
        // Test V2 functionality
        assertEq(vaultV2.getValue(), 0);
        vm.prank(admin);
        vaultV2.setValue(100);
        assertEq(vaultV2.getValue(), 100);
    }
} 