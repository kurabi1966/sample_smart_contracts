pragma solidity ^0.4.24;
contract MultiSig {
  struct Transaction{
    address destinationAddress;
    uint256 value;
    bool transactionStatus;
    bytes data;
  }

  // store the count of transactions
  uint256 public transactionCount;
  // store in a map the id of the transaction pointing to a transaction
  mapping (uint256 => Transaction) public transactions;
  // for each transaction we need a map of addresses that confirmed the transaction
  mapping (uint256 => mapping(address => bool)) public confirmations;

  address[] public owners;
  uint256 public required;
  mapping(address => bool) public validOwners;

  constructor(address[] _owners, uint256 _required) public{
    require(_owners.length > 0);
    require(_required >0 && _required <= _owners.length);
    owners = _owners;
    for(uint256 i; i < _owners.length; i++){
      validOwners[_owners[i]] = true;
    }
    required = _required;
  }

  modifier isValidOwner() {
    require(validOwners[msg.sender]);
    _;
  }
  modifier isValidTransaction(uint256 _transactionId){
    require(_transactionId < transactionCount);
    _;
  }
  function addTransaction(address _destinationAddress, uint256 _value, bytes _data) internal returns (uint256 transactionId ){
    require(_destinationAddress != address(0));
    require(_value > 0);
    transactions[transactionCount++] = Transaction(_destinationAddress, _value, false, _data);
    transactionId = transactionCount - 1;
  }

  function confirmTransaction(uint256 transactionId) public isValidOwner isValidTransaction(transactionId){
    require(transactions[transactionId].transactionStatus == false);
    // msg.sender should be part of the owners array
    require(!confirmations[transactionId][msg.sender]);

    confirmations[transactionId][msg.sender] = true;
    if(isConfirmed(transactionId)){
      executeTransaction(transactionId);
    }
  }

  function getConfirmations(uint256 transactionId) public view isValidTransaction(transactionId) returns(address[] memory confirmators){

    uint256 count;

    for(uint256 i; i < owners.length; i++){
      if(confirmations[transactionId][owners[i]]){
        count++;
      }
    }

    confirmators = new address[](count);
    uint256 index = 0;
    for(uint256 j; j < owners.length; j++){
      if(confirmations[transactionId][owners[j]] == true){
        confirmators[index++] = owners[j];
      }
    }

  }

  function submitTransaction(address _destinationAddress, uint256 _value, bytes _data) public{
    require(_destinationAddress != address(0));
    require(_value > 0);
    uint256 txnID = addTransaction(_destinationAddress,_value, _data);
    confirmTransaction(txnID);
  }

  function() public payable{}

  function isConfirmed(uint256 _transactionId) public view isValidTransaction(_transactionId) returns(bool confirmed){
    address[] memory confirmators = getConfirmations(_transactionId);
    return (confirmators.length >= required);
  }

  function executeTransaction(uint256 _transactionId) public isValidTransaction(_transactionId) {
    require(isConfirmed(_transactionId));
    Transaction storage txn = transactions[_transactionId];
    require(!txn.transactionStatus);
    txn.destinationAddress.call.value(txn.value)(txn.data);
    // txn.destinationAddress.transfer(txn.value);
    txn.transactionStatus = true;
  }

  function getTransactionCount(bool pending, bool executed) public view returns(uint256 count){
    if(pending && executed) {
      count = transactionCount;
    } else {
      for(uint256 i; i < transactionCount; i++) {
        if(transactions[i].transactionStatus){ // transaction has been executed
          if(executed){ // executed case
            count++;
          }
        } else {
          if(pending){
            count++;
          }
        }
      }
    }
  }

  function getTransactionIds(bool _pending, bool _executed) public view returns(uint[]) {
    uint count;
    for(uint i = 0; i < transactionCount; i++) {
        if(_pending && !transactions[i].transactionStatus) {
            count++;
        }
        else if(_executed && transactions[i].transactionStatus) {
            count++;
        }
    }
    uint[] memory ids = new uint[](count);
    uint idsCount = 0;
    for(uint j = 0; j < transactionCount; j++) {
        if(_pending && !transactions[j].transactionStatus) {
            ids[idsCount] = j;
            idsCount++;
        }
        else if(_executed && transactions[j].transactionStatus) {
            ids[idsCount] = j;
            idsCount++;
        }
    }
    return ids;
  }

  function getOwners() public view returns(address[]) {
    return owners;
  }
}
