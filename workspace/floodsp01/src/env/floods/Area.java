package floods;

import cartago.*;

public class Area extends Artifact {
	
	void init(String wpath, String gpath) {
		defineObsProperty("water_path", wpath);
		defineObsProperty("ground_path", gpath);
	}
	
	@LINK void addWaterPath(String area) {
		ObsProperty effect1 = getObsProperty("water_path");
		effect1.updateValue(effect1+area);
	}
	
	@LINK void removeWaterPath(String area) {
		ObsProperty effect1 = getObsProperty("water_path");
		effect1.updateValue(effect1.toString().replace(area,""));
	}
	
	@LINK void addGroundPath(String area) {
		ObsProperty effect1 = getObsProperty("ground_path");
		effect1.updateValue(effect1+area);
	}
	
	@LINK void removeGroundPath(String area) {
		ObsProperty effect1 = getObsProperty("ground_path");
		effect1.updateValue(effect1.toString().replace(area,""));
	}	
	
}