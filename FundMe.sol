// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {PriceConverter} from "./PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;
    address immutable owner;

    constructor() {
        owner = msg.sender;
    }

   

    function fund() public payable {
        require(
            msg.value.getConversionRate() >= MINIMUN_VAL,
            "can not run because of fund!!"
        );
        fundermapping[msg.sender] += msg.value;
        funder.push(msg.sender);
    }

   
}
