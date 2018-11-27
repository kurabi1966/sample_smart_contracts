pragma solidity ^0.4.24;

contract Main{
    address public logic;
    address public data;

    constructor(address _data, address _logic) public{
        data = _data;
        logic = _logic;
    }

    function changeDelegate(address _newDelegate) public{
        require(_newDelegate != logic);
        logic = _newDelegate;
    }

    function Add(uint256 var1, uint256 var2) public {
        logic.delegatecall(bytes4(sha3("setTotal(uint256,uint256)")), var1, var2);
    }

    // function callAdd(uint256 var1, uint256 var2) public{
    //     delegateContract.call(bytes4(sha3("add(uint256,uint256)")), var1, var2);

    // }

}
