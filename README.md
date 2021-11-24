# Transistors' Transit NFT Collection

Live on Rinkeby @ https://rinkeby.etherscan.io/address/0x97477c5163cfebf7deb502d9e5c90b587df57370
View on OpenSea: https://testnets.opensea.io/collection/transistors-transit-7qjlllophh
Mint yourself something! (reach out to me if you need play ETH): funnymania.lol/#donate

Following a teaching tutorial on buildspace, an NFT minting factory that produces catchy pop-art imagery. 

Uses hardhat, alchemy, and openzeppelin's contracts. 

## To run/deploy

Alchemy is used to broadcast transactions to the network, get an account [here](https://alchemy.com).

Make sure to include your credentials in a .env file.

Do not share or commit your .env file with anyone or anybody.

```
// Running
npx hardhat run scripts/run.js

// Deploying
npx hardhat run scripts/deploy.js --network rinkeby
```
