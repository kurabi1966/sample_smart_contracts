pragma solidity ^0.4.24;

contract Delegate{
    address public delegateContract;
    address[] public oldDelegeateContracts;
    uint256 public total;
    event DelegateChanged(address _oldDelegate, address _newDelegeate);

    function add(uint256 var1, uint256 var2) public {
        total = var1 + var2;
    }
}
