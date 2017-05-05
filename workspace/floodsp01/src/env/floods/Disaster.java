package floods;

import cartago.*;

public class Disaster extends Artifact {
	
	void init(String area) {
		defineObsProperty("visible_from", area);
	}
	
}

