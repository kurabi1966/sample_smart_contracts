pragma solidity ^0.4.24;

contract Score{
    uint public score = 12;
    function setScore(uint s)public {
        score = s;
    }
}


contract proxy {
    address impl;

    constructor(address _impl) public {
        impl = _impl;
    }

    function () public{
        address _impl;
        assembly {
            let ptr := mload(0x40)
            calldatacopy(ptr, 0, calldatasize)
            let result := delegatecall(gas, _impl, ptr, calldatasize, 0, 0)
            let size := returndatasize
            returndatacopy(ptr, 0, size)

            switch result
            case 0 { revert(ptr, size) }
            default { return(ptr, size) }
        }
    }
}
