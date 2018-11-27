pragma solidity ^0.4.24;

contract ScoreStorage{
    mapping(bytes32 => uint256) storeUint;

    function setUint(bytes32 field, uint256 _value) public{
        storeUint[field] = _value;
    }

    function getUint(bytes32 field) public view returns(uint256 _value){
        _value = storeUint[field];
    }

}

contract Score {
    ScoreStorage contractStorage;
    address owner;

    constructor(address _ScoreStorage) public{
        contractStorage = ScoreStorage(_ScoreStorage);
        owner = msg.sender;
    }

    function setScore(uint256 _score) public{
        uint256 newScore = _score * 2;
        contractStorage.setUint(keccak256('scrore'), newScore);
    }

    function getScore() public view returns(uint256 score){
        score = contractStorage.getUint(keccak256('scrore'));
    }
}
