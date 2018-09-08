pragma solidity ^0.4.24;

import "./ERC20Mintable.sol";
import "./ERC20Detailed.sol";


contract CryptoRubbleToken is ERC20Mintable, ERC20Detailed {
    
  constructor() public ERC20Detailed("Crypto-Rubble", "CRUB", 2) {
  }
  
}