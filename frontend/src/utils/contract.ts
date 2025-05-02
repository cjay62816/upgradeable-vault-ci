import { ethers } from 'ethers';
import VaultV1ABI from '../abi/VaultV1.json';

export const CONTRACT_ADDRESS = '0x76Cf2680138246636d03842d9326cbda0bf4e4Bd';

export type VaultContract = ethers.Contract & {
  setValue(value: ethers.BigNumberish): Promise<ethers.ContractTransactionResponse>;
  storedValue(): Promise<ethers.BigNumberish>;
};

export const getContract = (provider: ethers.BrowserProvider): VaultContract => {
  return new ethers.Contract(CONTRACT_ADDRESS, VaultV1ABI, provider) as unknown as VaultContract;
}; 