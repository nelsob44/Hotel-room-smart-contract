//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.7;

contract HotelRoom {
    address payable public owner;

    //vacant

    //occupied
    enum Statuses { Vacant, Occupied}
    Statuses currentStatus;
    event Occupy(address _occupant, uint _value);

    constructor() {
        owner = payable(msg.sender);
        currentStatus = Statuses.Vacant;
    }

    modifier onlyWhileVacant {
        //check status
        require(currentStatus == Statuses.Vacant, "Currently occupied.");
        _;
    }

    modifier costs (uint _amount) {
        //check price
        require(msg.value >= _amount, "Insufficient Ether provided");
        _;
    }

    receive() external payable onlyWhileVacant costs(2 ether) {
                
        currentStatus = Statuses.Occupied;
        owner.transfer(msg.value);
        emit Occupy(payable(msg.sender), msg.value);
    }
}