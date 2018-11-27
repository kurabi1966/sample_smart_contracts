pragma solidity ^0.4.24;

contract Score{
    uint256 public score;
    function getScore() public view returns(uint256 retVal){
        retVal = score;
    }
    function setScore(uint256 _newScore) public{
        score = _newScore + 1;
    }
}
