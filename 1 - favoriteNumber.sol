// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

contract FavoriteNumber
{
  address public owner;
  uint256 public myFavoriteNumber;

  constructor(uint256 paramNumber) 
  {
    owner = msg.sender;
    myFavoriteNumber = paramNumber;
  }

  function updateNumber(uint256 newParamNumber) external
  {
    require(msg.sender == owner, "Not owner.");
    myFavoriteNumber = newParamNumber;
  }
}
