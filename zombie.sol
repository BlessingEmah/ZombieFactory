//SPDX-License-identifier:MIT

pragma solidity  ^0.8.0;

contract ZombieFactory{

      event NewZombie(uint zombieId, string name, uint dna);

    address Zombieleader;
     uint dnaDigits = 16;
    uint dnaModulus =10 ** dnaDigits;

    struct Zombie{
        string name;
        uint dna;
    }

    Zombie[] public zombies;

    uint256 zombieCount =1;

    constructor() {
        Zombieleader =msg.sender;
    }

    modifier Creator(){
        require(Zombieleader ==msg.sender, "Not the leader");
        _;
    }

//instead of using private function to restrict the creation of zombies,
//created a constructor and a modifier function to restrict access
 
mapping(uint => address ) public zombieToOwner;
mapping(address => uint) public ownerZombieCount;

    function createZombie(string memory _name, uint _dna) private Creator {
      
        zombieToOwner[zombieCount] = msg.sender;
        zombies.push(Zombie(_name, _dna));
        ++zombieCount;
    }

    function generateRandomDna(string memory _str) private view  Creator returns(uint) {
         uint rand = uint(keccak256(abi.encodePacked(_str)));
       return rand % dnaModulus;
    }

function createRandomZombie(string memory _name) public {
     require(ownerZombieCount[msg.sender] == 0, "you have called this function");
       uint randDna =generateRandomDna(_name);
       createZombie(_name, randDna);
    }

}

