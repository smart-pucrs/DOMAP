package floods;

import cartago.*;

public class VehicleUgv extends Artifact {
	
	void init(String area, String state) {
		defineObsProperty("at",area);
		defineObsProperty("gripper",state);
	}
	
	@OPERATION void navigate(String area) {
		ObsProperty effect1 = getObsProperty("at");
		effect1.updateValue(area);
	}
	
	@OPERATION void take_picture(String flood, String visible_from) {
		ObsProperty cond1 = getObsProperty("at");
		if ( visible_from.contains(cond1.toString()) )
		{
			defineObsProperty("have_picture", flood);
		} else {
			failed("Action take_picture has failed.");
	    }
	}
	
	@OPERATION void get_kit() {
		ObsProperty cond1 = getObsProperty("gripper");
		if (cond1.stringValue().equals("none") )
		{
			ObsProperty effect1 = getObsProperty("gripper");
			effect1.updateValue("busy");
		} else {
			failed("Action get_kit has failed.");
	    }
	}
	
	@OPERATION void drop_kit() {
		ObsProperty cond1 = getObsProperty("gripper");
		if (cond1.stringValue().equals("busy") )
		{
			ObsProperty effect1 = getObsProperty("gripper");
			effect1.updateValue("none");
		} else {
			failed("Action drop_kit has failed.");
	    }
	}	
	
}

