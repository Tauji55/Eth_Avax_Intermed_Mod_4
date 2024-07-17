# Project4_Degen_ERC20_Token_Eth_Intermediadiate

Deployment of smart contract to create an ERC20 Token named Degen Token.
This project covers the Assessment 1 of Module 4 in the Eth+Avax Intermediate Course under Metacrafters.

## Description

The code deploys a simple contract which deploys an ERC20 token allowing minting, burning, transferring, and redeeming tokens for predefined collectables, with tracking of redeemed collectables per address and accordingly establishes transactions through the Metamask wallet. The main contract i.e. the  DegenToken.sol file contains the following:
* A constructor:
	* This constructor initializes the token with the name "Degen" and symbol "DGN" by calling the ERC20.sol constructor with these data as arguments.
	* Then it sets up predefined collectables (Books as NFTs in this case) with their names and redeem amounts(price).
```
//The constructor defined within the contract body: 
constructor() ERC20("Degen", "DGN") {
        collectables[1] = Collectable("Mandarin Book NFT", 500);
        collectables[2] = Collectable("Sanskrit Book NFT", 2000);
        collectables[3] = Collectable("Nepali Book NFT", 100);
        collectables[4] = Collectable("Czech Book NFT", 3000);
    }
```

* The function mint():
  * This function mints/generates new tokens and assigns them to the specified address.
  * It takes an address type receiver address and an unsigned integer type amount of tokens to be minted as arguments.
  * It has a modifier name onlyOwner (originally from Ownable.sol) attached to its signature specifying that this function is 'only callable by the contract owner'.
```
//mint function defined within the contract body:
function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
```
* Function burn():
  * This function burns the specified amount of tokens from the caller's balance.
  * It takes the amout of tokens to be burned as input.
  * It requires that this input amount is always less than or equal to the balance at the address of the sender of the function.
```
//The burn() function code: 
function burn(uint256 amount) public {
        require(balanceOf(msg.sender) >= amount, "You don't have enough Degen tokens to burn");
        _burn(msg.sender, amount);
    }
```
* Function decimals():
  * Overrides the default decimals to 0 for this token to return 0.
  * In short the token Degen token could not take fractional values for example 0.5, 0.25 etc. 
```
//The decimals() function code: 
function decimals() public view virtual override returns (uint8) {
        return 0;
    }
```
* Function getBalance():
  * It returns the caller's token balance.
  * It uses the balanceOf function of the ERC20sol imported at the beginning of the contract.
```
//The getBalance() function code: 
function getBalance() public view returns (uint256) {
        return balanceOf(msg.sender);
    }
```
* Function TransferToken():
  * This function transfers the specified amount of tokens from the caller to the receiver.
  * It takes the receiver's address and the amount to be transferred as arguments. 
  * It requires that this input amount be always less than or equal to the balance at the address of the sender of the function.
  * Once the requirement is satisfied, it approves these arguments.
  * Finally it passes these arguments along with the sender's address to the transferFrom() function imported through the ERC20.sol.
```
//The TransferToken() function code: 
function TransferToken(address _receiver, uint amount) external {
        require(balanceOf(msg.sender) >= amount, "Sorry, Not enough Degen tokens available");
        approve(msg.sender, amount);
        transferFrom(msg.sender, _receiver, amount);
    }
```
* Function ():
  * This function lets the user redeem a collectable by burning the required amount of tokens as the price from the user's balance.
  * Then it increases the redeemed count for the caller.
  * It requires the caller to have enough tokens to buy the NFT/collectible book of their choice.
```
//The () function code: 
function redeemToken(uint256 _collectableId) public {
        Collectable memory collectable = collectables[_collectableId];
        require(balanceOf(msg.sender) >= collectable.redeemAmount, "You don't have enough token to redeem this collectable");
        redeemedICollectable[msg.sender][_collectableId] += 1;
        _burn(msg.sender, collectable.redeemAmount);
    }
```
* Function getRedeemedICollectable():
  * It returns the if the the id of the specified collectable a caller has already redeemed taking the collectable id to be checked as input.
  * It requires the collectable id to be valid i.e. the variable _collectableId be greater than 0 as well as _collectableId less than or equal to 4.
```
//The getRedeemedICollectable() function code: 
function getRedeemedICollectable(uint256 _collectableId) public view returns (uint256) {
        require(_collectableId > 0 && _collectableId <= 4, "Invalid collectable id");
        return redeemedICollectable[msg.sender][_collectableId];
    }
```
* Function showAllCollectables():
  * It simply returns a string listing all the collectables available in the store.
```
//The showAllCollectables() function code: 
function showAllCollectables() external pure returns (string memory) {
        return "1. Mandarin Book NFT\n2. Sanskrit Book NFT\n3. Nepali Book NFT\n4. Czech Book NFT\n";
    }
```


### Installing

* User can fork this repository and the clone it to there local system. 
* User is required to install Node.js prior before executing the program.


### Executing program

1. After cloning the Repository, open first terminal and enter the commands: 

```shell
npm i
```
```shell
npm install @openzeppelin/contracts
```
```shell
npm install dotenv
```
```shell
npm install --save-dev hardhat
```

2. create a ".env " file in root directory and write the following in this:
```shell
WALLET_PRIVATE_KEY= your_metamask_private_key
```
Note: replace your_metamask_private_key with the private key of the metamask account which is on fuji network.

3. Now open second terminal and enter the following commands to start the hardhat node::

```shell
npx hardhat node
```

4. Finally in the third terminal, deploy the contract on fuji Network, using the following command:

```shell
npx hardhat run scripts/deploy.js --network fuji
```
This will deploy the contract on fuji successfully.

6. To run it on remix IDE install the following dependency:

```shell
npm install -g @remix-project/remixd
```

7. now type the following command:

```shell
remixd -s "shared folder path" -u https://remix.ethereum.org/
```
Note: replace the shared folder path with the root path of the project.

## Help

* To Understand the Hardhat commands on can use this command in terminal:
```
npx hardhat help
```
* To understand about Avalanche go the the docs section by visiting: https://docs.avax.network/

## Authors

IceTastesNice~Metacrafters

## License

This project is licensed under the [MIT] License - see the LICENSE.md file for details

