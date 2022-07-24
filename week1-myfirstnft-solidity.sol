// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts@4.7.1/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.7.1/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts@4.7.1/token/ERC721/extensions/ERC721URIStorage.sol";    
import "@openzeppelin/contracts@4.7.1/utils/Counters.sol";

contract SimmonWeek1 is ERC721, ERC721Enumerable, ERC721URIStorage {
    using Counters for Counters.Counter;


    Counters.Counter private _tokenIdCounter;
    uint MAX_SUPPLY = 1000;
    uint MAX_ALLOWED_PER_USER = 5;

    mapping(address => uint) public usersNft;

    constructor() ERC721("Simmon-Week1", "SMw1") {}

    function safeMint(address to, string memory uri) public {
        uint256 tokenId = _tokenIdCounter.current();
        require(usersNft[to] < MAX_ALLOWED_PER_USER, "You are not allowed to mint more NFT");
        require(tokenId <= MAX_SUPPLY, "I'm sorry, all NFTs have been minted");
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
        uint countUserNft = usersNft[to];
        usersNft[to] = countUserNft + 1;
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
