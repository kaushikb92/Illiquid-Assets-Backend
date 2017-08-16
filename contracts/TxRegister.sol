pragma solidity ^0.4.8;

contract TxRegister{

    /* Stracture to hold each trade's details*/
    struct receipt{
        bytes32 txid1;
        bytes32 txid2;
        address receiverAddress;
        address senderAddress;
        bytes32 assetID;
        uint assetQuantity;
        uint256 totalAmount;
    }

    /* This will create an array of stracures to hold trade details*/ 
    receipt[] public receipts; 

    /* Different mapping definations */
    mapping(address => receipt) public transactionsByAddress;           //Map user's associated wallet address with his trade receipts 

    /* Function to add a new transaction*/
    function addTx (bytes32 _assetTxid, bytes32 _currencyTxid, address _from, address _to, bytes32 _assetID, uint _assetQuantity, uint256 _totalAmount) returns (bool success){
        receipt memory newReceipt;
        newReceipt.txid1 = _assetTxid;
        newReceipt.txid2 = _currencyTxid;
        newReceipt.receiverAddress = _to;
        newReceipt.senderAddress = _from;
        newReceipt.assetID = _assetID;
        newReceipt.assetQuantity = _assetQuantity;
        newReceipt.totalAmount = _totalAmount;
        receipts.push(newReceipt);

        transactionsByAddress[_from] = newReceipt;
        transactionsByAddress[_to] = newReceipt;
        
        return true;
    }

    /* Function to query a transaction recept by associated wallet address */
    function getTxByAddress(address _addr) constant returns(bytes32, bytes32 , address , address , bytes32 , uint , uint256){
        return (transactionsByAddress[_addr].txid1,transactionsByAddress[_addr].txid2,transactionsByAddress[_addr].receiverAddress,transactionsByAddress[_addr].senderAddress,transactionsByAddress[_addr].assetID,transactionsByAddress[_addr].assetQuantity,transactionsByAddress[_addr].totalAmount);
    }

    /* Function to get all transaction receipts*/
    function getAllTx() constant returns (bytes32[] , bytes32[], address[] , address[] , bytes32[] , uint[] , uint256[]) {

        bytes32[] memory txids1 = new bytes32[](receipts.length);
        bytes32[] memory txids2 = new bytes32[](receipts.length);
        address[] memory senders = new address[](receipts.length);
        address[] memory receivers = new address[](receipts.length);
        bytes32[] memory assetIDs = new bytes32[](receipts.length);
        uint256[] memory totalAmounts = new uint256[](receipts.length);
        uint[] memory assetQuantities = new uint[](receipts.length);
        
        for (var i = 0; i < receipts.length; i++) {
 
            receipt memory currentReceipt;
            currentReceipt = receipts[i];
            txids1[i] = currentReceipt.txid1;
            txids2[i] = currentReceipt.txid2;
            senders[i] = currentReceipt.senderAddress;
            receivers[i] = currentReceipt.receiverAddress;
            assetIDs[i] = currentReceipt.assetID;
            assetQuantities[i] = currentReceipt.assetQuantity;
            totalAmounts[i] = currentReceipt.totalAmount;
        }
    return(txids1,txids2,senders, receivers, assetIDs, assetQuantities, totalAmounts);
    }

}