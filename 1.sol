// SPDX-License-Identifier: MIT

pragma solidity 0.8.27;

import "./Product.sol";

contract BondManager is Product {
  mapping(address => Bond[]) public userBonds;
  uint _timeBlock;
  address _owner;

  constructor(string memory _name, uint _price, uint _rewardBalance, uint _countReward) Product(_name, _price, msg.sender, _rewardBalance, _countReward) {
    // Initialize BondManager specific variables here if needed.
  }

  function buy(string memory _name, uint _price, uint _rewardBalance, uint _countReward) public returns (address) {
    _owner = msg.sender;
    Bond memory newProduct = Bond (
      _name,
      _price,
      _owner,
      _rewardBalance,
      _countReward,
      _timeBlock
    );
    userBonds[_owner].push(newProduct);
  }

  function transferBond(address from, address to, uint productIndex) public onlyOwner {
    
  }
}
