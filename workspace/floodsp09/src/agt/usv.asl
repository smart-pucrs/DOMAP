{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("decomp_breadth.asl") }
{ include("bidder.asl") }

/* Initial beliefs and rules */
role(usv).

/* Initial goals */


/* Plans */
+!navigate(Area)
	: at(From) & .my_name(Name) & jcm__art(_,Name,Id)
<-
	!navigate(From,Area);
	.
	
+!navigate(From,To)
	: at(To).
	
+!navigate(From,To)
	: water_path(From,To) & .my_name(Name) & jcm__art(_,Name,Id)
<-
	navigate(To)[artifact_id(Id)].
	
+!navigate(From,To)
	: water_path(From,Mid) & (not visited(Mid)) & .my_name(Name) & jcm__art(_,Name,Id)
<-
	!navigate(From,Mid);
	!navigate(Mid,To);
	.
	
+!get_picture(Flood)
	: visible_from(Flood,Area) & .my_name(Name) & jcm__art(_,Name,Id)
<-
	!navigate(Area);
	take_picture(Area,Flood)[artifact_id(Id)];
	!navigate(Area);
	communicate_data;
	.
	
+!deliver_sample(Cdm,Area)
	: .my_name(Name) & jcm__art(_,Name,Id)
<-
	!navigate(Area);
	get_sample[artifact_id(Id)];
	!navigate(Area);
	drop_sample[artifact_id(Id)];
	.