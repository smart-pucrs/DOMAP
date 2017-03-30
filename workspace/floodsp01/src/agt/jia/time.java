// Internal action code for project helloworld

package jia;

import jason.asSemantics.*;
import jason.asSyntax.*;

public class time extends DefaultInternalAction {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
    public Object execute(TransitionSystem ts, Unifier un, Term[] args) throws Exception {
		if (args.length == 1){
			long tStart = System.nanoTime();
	        return un.unifies(args[0], new NumberTermImpl(tStart));
		}
		else {
//			NumberTermImpl aux = (NumberTermImpl) args[1];
//			long tStart = (long) aux.solve();
			long tEnd = System.nanoTime();
//			long tRes = tEnd - tStart;
	        return un.unifies(args[1], new NumberTermImpl(tEnd));
		}
    }
}
