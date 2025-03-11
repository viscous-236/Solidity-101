//SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {SimpleStorage} from "./SimpleStorage.sol";

contract AddFiveStorage is SimpleStorage{
    // +5
    // override
    // virtual override
    // to override the function we have to set the keyword virtual to the old function
    // and the keyword override to new modified fuction
    function store(uint256 _newNumber) public override {
        myFavouriteNumber = _newNumber + 5;
    }
}