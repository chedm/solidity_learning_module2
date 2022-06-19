// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./ConvertLib.sol";

contract YourContractName {
  constructor() public {
  }
}

contract BonusChe {
	mapping (address => uint) balances;
  mapping (address => uint) spentCoins;

  address public owner = msg.sender;

	event Transfer(address indexed _from, address indexed _to, uint256 _value);
  event BonusDrop(address indexed _from, uint256 _value);

	constructor() public {
		balances[tx.origin] = 0;
	}

    modifier onlyOwner {
        require(msg.sender == owner, "You are not the owner.");
        _;
    }

  function addCoinByDevelop(address receiver, uint amount) public onlyOwner returns(bool sufficient) {
    balances[receiver] += amount;
    emit Transfer(msg.sender, receiver, amount);
    return true;
    }

	function payWithBonus(uint amount) public returns(bool sufficient) {
		if (balances[msg.sender] < amount) return false;
		balances[msg.sender] -= amount;
    spentCoins[msg.sender] += amount;
		emit BonusDrop(msg.sender, amount);
		return true;
	}

	function getBalanceInEth(address addr) public view returns(uint){
		return ConvertLib.convert(getBalance(addr),2);
	}

	function getBalance(address addr) public view returns(uint) {
		return balances[addr];
	}

  function getSpentBonuses(address addr) public view returns(uint){
    return spentCoins[addr];
  }
}
