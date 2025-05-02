# Upgradeable Vault CI

![CI](https://github.com/cjay62816/upgradeable-vault-ci/actions/workflows/ci.yml/badge.svg)

A production-grade, upgradeable vault system with a modern React frontend interface. This project demonstrates secure smart contract upgradeability patterns and professional development practices.

## 🚀 Overview

This project implements a secure vault system with the following key features:
- UUPS (Universal Upgradeable Proxy Standard) upgradeable smart contracts
- Modern React frontend with TypeScript and Chakra UI
- Docker containerization for production deployment
- Comprehensive CI/CD pipeline with Foundry tests and frontend checks

## 🧠 Architecture

### Smart Contracts
- `VaultV1`: Initial implementation with basic value storage
- `VaultV2`: Adds name functionality while maintaining storage layout
- `VaultV3_Broken`: Demonstrates storage layout violation (for educational purposes)

### Frontend
- React + TypeScript + Vite
- Chakra UI for modern, responsive design
- Ethers.js for blockchain interaction
- Docker containerization for production

## 📦 Smart Contract Workflow

1. Deploy implementation contract
2. Deploy proxy contract pointing to implementation
3. Initialize proxy with initial values
4. Upgrade implementation while maintaining storage layout

## 🖼️ Frontend Features

- Connect MetaMask wallet
- View current stored value
- Set new value
- Responsive design with Chakra UI
- Type-safe contract interactions

## 🐳 Docker Support

The frontend is containerized for production deployment:

```bash
# Build the Docker image
docker build -t vault-frontend .

# Run the container
docker run -p 8080:80 vault-frontend
```

Access the frontend at http://localhost:8080

## ✅ Live Links

- [Implementation on Sepolia](https://sepolia.etherscan.io/address/0x76Cf2680138246636d03842d9326cbda0bf4e4Bd)
- [Proxy Contract](https://sepolia.etherscan.io/address/0x76Cf2680138246636d03842d9326cbda0bf4e4Bd)

## 🧪 Testing & CI

The project uses a comprehensive CI pipeline:
1. Foundry tests for smart contracts
2. Frontend build and lint checks
3. Docker image build verification

### Local Development

```bash
# Install dependencies
cd frontend
npm install

# Start development server
npm run dev
```

## License

MIT

## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
