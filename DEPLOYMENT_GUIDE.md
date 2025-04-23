# UUPS Vault Deployment Guide

## Prerequisites

1. **Wallet Setup**:
   - Install MetaMask: https://metamask.io/download/
   - Create a new wallet (secure your seed phrase!)
   - Add Sepolia network to MetaMask:
     - Network Name: Sepolia
     - RPC URL: https://sepolia.infura.io/v3/YOUR_INFURA_ID
     - Chain ID: 11155111
     - Currency Symbol: ETH
     - Block Explorer: https://sepolia.etherscan.io

2. **Get Test ETH**:
   - Sepolia faucets:
     - https://sepoliafaucet.com/
     - https://faucet.quicknode.com/ethereum/sepolia
     - https://sepolia-faucet.pk910.de/

3. **Infura Account**:
   - Create account: https://infura.io/
   - Create new Ethereum project
   - Copy Project ID

## Configuration

1. **Environment Setup**:
   - Create `.env` file in project root with:
   ```
   PRIVATE_KEY=your_wallet_private_key
   SEPOLIA_RPC_URL=https://sepolia.infura.io/v3/your_infura_project_id
   ```
   - To get your private key from MetaMask:
     - Click three dots (top-right)
     - Account details
     - Export private key

2. **Update Deployment Script**:
   - Open `scripts/deploy-v1.ts`
   - Replace `YOUR_WALLET_ADDRESS_HERE` with your actual wallet address

## Deployment

1. **Deploy V1**:
   ```bash
   npx hardhat run scripts/deploy-v1.ts --network sepolia
   ```
   - Save the proxy address that appears in console

2. **Update Upgrade Script**:
   - Open `scripts/upgrade-to-v2.ts`
   - Replace `PROXY_ADDRESS_FROM_V1_DEPLOYMENT` with the proxy address from step 1

3. **Upgrade to V2**:
   ```bash
   npx hardhat run scripts/upgrade-to-v2.ts --network sepolia
   ```

## Interaction

You can interact with your contract using:
- Etherscan (Sepolia): https://sepolia.etherscan.io/
- Hardhat console
- Frontend application

### Available Functions

**V1 Functions**:
- `read()` - Returns the stored value
- `write(uint256)` - Updates the stored value (only owner)

**V2 Additional Functions**:
- `setName(string)` - Sets a name (only owner)
- `name()` - Returns the name

## Contract Verification (Optional)

```bash
npx hardhat verify --network sepolia IMPLEMENTATION_ADDRESS
```
Replace `IMPLEMENTATION_ADDRESS` with the implementation address. 