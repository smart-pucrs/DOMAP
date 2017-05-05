// Internal action code for project helloworld

package jia;

import jason.asSemantics.*;
import jason.asSyntax.*;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import static java.nio.file.StandardCopyOption.*;

public class copyFile extends DefaultInternalAction {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
    public Object execute(TransitionSystem ts, Unifier un, Term[] args) throws Exception {
        String name = args[0].toString();
        try {
        	Files.copy(Paths.get("/home/rovane/floods/p01/backup/"+name+".lisp"), Paths.get("/home/rovane/floods/p01/"+name+".lisp"), REPLACE_EXISTING);
        }catch (IOException e) {
            //exception handling left as an exercise for the reader
        }
        return true;
    }
}
