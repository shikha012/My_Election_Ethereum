// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <=0.8.17;


contract Election {
     address public owner = msg.sender;
     // Model a Candidate
     struct Candidate {
          uint id;
          string name;
          uint voteCount;
     }
     


     mapping (address => bool) public voters;
     mapping(uint => Candidate) public candidates;
     uint public candidatesCount;



     event votedEvent (string mine, uint indexed _candidateId);


     constructor () {
          addCandidate("Arun Surawat");
          addCandidate("Shoaib husain");
     }

     function addCandidate (string memory _name) public{
          require(msg.sender == owner,"Only Owner can add");
          candidatesCount+=1;
          candidates[candidatesCount] = Candidate(candidatesCount, _name,0);
          Candidate(candidatesCount, _name, 0);
     }

     function vote(uint _candidateId) public{
          // require that they haven't voted before
          require(!voters[msg.sender]);
          // require a valid candidate
          require(_candidateId > 0 && _candidateId <= candidatesCount);
          // record that voter has voted
          voters[msg.sender] = true;
          // update candidate vote Count
          candidates[_candidateId].voteCount ++;
          // trigger voted event
          emit votedEvent("voted right now", _candidateId);
     }

     function winner () public view returns(string memory winnerNameString) {
          for(uint i =0; i <= candidatesCount; i++ ){
             if(candidates[i].voteCount >= 5){
               // return string.concat("this person is the winner ", candidates[i].name);
               return candidates[i].name;
           }else{
                return 'Not declared!';
           }
        }
     }


}