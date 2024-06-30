// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

/**
 * @title HelperConfig
 * @author Shawn Rizo
 * @notice Purpose: HelperConfig serves as a configuration manager for deploying contracts across different networks. It
 * stores network-specific configurations, particularly the initialOwner address for deployed contracts. This allows for
 * flexible deployment setups tailored to the requirements of various Ethereum networks (mainnet, testnets, and layer 2
 * solutions).
 *
 * NetworkConfig Struct:
 *   - Holds network-specific configurations. The initialOwner field specifies the default owner address for contracts
 *  deployed using this configuration.
 *
 * State Variables and Constructor:
 *   - Maps network IDs to their respective configurations. The constructor initializes these mappings with predefined
 * settings for supported networks.
 *
 * getConfigByChainId and getActiveNetworkConfig Functions:
 *   - Retrieve the configuration for the current blockchain network. This enables the deployment script to adapt to the
 * network it's being executed on, using the appropriate initialOwner.
 */
import { Script } from "forge-std/Script.sol";
import { console2 } from "forge-std/console2.sol";

contract HelperConfig is Script {
    /*//////////////////////////////////////////////////////////////
                                 ERRORS
    //////////////////////////////////////////////////////////////*/
    error HelperConfig__InvalidChainId();

    /*//////////////////////////////////////////////////////////////
                                 TYPES
    //////////////////////////////////////////////////////////////*/
    struct NetworkConfig {
        address initialOwner;
    }

    /*//////////////////////////////////////////////////////////////
                            STATE VARIABLES
    //////////////////////////////////////////////////////////////*/
    uint256 constant ETH_MAINNET_CHAIN_ID = 1;
    uint256 constant ETH_SEPOLIA_CHAIN_ID = 11_155_111;

    uint256 constant ZKSYNC_MAINNET_CHAIN_ID = 324;
    uint256 constant ZKSYNC_SEPOLIA_CHAIN_ID = 300;

    uint256 constant POLYGON_MAINNET_CHAIN_ID = 137;
    uint256 constant POLYGON_MUMBAI_CHAIN_ID = 80_001;

    uint256 constant OP_MAINNET_CHAIN_ID = 10;
    uint256 constant OP_SEPOLIA_CHAIN_ID = 11_155_420;

    uint256 constant BASE_MAINNET_CHAIN_ID = 8453;
    uint256 constant BASE_SEPOLIA_CHAIN_ID = 84_532;

    uint256 constant MODE_MAINNET_CHAIN_ID = 34_443;
    uint256 constant MODE_SEPOLIA_CHAIN_ID = 919;

    // Local network state variables
    NetworkConfig public localNetworkConfig;
    mapping(uint256 chainId => NetworkConfig) public networkConfigs;

    /*//////////////////////////////////////////////////////////////
                               FUNCTIONS
    //////////////////////////////////////////////////////////////*/
    constructor() {
        networkConfigs[ETH_MAINNET_CHAIN_ID] = getEthMainnetConfig();
        networkConfigs[ETH_SEPOLIA_CHAIN_ID] = getEthSepoliaConfig();
        networkConfigs[ZKSYNC_MAINNET_CHAIN_ID] = getZkSyncConfig();
        networkConfigs[ZKSYNC_SEPOLIA_CHAIN_ID] = getZkSyncSepoliaConfig();
        networkConfigs[POLYGON_MAINNET_CHAIN_ID] = getPolygonMainnetConfig();
        networkConfigs[POLYGON_MUMBAI_CHAIN_ID] = getPolygonMumbaiConfig();
        networkConfigs[OP_MAINNET_CHAIN_ID] = getOpMainnetConfig();
        networkConfigs[OP_SEPOLIA_CHAIN_ID] = getOpSepoliaConfig();
        networkConfigs[BASE_MAINNET_CHAIN_ID] = getBaseMainnetConfig();
        networkConfigs[BASE_SEPOLIA_CHAIN_ID] = getBaseSepoliaConfig();
        networkConfigs[MODE_MAINNET_CHAIN_ID] = getModeMainnetConfig();
        networkConfigs[MODE_SEPOLIA_CHAIN_ID] = getModeSepoliaConfig();
    }

    function getConfigByChainId(uint256 chainId) public returns (NetworkConfig memory) {
        if (networkConfigs[chainId].initialOwner != address(0)) {
            return networkConfigs[chainId];
        } else {
            return getOrCreateAnvilEthConfig();
        }
    }

    function getActiveNetworkConfig() public returns (NetworkConfig memory) {
        return getConfigByChainId(block.chainid);
    }

    /*//////////////////////////////////////////////////////////////
                                CONFIGS
    //////////////////////////////////////////////////////////////*/
    function getEthMainnetConfig() public pure returns (NetworkConfig memory) {
        return NetworkConfig({ initialOwner: address(1) });
    }

    function getEthSepoliaConfig() public pure returns (NetworkConfig memory) {
        return NetworkConfig({ initialOwner: address(1) });
    }

    function getZkSyncConfig() public pure returns (NetworkConfig memory) {
        return NetworkConfig({ initialOwner: address(1) });
    }

    function getZkSyncSepoliaConfig() public pure returns (NetworkConfig memory) {
        return NetworkConfig({ initialOwner: address(1) });
    }

    function getPolygonMainnetConfig() public pure returns (NetworkConfig memory) {
        return NetworkConfig({ initialOwner: address(1) });
    }

    function getPolygonMumbaiConfig() public pure returns (NetworkConfig memory) {
        return NetworkConfig({ initialOwner: address(1) });
    }

    function getOpMainnetConfig() public pure returns (NetworkConfig memory) {
        return NetworkConfig({ initialOwner: address(1) });
    }

    function getOpSepoliaConfig() public pure returns (NetworkConfig memory) {
        return NetworkConfig({ initialOwner: address(1) });
    }

    function getBaseMainnetConfig() public pure returns (NetworkConfig memory) {
        return NetworkConfig({ initialOwner: address(1) });
    }

    function getBaseSepoliaConfig() public pure returns (NetworkConfig memory) {
        return NetworkConfig({ initialOwner: address(1) });
    }

    function getModeMainnetConfig() public pure returns (NetworkConfig memory) {
        return NetworkConfig({ initialOwner: address(1) });
    }

    function getModeSepoliaConfig() public pure returns (NetworkConfig memory) {
        return NetworkConfig({ initialOwner: address(1) });
    }

    /*//////////////////////////////////////////////////////////////
                              LOCAL CONFIG
    //////////////////////////////////////////////////////////////*/
    function getOrCreateAnvilEthConfig() public returns (NetworkConfig memory) {
        if (localNetworkConfig.initialOwner != address(0)) {
            return localNetworkConfig;
        }
        console2.log(unicode"⚠️ You have deployed a mock conract!");
        console2.log("Make sure this was intentional");

        _deployMocks();

        localNetworkConfig = NetworkConfig({ initialOwner: address(1) });
        return localNetworkConfig;
    }

    /*
     * Add your mocks, deploy and return them here for your local anvil network
     */
    function _deployMocks() internal { }
}
