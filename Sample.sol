pragma solidity ^0.4.24;

contract Sample{
    enum Action {Left , Right, Stop, Back}

    Action public defaultAction = Action.Stop;

    function setActionLeft() public{
        defaultAction = Action.Left;
    }
}
