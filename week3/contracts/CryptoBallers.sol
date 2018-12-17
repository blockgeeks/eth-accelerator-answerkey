pragma solidity ^0.4.24;

import './ERC721.sol';

contract CryptoBallers is ERC721 {

    struct Baller {
        string name;
        uint level;
        uint offenseSkill;
        uint defenseSkill;
        uint winCount;
        uint lossCount;

    }

    address owner;
    Baller[] public ballers;
    mapping(address => bool) public claimedFreeBaller;
    uint ballerFee = 0.10 ether;

    modifier onlyOwnerOf(uint256 _tokenId) {
        require(ownerOf(_tokenId) == msg.sender);
        _;
    }

    modifier onlyOwner() {
        require(owner == msg.sender);
        _;
    }

    modifier aboveLevel(uint _level, uint _ballerId) {
        require(ballers[_ballerId].level > _level);
        _;
    }

    constructor() public {
        owner = msg.sender;
    }

    function claimFreeBaller() public {
        require(!claimedFreeBaller[msg.sender]);
        _createBaller("Free Baller", 1, 50, 45);
        claimedFreeBaller[msg.sender] = true;
    }

    function buyBaller() public payable {
        require(msg.value >= ballerFee);
        _createBaller("I bought this baller", 10, 60, 50);
    }

    function playBall(uint _ballerId, uint _targetId) onlyOwnerOf(_ballerId) public {
        Baller storage baller1 = ballers[_ballerId];
        Baller storage baller2 = ballers[_targetId];
        if (baller1.offenseSkill > baller2.defenseSkill) {
            baller1.winCount = baller1.winCount.add(1);
            baller1.level = baller1.level.add(1);
            baller2.lossCount = baller2.lossCount.add(1);
            if (baller1.level == 5) {
                (uint level, uint offense, uint defense) = _breedBallers(baller1, baller2);
                _createBaller("Custom baller", level, offense, defense);
            }
        } else {
            baller1.lossCount = baller1.lossCount.add(1);
            baller2.winCount = baller2.winCount.add(1);
        }
    }

    function changeName(uint _ballerId, string _newName) external aboveLevel(2, _ballerId) onlyOwnerOf(_ballerId) {
        ballers[_ballerId].name = _newName;
    }


    function _createBaller(string _name, uint _level, uint _offenseSkill, uint _defenseSkill) internal {
        uint id = ballers.length;
        ballers.push(Baller(_name, _level, _offenseSkill, _defenseSkill, 0, 0));
        _mint(msg.sender, id);
    }

    function _breedBallers(Baller _baller1, Baller _baller2) internal pure returns (uint, uint, uint) {
        uint level = _baller1.level.add(_baller2.level).div(2);
        uint attack = _baller1.offenseSkill.add(_baller2.offenseSkill).div(2);
        uint defense = _baller1.defenseSkill.add(_baller2.defenseSkill).div(2);
        return (level, attack, defense);
    }
}
