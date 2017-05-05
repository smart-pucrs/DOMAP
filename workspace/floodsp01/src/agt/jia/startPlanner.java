package jia;

import jason.asSemantics.*;
import jason.asSyntax.*;
import java.io.*;
import java.io.PrintWriter;

public class startPlanner extends DefaultInternalAction {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
    public Object execute(TransitionSystem ts, Unifier un, Term[] args) throws Exception {
        // execute the internal action
//        ts.getAg().getLogger().info("executing internal action 'jia.startPlanner'");
        String name = args[0].toString();
        String cp = "/home/rovane/acl/floods/p01/startPlanner-"+name+".cl";
        boolean replan = false;
        //String domain =  ((StringTerm) args[0]).getString();
        //String problem =  ((StringTerm) args[1]).getString();        
        try
        {            
            Runtime rt = Runtime.getRuntime();
            Process proc = rt.exec(cp);
//            InputStream stderr = proc.getErrorStream();
//            InputStreamReader isr = new InputStreamReader(stderr);
//            BufferedReader br = new BufferedReader(isr);
//            String line = null;
//            System.out.println("<ERROR>");
//            while ( (line = br.readLine()) != null)
//                System.out.println(line);
//            System.out.println("</ERROR>");   
            InputStream stdin = proc.getInputStream();
            InputStreamReader isr = new InputStreamReader(stdin);
            BufferedReader br2 = new BufferedReader(isr);
            String line2 = null;
            try{
                PrintWriter writer = new PrintWriter("/home/rovane/floods/output/p01/"+name+".out", "UTF-8");
                writer.println("<OUTPUT>");
                while ( (line2 = br2.readLine()) != null) {
                    writer.println(line2);
                    if (line2.contains("NIL")) 
                    	replan = true;
                }
                writer.println("</OUTPUT>"); 
                writer.close();
            } catch (Exception e) {
               // do something
            }
            int exitVal = proc.waitFor();            
//            System.out.println("Process exitValue: " + exitVal);
        } catch (Throwable t)
          {
            t.printStackTrace();
          }
      /*
        try
        {            
            Runtime rt = Runtime.getRuntime();
            Process proc = rt.exec("java -cp "+cp+" JSHOP2.InternalDomain -r "+problem);
            InputStream stderr = proc.getErrorStream();
            InputStreamReader isr = new InputStreamReader(stderr);
            BufferedReader br = new BufferedReader(isr);
            String line = null;
            System.out.println("<ERROR>");
            while ( (line = br.readLine()) != null)
                System.out.println(line);
            System.out.println("</ERROR>");           
            int exitVal = proc.waitFor();            
            System.out.println("Process exitValue: " + exitVal);
        } catch (Throwable t)
          {
            t.printStackTrace();
          }
       
        try
        {            
            Runtime rt = Runtime.getRuntime();
            Process proc = rt.exec("javac -cp "+cp+" problem.java");
            InputStream stderr = proc.getErrorStream();
            InputStreamReader isr = new InputStreamReader(stderr);
            BufferedReader br = new BufferedReader(isr);
            String line = null;
            System.out.println("<ERROR>");
            while ( (line = br.readLine()) != null)
                System.out.println(line);
            System.out.println("</ERROR>");           
            int exitVal = proc.waitFor();            
            System.out.println("Process exitValue: " + exitVal);
        } catch (Throwable t)
          {
            t.printStackTrace();
          }          
        
        try
        {            
            Runtime rt = Runtime.getRuntime();
            Process proc = rt.exec("java -cp "+cp+" problem");
            InputStream stderr = proc.getErrorStream();
            InputStreamReader isr = new InputStreamReader(stderr);
            BufferedReader br = new BufferedReader(isr);
            String line = null;
            System.out.println("<ERROR>");
            while ( (line = br.readLine()) != null)
                System.out.println(line);
            System.out.println("</ERROR>");
            InputStream stdin = proc.getInputStream();
            InputStreamReader isr2 = new InputStreamReader(stdin);
            BufferedReader br2 = new BufferedReader(isr2);
            String line2 = null;
            System.out.println("<OUTPUT>");
            while ( (line2 = br2.readLine()) != null)
                System.out.println(line2);
            System.out.println("</OUTPUT>");            
            int exitVal = proc.waitFor();            
            System.out.println("Process exitValue: " + exitVal);
        } catch (Throwable t)
          {
            t.printStackTrace();
          }            
        */
        // everything ok, so returns true
        return un.unifies(args[1],  Literal.parseLiteral(replan+""));
    }
}
