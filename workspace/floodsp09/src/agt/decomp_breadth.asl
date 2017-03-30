count_actions([],NumberOfActions,NumberOfActions).
count_actions([Action|ActionList],NumberOfActions,NumberOfActionsAux) :- count_actions(ActionList,NumberOfActions+1,NumberOfActionsAux).

all_relevant([],PList,PList).
all_relevant([Goal|GList],PList,AuxList) :- .relevant_plans({+!Goal},Plans)  & .concat(PList,Plans,Aux)  & all_relevant(GList,Aux,AuxList).

+task(Goal,CNPBoard,TaskId)
	: .my_name(Me)
<- 
//	Timeout = Deadline * 10 / 100;
	lookupArtifact(CNPBoard,BoardId);
	focus(BoardId);
	.relevant_plans({+!Goal},Plans);
	if (Plans == [])
	{
//		.print("Not eligible.");
		Bid = [-1];
	}
	else {
//		!!timeout(Timeout,TaskId);
		jia.convert(Plans,Plans2);
		.length(Plans2,CurrentWidth);
		!calculate_bid(Plans2,[],0,0,0,CurrentWidth,TaskId,Bid);
	}
//	.print("My bid for goal: ",Goal," is = ",Bid);
	.term2string(Bid,BidS);
	bid(BidS,Me,Goal)[artifact_id(BoardId)];
	.

+task(Goal,CNPBoard,Role,TaskId)
	: .my_name(Me) & role(R)
<- 
//	Timeout = Deadline * 10 / 100;
	lookupArtifact(CNPBoard,BoardId);
	focus(BoardId);
//	.print("New goal announced: ",Goal," TaskId: ",TaskId);
	if (R == Role) {
		Bid = [-1];
	}
	else {
		.relevant_plans({+!Goal},Plans);
		if (Plans == [])
		{
	//		.print("Not eligible.");
			Bid = [-1];
		}
		else {
	//		!!timeout(Timeout,TaskId);
			jia.convert(Plans,Plans2);
			.length(Plans2,CurrentWidth);
			!calculate_bid(Plans2,[],0,0,0,CurrentWidth,TaskId,Bid);
		}
	}
//	.print("My bid for goal: ",Goal," is = ",Bid);
	.term2string(Bid,BidS);
	bid(BidS,Me,Goal)[artifact_id(BoardId)];	
	.
  
+!calculate_bid(List,List2,NumberOfPlans,NumberOfActions,Depth,Width,TaskId,Bid)
	: timeout(TaskId)
<-
//	.print(">>> Timeout expired for TaskId ",TaskId);
//	.print("Number of plans: ",NumberOfPlans);
//    .print("Number of actions: ",NumberOfActions);
//    .print("Plantree max depth: ",Depth);
//    .print("Plantree max width: ",Width);
    Bid = [1,NumberOfPlans,NumberOfActions,Depth,Width];
	.

+!calculate_bid([],[],NumberOfPlans,NumberOfActions,Depth,Width,TaskId,Bid)
<-
//	.print(">>> Calculated bid in time for TaskId ",TaskId);
//	.print("Number of plans: ",NumberOfPlans);
//    .print("Number of actions: ",NumberOfActions);
//    .print("Plantree max depth: ",Depth);
//    .print("Plantree max width: ",Width);
    Bid = [0,NumberOfPlans,NumberOfActions,Depth,Width];
    .

+!calculate_bid([Plan|List],List2,NumberOfPlans,NumberOfActions,Depth,CurrentWidth,TaskId,Bid)
	: jia.decomposeBody(Plan,Goals,Actions) & count_actions(Actions,NumberOfActions,NumberOfActionsR)
<-
	!decompose_goals(Goals,List,List2,NumberOfPlans,NumberOfActionsR,Depth,CurrentWidth,TaskId,Bid).

+!calculate_bid([],List2,NumberOfPlans,NumberOfActions,Depth,CurrentWidth,TaskId,Bid) 
	: .length(List2,NewWidth) & (NewWidth > CurrentWidth)
<-
	!calculate_bid(List2,[],NumberOfPlans,NumberOfActions,Depth+1,NewWidth,TaskId,Bid).
	
+!calculate_bid([],List2,NumberOfPlans,NumberOfActions,Depth,CurrentWidth,TaskId,Bid) 
<-	
	!calculate_bid(List2,[],NumberOfPlans,NumberOfActions,Depth+1,CurrentWidth,TaskId,Bid).

+!decompose_goals([],List,List2,NumberOfPlans,NumberOfActions,Depth,CurrentWidth,TaskId,Bid)
<-
	!calculate_bid(List,List2,NumberOfPlans+1,NumberOfActions,Depth,CurrentWidth,TaskId,Bid).

+!decompose_goals(Goals,List,List2,NumberOfPlans,NumberOfActions,Depth,CurrentWidth,TaskId,Bid) 
:  all_relevant(Goals,[],PList)  & .concat(List2,PList,AuxList)
<-
	!calculate_bid(List,AuxList,NumberOfPlans+1,NumberOfActions,Depth,CurrentWidth,TaskId,Bid).