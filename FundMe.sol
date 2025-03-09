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

    function fund() public payable {
        require(msg.value.getConversionRate() >= minimumDollar,"Didn't send enough Dollars!"); // 1e18 = 1ETH
        funders.push(msg.sender);// msg.sender is the default value to contain addresses 
        addressToFundedAmount[msg.sender] = msg.value + addressToFundedAmount[msg.sender];
    }
    // function withdraw() public {}

}