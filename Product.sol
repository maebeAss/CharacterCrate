// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Product {

    string public name;
    address public owner;
    uint public timeBlock;
    uint public rewardBalance;
    uint public countReward;
    bool isRewardPaid;

    constructor(
        string memory _name,
        uint _rewardBalance,
        uint _countReward,
        uint _timeBlock
        ) {
        name = _name;
        owner = msg.sender;
        rewardBalance = _rewardBalance;
        timeBlock = _timeBlock;
        countReward = _countReward;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    address to = 0x0000000000000000000000000000000000000000;

    function reward() public onlyOwner {
        require(block.timestamp >= timeBlock || isRewardPaid);
        uint amount;
        if (isRewardPaid) {
            amount = rewardBalance;
            isRewardPaid = true;
        } else {
            amount = rewardBalance / countReward;
            rewardBalance -= amount;
        }
    }

    function transferOwnership (address newOwner) public onlyOwner {
        owner = newOwner;
    }

    function burn() public onlyOwner {
        selfdestruct(payable(address(this)));
    }

    function getProductData() public view returns(string memory, address, uint, uint, uint) {
        return (name, owner, timeBlock, rewardBalance, countReward);
    } 
}
