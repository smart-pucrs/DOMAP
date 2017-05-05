// Internal action code for project helloworld

package jia;

import jason.asSemantics.*;
import jason.asSyntax.*;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;

public class addParameters extends DefaultInternalAction {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
    public Object execute(TransitionSystem ts, Unifier un, Term[] args) throws Exception {
        String name = args[0].toString();
        String params = "))\n\n(find-plans '"+name+" :which :shallowest :verbose :plans)";
        try {
            Files.write(Paths.get("/home/rovane/floods/p01/"+name+".lisp"), params.getBytes(), StandardOpenOption.APPEND);
        }catch (IOException e) {
            //exception handling left as an exercise for the reader
        }
        return true;
    }
}
