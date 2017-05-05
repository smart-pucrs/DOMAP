package jia;

import jason.asSemantics.DefaultInternalAction;
import jason.asSemantics.TransitionSystem;
import jason.asSemantics.Unifier;
import jason.asSyntax.ListTerm;
import jason.asSyntax.ListTermImpl;
import jason.asSyntax.Literal;
import jason.asSyntax.Plan;
import jason.asSyntax.PlanBody;
import jason.asSyntax.Term;

public class decomposeBody extends DefaultInternalAction {

	private static final long serialVersionUID = 1475248221992032023L;

	@Override
	public Object execute(TransitionSystem ts, Unifier un, Term[] args) throws Exception {
		/*Plan plan2 = (Plan) args[0];
		String[] bb =  plan2.getBody().toString().split(";");
		System.out.println("Plan BODY: "+bb);
		for (int i = 0; i < plan2.getBody().getPlanSize(); i++) {
			Term term = bb.getTerm(i);
			System.out.println("BODY TEST: "+term);
		}*/
		Plan plan2 = (Plan) args[0];
		ListTerm goals = new ListTermImpl();
		ListTerm actions = new ListTermImpl();
		if (plan2.getBody().getPlanSize() > 0) {
			Term plan = (Term) args[0];
			String p = plan.toString();
			String[] b = p.split("<-");
			String[] body = b[1].split(";"); 
			 for (int x=0; x<body.length; x++) {
				 if (body[x].trim().charAt(0) == '!') {
					 goals.append(Literal.parseLiteral(body[x].substring(2)));
				 }
				 else {
					 actions.append(Literal.parseLiteral(body[x].substring(1)));
				 }
			 }
		}
		un.unifies(args[2], actions);
		return un.unifies(args[1], goals);
	}
}
