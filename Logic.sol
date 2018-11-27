pragma solidity ^0.4.24;

contract Logic{
    address public logic;
    address public data;

    constructor(address _data) public{
       data = _data;
    }

    function setTotal(uint256 var1, uint256 var2) public {
        data.call(bytes4(sha3("setUint256(string,uint256)")), "total", var1+var2);
    }
}
