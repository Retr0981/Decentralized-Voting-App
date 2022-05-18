pragma solidity ^0.5.11;

contract Election {
    //model candidate
    struct Candidate{
    uint id;
    string name;
    string party;
    string region;
    uint voteCount;

    }

    //store accounts that has voted
    mapping(address => bool) public voters;
    //store candidates
    //fetch candidate
    mapping(uint => Candidate) public candidates;
    uint public  candidatesCount;

    //Voted Events
    event votedEvent(
    uint indexed _candidatesId
    );

    //Constructor
    constructor () public{
    addCandidates("David Nii Armah",  "APC", "NW");
        addCandidates("Clement Nii Okai Armah", "PDP", "WR");
        addCandidates("Nele Armah", "APGA", "CR");
        addCandidates("Stephanie Armah", "AA", "NR");
        addCandidates("Jesssica Armah", "YP", "GA");
    }

    function addCandidates (string memory _name, string memory _party, string memory _region) private {
      candidatesCount++;
            candidates[candidatesCount] = Candidate(candidatesCount, _name, _party,_region, 0);
    }

    function vote(uint _candidateId) public {
    //require that they have not voted before 
    require(!voters[msg.sender], "voting is only once");
    //require a valid voter
    require(_candidateId > 0 && _candidateId <= candidatesCount, "require a valid candidate");

    //record that voter has voted
    voters[msg.sender] = true;
    //update candidate vote count
    candidates[_candidatesId].voteCount ++;

    //trigger voted events
    emit votedEvent(_candidateId);
    }
}