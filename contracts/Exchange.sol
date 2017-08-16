pragma solidity ^0.4.8;

import "./AToken.sol";
import "./CToken.sol";

contract Exchange is AToken, CToken{
    
    AToken public assetToken;
    CToken public currencyToken;
   
   /* Initialize the exchange*/
    function Exchange(
        AToken addressOfTokenUsedAsAsset,
        CToken addressOfTokenUsedAsCurrency
    ) {
        assetToken = AToken(addressOfTokenUsedAsAsset);
        currencyToken = CToken(addressOfTokenUsedAsCurrency);
    }

    /* Function to send currency from buyer to seller */
    function tradeCurrencyWithAsset(uint _amt, address _buyer, address _seller) {
        currencyToken.CTtransferFrom(_buyer,_seller,_amt);
       }

    /* Function to trade asset from seller to buyer */
    function tradeAssetWithCurrency(uint _amt, address _buyer, address _seller, bytes32 _assetID) {
        assetToken.ATtransfer(_assetID, _seller, _buyer,_amt);
       }
}