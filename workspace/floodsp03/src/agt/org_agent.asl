{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

/* Initial beliefs and rules */
count(0).
replan(0).
max_bid_time(50).
round(0).

goal(get_picture(disaster1)).
goal(get_picture(disaster2)).
goal(get_picture(disaster3)).
goal(get_picture(disaster4)).
goal(get_picture(disaster5)).
goal(get_picture(disaster6)).
goal(get_picture(disaster7)).
goal(deliver_box(box1,area20)).
goal(deliver_box(box2,area14)).
goal(deliver_box(box3,area3)).
goal(deliver_box(box4,area19)).
goal(deliver_sample(cdm2,area10)).
goal(deliver_sample(cdm1,area4)).
goal(deliver_sample(cdm3,area5)).
goal(deliver_sample(cdm3,area17)).

select_bid0([],bid(AuxBid,AuxBidAgent,AuxGoal),bid(BidWinner,BidAgentWinner,GoalWinner)) :- BidWinner = AuxBid & BidAgentWinner = AuxBidAgent & GoalWinner = AuxGoal.
select_bid0([bid(Bid,BidAgent,Goal)|Bids],bid(AuxBid,AuxBidAgent,AuxGoal),BidWinner) :- .nth(0,Bid,L0) & L0 \== -1 & L0 == 0 & .nth(2,Bid,L2) & L2 < AuxBid & not awarded(BidAgent,_) & select_bid0(Bids,bid(L2,BidAgent,Goal),BidWinner).
select_bid0([bid(Bid,BidAgent,Goal)|Bids],bid(AuxBid,AuxBidAgent,AuxGoal),BidWinner) :- select_bid0(Bids,bid(AuxBid,AuxBidAgent,AuxGoal),BidWinner).

select_bid0_ignore([],bid(AuxBid,AuxBidAgent,AuxGoal),bid(BidWinner,BidAgentWinner,GoalWinner)) :- BidWinner = AuxBid & BidAgentWinner = AuxBidAgent & GoalWinner = AuxGoal.
select_bid0_ignore([bid(Bid,BidAgent,Goal)|Bids],bid(AuxBid,AuxBidAgent,AuxGoal),BidWinner) :- .nth(0,Bid,L0) & L0 \== -1 & L0 == 0 & .nth(2,Bid,L2) & L2 < AuxBid & select_bid0_ignore(Bids,bid(L2,BidAgent,Goal),BidWinner).
select_bid0_ignore([bid(Bid,BidAgent,Goal)|Bids],bid(AuxBid,AuxBidAgent,AuxGoal),BidWinner) :- select_bid0_ignore(Bids,bid(AuxBid,AuxBidAgent,AuxGoal),BidWinner).

select_bid1([],bid(AuxBid,AuxBidAgent,AuxGoal),bid(BidWinner,BidAgentWinner,GoalWinner)) :- BidWinner = AuxBid & BidAgentWinner = AuxBidAgent & GoalWinner = AuxGoal.
select_bid1([bid(Bid,BidAgent,Goal)|Bids],bid(AuxBid,AuxBidAgent,AuxGoal),BidWinner) :- .nth(0,Bid,L0) & L0 \== -1 & L0 == 1 & .nth(4,Bid,L4) & L4 > AuxBid & not awarded(BidAgent,_) & select_bid1(Bids,bid(L4,BidAgent,Goal),BidWinner).
select_bid1([bid(Bid,BidAgent,Goal)|Bids],bid(AuxBid,AuxBidAgent,AuxGoal),BidWinner) :- select_bid1(Bids,bid(AuxBid,AuxBidAgent,AuxGoal),BidWinner).

select_bid1_ignore([],bid(AuxBid,AuxBidAgent,AuxGoal),bid(BidWinner,BidAgentWinner,GoalWinner)) :- BidWinner = AuxBid & BidAgentWinner = AuxBidAgent & GoalWinner = AuxGoal.
select_bid1_ignore([bid(Bid,BidAgent,Goal)|Bids],bid(AuxBid,AuxBidAgent,AuxGoal),BidWinner) :- .nth(0,Bid,L0) & L0 \== -1 & L0 == 1 & .nth(4,Bid,L4) & L4 > AuxBid & select_bid1_ignore(Bids,bid(L4,BidAgent,Goal),BidWinner).
select_bid1_ignore([bid(Bid,BidAgent,Goal)|Bids],bid(AuxBid,AuxBidAgent,AuxGoal),BidWinner) :- select_bid1_ignore(Bids,bid(AuxBid,AuxBidAgent,AuxGoal),BidWinner).

/* Initial goals */
!announce_goals.

/* Plans */
+!announce_goals
<- 
	jia.time(Start);
	+time(Start);
	if (replan(0)) {
		.count(goal(_),NumberGoals);
		-+ngoals(NumberGoals);
		for (goal(Goal)) {
			-goal(Goal);
			!!announce(Goal);
		}
	}
	else {
		.count(goal(_,_),NumberGoals);
//		.print("ANNOUNCING REPLAN");
		?round(Round);
		-+round(Round+1);
		-+ngoals(NumberGoals);		
		-replan(_);
		+replan(0);
		for (goal(Goal,Role)) {
			for (.member(G,Goal)) {
			-goal(G,Role);
			!!announce_replan(G,Role);				
			}
		}
	}
	.

+!announce(Goal)
	: max_bid_time(Time)
<-
	announce(Goal,Time,CNPBoardName);
//	.print("Announced: ",Goal," on ",CNPBoardName);
	getBids(Bids) [artifact_name(CNPBoardName)];
	if (.length(Bids) \== 0) {	
//		.print("Got bids (",.length(Bids),") for task ",CNPBoardName," with the goal ",Goal," List ",Bids);
		!select_bid(Bids);
	}
	else {
//		.print("No bids.");
	}
	.
	
+!announce_replan(Goal,Role)
	: max_bid_time(Time)
<-
	announce_replan(Goal,Time,Role,CNPBoardName);
//	.print("Announced: ",Goal," on ",CNPBoardName);
	getBids(Bids) [artifact_name(CNPBoardName)];
	if (.length(Bids) \== 0) {	
//		.print("Got bids (",.length(Bids),") for task ",CNPBoardName," with the goal ",Goal," List ",Bids);
		!select_bid(Bids);
	}
	else {
//		.print("No bids.");
	}
	.	

@select_bid[atomic]
+!select_bid(Bids)
	: ngoals(NumberGoals) & round(Round)
<-
	if (not allBids(_)) {
		+allBids([Bids]);
		if (1 == NumberGoals) {
//	    	.print("Complete bid list ",Bids);
	    	-allBids(_);
	    	if (.substring("bid([0,",Bids)) {
	    		?select_bid0_ignore(Bids,bid(99999,99999,99999),bid(Bid,Agent,Goal));
	    	}
	    	else {
	    		?select_bid1_ignore(Bids,bid(0,0,0),bid(Bid,Agent,Goal));
	    	}
//			.print("Bid that won: ",Bid," Agent: ",Agent," Goal: ",Goal);
			.send(Agent,tell,winner([Goal]));
			.broadcast(achieve,start_planner);
			?time(Start);
			jia.time(Start,Final);
			+time_goal_alloc((Final-Start)/1000000000.0);
			.print("Elapsed time goal allocation round ",Round,": ",(Final-Start)/1000000000.0);
			-time(Start);
			jia.time(StartNew);
			+time(StartNew);			
    	}
	}
	else {
		?allBids(AuxBidList);
		.concat(AuxBidList,[Bids],BidList);
		-+allBids(BidList);
		 ?allBids(BidList);
	    if (.length(BidList) == NumberGoals) {
	    	+auxList([]);
//	    	.print("Complete bid list ",BidList);
	    	-allBids(_);
	    	for (.range(I,0,.length(BidList)-1)) {
	    		.nth(I,BidList,X);
	    		if (.substring([-1],X)) {
	    			if (.substring("bid([0,",X)) {
	    				?select_bid0(X,bid(99999,99999,99999),bid(Bid,Agent,Goal));
	    				if (Agent == 99999) {
	    					?select_bid1(X,bid(0,0,0),bid(Bid3,Agent3,Goal3));
	    					if (Agent3 == 0) {
		    					?select_bid0_ignore(X,bid(99999,99999,99999),bid(Bid2,Agent2,Goal2));
//		    					.print("Bid that won: ",Bid2," Agent: ",Agent2," Goal: ",Goal2);
						    	?awarded(Agent2,List);
						    	-awarded(Agent2,List);
						    	.concat(List,[Goal2],NewList);
						    	+awarded(Agent2,NewList);
		    				}
		    				else {
//		    					.print("Bid that won: ",Bid3," Agent: ",Agent3," Goal: ",Goal3);
				    			+awarded(Agent3,[Goal3]);
		    				}
						}
						else {
//	    					.print("Bid that won: ",Bid," Agent: ",Agent," Goal: ",Goal);
			    			+awarded(Agent,[Goal]);						
						}
	    			}
	    			else {
	    				?select_bid1(X,bid(0,0,0),bid(Bid,Agent,Goal));
	    				if (Agent == 0) {
	    					?select_bid1_ignore(X,bid(0,0,0),bid(Bid2,Agent2,Goal2));
//	    					.print("Bid that won: ",Bid2," Agent: ",Agent2," Goal: ",Goal2);
					    	?awarded(Agent2,List);
					    	-awarded(Agent2,List);
					    	.concat(List,[Goal2],NewList);
					    	+awarded(Agent2,NewList);
	    				}
	    				else {
//	    					.print("Bid that won: ",Bid," Agent: ",Agent," Goal: ",Goal);
			    			+awarded(Agent,[Goal]);
	    				}
	    			}
	    		}
	    		else {
	    			?auxList(AuxL);
	    			if (AuxL == []) {
	    				-auxList([]);
	    				+auxList([X]);
	    			}
	    			else {
	    				?auxList(Aux2);
	    				.concat(Aux2,[X],Aux3);
	    				-auxList(Aux2);
	    				+auxList(Aux3);
	    			}
	    		}
		    }
		    ?auxList(Aux);
		    -auxList(Aux);
		    for (.range(I,0,.length(Aux)-1)) {
		    	.nth(I,Aux,X);
    			if (.substring("bid([0,",X)) {
    				?select_bid0(X,bid(99999,99999,99999),bid(Bid,Agent,Goal));
    				if (Agent == 99999) {
    					?select_bid1(X,bid(0,0,0),bid(Bid3,Agent3,Goal3));
    					if (Agent3 == 0) {
	    					?select_bid0_ignore(X,bid(99999,99999,99999),bid(Bid2,Agent2,Goal2));
	    					.print("Bid that won: ",Bid2," Agent: ",Agent2," Goal: ",Goal2);
					    	?awarded(Agent2,List);
					    	-awarded(Agent2,List);
					    	.concat(List,[Goal2],NewList);
					    	+awarded(Agent2,NewList);
	    				}
	    				else {
//	    					.print("Bid that won: ",Bid3," Agent: ",Agent3," Goal: ",Goal3);
			    			+awarded(Agent3,[Goal3]);
	    				}
					}
					else {
//    					.print("Bid that won: ",Bid," Agent: ",Agent," Goal: ",Goal);
		    			+awarded(Agent,[Goal]);						
					}
    			}
    			else {
    				?select_bid1(X,bid(0,0,0),bid(Bid,Agent,Goal));
    				if (Agent == 0) {
    					?select_bid1_ignore(X,bid(0,0,0),bid(Bid2,Agent2,Goal2));
    					.print("Bid that won: ",Bid2," Agent: ",Agent2," Goal: ",Goal2);
				    	?awarded(Agent2,List);
				    	-awarded(Agent2,List);
				    	.concat(List,[Goal2],NewList);
				    	+awarded(Agent2,NewList);
    				}
    				else {
//    					.print("Bid that won: ",Bid," Agent: ",Agent," Goal: ",Goal);
		    			+awarded(Agent,[Goal]);
    				}
    			}		    	
		    }
		    for (awarded(Agent,List)) {
//		    	.print("Agent ",Agent," to plan for ",List);
		    	.send(Agent,tell,winner(List));
    			-awarded(Agent,List);
			}
			.broadcast(achieve,start_planner);
			?time(Start);
			jia.time(Start,Final);
			+time_goal_alloc((Final-Start)/1000000000.0);
			.print("Elapsed time goal allocation round ",Round,": ",(Final-Start)/1000000000.0);
			-time(Start);
			jia.time(StartNew);
			+time(StartNew);
	    }
	}
	.
	
+!replan(Goal,Role) : count(C) & replan(R) & C + R == 14 & round(Round) & time(Start)
<-
	-count(C);
	+count(0);
	if (R == 0) {
		-+replan(1);
	}
	jia.time(Start,Final);
	+time_ind_plan((Final-Start)/1000000000.0);
	.print("Elapsed time individual planning round ",Round,": ",(Final-Start)/1000000000.0);
	-time(Start);	
	+goal(Goal,Role);
	!announce_goals;
	.
@replan[atomic]
+!replan(Goal,Role) : replan(R) & round(Round)
<-  +goal(Goal,Role);
	-+replan(R+1).

+!count : count(C) & C == 14 & time(Start) & replan(0) & round(Round)
<-
	jia.time(Start,Final);
	+time_ind_plan((Final-Start)/1000000000.0);
	.print("Elapsed time individual planning round ",Round,": ",(Final-Start)/1000000000.0);
	-time(Start);
	+total_plan(0);
	for (time_ind_plan(TP1)) {
		?total_plan(TP2);
		-+total_plan(TP1+TP2);
	}
	?total_plan(TimeP);
	+total_alloc(0);
	for (time_goal_alloc(TA1)) {
		?total_alloc(TA2);
		-+total_alloc(TA1+TA2);
	}
	?total_alloc(TimeG);
	.print("Total elapsed time: ",TimeG+TimeP);
	.stopMAS;
	.
+!count : count(C) & replan(R) & C + R == 14  & round(Round) & time(Start)
<-
	-count(C);
	+count(0);
	if (R == 0) {
		-+replan(1);
	}	
	jia.time(Start,Final);
	+time_ind_plan((Final-Start)/1000000000.0);
	.print("Elapsed time individual planning round ",Round,": ",(Final-Start)/1000000000.0);
	-time(Start);	
	!announce_goals;
	.
@count[atomic]
+!count : count(C)
<- -+count(C+1).
