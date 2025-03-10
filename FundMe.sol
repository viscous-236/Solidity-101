// Gets fund from the user 
// Withdraws Funds
// Set a minimum funding value in USD
// SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;

import {PriceConverter} from "./PriceConverter.sol";


contract FundMe{

    using PriceConverter for uint256;

    uint256 minimumDollar = 5e18; // we multiply it by e18 as the getConversionRate
    // will give the result is e18 decimal points

    address[] public funders;// arrays of address of people who send the money
    mapping(address funder => uint256 amountFunded) public addressToFundedAmount;

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function fund() public payable {
        require(msg.value.getConversionRate() >= minimumDollar,"Didn't send enough Dollars!"); // 1e18 = 1ETH
        funders.push(msg.sender);// msg.sender is the default value to contain addresses 
        addressToFundedAmount[msg.sender] += msg.value;
    }
    function withdraw() public onlyOwner {
        // require(msg.sender == owner,"Must be owner"); add modifiuer instead
        for (uint256 fundersIndex=0; fundersIndex<funders.length; fundersIndex++) 
        {
            address funder = funders[fundersIndex];
            addressToFundedAmount[funder] = 0;
        }
        // reset the array
        funders = new address[](0);
        // withdraw the function
        // transfer 
        // payable(msg.sender).transfer(address(this).balance);// address refers to adress of the person belongi
        // send  
        // bool sendSuccessMsg = payable(msg.sender).send(address(this).balance);
        // require(sendSuccessMsg,"Send Falied");
        // call
        (bool callSuccessMsg,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccessMsg,"Call Failed");
    }
    modifier onlyOwner(){
        require(msg.sender == owner,"Must be Owner");
        _;
    }
}