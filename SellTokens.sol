pragma solidity ^0.4.24;

import "./SafeMath.sol";
import "./Ownable.sol";
import "./SafeERC20.sol";
import "./ERC20Detailed.sol";


contract SellTokens is Ownable {
  using SafeMath for uint256;
  using SafeERC20 for IERC20;
  
  mapping (address => uint256) public rates; // token_wei / rate = eth_wei

  function SellTokens() {
  }

  function() {
    throw;
  }

  function setRate(address token, uint256 newRate) public onlyOwner {
      rates[token] = newRate;
  }
  
  // deposit ETH to contract
  function deposit() payable {
  }
  
  function withdrawToken(address token, uint256 amount, address withdrawAddress) onlyOwner {
    if (token==0) throw;
    if (withdrawAddress==0) throw;
    if (IERC20(token).balanceOf(this) < amount) throw;
    if (!IERC20(token).transfer(withdrawAddress, amount)) throw;
  }

  function sellToken(address token, uint256 amount) {
    //remember to call Token(address).approve(this, amount) or this contract will not be able to do the transfer on your behalf.
    if (token==0) throw;
    uint256 weiAmount = getWeiAmount(token, amount);
    if (!IERC20(token).transferFrom(msg.sender, this, amount)) throw;
    if (!msg.sender.call.value(weiAmount)()) throw;
  }
  
  function getWeiAmount(address token, uint256 tokenAmount) returns (uint256) {
    if (token==0) throw;
    uint256 rate = rates[token];
    if (rate==0) throw;
    return tokenAmount.mul(10000000000000000).div(_rate); // only for 2decimals tokens
  }

  function balance() constant returns (uint256) {
    return address(this).balance;
  }
  function balanceToken(address token) constant returns (uint256) {
    return IERC20(token).balanceOf(this);
  }
}