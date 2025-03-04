// Gets fund from the user 
// Withdraws Funds
// Set a minimum funding value in USD

// SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;

contract FundMe{
    function fund() public payable {
        require(msg.value > 1e18,"Didn't send enough ETH!"); // 1e18 = 1ETH
    }
    // function withdraw() public {}
}