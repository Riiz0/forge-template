// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

/**
 * @title ExampleContract
 * @author Shawn Rizo
 * @notice Purpose: A simple contract example that showcases ownership (via OpenZeppelin's Ownable) and basic state
 * manipulation (incrementing a number).
 *
 * Constructor:
 *       - Accepts an initialOwner address, demonstrating how deployment parameters can be dynamically adjusted
 * based on the deployment script's environment, facilitated by HelperConfig.
 */
contract ExampleContract {
    uint256 public number;

    constructor(address initialOwner) { }

    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function increment() public {
        number++;
    }
}
