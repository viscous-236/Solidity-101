// Gets fund from the user 
// Withdraws Funds
// Set a minimum funding value in USD
// SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";


contract FundMe{

    uint256 minimumDollar = 5e18;

    function fund() public payable {
        require(getConversionRate(msg.value) >= minimumDollar,"Didn't send enough Dollars!"); // 1e18 = 1ETH
    }
    // function withdraw() public {}

    function getPrice() public view returns(uint256){
        // Address 0x694AA1769357215DE4FAC081bf1f309aDC325306
        // ABI 
        
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (, int256 answer,,,) = priceFeed.latestRoundData();
        // Price of Eth in terms oF USD
        // 2000.00000000
        return uint256(answer * 1e10);
    }   

    function getConversionRate(uint256 ethAmount) public view returns(uint256){
        uint256 ethPriceInUSD = getPrice();
        uint256 totalEthPriceInUSD = (ethPriceInUSD * ethAmount) / 1e18;
        return totalEthPriceInUSD;
    }
}