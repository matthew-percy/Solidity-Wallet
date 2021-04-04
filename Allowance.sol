pragma solidity ^0.7.4;

import "./Ownership.sol";

contract Allowance is Ownership{
    
    event AllowanceChanged(address indexed forWho,address indexed fromWhom, uint oldAmount,uint newAmount);
    
    
        //who has permission to do certain things in our contract
    mapping(address => uint) public allowance;
    
    //give permissions and set how much they can withdraw
    function addAllowance(address who,uint amount) public onlyOwner {
        emit AllowanceChanged(who,msg.sender,allowance[who],amount);
        allowance[who] = amount;
        
    }
    
    function reduceAllowance(address who,uint amount) internal
    {
        emit AllowanceChanged(who,msg.sender,allowance[who],allowance[who] - amount);
        allowance[who] -= amount; //Reduce Allowance
    }
    
    modifier ownerOrAllowed(uint amount) {
        //if you  are the owner or are an allowed person taking less than permitted
        require(owner == msg.sender || allowance[msg.sender] >= amount, "You aare not allowed");
        if(owner != msg.sender) {
            reduceAllowance(msg.sender,amount);
        }
        _;
    }
    
}