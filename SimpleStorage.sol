// SPDX-License-Identifier: MIT
pragma solidity 0.8.24; // Starting line of the solidity specifying the version
// the '^' specify the version equal to or greater than the specified will work
// pragma solidity >=0.8.18 <0.9.0 any version between the two specified

contract SimpleStorage{
    // Basic types: boolean,uint,int,address,bytes
    // bool hasFavouriteNumber=true;
    // uint256 favouriteNumber=88;// uint256=uint
    // int256 favouriteNum = -88;// int256=int
    // address myAddress= 0x33C958aB751734E6722C91B3AE89DA026D5B2AF8;
    // bytes32 favuriteAnimal="Dog";// max bytes 32
    uint256 myFavouriteNumber; // 0

    function store(uint256 _favouriteNumber) public {
        myFavouriteNumber=_favouriteNumber;
    }

    function retrieve() public view returns(uint256){
        return myFavouriteNumber;
    }

    // uint256[] listOfFavouriteNumbers;
    struct Person{
        uint256 favouriteNumber;
        string name;
    }

    // Person public vai = Person(10,"Vai");
    // Person public vai = Person({favouriteNumber: 10,name:"Vai"});

    //Dynamic Array
    Person[] public listOfPeople;

    //Static array
    // Person[2] public listofpeople;

    // mapping every uint256 has a unique string associated with it
    mapping(string => uint256) public nameToFavouriteNumber;

    function addPerson(string memory _name,uint256 _favouriteNumber) public {
        // Person memory newPerson=Person(_favouriteNumber,_name);
        // listOfPeople.push(newPerson);
        listOfPeople.push(Person(_favouriteNumber,_name));
        nameToFavouriteNumber[_name]=_favouriteNumber;
    }
}