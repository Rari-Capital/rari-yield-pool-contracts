// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.5.17;

import "@openzeppelin/contracts-ethereum-package/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/token/ERC20/SafeERC20.sol";

import "../../external/mstable/IMasset.sol";

/**
 * @title MStableExchangeController
 * @author David Lucid <david@rari.capital> (https://github.com/davidlucid)
 * @dev This library handles minting and redeeming of mStable's mUSD token.
 */
library MStableExchangeController {
    using SafeMath for uint256;
    using SafeERC20 for IERC20;

    address constant private MUSD_TOKEN_CONTRACT = 0xe2f2a5C287993345a840Db3B0845fbC70f5935a5;
    IMasset constant private _mUsdToken = IMasset(MUSD_TOKEN_CONTRACT);

    /**
     * @dev Returns the mUSD swap fee (scaled by 1e18).
     */
    function getSwapFee() external view returns (uint256) {
        return _mUsdToken.swapFee();
    }

    /**
     * @dev Approves tokens to the mUSD token contract without spending gas on every deposit.
     * @param erc20Contract The ERC20 contract address of the token.
     * @param amount Amount of the specified token to approve to the mUSD token contract.
     */
    function approve(address erc20Contract, uint256 amount) external {
        IERC20 token = IERC20(erc20Contract);
        uint256 allowance = token.allowance(address(this), MUSD_TOKEN_CONTRACT);
        if (allowance == amount) return;
        if (amount > 0 && allowance > 0) token.safeApprove(MUSD_TOKEN_CONTRACT, 0);
        token.safeApprove(MUSD_TOKEN_CONTRACT, amount);
        return;
    }

    /**
     * @dev Mints mUSD tokens in exchange for the specified amount of the specified token.
     * @param erc20Contract The ERC20 contract address of the token to be exchanged.
     * @param inputAmount The amount of input tokens to be exchanged for mUSD.
     * @return The amount of mUSD tokens minted.
     */
    function mint(address erc20Contract, uint256 inputAmount) external returns (uint256) {
        require(inputAmount > 0, "Input amount must be greater than 0.");
        uint256 mAssetMinted = _mUsdToken.mint(erc20Contract, inputAmount);
        require(mAssetMinted > 0, "Error calling mint on mStable mUSD token: no mUSD minted.");
        return mAssetMinted;
    }

    /**
     * @dev Redeems mUSD tokens in exchange for the specified amount of the specified token.
     * @param erc20Contract The ERC20 contract address of the token to be withdrawn.
     * @param outputAmount The amount of output tokens to be exchanged from mUSD.
     * @return The amount of mUSD tokens redeemed.
     */
    function redeem(address erc20Contract, uint256 outputAmount) external returns (uint256) {
        require(outputAmount > 0, "Output amount must be greater than 0.");
        uint256 mAssetRedeemed = _mUsdToken.redeem(erc20Contract, outputAmount);
        require(mAssetRedeemed > 0, "Error calling redeem on mStable mUSD token: no mUSD redeemed.");
        return mAssetRedeemed;
    }

    /**
     * @dev Redeems mUSD tokens in exchange for the specified amount of the specified token.
     * @param inputErc20Contract The ERC20 contract address of the token to be exchanged for mUSD.
     * @param outputErc20Contract The ERC20 contract address of the token to be exchanged from mUSD.
     * @param inputAmount The amount of input tokens to be exchanged for mUSD.
     * @return The amount of output tokens.
     */
    function swap(address inputErc20Contract, address outputErc20Contract, uint256 inputAmount) external returns (uint256) {
        require(inputAmount > 0, "Input amount must be greater than 0.");
        uint256 outputAmount = _mUsdToken.swap(inputErc20Contract, outputErc20Contract, inputAmount, address(this));
        require(outputAmount > 0, "Error calling redeem on mStable mUSD token: output amount not greater than 0.");
        return outputAmount;
    }
}
