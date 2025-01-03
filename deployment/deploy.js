
async function main() {

    const [deployer] = await ethers.getSigners();
    console.log("Deploying contracts with the account:", deployer.address);

    const Token = await ethers.getContractFactory("FortyTwo42");
    const mintAmount = ethers.utils.parseUnits("1000000", 18);
    const token = await Token.deploy(mintAmount);

    console.log("FortyTwo42 deployed to:", token.address)

    let balance = await token.balanceOf(deployer.address);
    console.log("Solde de l'adresse du propriétaire (deployer):", ethers.utils.formatUnits(balance, 18), "tokens");

}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
