// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/MyVaultV1.sol";
import "../src/MyVaultV2.sol";
import "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

contract MyVaultTest is Test {
    MyVaultV1 public implementation;
    MyVaultV1 public proxy;
    address public owner;
    address public admin;

    function setUp() public {
        owner = address(this);
        admin = address(0x123);

        // Deploy implementation
        implementation = new MyVaultV1();

        // Deploy proxy
        bytes memory initData = abi.encodeWithSelector(MyVaultV1.initialize.selector, 42, admin);

        ERC1967Proxy proxyContract = new ERC1967Proxy(address(implementation), initData);

        proxy = MyVaultV1(address(proxyContract));
    }

    function testInitialState() public {
        assertEq(proxy.read(), 42);
    }

    function testWriteValue() public {
        vm.prank(owner);
        proxy.write(100);
        assertEq(proxy.read(), 100);
    }

    function testUpgradeToV2() public {
        // Deploy V2 implementation
        MyVaultV2 implementationV2 = new MyVaultV2();

        // Set initial value
        vm.prank(owner);
        proxy.write(42);

        // Upgrade to V2
        vm.prank(owner);
        (bool success,) = address(proxy).call(
            abi.encodeWithSignature("upgradeToAndCall(address,bytes)", address(implementationV2), "")
        );
        require(success, "Upgrade failed");

        // Cast to V2
        MyVaultV2 proxyV2 = MyVaultV2(address(proxy));

        // Test V1 functionality still works
        assertEq(proxyV2.read(), 42);

        // Test new V2 functionality
        vm.prank(owner);
        proxyV2.setName("MyVault");
        assertEq(proxyV2.name(), "MyVault");
    }
}
