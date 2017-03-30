package cnp;

import jason.asSyntax.Literal;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

import cartago.*;

public class ContractNetBoard extends Artifact {
	
	private Logger logger = null;
	
	private List<Bid> bids;
	
	void init(String taskDescr, long duration, int taskId){
		logger = Logger.getLogger(ContractNetBoard.class.getName()+"_"+taskDescr);
		this.defineObsProperty("state","open");
		bids = new ArrayList<Bid>();
		this.execInternalOp("checkDeadline", duration, taskId);
		this.execInternalOp("checkAllBids");
	}
	
	@OPERATION void bid(String bid, String agent, String goal){
		if (getObsProperty("state").stringValue().equals("open")){
			bids.add(new Bid(agent,bid,goal));
		} else {
			this.failed("cnp_closed");
		}
	}
	
	@INTERNAL_OPERATION void checkDeadline(long dt, int taskId){
		await_time(dt);
		this.defineObsProperty("timeout",taskId);
//			logger.info("bidding stage closed by deadline.");
	}
	
	@INTERNAL_OPERATION void checkAllBids(){
		while(!isClosed() && !allAgentsMadeTheirBid()){
			await_time(50);
		}
		if(!isClosed()){
			getObsProperty("state").updateValue("closed");
//			logger.info("bidding stage closed by all agents bids.");
		}
	}
	
	@OPERATION void getBids(OpFeedbackParam<Literal[]> bidList){
		await("biddingClosed");
		int i = 0;
		Literal[] aux= new Literal[bids.size()];
		for (Bid p: bids){
			aux[i] = Literal.parseLiteral("bid("+p.getValue()+","+p.getAgent()+","+p.getGoal()+")");
			i++;
		}
		bidList.set(aux);
	}	
	
	@GUARD boolean biddingClosed(){
		return isClosed();
	}
	
	private boolean isClosed(){
		return this.getObsProperty("state").stringValue().equals("closed");		
	}
	
	private boolean allAgentsMadeTheirBid(){
		 return bids.size() == 30;
	}
	
	static public class Bid {
		
		private String agent;
		private String value;
		private String goal;
		
		public Bid(String agent, String value, String goal){
			this.value = value;
			this.agent = agent;
			this.goal = goal;
		}
		
		public String getAgent(){ return agent; }
		public String getValue(){ return value; }
		public String getGoal(){ return goal; }
	}
	
}
