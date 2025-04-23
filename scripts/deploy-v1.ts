import { ethers, upgrades } from "hardhat";

async function main() {
  // Replace this with your wallet address
  const adminAddress = "YOUR_WALLET_ADDRESS_HERE";
  
  const MyVaultV1 = await ethers.getContractFactory("MyVaultV1");
  const proxy = await upgrades.deployProxy(MyVaultV1, [1234, adminAddress], {
    initializer: "initialize",
  });

  await proxy.waitForDeployment();

  const proxyAddress = await proxy.getAddress();
  console.log("Proxy deployed to:", proxyAddress);
  console.log("Save this address for upgrading to V2 later!");
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
}); 