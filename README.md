# Vault Contract Interface

![CI](https://github.com/cjay62816/upgradeable-vault-ci/actions/workflows/ci.yml/badge.svg)

A React-based frontend interface for interacting with the Vault smart contract.

## Features

- Connect MetaMask wallet
- View current stored value
- Set new value
- Responsive design with Chakra UI

## Getting Started

### Prerequisites

- Node.js 18+
- MetaMask browser extension
- Docker (optional, for containerized deployment)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/jasonc/ethwork.git
cd ethwork
```

2. Install dependencies:
```bash
cd frontend
npm install
```

3. Start the development server:
```bash
npm run dev
```

The application will be available at http://localhost:5173.

### Docker Deployment

To run the application in a Docker container:

```bash
docker build -t vault-frontend .
docker run -p 8080:80 vault-frontend
```

The application will be available at http://localhost:8080.

## Development

### Project Structure

- `src/` - Source code
  - `App.tsx` - Main application component
  - `utils/` - Utility functions
    - `contract.ts` - Smart contract interaction
  - `abi/` - Contract ABIs
  - `theme.ts` - Chakra UI theme configuration

### Testing

Run the test suite:

```bash
npm test
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
