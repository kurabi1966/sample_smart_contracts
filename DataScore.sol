pragma solidity ^0.4.24;

contract DataScore{
    uint256 public score;
    function setScore(uint256 _score) public{
        score = _score;
    }
}
