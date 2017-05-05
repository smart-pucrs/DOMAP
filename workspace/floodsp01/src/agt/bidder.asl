//+winner(Goal)
//	: .my_name(Me) & role(Role)
//<- 
////	.print("Awarded goals ",Goal);
//	+goal(Goal);
//	.count(goal(_),NumberGoals);
//	jia.copyFile(Me);
//	for (goal(Goal)) {
//		.print("Adding goal ",Goal);
//		jia.addGoals(Me,Goal);
//	}
//	jia.addParameters(Me);
//	jia.startPlanner(Me,Replan);
//	if (Replan) {
//		-goal(Goal);
//		.send(org_agent,achieve,replan(Goal,Role));
//	}
//	else {
//		for (.range(I,1,NumberGoals)) {
//			.send(org_agent,achieve,count);
//		}
//	}
//	.
	
+!start_planner[source(X)]
	: .my_name(Me) & role(Role) & winner(Goal)
<- 
//	.print("Awarded goals ",Goal);
	-winner(Goal)[source(X)];
	+goal(Goal);
	jia.copyFile(Me);
	for (goal(Goals)) {
//		.print("Adding goal ",Goals);
		jia.addGoals(Me,Goals);
	}
	jia.addParameters(Me);
	jia.startPlanner(Me,Replan);
	if (Replan) {
		-goal(Goal);
//		.print("Goal replan: ",Goal," role: ",Role);
		.send(org_agent,achieve,replan(Goal,Role));
	}
	else {
		for (goal(Goals2)) {
			for (.member(G,Goals2)) {
//				.print("Sending done for goal ",G);
				.send(org_agent,achieve,count);
			}
		}
	}
	.
	
+!start_planner[source(X)]
	: goal(Goal)
<-
		for (goal(Goals2)) {
			for (.member(G,Goals2)) {
//				.print("Sending done previously for goal ",G);
				.send(org_agent,achieve,count);
			}
		}
	.
+!start_planner.