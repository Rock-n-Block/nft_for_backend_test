// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract MintableNFT is ERC721Enumerable, ERC721URIStorage, AccessControl {
    
    mapping (string => uint256) public hashToId;

    constructor() ERC721("Mintable NFT","MNFT") {}

    function mint(address owner, string calldata uniqueHash, string calldata mediaURL) external {
        require (hashToId[uniqueHash] == 0, "MintableNFT: This hash is already used");
        uint256 tokenId = totalSupply();
        _safeMint(owner, tokenId);
        _setTokenURI(tokenId, mediaURL);
        hashToId[uniqueHash] = tokenId;
    }

    function tokenURI(uint256 tokenId) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return ERC721URIStorage.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId) public view override(ERC721, ERC721Enumerable, AccessControl) returns (bool) {
        return ERC721.supportsInterface(interfaceId) || ERC721Enumerable.supportsInterface(interfaceId) || AccessControl.supportsInterface(interfaceId);
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        ERC721URIStorage._burn(tokenId);
    }

    function _beforeTokenTransfer(address from, address to, uint256 tokenId) internal override(ERC721, ERC721Enumerable) {
        ERC721Enumerable._beforeTokenTransfer(from, to, tokenId);
    }
}
