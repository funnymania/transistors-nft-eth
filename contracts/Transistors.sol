// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

import { Base64 } from "./libraries/Base64.sol";

contract Transistors is ERC721URIStorage {
  // Just a counter.
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

  string partOneSvg = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: sans-serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='";
  string partColorSvg = "' /><text x='50%' y='25%' class='base' dominant-baseline='middle' text-anchor='middle'>";
  string partTwoSvg = "</text><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";
  string partThreeSvg = "</text><text x='50%' y='75%' class='base' dominant-baseline='middle' text-anchor='middle'>";

  string[] firstWords = [" argue ", " fuck ", " heart ", " die ", " spit ", " cantor ", " insole ", " bark ", " hollup ", " absorb ", " transcend ", " amplify ", " hack ", " shimmer ", " illuminate ", " mystify ", " transform ", " untangle ", " unearth ", " RIP ", " rise ", " glitter ", " glisten ", " glare ", " garble ", " fuse ", " recoil ", " snare ", " drain ", " download ", " devour ", " dangle ", " crash ", " hail ", " boost ", " can't ", " ship ", " zing ", " get ", " post ", " drip ", " steal ", " slurp ", " slurm ", " sneak ", " spam ", " sparkle ", " sprinkle " , " roll ", " clone ", " sashay ", " spin ", " whirl ", " hovel ", " dump ", " nag ", " skyrocket ", " reminiscice", " flower ", " bloody ", " devalue ", " taint ", " vex ", "send "]; //verbs
  string[] secondWords = [unicode"😇 ", unicode"😝 ", unicode"😎 ", unicode"😫 ", unicode"😩 ", unicode"🥺 ", unicode"😤 ", unicode"😳 ", unicode"😱 ", unicode"😨 ", unicode"🤫 ", unicode"🤥 ",unicode"😶 ",unicode"😑 ",unicode"🙄 ",unicode"😲 ",unicode"🥱 ",unicode"😴 ",unicode"🤤 ",unicode"😪 ",unicode"😵 ",unicode"🥴 ",unicode"🤮 ",unicode"🤧 ",unicode"🤑 ",unicode"🤠 ", unicode"🤡 ", unicode"🚨 "]; //Emoji
  string[] thirdWords = ["a lot ", "your lies ", "desperately ", "pls ", "with intent ", "consciously ", "zing ", "zap ", "zoom ", "away ", "me ", "this space ", "truly ", "dog money ", "my center ", "bitchness ", "harp " , "with anticipation "]; //adverbs

  string[] colors = ["black", "#40d640", "#d64040", "#d640d6", "#4040d6", "#d6d640"];

  event NewNFTMinted(address sender, uint tokenId);

  constructor() ERC721 ("transistors transit", "TRANSISTORS") {
    console.log("Constructed!");
  } 

  function pickRandomFirstWord(uint tokenId) public view returns (string memory) {
    // Seed.
    uint rand = random(string(abi.encodePacked("FIRST_WORD", Strings.toString(tokenId))));
    rand = rand % firstWords.length;
    return firstWords[rand];
  }

  function pickRandomSecondWord(uint tokenId) public view returns (string memory) {
    // Seed.
    uint rand = random(string(abi.encodePacked("SECOND_WORD", Strings.toString(tokenId))));
    rand = rand % secondWords.length;
    return secondWords[rand];
  }

  function pickRandomThirdWord(uint tokenId) public view returns (string memory) {
    // Seed.
    uint rand = random(string(abi.encodePacked("THIRD_WORD", Strings.toString(tokenId))));
    rand = rand % thirdWords.length;
    return thirdWords[rand];
  }

  function pickRandomColor(uint tokenId) public view returns (string memory) {
    uint rand = random(string(abi.encodePacked("COLOR", Strings.toString(tokenId))));
    rand = rand % colors.length;
    return colors[rand];
  }

  function random(string memory input) internal pure returns (uint) {
    return uint256(keccak256(abi.encodePacked(input)));
  }

  function makeNFT() public {
    uint newItemId = _tokenIds.current();

    require(newItemId < 212, "Maximum distribution reached.");

    string memory first = pickRandomFirstWord(newItemId);
    string memory second = pickRandomSecondWord(newItemId);
    string memory third = pickRandomThirdWord(newItemId);
    string memory color = pickRandomColor(newItemId);
    string memory combinedWord = string(abi.encodePacked(first, second, third));

    // Concatenate to SVG.
    string memory finalSvg = string(abi.encodePacked(partOneSvg, color, partColorSvg, first, partTwoSvg, second, partThreeSvg, third, "</text></svg>"));

    string memory json = Base64.encode(
      bytes(
        string(
          abi.encodePacked(
            '{"name": "',
            // We set the title as generated word.
            combinedWord,
            '", "description": "A highly acclaimed collection of new web.", "image": "data:image/svg+xml;base64, ',
            Base64.encode(bytes(finalSvg)),
            '"}'
          )
        )
      )
    );

    string memory finalTokenUri = string(abi.encodePacked("data:application/json;base64, ", json));

    console.log("\n--------------------------");
    console.log(finalTokenUri);
    console.log("\n--------------------------");

    // Associate ID with sender. 
    _safeMint(msg.sender, newItemId);

    // Set the resource location
    //TODO: Make JSON refer to something which stores transistor
    _setTokenURI(newItemId, finalTokenUri);

    console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);

    // Increment counter.
    _tokenIds.increment();

    emit NewNFTMinted(msg.sender, newItemId);
  }
}
