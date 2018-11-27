pragma solidity ^0.4.24;

contract Data{
    mapping(string => uint256) Uints256;

    function setUint256(string field, uint256 _value) public{
        Uints256[field] = _value;
    }

    function getUint256(string field) public view returns(uint256){
        return Uints256[field];
    }
}
