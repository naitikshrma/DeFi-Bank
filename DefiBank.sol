//SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.7.0 <0.9.0;

contract ToyBank
{
    uint totalBankBalance =0;

    function getContractbalance() public view returns(uint)
    {
        return totalBankBalance;
    }

    mapping(address => uint) balances;
    mapping(address => uint) depositimestamps;


    // function addBalance(address userAddress, uint amount) public payable
    // {
    //     balances[userAddress] = amount;      
    //     totalBankBalance = totalBankBalance + amount;
    // // }
    function addBalance() public payable
    {
        balances[msg.sender] = msg.value;
        totalBankBalance = totalBankBalance + msg.value;
        depositimestamps[msg.sender] = block.timestamp;    


    }
    function getBalance(address userAddress) public view returns(uint)
    {
        uint principal = balances[userAddress];
        uint timeElapsed = block.timestamp - depositimestamps[userAddress];
        return principal + uint((principal * 7 * timeElapsed) / (100 * 365 * 24 * 60 * 60)) + 1; //simple interest of 0.07%  per year
    }

    function withdraw() public payable
     {  //who is the reciever
        address payable withdrawTo = payable(msg.sender);
        //how much should they get
        uint amountToTransfer = getBalance(msg.sender);
        //transfer
        withdrawTo.transfer(amountToTransfer);
        totalBankBalance = totalBankBalance - amountToTransfer;
        balances[msg.sender] = 0;
    }
    
    function addMoneyToContract() public payable
     {
        totalBankBalance += msg.value;
     }

     function 
    
}