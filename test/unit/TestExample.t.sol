// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import { Test, console2 } from "forge-std/Test.sol";
import { ExampleContract } from "src/ExampleContract.sol";
import { HelperConfig } from "../../script/HelperConfig.s.sol";
import { DeployTestExample } from "../../script/DeployTestExample.s.sol";

contract CounterTest is Test {
    ExampleContract exampleContract;
    HelperConfig config;
    DeployTestExample deployer;

    function setUp() public {
        config = new HelperConfig();

        deployer = new DeployTestExample();
        (exampleContract, config) = deployer.run();

        exampleContract.setNumber(0);
    }

    function test_Increment() public {
        exampleContract.increment();
        assertEq(exampleContract.number(), 1);
    }

    function testFuzz_SetNumber(uint256 x) public {
        exampleContract.setNumber(x);
        assertEq(exampleContract.number(), x);
    }
}
