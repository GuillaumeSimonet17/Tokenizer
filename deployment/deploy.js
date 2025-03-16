async function main() {
    const [deployer] = await ethers.getSigners();
    console.log("Deploying contracts with the account:", deployer.address);

    const FortyTwo42 = await ethers.getContractFactory("FortyTwo42");
    const supply = 1000000;
    const decimals = 18;

    // Utiliser BigNumber pour éviter un dépassement
    const initialSupply = ethers.BigNumber.from(supply).mul(ethers.BigNumber.from(10).pow(decimals));

    console.log("Initial supply:", initialSupply.toString());

    const ft42 = await FortyTwo42.deploy(initialSupply);
    console.log("FortyTwo42 deployed to:", ft42.address);

    // Déployer le contrat StakingContract avec l'adresse de FortyTwo42
    const StakingContract = await ethers.getContractFactory("StakingContract");
    const stakingContract = await StakingContract.deploy(ft42.address);
    console.log("StakingContract deployed to:", stakingContract.address);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
