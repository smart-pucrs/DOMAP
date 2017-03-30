{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("decomp_breadth.asl") }
{ include("bidder.asl") }

/* Initial beliefs and rules */
role(uav).

/* Initial goals */



/* Plans */
+!navigate(Area)
	: at(From) & .my_name(Name) & jcm__art(_,Name,Id)
<-
	navigate(To)[artifact_id(Id)];
	.
	
+!get_picture(Flood)
	: visible_from(Flood,Area) & .my_name(Name) & jcm__art(_,Name,Id)
<-
	!navigate(Area);
	take_picture(Area,Flood)[artifact_id(Id)];
	!navigate(Area);
	communicate_data;
	.