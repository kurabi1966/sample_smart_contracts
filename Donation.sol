pragma solidity ^0.4.24;

contract Donation{

    address public owner;

    uint16 public donators;

    event dataChanged(uint16 donaters, uint256 balance);

    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }

    constructor () public{
        owner = msg.sender;
    }

    function donate() public payable{
        donators += 1;
        emit dataChanged(donators, address(this).balance);
    }

    function withdraw() public onlyOwner{
        owner.transfer(address(this).balance);
        donators = 0;
        emit dataChanged(donators, address(this).balance);
    }

    function getBalance() public view returns(uint256){
        return address(this).balance;
    }
}
