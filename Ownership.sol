pragma solidity ^0.7.4;

contract Ownership {
    address public owner;
    
    modifier onlyOwner() {
        require(owner == msg.sender, "You are not allowed");
        _;
    }
}