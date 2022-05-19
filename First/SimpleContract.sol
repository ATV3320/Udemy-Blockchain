pragma solidity ^0.8.0;
import "./Allowance.sol";

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";


contract SimpleWallet is Allowance {

    event moneySent(address indexed _sentTo, uint _amount);
    event moneyRecieved(address indexed _from, uint _amount);

    function withdrawMoney(address payable _to, uint _amount) public ownerOrAllowed(_amount) {
        require(_amount<=address(this).balance, "There is not enough money in the contract");
        if(owner()!=msg.sender){
            reduceAllowance(msg.sender, _amount);
        }
        emit moneySent(_to, _amount);
        _to.transfer(_amount);
    }

    function renounceOwnership() public override onlyOwner {
        revert("Can't renounce ownership");
    }

    function fallback() external payable {
        emit moneyRecieved(msg.sender, msg.value);
    }
}
