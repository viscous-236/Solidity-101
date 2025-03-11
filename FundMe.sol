// SPDX-License-Identifier:MIT

pragma solidity 0.8.24;

import {PriceConverter} from "./PriceConverter.sol";

error NotOwner();
error CallFailed();

contract FundMe{

    using PriceConverter for uint256;

    uint256 public constant MINIMUM_DOLLAR = 5000000000000000000; // we multiply it by e18 as the getConversionRate
    // will give the result is e18 decimal points

    address[] public funders;// arrays of address of people who send the money
    mapping(address funder => uint256 amountFunded) public addressToFundedAmount;

    address public immutable i_owner;

    constructor() {
        i_owner = msg.sender;
    }

    function fund() public payable {
        require(msg.value.getConversionRate() >= MINIMUM_DOLLAR,"Didn't send enough Dollars!"); // 1e18 = 1ETH
        funders.push(msg.sender);// msg.sender is the default value to contain addresses 
        addressToFundedAmount[msg.sender] += msg.value;
    }
    function withdraw() public onlyOwner {
        // require(msg.sender == owner,"Must be owner"); add modifiuer instead
        for (uint256 fundersIndex=0; fundersIndex<funders.length; fundersIndex++) 
        {
            // address funder = funders[fundersIndex];
            // addressToFundedAmount[funder] = 0;
            addressToFundedAmount[funders[fundersIndex]]=0;
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
        // require(callSuccessMsg,"Call Failed");
        if (!callSuccessMsg) { revert CallFailed();}
    }
    modifier onlyOwner(){
        // require(msg.sender == i_owner,"Must be Owner");
        // _;
        if (msg.sender != i_owner){
            revert NotOwner();
        }
        _;
    }

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }
}