// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract StakingContract {
    IERC20 public ft42Token; // Référence au contrat ERC20

    struct Staker {
        uint256 amount;
        uint256 lastClaim;
    }

    mapping(address => Staker) public stakers;
    mapping(address => uint8) public userLevel; // 0 = None, 1 = Silver, 2 = Gold, 3 = Platinum

    uint256 public constant SILVER_THRESHOLD = 10000 * 10 ** 18;
    uint256 public constant GOLD_THRESHOLD = 50000 * 10 ** 18;
    uint256 public constant PLATINUM_THRESHOLD = 100000 * 10 ** 18;

    uint256 public constant REWARD_PER_TASK = 100 * 10 ** 18;
    uint256 public constant MONTHLY_REWARD_PERCENT = 5;

    struct Service {
        string name;
        uint256 price;
    }

    Service[] public services;

    // Construction du contrat en prenant l'adresse du contrat FortyTwo42
    constructor(address _ft42Token) {
        ft42Token = IERC20(_ft42Token);
    }

    function stakeTokens(uint256 amount) external {
        require(amount > 0, "Amount must be greater than zero");
        require(ft42Token.balanceOf(msg.sender) >= amount, "Not enough tokens");
        require(address(ft42Token) != address(0), "Token contract not set");
        require(ft42Token.allowance(msg.sender, address(this)) >= amount, "Allowance too low");

        // Transfert des tokens de l'utilisateur vers ce contrat
        ft42Token.transferFrom(msg.sender, address(this), amount);

        stakers[msg.sender].amount += amount;
        stakers[msg.sender].lastClaim = block.timestamp;

        updateUserLevel(msg.sender);
    }

    function unstakeTokens(uint256 amount) external {
        require(stakers[msg.sender].amount >= amount, "Not enough staked tokens");
        claimStakingReward();
        stakers[msg.sender].amount -= amount;
        ft42Token.transfer(msg.sender, amount);
        updateUserLevel(msg.sender);
    }

    function claimStakingReward() public {
        require(stakers[msg.sender].amount > 0, "No staked tokens");
        uint256 timeDiff = block.timestamp - stakers[msg.sender].lastClaim;
        uint256 monthsPassed = timeDiff / 30 days;
        if (monthsPassed > 0) {
            uint256 reward = (stakers[msg.sender].amount * MONTHLY_REWARD_PERCENT * monthsPassed) / 100;
            ft42Token.transfer(msg.sender, reward); // Utilisation de `transfer` pour envoyer des tokens
            stakers[msg.sender].lastClaim = block.timestamp;
        }
    }

    function updateUserLevel(address user) internal {
        uint256 staked = stakers[user].amount;
        if (staked >= PLATINUM_THRESHOLD) {
            userLevel[user] = 3;
        } else if (staked >= GOLD_THRESHOLD) {
            userLevel[user] = 2;
        } else if (staked >= SILVER_THRESHOLD) {
            userLevel[user] = 1;
        } else {
            userLevel[user] = 0;
        }
    }

    function getUserLevel(address user) external view returns (string memory) {
        if (userLevel[user] == 3) return "Platinum";
        if (userLevel[user] == 2) return "Gold";
        if (userLevel[user] == 1) return "Silver";
        return "0";
    }

    function tokensRequiredForNextLevel(address user) external view returns (uint256) {
        uint256 staked = stakers[user].amount;

        if (staked >= PLATINUM_THRESHOLD) {
            return 0;  // L'utilisateur est déjà au niveau Platinum
        } else if (staked >= GOLD_THRESHOLD) {
            return PLATINUM_THRESHOLD - staked;  // L'utilisateur doit atteindre le niveau Platinum
        } else if (staked >= SILVER_THRESHOLD) {
            return GOLD_THRESHOLD - staked;  // L'utilisateur doit atteindre le niveau Gold
        } else {
            return SILVER_THRESHOLD - staked;  // L'utilisateur doit atteindre le niveau Silver
        }
    }

    function purchaseService(uint256 serviceId) external {
        require(serviceId < services.length, "Invalid service ID");
        Service memory service = services[serviceId];
        require(ft42Token.balanceOf(msg.sender) >= service.price, "Not enough tokens");
        ft42Token.transferFrom(msg.sender, address(this), service.price);
    }
}
