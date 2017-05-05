package floods;

import cartago.*;

@ARTIFACT_INFO( outports = { @OUTPORT(name = "out-1"), @OUTPORT(name = "out-2"), @OUTPORT(name = "out-3"), @OUTPORT(name = "out-4") } )

public class Cdm extends Artifact {
	
	void init(String area) {
		defineObsProperty("at_cdm",area);
	}
	
	@OPERATION void changeLoc(String area) {
		ObsProperty effect1 = getObsProperty("at_cdm");
		effect1.updateValue(area);
	}
	
	@OPERATION void addWaterPathArea(String out, String a) { try {
		execLinkedOp(out,"addWaterPath",a);
	} catch (OperationException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} }
	@OPERATION void removeWaterPathArea(String out, String a) { try {
		execLinkedOp(out,"removeWaterPath",a);
	} catch (OperationException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} }
	@OPERATION void addGroundPathArea(String out, String a) { try {
		execLinkedOp(out,"addGroundPath",a);
	} catch (OperationException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} }
	@OPERATION void removeGroundPathArea(String out, String a) { try {
		execLinkedOp(out,"removeGroundPath",a);
	} catch (OperationException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} }	
}


