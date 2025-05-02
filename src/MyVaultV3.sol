// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract VaultV1 is Initializable, UUPSUpgradeable, OwnableUpgradeable {
    uint256 public storedValue;

    function initialize() public initializer {
        __Ownable_init(msg.sender);
        storedValue = 1;
    }

    function setValue(uint256 newVal) external {
        storedValue = newVal;
    }

    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {}
}

contract VaultV2 is VaultV1 {
    string public vaultName;

    function setVaultName(string memory _name) external onlyOwner {
        vaultName = _name;
    }

    function version() external pure returns (string memory) {
        return "V2.1";
    }
}

// BAD UPGRADE EXAMPLE: Will break storage layout (simulate failure)
contract VaultV3_Broken is Initializable, UUPSUpgradeable, OwnableUpgradeable {
    string public vaultName; // Moved up, breaks storedValue layout
    uint256 public storedValue;

    function initialize() public initializer {
        __Ownable_init(msg.sender);
        vaultName = "oops";
        storedValue = 42;
    }

    function setValue(uint256 newVal) external {
        storedValue = newVal;
    }

    function version() external pure returns (string memory) {
        return "BROKEN V3";
    }

    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {}
}
