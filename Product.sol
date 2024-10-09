// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

contract Product {

    struct Bond {
    string name;
    uint price;
    address owner;
    uint timeBlock;
    uint rewardBalance;
    uint countReward;
    }

    Bond public bond;

    constructor(string memory _name, uint _price, address _owner, uint _rewardBalance, uint _countReward) {
        bond.name = _name;
        bond.price = _price;
        bond.owner = _owner;
        bond.rewardBalance = _rewardBalance;
        bond.timeBlock = block.timestamp + 20;
        bond.countReward = _countReward;
    }

    modifier onlyOwner() {
        require(msg.sender == bond.owner, "Not owner");
        _;
    }

    address to = bond.owner ;

    function reward(uint amount) public onlyOwner returns(uint) {
        require(block.timestamp >= bond.timeBlock || bond.countReward > 0);
        (bool sent, ) = to.call{value: bond.countReward}("");
        require(sent, "Reward still unclaimed due some error");
        require(bond.countReward > 0);
        bond.countReward--;
        bond.rewardBalance -= amount;
        return bond.rewardBalance;
    }

    function transferOwnership (address newOwner) public onlyOwner {
        bond.owner = newOwner;
    }

    function burn() external onlyOwner {
        selfdestruct(payable(address(bond.owner)));
    }

    function getBondData() external view returns(string memory, address, uint, uint, uint) {
        return (bond.name, bond.owner, bond.timeBlock, bond.rewardBalance, bond.countReward);
    }
}
