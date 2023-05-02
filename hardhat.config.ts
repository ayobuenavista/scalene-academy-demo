import { HardhatUserConfig } from "hardhat/types";
import '@nomiclabs/hardhat-ethers';
import "@nomicfoundation/hardhat-toolbox";
import '@typechain/hardhat';
import 'hardhat-contract-sizer';

const config: HardhatUserConfig = {
  defaultNetwork: "hardhat",
  networks: {
    hardhat: {
      chainId: 1337,
      // forking: {
      //   url: `https://mainnet.infura.io/v3/${process.env.INFURA}`
      //   // blockNumber: 10000 
      // },
      accounts: [
        // 20 accounts with 10^14 ETH each
        // Addresses:
        //   0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
        //   0x70997970C51812dc3A010C7d01b50e0d17dc79C8
        //   0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC
        {
          privateKey: '0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80',
          balance: '100000000000000000000000000000000',
        },
        {
          privateKey: '0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d',
          balance: '100000000000000000000000000000000',
        },
        {
          privateKey: '0x5de4111afa1a4b94908f83103eb1f1706367c2e68ca870fc3fb9a804cdab365a',
          balance: '100000000000000000000000000000000',
        },
      ]
    },
    mainnet: {
      url: `https://mainnet.infura.io/v3/${process.env.INFURA}`
    }
  },
  paths: {
    sources: "./contracts",
    tests: "./test",
    artifacts: "./build/artifacts",
    cache: "./build/cache",
  },
  solidity: {
    compilers: [
      {
        version: "0.8.18",
        settings: {
          optimizer: {
            enabled: true,
            runs: 10000,
          },
        },
      },
    ],
  },
  contractSizer: {
    alphaSort: true,
    disambiguatePaths: false,
    runOnCompile: true,
    strict: true,
  },
  typechain: {
    outDir: 'typechain',
    target: 'ethers-v5',
  },
};

export default config;
