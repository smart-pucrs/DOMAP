// Internal action code for project helloworld

package jia;

import jason.asSemantics.*;
import jason.asSyntax.*;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;

public class addGoals extends DefaultInternalAction {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
    public Object execute(TransitionSystem ts, Unifier un, Term[] args) throws Exception {
        String name = args[0].toString();
        String goals = args[1].toString();
        goals = goals.replace("(", " ");
        goals = goals.replace(",", " ");
        goals = goals.replace("[", "(:task ");
        goals = goals.replace(") ", ")\n(:task ");
        goals = goals.replace(")]", ")\n");
        try {
            Files.write(Paths.get("/home/rovane/floods/p01/"+name+".lisp"), goals.getBytes(), StandardOpenOption.APPEND);
        }catch (IOException e) {
            //exception handling left as an exercise for the reader
        }
        return true;
    }
}
