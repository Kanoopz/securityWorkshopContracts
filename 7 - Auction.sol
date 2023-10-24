// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

contract Auction
{
  address admin;
  address payable public currentLeader;
  uint256 public highestBid;

  struct Refund 
  {
    address payable addr;
    uint256 amount;
  }

  Refund[] public refunds;

  constructor()
  {
    admin = msg.sender;
  }

  function bid() external payable  
  {
    require(msg.value > highestBid, "Bid not high enough");

    if (currentLeader != address(0)) 
    {
      refunds.push(Refund(currentLeader, highestBid));
    }

    currentLeader = payable(msg.sender);
    highestBid = msg.value;
  }

  function refundAll() external 
  {
    require(msg.sender == admin, "Not admin.");

    for (uint256 i; i < refunds.length; i++) 
    {
        (bool sent, bytes memory data) = (refunds[i].addr).call{value: refunds[i].amount}("");
    }

    delete refunds;
  }
}
