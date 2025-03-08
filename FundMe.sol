// Gets fund from the user 
// Withdraws Funds
// Set a minimum funding value in USD

// SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;

contract FundMe{

    uint256 minimumDollar = 5;

    function fund() public payable {
        require(msg.value > minimumDollar,"Didn't send enough ETH!"); // 1e18 = 1ETH
    }
    // function withdraw() public {}
}