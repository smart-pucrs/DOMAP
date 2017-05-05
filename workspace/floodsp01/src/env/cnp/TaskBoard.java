package cnp;

import java.util.logging.Logger;

import jason.asSyntax.Literal;
import cartago.*;

public class TaskBoard extends Artifact {
	
	private Logger logger = Logger.getLogger(TaskBoard.class.getName());
	
	private int taskId;
	
	void init(){
//		logger.info("TaskBoard Artifact created!");
		taskId = 0;
	}
	
	@OPERATION void announce(String taskDescr, int duration, OpFeedbackParam<String> id){
		taskId++;
		try {
			String artifactName = "cnp_board_"+taskId;
			makeArtifact(artifactName, "cnp.ContractNetBoard", new ArtifactConfig(taskDescr,duration,taskId));
			defineObsProperty("task", Literal.parseLiteral(taskDescr), artifactName, taskId);
			id.set(artifactName);
		} catch (Exception ex){
//			logger.info("announce_failed");
		}
	}
	
	@OPERATION void announce_replan(String taskDescr, int duration, String Role, OpFeedbackParam<String> id){
		taskId++;
		try {
			String artifactName = "cnp_board_"+taskId;
			makeArtifact(artifactName, "cnp.ContractNetBoard", new ArtifactConfig(taskDescr,duration,taskId));
			defineObsProperty("task", Literal.parseLiteral(taskDescr), artifactName, Literal.parseLiteral(Role), taskId);
			id.set(artifactName);
		} catch (Exception ex){
//			logger.info("announce_failed");
		}
	}	
	
	@OPERATION void clear(String artifactName){
		this.removeObsPropertyByTemplate("task", null, artifactName, null, null);
	}
	
}