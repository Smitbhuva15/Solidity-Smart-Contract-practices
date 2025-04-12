// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {PriceConverter} from "./PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;
    address immutable owner;

    constructor() {
        owner = msg.sender;
    }

 uint256 public constant MINIMUN_VAL = 5e18;
     address[] public funder;
    mapping(address => uint256) public fundermapping;  

    function fund() public payable {
        require(
            msg.value.getConversionRate() >= MINIMUN_VAL,
            "can not run because of fund!!"
        );
        fundermapping[msg.sender] += msg.value;
        funder.push(msg.sender);
    }

  function withdraw() public {
        require(msg.sender == owner, "Only the owner can withdraw money");

        for (uint256 i = 0; i < funder.length; i++) {
            address addr1 = funder[i];
            fundermapping[addr1] = 0;
        }

      
        funder = new address[](0);

        (bool success, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(success, "Withdrawal failed");
    }

     function withdrawspecificamount(uint256 amount) public {

        require(amount > 0, "you cannot withdraw amount");
        require(
            amount <= address(this).balance,
            "not have sufficient balance in your account"
        );

        (bool success,)=payable (msg.sender).call{value:amount}("");
              require(success, "Withdrawal failed");

    }

   
}
