// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";

contract SimpleContract {
    uint256 private _value;
    address private _admin;
    
    function initialize(uint256 value, address admin) public {
        _value = value;
        _admin = admin;
    }
    
    function read() public view returns (uint256) {
        return _value;
    }
    
    function write(uint256 newValue) public {
        _value = newValue;
    }
}

contract DeploySimple is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address admin = vm.addr(deployerPrivateKey);

        vm.startBroadcast(deployerPrivateKey);

        SimpleContract vault = new SimpleContract();
        vault.initialize(1234, admin);

        console.log("Vault deployed at:", address(vault));
        console.log("Admin address:", admin);
        
        vm.stopBroadcast();
    }
} 