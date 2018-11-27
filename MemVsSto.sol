pragma solidity ^0.4.24;


contract MemVsSto{

    string[] public names;

    constructor () public {
        names.push("Lina");
        names.push("Adam");
    }

    function addName(string _name) public{
        names.push(_name);
    }

    function test1() public {
        string[] memory myNames = names;
        myNames[1] = "Yasser";
    }

    function test2() public {
        string[] storage myNames = names;
        myNames[1] = "Ammar";
    }

    function test3() public{
        LetUsChangeNames(names);
    }

    function LetUsChangeNames(string[] _names) private {
        _names[1] = "Joh";
    }
}
