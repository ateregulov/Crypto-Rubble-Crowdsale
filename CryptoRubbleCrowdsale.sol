pragma solidity ^0.4.24;

import "./Crowdsale.sol";
import "./Ownable.sol";

contract CryptoRubbleCrowdsale is Ownable, Crowdsale {
  constructor(uint256 _rate, address _wallet, address _token) public
    Crowdsale(_rate, _wallet, _token) {
  }
  
  function setRate(uint256 newRate) public onlyOwner {
      rate = newRate;
  }
  
  function sendTokens(address beneficiary, uint256 tokensAmount) public onlyOwner {
    require(beneficiary != address(0));
    _processPurchase(beneficiary, tokensAmount);
    TokenSending(beneficiary, tokensAmount); // event
  }
}