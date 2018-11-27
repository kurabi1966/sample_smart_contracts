pragma solidity ^0.4.24;

contract HelloWorld{
  string public name;
  address owner;

  constructor (string iniName) public{
    name = iniName;
    owner = msg.sender;
  }

  function setNameRequire(string newName) public{
    require(msg.sender == owner, "You Have to be the owner");
    name = newName;
  }

  function setNameRevert(string newName) public{
    if(msg.sender != owner) { revert("You have to be the owner"); }
    name = newName;
  }

  function setNameAssert(string newName) public{
    assert(msg.sender == owner);
    name = newName;
  }
}
