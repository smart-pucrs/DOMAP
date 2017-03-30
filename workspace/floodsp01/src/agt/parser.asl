+!parse_solution
<-
	jia.solutionParser(Actions);
	.concat("+!execute : true <- ",Actions,Plan)
	.add_plan(Plan);
	.list_plans({ +!execute }).
	
//.add_plan("+b : true <- .print(b)."): adds the plan +b : true <- .print(b). to the agent's plan library with a plan label annotated with source(self).