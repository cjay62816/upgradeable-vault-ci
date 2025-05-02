// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract MyVaultV2 is Initializable, UUPSUpgradeable, OwnableUpgradeable {
    uint256 private _value;
    address private _admin;
    string private _name;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(uint256 value, address admin) public initializer {
        __Ownable_init(msg.sender);
        __UUPSUpgradeable_init();
        _value = value;
        _admin = admin;
    }

    function read() public view returns (uint256) {
        return _value;
    }

    function write(uint256 newValue) public onlyOwner {
        _value = newValue;
    }

    function setName(string memory newName) public onlyOwner {
        _name = newName;
    }

    function name() public view returns (string memory) {
        return _name;
    }

    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {}

    function version() public pure returns (string memory) {
        return "V2";
    }
}
