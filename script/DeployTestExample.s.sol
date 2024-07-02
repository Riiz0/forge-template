// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

/**
 * @title DeployTestExample
 * @author Shawn Rizo
 * @notice This contract demonstrates the deployment of ExampleContract using network-specific settings managed by
 * HelperConfig. It illustrates the dynamic application of configurations in a deployment script for different network
 * environments.
 *
 * run Function:
 *   - Instantiates a new HelperConfig contract.
 *   - Retrieves the active network configuration from the newly created HelperConfig instance.
 *   - Deploys ExampleContract with the initialOwner specified in the active network configuration. This process
 * exemplifies the utilization of HelperConfig to facilitate adaptable deployments across various networks.
 *   - Returns instances of both ExampleContract and HelperConfig, showcasing the contract's ability to interact with
 * and configure other contracts dynamically.
 *
 * @dev The deployment script leverages HelperConfig for fetching network-specific configurations, such as the
 * initialOwner address, to deploy ExampleContract. This approach ensures flexibility and adaptability in deployment
 * strategies, catering to different network requirements without altering the core contract code.
 *
 * HelperConfig Interaction:
 *   - The script begins by creating a new instance of HelperConfig, which is responsible for managing network-specific
 * configurations.
 *   - It then fetches the active network configuration using `getActiveNetworkConfig()`, obtaining parameters like the
 * initialOwner.
 *
 * ExampleContract Deployment:
 *   - With the active network configuration at hand, the script deploys ExampleContract, passing `config.initialOwner`
 * to its constructor. This method ensures that the initialOwner is determined by the current deployment environment,
 * facilitated by HelperConfig, rather than being hardcoded.
 *
 * Purpose and Benefits:
 *   - The primary aim is to demonstrate a flexible and dynamic deployment mechanism that can easily adapt to various
 * network settings without necessitating changes to the deployed contracts' code.
 *   - This method significantly enhances deployment efficiency and adaptability, particularly beneficial for projects
 * targeting multiple networks (e.g., Ethereum mainnet, testnets) with varying configurations.
 */
import { Script, console2 } from "forge-std/Script.sol";
import { ExampleContract } from "../src/ExampleContract.sol";
import { HelperConfig } from "./HelperConfig.s.sol";

contract DeployTestExample is Script {
    function run() external returns (ExampleContract, HelperConfig) {
        HelperConfig helperConfig = new HelperConfig();

        HelperConfig.NetworkConfig memory config = helperConfig.getActiveNetworkConfig();

        ExampleContract exampleContract = new ExampleContract(config.initialOwner);

        return (exampleContract, helperConfig);
    }
}
