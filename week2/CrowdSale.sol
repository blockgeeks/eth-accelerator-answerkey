pragma solidity ^0.4.24;

import "./IERC20.sol";
import "./SafeMath.sol";

contract Crowdsale {
    using SafeMath for uint256;

    uint256 private cap; // maximum amount of ether to be raised
    uint256 private weiRaised; // current amount of wei raised

    uint256 private rate; // price in wei per smallest unit of token (e.g. 1 wei = 10 smallet unit of a token)
    address private wallet; // wallet to hold the ethers
    IERC20 private token; // address of erc20 tokens

   /**
    * Event for token purchase logging
    * @param purchaser who paid for the tokens
    * @param beneficiary who got the tokens
    * @param value weis paid for purchase
    * @param amount amount of tokens purchased
    */
    event TokensPurchased(
        address indexed purchaser,
        address indexed beneficiary,
        uint256 value,
        uint256 amount
    );

    // -----------------------------------------
    // External functions (DO NOT change the interface!)
    // -----------------------------------------
   /**
    * @param _rate Number of token units a buyer gets per wei
    * @dev The rate is the conversion between wei and the smallest and indivisible token unit.
    * @param _wallet Address where collected funds will be forwarded to
    * @param _token Address of the token being sold
    * @param _cap Max amount of wei to be contributed
    */
    constructor(uint256 _rate, address _wallet, IERC20 _token, uint256 _cap) public {
        require(_rate > 0);
        require(_wallet != address(0));
        require(_token != address(0));
        require(_cap > 0);

        rate = _rate;
        wallet = _wallet;
        token = _token;
        cap = _cap;
    }

    /**
    * @dev Fallback function for users to send ether directly to contract address
    */
    function() external payable {
        buyTokens(msg.sender);
    }

    function buyTokens(address beneficiary) public payable {
        // Below are some general steps that should be done.
        // You need to decide the right order to do them in.
        //  - Validate any conditions
        //  - Calculate number of tokens
        //  - Update any states
        //  - Transfer tokens and emit event
        //  - Forward funds to wallet

        uint256 weiAmount = msg.value;
        _preValidatePurchase(beneficiary, weiAmount);

        // calculate token amount to be created
        uint256 tokens = _getTokenAmount(weiAmount);

        // update state
        weiRaised = weiRaised.add(weiAmount);

        _processPurchase(beneficiary, tokens);
        emit TokensPurchased(
            msg.sender,
            beneficiary,
            weiAmount,
            tokens
        );

        _forwardFunds();
    }

    /**
    * @dev Checks whether the cap has been reached.
    * @return Whether the cap was reached
    */
    function capReached() public view returns (bool) {
        return weiRaised >= cap;
    }

    // -----------------------------------------
    // Internal functions (you can write any other internal helper functions here)
    // -----------------------------------------
    /**
    * @dev Validation of an incoming purchase. Use require statements to revert state when conditions are not met. Use `super` in contracts that inherit from Crowdsale to extend their validations.
    * Example from CappedCrowdsale.sol's _preValidatePurchase method:
    *   super._preValidatePurchase(beneficiary, weiAmount);
    *   require(weiRaised().add(weiAmount) <= cap);
    * @param beneficiary Address performing the token purchase
    * @param weiAmount Value in wei involved in the purchase
    */
    function _preValidatePurchase(
        address beneficiary,
        uint256 weiAmount
    )
        view internal
    {
        require(beneficiary != address(0));
        require(weiAmount != 0);
        require(weiRaised.add(weiAmount) <= cap);
    }

    /**
    * @dev Source of tokens. Override this method to modify the way in which the crowdsale ultimately gets and sends its tokens.
    * @param beneficiary Address performing the token purchase
    * @param tokenAmount Number of tokens to be emitted
    */
    function _processPurchase(
        address beneficiary,
        uint256 tokenAmount
    )
        internal
    {
        token.transfer(beneficiary, tokenAmount);
    }

    /**
    * @dev Override to extend the way in which ether is converted to tokens.
    * @param weiAmount Value in wei to be converted into tokens
    * @return Number of tokens that can be purchased with the specified _weiAmount
    */
    function _getTokenAmount(uint256 weiAmount)
        internal view returns (uint256)
    {
        return weiAmount.mul(rate);
    }

    /**
    * @dev Determines how ETH is stored/forwarded on purchases.
    */
    function _forwardFunds() internal {
        wallet.transfer(msg.value);
    }

}
