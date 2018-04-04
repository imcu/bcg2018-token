pragma solidity ^0.4.19;

import {Ownable} from '../zeppelin/contracts/ownership/Ownable.sol';
import {ERC721Token} from '../zeppelin/contracts/token/ERC721/ERC721Token.sol';

contract Collectibles is Ownable, ERC721Token {

	address public acctAdmin;

	struct TokenMetadata {
		uint32 timestamp;
	}

	// Optional mapping for token metadata
	mapping(uint256 => TokenMetadata) internal metadata;

	function Collectibles(
		address _msigOwner,
		address _acctAdmin) public
		ERC721Token("BlockChangers Participation Token", "BCG") {

		acctAdmin = _acctAdmin;
		transferOwnership(_msigOwner);
	}

	modifier onlyAdmin() {
		require(msg.sender == acctAdmin);
		_;
	}

	function mint(address _to, uint256 _tokenId, uint32 _timestamp) public onlyAdmin {
		super._mint(_to, _tokenId);
		metadata[_tokenId] = TokenMetadata({timestamp : _timestamp});
	}

	function massMint(address[] _to, uint256 []_tokenId) public onlyAdmin {
		for(uint32 index=0; index<_to.length; index++) {
			mint(_to[index], _tokenId[index], uint32(now));
		}
	}

	function setTokenURI(uint256 _tokenId, string _uri) public onlyAdmin {
		super._setTokenURI(_tokenId, _uri);
	}

	function changeAdmin(address _newAdmin) public onlyOwner {
		acctAdmin = _newAdmin;
	}

	function getTokenMetadata(uint256 _tokenId) public view returns (uint32 timestamp) {
		require(exists(_tokenId));
		TokenMetadata storage tm = metadata[_tokenId];
		return (tm.timestamp);
	}
}
