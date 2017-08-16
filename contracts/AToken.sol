pragma solidity ^0.4.8;
import "./AssetRegistration.sol";


contract AToken is AssetRegistration{
    /* Public variables of the token */
    address public ATOwner;

   /* This creates an array with asset balances to asset ids and wallet address */
    mapping (bytes32 => mapping (address => uint256)) public balanceATOfUsers;
    
    /* This generates a public event on the blockchain that will notify clients */
    event assetTransfer(address indexed from, address indexed to, uint256 value, bytes32 assetName);

    /* Initializes contract with initial supply tokens to the creator of the contract */
    function AToken() {
             ATOwner = msg.sender; 
    }

    /* Function to mint tokens as per the registered asset's details with the seller's wallet address*/
    function setAToken(address _assetOwner, bytes32 _assetID, uint256 _tokensToMint) returns (bool success){
        balanceATOfUsers[_assetID][_assetOwner] = _tokensToMint;
        return true;
    }

    /* Function to get asset balance of an user by user's wallet address and asset's asset id*/
    function getATBalanceOfUser(address _holder, bytes32 _assetID) constant returns(uint256){
        uint256 _bal = balanceATOfUsers[_assetID][_holder];
        return _bal;
    }

    /* Function to trade asset from seller to buyer */
    function ATtransfer( bytes32 _assetID, address _from, address _to, uint256 _value) returns (bool success) {
        if (_to == 0x0) throw;                               // Prevent transfer to 0x0 address
        if (balanceATOfUsers[_assetID][_from] < _value) throw;           // Check if the sender has enough
        if (balanceATOfUsers[_assetID][_to] + _value < balanceATOfUsers[_assetID][_to]) throw; // Check for overflows
        balanceATOfUsers[_assetID][_from] -= _value;                     // Subtract from the sender
        balanceATOfUsers[_assetID][_to] += _value;   
        assetTransfer(ATOwner, _to, _value, _assetID);                   // Notify anyone listening that this transfer took place
        AssetRegistration.updateAssetQuantityOfSeller(_from,_assetID,_value);
    }   
}