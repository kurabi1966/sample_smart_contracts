pragma solidity ^0.4.24;


contract DataExchange{
    address owner;

    struct Data4Sell{
        address owner;
        string ipfsHash;
        uint256 price;
        string title;
        bool isAvailable;
    }


    mapping(string => Data4Sell) products;
    string[] public productsArray;

    constructor () public{
        owner = msg.sender;
    }

    function addProduct(string _title, string _ipfsHash, uint256 _price)public {
        // Data4Sell new_prod =  Data4Sell({owner: msg.sender,ipfsHash: _ipfsHash,price: _price, title: _title});
        products[_ipfsHash].owner = msg.sender;
        products[_ipfsHash].price = _price;
        products[_ipfsHash].title = _title;
        products[_ipfsHash].isAvailable = true;
        productsArray.push(_ipfsHash);
    }

    function getProduct(uint256 index) public view returns(string, uint256){
        require(index <= productsArray.length);
        string memory ipfsHash = productsArray[index];

        return (products[ipfsHash].title, products[ipfsHash].price);
    }

    function suspenedProduct(uint256 index)public{
        require(index <= productsArray.length);
        string memory ipfsHash = productsArray[index];

        require(msg.sender == products[ipfsHash].owner);
        products[ipfsHash].isAvailable = false;
    }

    function resumeProduct(uint256 index)public{
        require(index <= productsArray.length);
        string memory ipfsHash = productsArray[index];
        require(msg.sender == products[ipfsHash].owner);
        products[ipfsHash].isAvailable = true;
    }

    function getProductsLength() public view returns(uint){
        return productsArray.length;
    }

    function buyProduct(uint256 index) public payable returns(string){
        require(index <= productsArray.length);
        string memory ipfsHash = productsArray[index];

        require(products[ipfsHash].price <= msg.value, "Insufeciant fund");
        products[ipfsHash].owner.transfer(msg.value * 99 / 100);
        owner.transfer(msg.value / 100);
        return ipfsHash;
    }

    function updateProduct(string _title, string _ipfsHash, uint256 _price)public {
        require(products[_ipfsHash].owner == msg.sender);
        products[_ipfsHash].price = _price;
        products[_ipfsHash].title = _title;
    }
}
