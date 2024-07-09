// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";



contract DegenToken is ERC20, Ownable {

    struct Collectable {
        string name;
        uint256 redeemAmount;
    }

    mapping(uint256 => Collectable) public collectables;
    mapping(address => mapping(uint256 => uint256)) public redeemedICollectable;


    constructor() ERC20("Degen", "DGN") {
        collectables[1] = Collectable("Mandarin Book NFT", 500);
        collectables[2] = Collectable("Sanskrit Book NFT", 2000);
        collectables[3] = Collectable("Nepali Book NFT", 100);
        collectables[4] = Collectable("Czech Book NFT", 3000);
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function burn(uint256 amount) public {
        require(balanceOf(msg.sender) >= amount, "You don't have enough Degen tokens to burn");
        _burn(msg.sender, amount);
    }

    function decimals() public view virtual override returns (uint8) {
        return 0;
    }

    function getBalance() public view returns (uint256) {
        return balanceOf(msg.sender);
    }

    function TransferToken(address _receiver, uint amount) external {
        require(balanceOf(msg.sender) >= amount, "Sorry, Not enough Degen tokens available");
        approve(msg.sender, amount);
        transferFrom(msg.sender, _receiver, amount);
    }

    function redeemToken(uint256 _collectableId) public {
        Collectable memory collectable = collectables[_collectableId];
        require(balanceOf(msg.sender) >= collectable.redeemAmount, "You don't have enough token to redeem this collectable");
        redeemedICollectable[msg.sender][_collectableId] += 1;
        _burn(msg.sender, collectable.redeemAmount);
    }

    function getRedeemedICollectable(uint256 _collectableId) public view returns (uint256) {
        require(_collectableId > 0 && _collectableId <= 4, "Invalid collectable id");
        return redeemedICollectable[msg.sender][_collectableId];
    }

    function showAllCollectables() public view returns (Collectable[] memory) {
        Collectable[] memory _collectables = new Collectable[](4);
        for (uint256 i = 1; i <= 4; i++) {
            _collectables[i - 1] = collectables[i];
        }
        return _collectables;
    }

}