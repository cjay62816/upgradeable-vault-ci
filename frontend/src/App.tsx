import { useState, useEffect } from 'react';
import { ethers } from 'ethers';
import { Box, Button, Container, Heading, Input, Text, VStack } from '@chakra-ui/react';
import { getContract, type VaultContract } from './utils/contract';

function App() {
  const [account, setAccount] = useState<string>('');
  const [storedValue, setStoredValue] = useState<string>('');
  const [newValue, setNewValue] = useState<string>('');
  const [provider, setProvider] = useState<ethers.BrowserProvider | null>(null);

  const connectWallet = async () => {
    if (window.ethereum) {
      try {
        const provider = new ethers.BrowserProvider(window.ethereum);
        setProvider(provider);
        const accounts = await provider.send('eth_requestAccounts', []);
        setAccount(accounts[0]);
      } catch (error) {
        console.error('Error connecting to MetaMask:', error);
      }
    } else {
      alert('Please install MetaMask!');
    }
  };

  const fetchStoredValue = async () => {
    if (!provider) return;
    try {
      const contract = getContract(provider);
      const value = await contract.storedValue();
      setStoredValue(value.toString());
    } catch (error) {
      console.error('Error fetching stored value:', error);
    }
  };

  const setValue = async () => {
    if (!provider || !newValue) return;
    try {
      const signer = await provider.getSigner();
      const contract = getContract(provider).connect(signer) as VaultContract;
      const tx = await contract.setValue(newValue);
      await tx.wait();
      fetchStoredValue();
    } catch (error) {
      console.error('Error setting value:', error);
    }
  };

  useEffect(() => {
    if (provider) {
      fetchStoredValue();
    }
  }, [provider]);

  return (
    <Container maxW="container.md" py={8}>
      <VStack spacing={6}>
        <Heading>Vault Contract Interface</Heading>
        
        {!account ? (
          <Button colorScheme="blue" onClick={connectWallet}>
            Connect MetaMask
          </Button>
        ) : (
          <Text>Connected: {account}</Text>
        )}

        <Box w="100%" p={4} borderWidth={1} borderRadius="lg">
          <Text mb={2}>Current Stored Value: {storedValue}</Text>
          <Button onClick={fetchStoredValue} colorScheme="teal" size="sm">
            Refresh
          </Button>
        </Box>

        <Box w="100%" p={4} borderWidth={1} borderRadius="lg">
          <VStack spacing={4}>
            <Input
              placeholder="Enter new value"
              value={newValue}
              onChange={(e) => setNewValue(e.target.value)}
              type="number"
            />
            <Button onClick={setValue} colorScheme="purple" isDisabled={!account}>
              Set Value
            </Button>
          </VStack>
        </Box>
      </VStack>
    </Container>
  );
}

export default App;
