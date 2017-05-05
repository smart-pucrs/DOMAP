package floods;

import cartago.*;

public class VehicleUsv extends Artifact {
	
	void init(String area, String store) {
		defineObsProperty("at",area);
		defineObsProperty("storage",store);
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
	
	@OPERATION void sample_water(String area) {
		ObsProperty cond1 = getObsProperty("at");
		ObsProperty cond2 = getObsProperty("storage");
		if ( (cond1.stringValue().equals(area)) && (cond2.stringValue().equals("empty")) )
		{
			ObsProperty effect1 = getObsProperty("storage");
			effect1.updateValue("full");
			defineObsProperty("have_water_sample", area);
		} else {
			failed("Action sample_water has failed.");
	    }
	}
	
	@OPERATION void deliver_sample() {
		ObsProperty cond1 = getObsProperty("storage");
		if (cond1.stringValue().equals("full") )
		{
			ObsProperty effect1 = getObsProperty("storage");
			effect1.updateValue("empty");
		} else {
			failed("Action deliver_sample has failed.");
	    }
	}
	
}

