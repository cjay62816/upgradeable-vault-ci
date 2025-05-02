# UUPS Vault Deployment Guide (Foundry)

This guide walks you through deploying and upgrading a UUPS upgradeable vault using Foundry.

## Prerequisites

- Foundry (forge, cast, anvil)
- Sepolia ETH
- Environment variables set in `.env`

## Environment Setup

Create a `.env` file with:

```env
PRIVATE_KEY=your_wallet_private_key
SEPOLIA_RPC_URL=https://sepolia.infura.io/v3/YOUR_INFURA_PROJECT_ID
ETHERSCAN_API_KEY=your_etherscan_api_key
```

## Deployment Steps

1. Deploy V1:

```bash
source .env && forge script script/DeployUUPSVault.s.sol:DeployScript --rpc-url $SEPOLIA_RPC_URL --broadcast --verify -vvvv
```

2. Save the proxy address from the deployment output and add it to your `.env`:

```env
PROXY_ADDRESS=0x...
```

3. Upgrade to V2:

```bash
source .env && forge script script/UpgradeUUPSVault.s.sol:UpgradeScript --rpc-url $SEPOLIA_RPC_URL --broadcast --verify -vvvv
```

## Interacting with the Vault

1. Read the current value:
```bash
cast call $PROXY_ADDRESS "read()(uint256)" --rpc-url $SEPOLIA_RPC_URL
```

2. Write a new value (requires owner):
```bash
cast send $PROXY_ADDRESS "write(uint256)" 5678 --private-key $PRIVATE_KEY --rpc-url $SEPOLIA_RPC_URL
```

3. After upgrade, set the name:
```bash
cast send $PROXY_ADDRESS "setName(string)" "MyProtocol" --private-key $PRIVATE_KEY --rpc-url $SEPOLIA_RPC_URL
```

4. Read the name:
```bash
cast call $PROXY_ADDRESS "name()(string)" --rpc-url $SEPOLIA_RPC_URL
```

## Security Notes

- Keep your private key secure
- Verify all contract deployments
- Test upgrades thoroughly before mainnet deployment
- Consider using a multisig for upgrade authorization

## Contract Verification (Optional)

```bash
npx hardhat verify --network sepolia IMPLEMENTATION_ADDRESS
```