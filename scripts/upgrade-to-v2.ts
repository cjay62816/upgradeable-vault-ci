import { ethers, upgrades } from "hardhat";

async function main() {
  // Replace this with the proxy address from your V1 deployment
  const proxyAddress = "PROXY_ADDRESS_FROM_V1_DEPLOYMENT";
  
  console.log("Upgrading proxy at:", proxyAddress);
  
  const MyVaultV2 = await ethers.getContractFactory("MyVaultV2");
  await upgrades.upgradeProxy(proxyAddress, MyVaultV2);
  
  console.log("✅ Upgraded to V2 successfully!");
  console.log("You can now use the new functions setName() and name()");
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
}); 