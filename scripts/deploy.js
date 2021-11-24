const main = async () => {
  const nftContractFactory = await hre.ethers.getContractFactory('Transistors')
  const nftContract = await nftContractFactory.deploy();
  await nftContract.deployed();
  console.log("Contract deployed to: ", nftContract.address);

  // Call makeNFT on deployed contract.
  let i = 0;
  while (i < 20) {
    let txn = await nftContract.makeNFT();
    await txn.wait();
    console.log("NFT written.");
    i += 1;
  }
}

const runMain = async() => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1)
  }
}

runMain();
