// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";


library PriceConverter{
    function getPrice() internal view returns(uint256){
        // Address 0x694AA1769357215DE4FAC081bf1f309aDC325306
        // ABI ✅
        
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (, int256 answer,,,) = priceFeed.latestRoundData();
        // Price of Eth in terms oF USD
        // 2000.00000000 has 10 decimal points so multiply it by e10
        return uint256(answer * 10000000000);// int has to be converted into uint256
    }   

    function getConversionRate(uint256 ethAmount) internal  view returns(uint256){
        uint256 ethPriceInUSD = getPrice();// will give the price of ETH in USD
        uint256 totalEthPriceInUSD = (ethPriceInUSD * ethAmount) / 1000000000000000000;
        // 1e18*1e18/1e18
        return totalEthPriceInUSD;
    }

    function getVersion() internal view  returns (uint256){
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }
}
