pragma solidity ^0.7.4;

import "./Allowance.sol";

contract Wallet is Allowance{
    
    event MoneySent(address indexed to,uint amount);
    event MoneyReceived(address indexed from, uint amount);
    
    constructor() public {
        owner = msg.sender;
    }
    
    //send money to smart ocntract
    fallback() external payable  {
        emit MoneyReceived(msg.sender,msg.value);
    }
    
    //withdraw from smart ccontract
    function withdrawMoney(address payable to, uint amount) public ownerOrAllowed(amount) {
        require(amount <= address(this).balance, "Insufficient Funds in the Contract");
        
        //require(owner == msg.sender, "You are not allowed");
        emit MoneySent(to,amount);
        to.transfer(amount);
    }
    
}