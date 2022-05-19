pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";


contract Allowance is Ownable {

    event AllowanceChanged(address indexed _forPerson, address indexed _fromPerson, uint _oldAmount, uint _newAmount);

    mapping(address => uint) public allowance;

    function addAllowance(address _person, uint _amount) public onlyOwner {
        emit AllowanceChanged(_person, msg.sender, allowance[_person], _amount);
        allowance[_person] = _amount;
    }

    modifier ownerOrAllowed(uint _amount){
        require(allowance[msg.sender] >= _amount || owner() == msg.sender, "You are not eligible.");
        _;
    }
    
    function reduceAllowance(address _person, uint _amount) internal {
        emit AllowanceChanged(_person, msg.sender, allowance[_person], allowance[_person] - _amount);
        allowance[_person] -= _amount;
    }
}
