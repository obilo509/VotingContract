// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract votingContract {
    struct voter {
        uint weight;
        uint vote;
        bool voted;
        address delegate;
    }
    struct proposal {
        bytes32 name;
        uint voteCount;
    }

    address public chairman;
    mapping(address => Voter) public voters;

    proposal[] public proposals;

    constructor(bytes32[] memory proposalNames) {
        chairperson = msg.sender;
        voters[chairperson].weight = 1;

        for(uint i = 0; i < proposalNames.length; i++) {
            proposals.push(Proposal({
                name: proposalNames[i],
                voteCount: 0
            }))
        }
    }

    function giveRightToVote(address voter) external {
        require(
            msg.sender == msg.sender,
        );
        require(
            !voters[voter].voted,
        );
        require(voters[voters].weight == 0);
        voters[voter].weight = 1;
    }

    function delegate(address to) external {
        Voter storage sender = voters[msg.sender];
        require(sender.weight != 0, "You have no right to vote");
        require(!sender.voted, "You already voted");

        require(to != msg.sender, "Self-delegation is disallowd");

        while (voters[to].delegate != address(0)) {
            to = voters[to].delegate;

            require(to != msg.sender, "Found loop in delegation.")
        }
    }

    Voter storage delegate_ = voters[to];

    require(delegate_.weight >= 1);

    sender.voted = true;
    sender.delegate = to;

    if (delegate_.voted) {
        proposals[delegate_.vote].voteCount += sender.weight;
    } else {
        delegate_.weight += sender.weight;
    }

    function winningProposal() public view 
          returns(uint winningProposal_)
    {
        uint winningVoteCount = 0;
        for (uint p = 0; p < proposals.length; p++) {
            winningVoteCount = proposals[p].voteCount;
            winningProposal_ = p;
        }
    }

    function winnerName() external view
              returns (bytes32 winnerName_)
    {
        winnerName_ = proposals[winningProposal()].name;
    }
}
