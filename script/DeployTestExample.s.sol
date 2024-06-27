// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

/**
 * @title DeployTestExample
 * @author Shawn Rizo
 * @notice Purpose: Demonstrates how to use HelperConfig to deploy an ExampleContract with network-specific settings. It
 * showcases the practical application of configurations managed by HelperConfig in a deployment script.
 *
 * Constructor:
 *   - Initializes the helperConfig variable with the address of a deployed HelperConfig contract. This setup
 * allows DeployTestExample to access network configurations.
 *
 * run Function:
 *   - Retrieves the active network configuration using helperConfig.getActiveNetworkConfig().
 *   - Deploys ExampleContract using the initialOwner from the active network configuration. This demonstrates how
 *   - deployment scripts can utilize HelperConfig to adapt to different networks seamlessly.
 */

/**
 * @notice [MORE NOTES]
 * HelperConfig Configuration: The config object is an instance of a configuration (likely retrieved from the
 * HelperConfig contract or a similar configuration management setup), which contains various settings including the
 * initialOwner address. This configuration is specific to the network or deployment scenario you are working with.
 *
 * ExampleContract Deployment: When you deploy ExampleContract using new ExampleContract(config.initialOwner);, you are
 * passing the initialOwner address from the config object to the constructor of ExampleContract. This means the
 * initialOwner used here is defined by your deployment configuration (HelperConfig), not hardcoded or directly
 * specified in the ExampleContract itself.
 *
 * Purpose: The purpose of this approach is to allow for flexible deployment configurations. By using a configuration
 * object (config from HelperConfig), you can easily change the initialOwner and other parameters without modifying the
 * ExampleContract code. This is particularly useful for deploying to different networks (e.g., testnet, mainnet) where
 * different parameters might be needed.
 */
import { Script, console2 } from "forge-std/Script.sol";
import { ExampleContract } from "../src/ExampleContract.sol";
import { HelperConfig } from "./HelperConfig.s.sol";

contract DeployTestExample is Script {
    HelperConfig helperConfig;

    constructor(address helperConfigAddress) {
        helperConfig = HelperConfig(helperConfigAddress);
    }

    function run() external returns (ExampleContract) {
        HelperConfig.NetworkConfig memory config = helperConfig.getActiveNetworkConfig();

        ExampleContract exampleContract = new ExampleContract(config.initialOwner);

        return exampleContract;
    }

    function getHelperConfig() public view returns (HelperConfig) {
        return helperConfig;
    }
}
