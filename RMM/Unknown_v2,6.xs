// Land Unknown adapted to Rocket
// ver 11 Jan 2005

include "ypAsianInclude.xs";
include "ypKOTHInclude.xs";
include "mercenaries.xs";

void main(void)
{

  // Text
   rmSetStatusText("",0.01);

  // Set size.

   int playerTiles=11000;

   	if(rmRandFloat(0,0.1) > 0.25)
	{
		playerTiles=16000;
		rmEchoInfo("Extra large map");
	}
	if (cNumberNonGaiaPlayers >2)
		playerTiles = 10300;
   if (cNumberNonGaiaPlayers >4)
      playerTiles = 9200;

	int size=2.0*sqrt(cNumberNonGaiaPlayers*playerTiles);
	rmEchoInfo("Map size="+size+"m x "+size+"m");
	rmSetMapSize(size, size);
	rmSetMapElevationParameters(cElevTurbulence, 0.02, rmRandFloat(2, 4), 0.7, 8.0);

// ============= Base terrain ============= 

	float baseTerrain = rmRandFloat(0,1);
	int amazonMap = -1;
	int carolinaMap = -1;
	int saguenayMap = -1;
	int rockiesMap = -1;
	int sonoraMap = -1;
	int californiaMap = -1;
	string riverName = "";
	string oceanName = "";
	string pondName = "";
	string cliffName = "";
	string forestName = "";
	string landName = "";
	string treeName = "";
	string critterOneName = "";
	string critterTwoName = "";
	string livestockName = "";
	string fishName = "";
	string whaleName = "";

	if(baseTerrain < 0.17)
	{
		rmEchoInfo("Amazon terrain");
		amazonMap = 1;
		rmSetBaseTerrainMix("amazon grass");
		rmTerrainInitialize("pampas\ground5_pam", 6);
		rmSetMapType("yucatan");
		rmSetMapType("tropical");
		rmSetMapType("land");
	   rmSetLightingSet("amazon");
		riverName = "Amazon River";
		oceanName = "Amazon River Basin";
		pondName = "Bayou";
		cliffName = "Amazon";
		forestName = "Amazon Rain Forest";
		landName = "amazon grass";
		treeName = "treeAmazon";
		critterOneName = "capybara";
		critterTwoName = "tapir";
		livestockName = "cow";
		fishName = "fishMahi";
		whaleName = "humpbackWhale";
	}
	else if(baseTerrain < 0.34)
	{
		rmEchoInfo("California terrain");
		carolinaMap = 1;
		rmSetBaseTerrainMix("california_grass");
		rmTerrainInitialize("california\ground6_cal", 6);
		rmSetMapType("california");
		rmSetMapType("grass");
		rmSetMapType("land");
		rmSetLightingSet("california");
		riverName = "Yulon River";
		oceanName = "California Coast";
		pondName = "Texas Pond";
		cliffName = "Carolina Inland";
		forestName = "California redwood forest";
		landName = "califorinia_grass";
		treeName = "TreeMadrone";
		critterOneName = "turkey";
		critterTwoName = "deer";
		livestockName = "sheep";
		fishName = "fishCod";
		whaleName = "humpbackWhale";
	}
	else if(baseTerrain < 0.51)
	{
		rmEchoInfo("Carolina terrain");
		carolinaMap = 1;
		rmSetBaseTerrainMix("carolina_grass");
		rmTerrainInitialize("pampas\ground5_pam", 6);
		rmSetMapType("carolina");
		rmSetMapType("grass");
		rmSetMapType("land");
		rmSetLightingSet("carolina");
		riverName = "Pampas River";
		oceanName = "Atlantic Coast";
		pondName = "Texas Pond";
		cliffName = "Carolina Inland";
		forestName = "Carolina Pine Forest";
		landName = "carolina_grass";
		treeName = "treeCarolinaGrass";
		critterOneName = "turkey";
		critterTwoName = "deer";
		livestockName = "sheep";
		fishName = "fishCod";
		whaleName = "humpbackWhale";
	}


	else if(baseTerrain < 0.68)
	{
		rmEchoInfo("Saguenay terrain");
		saguenayMap = 1;
		rmSetBaseTerrainMix("saguenay tundra");
		rmTerrainInitialize("saguenay\ground1_sag",6);
		rmSetMapType("saguenay");
		rmSetMapType("grass");
		rmSetMapType("land");
	   rmSetLightingSet("saguenay");
		riverName = "Amazon River";
		oceanName = "Hudson Bay";
		pondName = "Saguenay Lake";
		cliffName = "New England Inland";
		forestName = "Saguenay Forest";
		landName = "saguenay tundra";
		treeName = "treeSaguenay";
		critterOneName = "elk";
		critterTwoName = "moose";
		livestockName = "sheep";
		fishName = "fishSalmon";
		whaleName = "minkeWhale";
	}

	else if(baseTerrain < 0.85)
	{
		rmEchoInfo("Rockies terrain");
		rockiesMap = 1;
		rmSetBaseTerrainMix("rockies_snow");
		rmTerrainInitialize("rockies\groundsnow1_roc", 6);	
		rmSetMapType("rockies");
		rmSetMapType("land");
		rmSetLightingSet("rockies");
		riverName = "Yukon River";
		oceanName = "Great Lakes Ice";
		pondName = "Great Lakes Ice";
		cliffName = "Rocky Mountain2";
		forestName = "Rockies Snow Forest";
		landName = "rockies_snow";
		treeName = "treeRockies";
		critterOneName = "caribou";
		critterTwoName = "muskOx";
		livestockName = "cow";
		fishName = "fishSardine";
		whaleName = "beluga";
	}

	else
	{
		rmEchoInfo("Sonora terrain");
		sonoraMap = 1;
		rmSetBaseTerrainMix("sonora_dirt");
		rmTerrainInitialize("sonora\ground2_son", 6);
		rmSetMapType("sonora");
		rmSetMapType("grass");
		rmSetMapType("land");
		rmSetLightingSet("Sonora");
		riverName = "Pampas River";
		oceanName = "Great Lakes";
		pondName = "Great Lakes"; 
		cliffName = "Sonora";
		forestName = "Sonora Forest";
		landName = "sonora_dirt";
		treeName = "treeSonora";
		critterOneName = "turkey";
		critterTwoName = "rhea";
		livestockName = "llama";
		fishName = "fishTarpon";
		whaleName = "humpbackWhale";

	}

	// Text
   rmSetStatusText("", 0.1);



// ============= Classes =============

	int classPlayer=rmDefineClass("player");
	int classNatives=rmDefineClass("natives");
	int classCanyon=rmDefineClass("canyon");
	int pondClass=rmDefineClass("pond");
	rmDefineClass("startingUnit");
	rmDefineClass("classForest");



// ============= Constraints =============

	int avoidImpassableLand = rmCreateTerrainDistanceConstraint("avoid impassable land", "Land", false, 24.0);
	int playerAvoidImpassableLand = rmCreateTerrainDistanceConstraint("player avoid impassable land", "Land", false, 18.0);
	int mediumAvoidImpassableLand = rmCreateTerrainDistanceConstraint("slightly avoid impassable", "Land", false, 12.0);
	int shortAvoidImpassableLand = rmCreateTerrainDistanceConstraint("just barely avoid impassable", "Land", false, 4.0);
	int TCAvoidImpassableLand = rmCreateTerrainDistanceConstraint("TCs vs impassable land", "Land", false, 8.0);
	int avoidPlayers = rmCreateClassDistanceConstraint("stay away from players medium", classPlayer, 15.0);
	int avoidPlayersFar = rmCreateClassDistanceConstraint("stay away from players far", classPlayer, 50.0);
	int avoidTradeRoute = rmCreateTradeRouteDistanceConstraint("trade route", 10.0);
	int avoidTradeRouteSocket = rmCreateTypeDistanceConstraint("avoid trade route sockets", "sockettraderoute", 15.0);
	int avoidNatives = rmCreateClassDistanceConstraint("stay away from natives", classNatives, 60.0);
	int nativesAvoidPlayers = rmCreateClassDistanceConstraint("natives vs. players", classPlayer, 50.0);
   int edgeConstraint=rmCreatePieConstraint("continent avoids edge",  0.5, 0.5, 0, rmGetMapXSize()-30, 0, 0, 0);
	int avoidCanyon = rmCreateClassDistanceConstraint("don't place on mesa where you can't path", classCanyon, 2.0);
   int pondConstraint=rmCreateClassDistanceConstraint("ponds avoid ponds", rmClassID("pond"), 30.0);
   int forestConstraint=rmCreateClassDistanceConstraint("forest vs. forest", rmClassID("classForest"), 20.0);
	int avoidTC=rmCreateTypeDistanceConstraint("vs. TC", "TownCenter", 20.0);
	int avoidCW=rmCreateTypeDistanceConstraint("vs. CW", "CoveredWagon", 20.0);
   int avoidNugget=rmCreateTypeDistanceConstraint("nugget avoid nugget", "abstractNugget", 30.0);
   int fishVsFishID=rmCreateTypeDistanceConstraint("fish v fish", "abstractFish", 10.0);
   int whaleVsWhaleID=rmCreateTypeDistanceConstraint("whale v whale", "abstractWhale", 25.0);
   int fishLand = rmCreateTerrainDistanceConstraint("fish land", "land", true, 6.0);
   int whaleLand = rmCreateTerrainDistanceConstraint("whale v. land", "land", true, 20.0);
	int flagVsFlag = rmCreateTypeDistanceConstraint("flag avoid same", "HomeCityWaterSpawnFlag", 20);
   int avoidFood = rmCreateTypeDistanceConstraint("food avoids food", "food", 40.0);
	int avoidFood1 = rmCreateTypeDistanceConstraint("food avoids food1", critterOneName, 40.0);
	int avoidFood2 = rmCreateTypeDistanceConstraint("food avoids food2", critterTwoName, 40.0);
	int avoidSilver = rmCreateTypeDistanceConstraint("fast coin avoids coin", "gold", 40.0);
	int avoidEdge = rmCreatePieConstraint("Avoid Edge",0.5,0.5, rmXFractionToMeters(0.0),rmXFractionToMeters(0.47), rmDegreesToRadians(0),rmDegreesToRadians(360));
	int avoidForestMin=rmCreateClassDistanceConstraint("avoid forest min", rmClassID("classForest"), 4.0);
   	int avoidPond=rmCreateClassDistanceConstraint("avoid pond min", rmClassID("pond"), 15.0);
	int avoidPlayersFar1 = rmCreateClassDistanceConstraint("stay away from players far1", classPlayer, 30.0);
	int avoidEdgeFar = rmCreatePieConstraint("Avoid Edge Far",0.5,0.5, rmXFractionToMeters(0.0),rmXFractionToMeters(0.43), rmDegreesToRadians(0),rmDegreesToRadians(360));
	int avoidSilver1 = rmCreateTypeDistanceConstraint("fast coin avoids coin1", "gold", 12.0);

   int avoidAll=rmCreateTypeDistanceConstraint("avoid all", "all", 4.0);



// ============= Land and Water Configuration =============

	int allLand = 1;
	int sagTest = 1;
	int riverExists = -1;
	int oceanMiddle = -1;
	int oceanOffCenter = -1;
	int oceanRing = -1;
	int plateauMiddle = -1;
	int forestMiddle = -1;
	int blockedMiddle = -1; // used to determine if trade route should be a circle
	
	float landConfig = rmRandFloat(0,1);


// ============= Land Only =============
	if(landConfig < 0.30)
		rmEchoInfo("just land");

// ============= River Across Middle =============
	else if(landConfig < 0.45)
	{
		rmEchoInfo("river exists");
		allLand = -1;
		riverExists = 1;
		int unknownRiver = rmRiverCreate(-1, riverName, 30, 15, 5, 8);
		float riverPosition = rmRandFloat(0,1);

		// Spin river randomly around the edge		
		if(riverPosition < 0.12)
			rmRiverSetConnections(unknownRiver, 0.0, 0.5, 1.0, 0.5);
		else if(riverPosition < 0.24)
			rmRiverSetConnections(unknownRiver, 0.0, 0.0, 1.0, 1.0);
		else if(riverPosition < 0.36)
			rmRiverSetConnections(unknownRiver, 0.5, 0.0, 0.5, 1.0);
		else if(riverPosition < 0.48)
			rmRiverSetConnections(unknownRiver, 0.0, 1.0, 1.0, 0.0);
		else if(riverPosition < 0.60)
			rmRiverSetConnections(unknownRiver, 0.0, 0.25, 1.0, 0.75);
		else if(riverPosition < 0.72)
			rmRiverSetConnections(unknownRiver, 0.0, 0.75, 1.0, 0.25);
		else if(riverPosition < 0.84)
			rmRiverSetConnections(unknownRiver, 0.25, 0.0, 0.75, 1.0);
		else
			rmRiverSetConnections(unknownRiver, 0.75, 0.0, 0.25, 1.0);
		
		// River always has 2 shallows and usually 3
		rmRiverSetShallowRadius(unknownRiver, rmRandInt(10, 12));
		rmRiverAddShallow(unknownRiver, rmRandFloat(0.1, 0.35)); 

		if(rmRandFloat(0,1) < 0.66)
		{
			rmRiverSetShallowRadius(unknownRiver, rmRandInt(10, 12));
			rmRiverAddShallow(unknownRiver, 0.5);
		}

		rmRiverSetShallowRadius(unknownRiver, rmRandInt(10, 12));
		rmRiverAddShallow(unknownRiver, rmRandFloat(0.65, 0.95));
		rmRiverSetBankNoiseParams(unknownRiver, 0.07, 2, 1.5, 10.0, 0.667, 3.0);

		rmRiverBuild(unknownRiver);
	}

// ============= Great Lakes Style Ocean =============
	else if(landConfig < 0.65)
	{
		rmEchoInfo("ocean in middle");
		allLand = -1;
		oceanMiddle = 1;
		blockedMiddle = 1;

		// But don't build ocean every single time
		if(rmRandFloat(0,1) < 0.9)
		{
			int lakeOfTheUnknown=rmCreateArea("big lake in middle");
			rmSetAreaWaterType(lakeOfTheUnknown, oceanName);
			if(rmRandFloat(0,1) < 0.4)
			{
				rmSetAreaSize(lakeOfTheUnknown, 0.06, 0.09);
				rmEchoInfo("larger lake");
			}
			else
			{
				rmSetAreaSize(lakeOfTheUnknown, 0.04, 0.06);
				rmEchoInfo("smaller lake");
			}
			rmSetAreaLocation(lakeOfTheUnknown, 0.5, 0.5);
			rmAddAreaConstraint(lakeOfTheUnknown, avoidPlayers);
			rmSetAreaSmoothDistance(lakeOfTheUnknown, 50);
			rmSetAreaCoherence(lakeOfTheUnknown, 0.25);
		}
	} 

// Build the lake later to avoid players

// ============= Saguenay Style Ocean =============
	else if(landConfig < 0.90)
	{
		rmEchoInfo("ocean off center");
		allLand = -1;
		sagTest = -1;
		oceanOffCenter = 1;
		float bayPosition = rmRandFloat(0,1);
		int unknownBay=rmCreateArea("big bay on edge");
		rmSetAreaWaterType(unknownBay, oceanName);
		rmSetAreaWarnFailure(unknownBay, false);
		rmSetAreaSize(unknownBay, 0.08, 0.15);

		// Spin bay randomly around the edge		
		if(bayPosition < 0.12)
			rmSetAreaLocation(unknownBay, 0.0, 0.0);
		else if(bayPosition < 0.24)
			rmSetAreaLocation(unknownBay, 0.0, 0.5);
		else if(bayPosition < 0.36)
			rmSetAreaLocation(unknownBay, 0.0, 1.0);
		else if(bayPosition < 0.48)
			rmSetAreaLocation(unknownBay, 0.5, 1.0);
		else if(bayPosition < 0.60)
			rmSetAreaLocation(unknownBay, 1.0, 1.0);
		else if(bayPosition < 0.72)
			rmSetAreaLocation(unknownBay, 1.0, 0.5);
		else if(bayPosition < 0.84)
			rmSetAreaLocation(unknownBay, 1.0, 0.0);
		else
			rmSetAreaLocation(unknownBay, 0.5, 0.0);

  		rmSetAreaObeyWorldCircleConstraint(unknownBay, false);
		rmAddAreaConstraint(unknownBay, avoidPlayers);
	   rmSetAreaSmoothDistance(unknownBay, 50);
	   rmSetAreaCoherence(unknownBay, 0.15);
	}

	// Build bay later to avoid players


// ============= Oasis Style Forest =============
	else
	{
		rmEchoInfo("forest in middle");
		allLand = -1;
		forestMiddle = 1;
		int greatUnknownForest=rmCreateArea("large central forest");
      rmSetAreaWarnFailure(greatUnknownForest, false);
      rmSetAreaSize(greatUnknownForest, 0.07, 0.07);
      rmSetAreaForestType(greatUnknownForest, forestName);
      rmSetAreaForestDensity(greatUnknownForest, 0.5);
      rmSetAreaForestClumpiness(greatUnknownForest, 0.6);
      rmSetAreaForestUnderbrush(greatUnknownForest, 0.0);
      rmSetAreaMinBlobs(greatUnknownForest, 1);
      rmSetAreaMaxBlobs(greatUnknownForest, 5);
      rmSetAreaMinBlobDistance(greatUnknownForest, 16.0);
      rmSetAreaMaxBlobDistance(greatUnknownForest, 70.0);
      rmSetAreaCoherence(greatUnknownForest, 0.15);
      rmSetAreaSmoothDistance(greatUnknownForest, 0);
      rmAddAreaToClass(greatUnknownForest, rmClassID("classForest"));
		rmSetAreaLocation(greatUnknownForest, 0.5, 0.5);
      rmAddAreaConstraint(greatUnknownForest, avoidPlayers); 
	}
	
// Build forest later to avoid players


	// Text
   rmSetStatusText("", 0.2);


// ============= Player Configurations =============

// Sometimes teams closer together

	if (riverExists == 1)
	{
		rmSetTeamSpacingModifier(1.0);
		rmEchoInfo("Teams spaced normal because of river");
	}
	else if (rmRandFloat(0.2,0.30) < 0.75)
	{
		rmSetTeamSpacingModifier(0.50);
		rmEchoInfo("Teams close together");
	}
	else if (rmRandFloat(0.5,1) < 0.33)
	{
		rmSetTeamSpacingModifier(0.50);
		rmEchoInfo("Teams very close together");
	}
	else
		rmEchoInfo("Teams spaced normal");


	if (oceanMiddle == 1)
	{
		rmPlacePlayersCircular(0.38, 0.40, 0);
		rmEchoInfo("players nearer edge because ocean in middle");
	}
	else if(oceanRing == 1)
	{
		rmPlacePlayersCircular(0.32, 0.40, 0);
		rmEchoInfo("players very far from edge because of continent");
	}
	else if(oceanOffCenter == 1)
	{
		rmPlacePlayersCircular(0.32, 0.40, 0);
		rmEchoInfo("players very far from edge because of off center bay");
	}
	else
	{
		rmPlacePlayersCircular(0.32, 0.40, 0);
		rmEchoInfo("players can be farther from edge");
	}
	

	float playerFraction = rmAreaTilesToFraction(1000);

	for(i=1; <cNumberPlayers)
   {
      // Create the area.
      int id=rmCreateArea("Player"+i);
      // Assign to the player.
      rmSetPlayerArea(i, id);
      // Set the size.
      rmSetAreaSize(id, playerFraction, playerFraction);
      rmAddAreaToClass(id, classPlayer);
      rmSetAreaMinBlobs(id, 1);
      rmSetAreaMaxBlobs(id, 1);
      rmAddAreaConstraint(id, avoidPlayers);
		// for testing areas
 //     rmSetAreaTerrainType(id, "rockies\groundsnow1_roc");
	   rmSetAreaCoherence(id, 0.35);
	   rmSetAreaSmoothDistance(id, 20);
		rmAddAreaConstraint(id, playerAvoidImpassableLand);
		rmSetAreaLocPlayer(id, i);
		rmSetAreaWarnFailure(id, false);
   }
	rmBuildAllAreas();

	// Text
   rmSetStatusText("", 0.3);


// ============= Trade Route =============


	int tradeRouteID = rmCreateTradeRoute();

   int socketID=rmCreateObjectDef("sockets for Trade Route");

	float XStart = -1;
	float ZStart = -1;
	float XStop = -1;
	float ZStop = -1;
	float routePosition = rmRandFloat(0,1);

   rmAddObjectDefItem(socketID, "SocketTradeRoute", 1, 0.0);
	rmAddObjectDefConstraint(socketID, shortAvoidImpassableLand);
   rmSetObjectDefAllowOverlap(socketID, true);
   rmSetObjectDefMinDistance(socketID, 0.0);
   rmSetObjectDefMaxDistance(socketID, 8.0);
	rmAddClosestPointConstraint(shortAvoidImpassableLand);
   vector tradeRoutePoint = cOriginVector;

	// Trade route circular if center mesa or ocean, else linear
	if(blockedMiddle == 1)
	{
		tradeRoutePoint = rmFindClosestPoint(0.08, 0.55, 30);
		rmAddTradeRouteWaypoint(tradeRouteID, rmXMetersToFraction(xsVectorGetX(tradeRoutePoint)), rmZMetersToFraction(xsVectorGetZ(tradeRoutePoint)));
		tradeRoutePoint = rmFindClosestPoint(0.20, 0.83, 30);
		rmAddRandomTradeRouteWaypoints(tradeRouteID, rmXMetersToFraction(xsVectorGetX(tradeRoutePoint)), rmZMetersToFraction(xsVectorGetZ(tradeRoutePoint)), 4, 6);
		tradeRoutePoint = rmFindClosestPoint(0.45, 0.93, 30);
		rmAddRandomTradeRouteWaypoints(tradeRouteID, rmXMetersToFraction(xsVectorGetX(tradeRoutePoint)), rmZMetersToFraction(xsVectorGetZ(tradeRoutePoint)), 4, 6);
		tradeRoutePoint = rmFindClosestPoint(0.67, 0.89, 30);
		rmAddRandomTradeRouteWaypoints(tradeRouteID, rmXMetersToFraction(xsVectorGetX(tradeRoutePoint)), rmZMetersToFraction(xsVectorGetZ(tradeRoutePoint)), 4, 6);
		tradeRoutePoint = rmFindClosestPoint(0.78, 0.78, 30);
		rmAddRandomTradeRouteWaypoints(tradeRouteID, rmXMetersToFraction(xsVectorGetX(tradeRoutePoint)), rmZMetersToFraction(xsVectorGetZ(tradeRoutePoint)), 4, 6);
		tradeRoutePoint = rmFindClosestPoint(0.84, 0.70, 30);
		rmAddRandomTradeRouteWaypoints(tradeRouteID, rmXMetersToFraction(xsVectorGetX(tradeRoutePoint)), rmZMetersToFraction(xsVectorGetZ(tradeRoutePoint)), 4, 6);
		tradeRoutePoint = rmFindClosestPoint(0.86, 0.68, 30);
		rmAddRandomTradeRouteWaypoints(tradeRouteID, rmXMetersToFraction(xsVectorGetX(tradeRoutePoint)), rmZMetersToFraction(xsVectorGetZ(tradeRoutePoint)), 4, 6);
		tradeRoutePoint = rmFindClosestPoint(0.88, 0.40, 30);
		rmAddRandomTradeRouteWaypoints(tradeRouteID, rmXMetersToFraction(xsVectorGetX(tradeRoutePoint)), rmZMetersToFraction(xsVectorGetZ(tradeRoutePoint)), 4, 6);
		tradeRoutePoint = rmFindClosestPoint(0.81, 0.23, 30);
		rmAddRandomTradeRouteWaypoints(tradeRouteID, rmXMetersToFraction(xsVectorGetX(tradeRoutePoint)), rmZMetersToFraction(xsVectorGetZ(tradeRoutePoint)), 4, 6);
		tradeRoutePoint = rmFindClosestPoint(0.70, 0.10, 30);
		rmAddRandomTradeRouteWaypoints(tradeRouteID, rmXMetersToFraction(xsVectorGetX(tradeRoutePoint)), rmZMetersToFraction(xsVectorGetZ(tradeRoutePoint)), 4, 6);
		tradeRoutePoint = rmFindClosestPoint(0.50, 0.08, 30);
		rmAddRandomTradeRouteWaypoints(tradeRouteID, rmXMetersToFraction(xsVectorGetX(tradeRoutePoint)), rmZMetersToFraction(xsVectorGetZ(tradeRoutePoint)), 4, 6);
		tradeRoutePoint = rmFindClosestPoint(0.30, 0.15, 30);
		rmAddRandomTradeRouteWaypoints(tradeRouteID, rmXMetersToFraction(xsVectorGetX(tradeRoutePoint)), rmZMetersToFraction(xsVectorGetZ(tradeRoutePoint)), 4, 6);
		tradeRoutePoint = rmFindClosestPoint(0.15, 0.23, 30);
		rmAddRandomTradeRouteWaypoints(tradeRouteID, rmXMetersToFraction(xsVectorGetX(tradeRoutePoint)), rmZMetersToFraction(xsVectorGetZ(tradeRoutePoint)), 4, 6);
		tradeRoutePoint = rmFindClosestPoint(0.08, 0.55, 30);
		rmAddRandomTradeRouteWaypoints(tradeRouteID, rmXMetersToFraction(xsVectorGetX(tradeRoutePoint)), rmZMetersToFraction(xsVectorGetZ(tradeRoutePoint)), 4, 6);

	}
else if (rmRandFloat(0,1) > 0.5 && sagTest == 1)
	{
		tradeRoutePoint = rmFindClosestPoint(0.08, 0.55, 30);
		rmAddTradeRouteWaypoint(tradeRouteID, rmXMetersToFraction(xsVectorGetX(tradeRoutePoint)), rmZMetersToFraction(xsVectorGetZ(tradeRoutePoint)));
		tradeRoutePoint = rmFindClosestPoint(0.20, 0.83, 30);
		rmAddRandomTradeRouteWaypoints(tradeRouteID, rmXMetersToFraction(xsVectorGetX(tradeRoutePoint)), rmZMetersToFraction(xsVectorGetZ(tradeRoutePoint)), 4, 6);
		tradeRoutePoint = rmFindClosestPoint(0.45, 0.93, 30);
		rmAddRandomTradeRouteWaypoints(tradeRouteID, rmXMetersToFraction(xsVectorGetX(tradeRoutePoint)), rmZMetersToFraction(xsVectorGetZ(tradeRoutePoint)), 4, 6);
		tradeRoutePoint = rmFindClosestPoint(0.67, 0.89, 30);
		rmAddRandomTradeRouteWaypoints(tradeRouteID, rmXMetersToFraction(xsVectorGetX(tradeRoutePoint)), rmZMetersToFraction(xsVectorGetZ(tradeRoutePoint)), 4, 6);
		tradeRoutePoint = rmFindClosestPoint(0.78, 0.78, 30);
		rmAddRandomTradeRouteWaypoints(tradeRouteID, rmXMetersToFraction(xsVectorGetX(tradeRoutePoint)), rmZMetersToFraction(xsVectorGetZ(tradeRoutePoint)), 4, 6);
		tradeRoutePoint = rmFindClosestPoint(0.84, 0.70, 30);
		rmAddRandomTradeRouteWaypoints(tradeRouteID, rmXMetersToFraction(xsVectorGetX(tradeRoutePoint)), rmZMetersToFraction(xsVectorGetZ(tradeRoutePoint)), 4, 6);
		tradeRoutePoint = rmFindClosestPoint(0.86, 0.68, 30);
		rmAddRandomTradeRouteWaypoints(tradeRouteID, rmXMetersToFraction(xsVectorGetX(tradeRoutePoint)), rmZMetersToFraction(xsVectorGetZ(tradeRoutePoint)), 4, 6);
		tradeRoutePoint = rmFindClosestPoint(0.88, 0.40, 30);
		rmAddRandomTradeRouteWaypoints(tradeRouteID, rmXMetersToFraction(xsVectorGetX(tradeRoutePoint)), rmZMetersToFraction(xsVectorGetZ(tradeRoutePoint)), 4, 6);
		tradeRoutePoint = rmFindClosestPoint(0.81, 0.23, 30);
		rmAddRandomTradeRouteWaypoints(tradeRouteID, rmXMetersToFraction(xsVectorGetX(tradeRoutePoint)), rmZMetersToFraction(xsVectorGetZ(tradeRoutePoint)), 4, 6);
		tradeRoutePoint = rmFindClosestPoint(0.70, 0.10, 30);
		rmAddRandomTradeRouteWaypoints(tradeRouteID, rmXMetersToFraction(xsVectorGetX(tradeRoutePoint)), rmZMetersToFraction(xsVectorGetZ(tradeRoutePoint)), 4, 6);
		tradeRoutePoint = rmFindClosestPoint(0.50, 0.08, 30);
		rmAddRandomTradeRouteWaypoints(tradeRouteID, rmXMetersToFraction(xsVectorGetX(tradeRoutePoint)), rmZMetersToFraction(xsVectorGetZ(tradeRoutePoint)), 4, 6);
		tradeRoutePoint = rmFindClosestPoint(0.30, 0.15, 30);
		rmAddRandomTradeRouteWaypoints(tradeRouteID, rmXMetersToFraction(xsVectorGetX(tradeRoutePoint)), rmZMetersToFraction(xsVectorGetZ(tradeRoutePoint)), 4, 6);
		tradeRoutePoint = rmFindClosestPoint(0.15, 0.23, 30);
		rmAddRandomTradeRouteWaypoints(tradeRouteID, rmXMetersToFraction(xsVectorGetX(tradeRoutePoint)), rmZMetersToFraction(xsVectorGetZ(tradeRoutePoint)), 4, 6);
		tradeRoutePoint = rmFindClosestPoint(0.08, 0.55, 30);
		rmAddRandomTradeRouteWaypoints(tradeRouteID, rmXMetersToFraction(xsVectorGetX(tradeRoutePoint)), rmZMetersToFraction(xsVectorGetZ(tradeRoutePoint)), 4, 6);

	}
	else // nothing big in middle so go linear
	{
		// If continet, scoot linear trade route in a bit
		if(oceanRing == 1)
		{
			// Spin trade route points around edge
			if(routePosition < 0.12)
			{
				XStart = 0.25;
				ZStart = 0.5;
				XStop = 0.75;
				ZStop = 0.5;
			}
			else if(routePosition < 0.24)
			{
				XStart = 0.25;
				ZStart = 0.25;
				XStop = 0.75;
				ZStop = 0.75;
			}
			else if(routePosition < 0.36)
			{
				XStart = 0.5;
				ZStart = 0.25;
				XStop = 0.5;
				ZStop = 0.75;
			}
			else if(routePosition < 0.48)
			{
				XStart = 0.25;
				ZStart = 0.75;
				XStop = 0.75;
				ZStop = 0.25;
			}
			else if(routePosition < 0.60)
			{
				XStart = 0.25;
				ZStart = 0.25;
				XStop = 0.75;
				ZStop = 0.75;
			}
			else if(routePosition < 0.72)
			{	
				XStart = 0.25;
				ZStart = 0.75;
				XStop = 0.75;
				ZStop = 0.25;
			}
			else if(routePosition < 0.84)
			{
				XStart = 0.25;
				ZStart = 0.25;
				XStop = 0.75;
				ZStop = 0.75;
			}
			else
			{
				XStart = 0.75;
				ZStart = 0.25;
				XStop = 0.25;
				ZStop = 0.75;
			}
		}
		else
		// Otherwise extend trade route to edge
		{
			// Spin trade route points around edge
			if(routePosition < 0.12)
			{
				XStart = 0.0;
				ZStart = 0.5;
				XStop = 1.0;
				ZStop = 0.5;
			}
			else if(routePosition < 0.24)
			{
				XStart = 0.0;
				ZStart = 0.0;
				XStop = 1.0;
				ZStop = 1.0;
			}
			else if(routePosition < 0.36)
			{
				XStart = 0.5;
				ZStart = 0.0;
				XStop = 0.5;
				ZStop = 1.0;
			}
			else if(routePosition < 0.48)
			{
				XStart = 0.0;
				ZStart = 1.0;
				XStop = 1.0;
				ZStop = 0.0;
			}
			else if(routePosition < 0.60)
			{
				XStart = 0.0;
				ZStart = 0.25;
				XStop = 1.0;
				ZStop = 0.75;
			}
			else if(routePosition < 0.72)
			{	
				XStart = 0.0;
				ZStart = 0.75;
				XStop = 1.0;
				ZStop = 0.25;
			}
			else if(routePosition < 0.84)
			{
				XStart = 0.25;
				ZStart = 0.0;
				XStop = 0.75;
				ZStop = 1.0;
			}
			else
			{
				XStart = 0.75;
				ZStart = 0.0;
				XStop = 0.25;
				ZStop = 1.0;
			}
		}

		// Assign trade route waypoints
		tradeRoutePoint = rmFindClosestPoint(XStart, ZStart, 100.0);
		rmAddTradeRouteWaypoint(tradeRouteID, rmXMetersToFraction(xsVectorGetX(tradeRoutePoint)), rmZMetersToFraction(xsVectorGetZ(tradeRoutePoint)));
		rmAddRandomTradeRouteWaypoints(tradeRouteID, 0.5, 0.5, 6, 6);
		tradeRoutePoint = rmFindClosestPoint(XStop, ZStop, 100.0);
		rmAddRandomTradeRouteWaypoints(tradeRouteID, rmXMetersToFraction(xsVectorGetX(tradeRoutePoint)), rmZMetersToFraction(xsVectorGetZ(tradeRoutePoint)), 4, 6);
	}	

   bool placedTradeRoute = rmBuildTradeRoute(tradeRouteID, "dirt");
   if(placedTradeRoute == false)
      rmEchoError("Failed to place trade route");  

   // add the sockets along the trade route.
   rmSetObjectDefTradeRouteID(socketID, tradeRouteID);
   vector socketLoc = rmGetTradeRouteWayPoint(tradeRouteID, 0.20);
   rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);

	// If continent, then 2 slots. Otherwise 3 or 4.
	if(oceanRing < 1)
	{
		if(rmRandFloat(0,1) < 0.3)
		{
			socketLoc = rmGetTradeRouteWayPoint(tradeRouteID, 0.50);
			rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);
		}
		else if (rmRandFloat(0,1) < 0.5)
		{
			socketLoc = rmGetTradeRouteWayPoint(tradeRouteID, 0.35);
			rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);
	
			socketLoc = rmGetTradeRouteWayPoint(tradeRouteID, 0.65);
			rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);
		}
		else
		{
			socketLoc = rmGetTradeRouteWayPoint(tradeRouteID, 0.30);
			rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);
	
			socketLoc = rmGetTradeRouteWayPoint(tradeRouteID, 0.50);
			rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);

			socketLoc = rmGetTradeRouteWayPoint(tradeRouteID, 0.70);
			rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);
		}
	}

   socketLoc = rmGetTradeRouteWayPoint(tradeRouteID, 0.90);
   rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);


	rmClearClosestPointConstraints();


	// Text
   rmSetStatusText("", 0.4);

// ============= Starting Units =============

	int startingTCID= rmCreateObjectDef("startingTC");
	if (rmGetNomadStart())
		rmAddObjectDefItem(startingTCID, "CoveredWagon", 1);
	else
		rmAddObjectDefItem(startingTCID, "townCenter", 1);
	rmSetObjectDefMinDistance(startingTCID, 0.0);
	rmSetObjectDefMaxDistance(startingTCID, 20.0);
	// For FFA, allow more of a float distance.
	if ( cNumberTeams > 2 )
	{
		rmSetObjectDefMaxDistance(startingTCID, 30.0);
	}
	rmAddObjectDefConstraint(startingTCID, TCAvoidImpassableLand);
	rmAddObjectDefConstraint(startingTCID, avoidEdgeFar);
	rmAddObjectDefConstraint(startingTCID, avoidTradeRoute);
	rmAddObjectDefConstraint(startingTCID, avoidTradeRouteSocket);
	rmAddObjectDefToClass(startingTCID, rmClassID("player"));

	int startingUnits = rmCreateStartingUnitsObjectDef(5.0);
	rmSetObjectDefMinDistance(startingUnits, 5.0);
	rmSetObjectDefMaxDistance(startingUnits, 12.0);
	rmAddObjectDefConstraint(startingUnits, shortAvoidImpassableLand);
	rmAddObjectDefToClass(startingUnits, rmClassID("startingUnit"));

// Place Starting Units now so other stuff can avoid them
	for(i=1; <cNumberPlayers)
	{
		rmPlaceObjectDefAtLoc(startingTCID, i, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));
		//rmPlaceObjectDefAtLoc(startingUnits, i, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));
	}

	// Text
   rmSetStatusText("", 0.5);



// ============= Choose Natives =============

	int ZapotecVillageID = -1;
	int CaribsVillageID = -1;
	int CherokeeVillageID = -1;
	int ComancheVillageID = -1;
	int CreeVillageID = -1;
	int IncasVillageID = -1;
	int KlamathVillageID = -1;
	int CheyenneVillageID = -1;
	int MayaVillageID = -1;
	int NootkaVillageID = -1;
	int SeminolesVillageID = -1;
	int TupiVillageID = -1;
	int NavajoVillageID = -1;
	int HuronVillageID = -1;
	int MapucheVillageID = -1;
	int UdasiVillageID = -1;
	int BhaktiVillageID = -1;
	int JesuitVillageID = -1;
	int ZenVillageID = -1;
	int ShaolinVillageID= -1;
	int SufiVillageID = -1;

	float nativeChance = -1;

// Usually 3 to 4, but rarely more or less

	int nativeNumber = 3;
	if(rmRandFloat(0.5,1) < 0.25)
		nativeNumber = rmRandInt(5,6);
	else if(rmRandFloat(0,1) < 0.15)
		nativeNumber = rmRandInt(1,2);
	rmEchoInfo("Native number = "+nativeNumber);

// For each native, randomly determine tribe

	for(i = 0; <nativeNumber)
	{
		nativeChance = rmRandFloat(0,1);
		if(nativeChance < 0.05)
		{
			rmSetSubCiv(i, "Zapotec");
			rmEchoInfo("subCiv"+i+" is Zapotec");
			ZapotecVillageID = rmCreateGrouping("zapotec village "+i, "native zapotec village "+rmRandInt(1,5));
			rmSetGroupingMinDistance(ZapotecVillageID, 0);
			rmSetGroupingMaxDistance(ZapotecVillageID, rmXFractionToMeters(0.45));
			rmAddGroupingToClass(ZapotecVillageID, rmClassID("natives"));
			rmAddGroupingConstraint(ZapotecVillageID, avoidImpassableLand);
			rmAddGroupingConstraint(ZapotecVillageID, avoidTradeRoute);
			rmAddGroupingConstraint(ZapotecVillageID, avoidTradeRouteSocket);
			rmAddGroupingConstraint(ZapotecVillageID, nativesAvoidPlayers);
			rmAddGroupingConstraint(ZapotecVillageID, avoidNatives);
			rmAddGroupingConstraint(ZapotecVillageID, edgeConstraint);
			rmAddGroupingConstraint(ZapotecVillageID, avoidCanyon);
			rmPlaceGroupingAtLoc(ZapotecVillageID, 0, 0.5, 0.5);
			if (rmRandFloat(0,1) > 0.6)
			{
				rmPlaceGroupingAtLoc(ZapotecVillageID, 0, 0.5, 0.5);
			}
		}
		else if(nativeChance < 0.10)
		{
			rmSetSubCiv(i, "Shaolin");
			rmEchoInfo("subCiv"+i+" is Shaolin");
			ShaolinVillageID = rmCreateGrouping("Shaolin village "+i, "native shaolin temple mongol 0"+rmRandInt(1,5));
			rmSetGroupingMinDistance(ShaolinVillageID, 0);
			rmSetGroupingMaxDistance(ShaolinVillageID, rmXFractionToMeters(0.45));
			rmAddGroupingToClass(ShaolinVillageID, rmClassID("natives"));
			rmAddGroupingConstraint(ShaolinVillageID, avoidImpassableLand);
			rmAddGroupingConstraint(ShaolinVillageID, avoidTradeRoute);
			rmAddGroupingConstraint(ShaolinVillageID, avoidTradeRouteSocket);
			rmAddGroupingConstraint(ShaolinVillageID, nativesAvoidPlayers);
			rmAddGroupingConstraint(ShaolinVillageID, avoidNatives);
			rmAddGroupingConstraint(ShaolinVillageID, edgeConstraint);
			rmAddGroupingConstraint(ShaolinVillageID, avoidCanyon);
			rmPlaceGroupingAtLoc(ShaolinVillageID, 0, 0.5, 0.5);
			if (rmRandFloat(0,1) > 0.6)
			{
				rmPlaceGroupingAtLoc(ShaolinVillageID, 0, 0.5, 0.5);
			}
		}
		else if(nativeChance < 0.15)
		{
			rmSetSubCiv(i, "Sufi");
			rmEchoInfo("subCiv"+i+" is Sufi");
			SufiVillageID = rmCreateGrouping("Sufi village "+i, "native sufi mosque mongol "+rmRandInt(1,5));
			rmSetGroupingMinDistance(SufiVillageID, 0);
			rmSetGroupingMaxDistance(SufiVillageID, rmXFractionToMeters(0.45));
			rmAddGroupingToClass(SufiVillageID, rmClassID("natives"));
			rmAddGroupingConstraint(SufiVillageID, avoidImpassableLand);
			rmAddGroupingConstraint(SufiVillageID, avoidTradeRoute);
			rmAddGroupingConstraint(SufiVillageID, avoidTradeRouteSocket);
			rmAddGroupingConstraint(SufiVillageID, nativesAvoidPlayers);
			rmAddGroupingConstraint(SufiVillageID, avoidNatives);
			rmAddGroupingConstraint(SufiVillageID, edgeConstraint);
			rmAddGroupingConstraint(SufiVillageID, avoidCanyon);
			rmPlaceGroupingAtLoc(SufiVillageID, 0, 0.5, 0.5);
			if (rmRandFloat(0,1) > 0.6)
			{
				rmPlaceGroupingAtLoc(SufiVillageID, 0, 0.5, 0.5);
			}
		}
		else if(nativeChance < 0.20)
		{
			rmSetSubCiv(i, "Zen");
			rmEchoInfo("subCiv"+i+" is Zen");
			ZenVillageID = rmCreateGrouping("Zen village "+i, "native zen temple ceylon 0"+rmRandInt(1,5));
			rmSetGroupingMinDistance(ZenVillageID, 0);
			rmSetGroupingMaxDistance(ZenVillageID, rmXFractionToMeters(0.45));
			rmAddGroupingToClass(ZenVillageID, rmClassID("natives"));
			rmAddGroupingConstraint(ZenVillageID, avoidImpassableLand);
			rmAddGroupingConstraint(ZenVillageID, avoidTradeRoute);
			rmAddGroupingConstraint(ZenVillageID, avoidTradeRouteSocket);
			rmAddGroupingConstraint(ZenVillageID, nativesAvoidPlayers);
			rmAddGroupingConstraint(ZenVillageID, avoidNatives);
			rmAddGroupingConstraint(ZenVillageID, edgeConstraint);
			rmAddGroupingConstraint(ZenVillageID, avoidCanyon);
			rmPlaceGroupingAtLoc(ZenVillageID, 0, 0.5, 0.5);
			if (rmRandFloat(0,1) > 0.6)
			{
				rmPlaceGroupingAtLoc(ZenVillageID, 0, 0.5, 0.5);
			}
		}
		else if(nativeChance < 0.25)
		{
			rmSetSubCiv(i, "Jesuit");
			rmEchoInfo("subCiv"+i+" is Jesuit");
			JesuitVillageID = rmCreateGrouping("Jesuit village "+i, "native jesuit mission borneo 0"+rmRandInt(1,5));
			rmSetGroupingMinDistance(JesuitVillageID, 0);
			rmSetGroupingMaxDistance(JesuitVillageID, rmXFractionToMeters(0.45));
			rmAddGroupingToClass(JesuitVillageID, rmClassID("natives"));
			rmAddGroupingConstraint(JesuitVillageID, avoidImpassableLand);
			rmAddGroupingConstraint(JesuitVillageID, avoidTradeRoute);
			rmAddGroupingConstraint(JesuitVillageID, avoidTradeRouteSocket);
			rmAddGroupingConstraint(JesuitVillageID, nativesAvoidPlayers);
			rmAddGroupingConstraint(JesuitVillageID, avoidNatives);
			rmAddGroupingConstraint(JesuitVillageID, edgeConstraint);
			rmAddGroupingConstraint(JesuitVillageID, avoidCanyon);
			rmPlaceGroupingAtLoc(JesuitVillageID, 0, 0.5, 0.5);
			if (rmRandFloat(0,1) > 0.6)
			{
				rmPlaceGroupingAtLoc(JesuitVillageID, 0, 0.5, 0.5);
			}
		}
		else if(nativeChance < 0.30)
		{
			rmSetSubCiv(i, "Udasi");
			rmEchoInfo("subCiv"+i+" is Udasi");
			UdasiVillageID = rmCreateGrouping("Udasi village "+i, "native Udasi village "+rmRandInt(1,5));
			rmSetGroupingMinDistance(UdasiVillageID, 0);
			rmSetGroupingMaxDistance(UdasiVillageID, rmXFractionToMeters(0.45));
			rmAddGroupingToClass(UdasiVillageID, rmClassID("natives"));
			rmAddGroupingConstraint(UdasiVillageID, avoidImpassableLand);
			rmAddGroupingConstraint(UdasiVillageID, avoidTradeRoute);
			rmAddGroupingConstraint(UdasiVillageID, avoidTradeRouteSocket);
			rmAddGroupingConstraint(UdasiVillageID, nativesAvoidPlayers);
			rmAddGroupingConstraint(UdasiVillageID, avoidNatives);
			rmAddGroupingConstraint(UdasiVillageID, edgeConstraint);
			rmAddGroupingConstraint(UdasiVillageID, avoidCanyon);
			rmPlaceGroupingAtLoc(UdasiVillageID, 0, 0.5, 0.5);
			if (rmRandFloat(0,1) > 0.6)
			{
				rmPlaceGroupingAtLoc(UdasiVillageID, 0, 0.5, 0.5);
			}
		}
		else if(nativeChance < 0.40)
		{
			rmSetSubCiv(i, "Bhakti");
			rmEchoInfo("subCiv"+i+" is Bhakti");
			BhaktiVillageID = rmCreateGrouping("Bhakti village "+i, "native Bhakti village "+rmRandInt(1,5));
			rmSetGroupingMinDistance(BhaktiVillageID, 0);
			rmSetGroupingMaxDistance(BhaktiVillageID, rmXFractionToMeters(0.45));
			rmAddGroupingToClass(BhaktiVillageID, rmClassID("natives"));
			rmAddGroupingConstraint(BhaktiVillageID, avoidImpassableLand);
			rmAddGroupingConstraint(BhaktiVillageID, avoidTradeRoute);
			rmAddGroupingConstraint(BhaktiVillageID, avoidTradeRouteSocket);
			rmAddGroupingConstraint(BhaktiVillageID, nativesAvoidPlayers);
			rmAddGroupingConstraint(BhaktiVillageID, avoidNatives);
			rmAddGroupingConstraint(BhaktiVillageID, edgeConstraint);
			rmAddGroupingConstraint(BhaktiVillageID, avoidCanyon);
			rmPlaceGroupingAtLoc(BhaktiVillageID, 0, 0.5, 0.5);
			if (rmRandFloat(0,1) > 0.6)
			{
				rmPlaceGroupingAtLoc(BhaktiVillageID, 0, 0.5, 0.5);
			}
		}
		else if(nativeChance < 0.45)
		{
			rmSetSubCiv(i, "Caribs");
			rmEchoInfo("subCiv"+i+" is Caribs");
			CaribsVillageID = rmCreateGrouping("carib village "+i, "native carib village "+rmRandInt(1,5));
			rmSetGroupingMinDistance(CaribsVillageID, 0);
			rmSetGroupingMaxDistance(CaribsVillageID, rmXFractionToMeters(0.45));
			rmAddGroupingToClass(CaribsVillageID, rmClassID("natives"));
			rmAddGroupingConstraint(CaribsVillageID, avoidImpassableLand);
			rmAddGroupingConstraint(CaribsVillageID, avoidTradeRoute);
			rmAddGroupingConstraint(CaribsVillageID, avoidTradeRouteSocket);
			rmAddGroupingConstraint(CaribsVillageID, nativesAvoidPlayers);
			rmAddGroupingConstraint(CaribsVillageID, avoidNatives);
			rmAddGroupingConstraint(CaribsVillageID, edgeConstraint);
			rmAddGroupingConstraint(CaribsVillageID, avoidCanyon);
			rmPlaceGroupingAtLoc(CaribsVillageID, 0, 0.5, 0.5);
			if (rmRandFloat(0,1) > 0.6)
			{
				rmPlaceGroupingAtLoc(CaribsVillageID, 0, 0.5, 0.5);
			}
		}
		else if(nativeChance < 0.49)
		{
			rmSetSubCiv(i, "Huron");
			rmEchoInfo("subCiv"+i+" is Huron");
			HuronVillageID = rmCreateGrouping("huron village "+i, "native huron village "+rmRandInt(1,5));
			rmSetGroupingMinDistance(HuronVillageID, 0);
			rmSetGroupingMaxDistance(HuronVillageID, rmXFractionToMeters(0.45));
			rmAddGroupingToClass(HuronVillageID, rmClassID("natives"));
			rmAddGroupingConstraint(HuronVillageID, avoidImpassableLand);
			rmAddGroupingConstraint(HuronVillageID, avoidTradeRoute);
			rmAddGroupingConstraint(HuronVillageID, avoidTradeRouteSocket);
			rmAddGroupingConstraint(HuronVillageID, nativesAvoidPlayers);
			rmAddGroupingConstraint(HuronVillageID, avoidNatives);
			rmAddGroupingConstraint(HuronVillageID, edgeConstraint);
			rmAddGroupingConstraint(HuronVillageID, avoidCanyon);
			rmPlaceGroupingAtLoc(HuronVillageID, 0, 0.5, 0.5);
			if (rmRandFloat(0,1) > 0.6)
			{
				rmPlaceGroupingAtLoc(HuronVillageID, 0, 0.5, 0.5);
			}
		}	
		else if(nativeChance < 0.54)
		{
			rmSetSubCiv(i, "Cherokee");
			rmEchoInfo("subCiv"+i+" is Cherokee");
			CherokeeVillageID = rmCreateGrouping("cherokee village "+i, "native cherokee village "+rmRandInt(1,5));
			rmSetGroupingMinDistance(CherokeeVillageID, 0);
			rmSetGroupingMaxDistance(CherokeeVillageID, rmXFractionToMeters(0.45));
			rmAddGroupingToClass(CherokeeVillageID, rmClassID("natives"));
			rmAddGroupingConstraint(CherokeeVillageID, avoidImpassableLand);
			rmAddGroupingConstraint(CherokeeVillageID, avoidTradeRoute);
			rmAddGroupingConstraint(CherokeeVillageID, avoidTradeRouteSocket);
			rmAddGroupingConstraint(CherokeeVillageID, nativesAvoidPlayers);
			rmAddGroupingConstraint(CherokeeVillageID, avoidNatives);
			rmAddGroupingConstraint(CherokeeVillageID, edgeConstraint);
			rmAddGroupingConstraint(CherokeeVillageID, avoidCanyon);
			rmPlaceGroupingAtLoc(CherokeeVillageID, 0, 0.5, 0.5);
			if (rmRandFloat(0,1) > 0.6)
			{
				rmPlaceGroupingAtLoc(CherokeeVillageID, 0, 0.5, 0.5);
			}
		}
		else if(nativeChance < 0.59)
		{	
			rmSetSubCiv(i, "Comanche");
			rmEchoInfo("subCiv"+i+" is Comanche");
			ComancheVillageID = rmCreateGrouping("comanche village "+i, "native comanche village "+rmRandInt(1,5));
			rmSetGroupingMinDistance(ComancheVillageID, 0);
			rmSetGroupingMaxDistance(ComancheVillageID, rmXFractionToMeters(0.50));
			rmAddGroupingToClass(ComancheVillageID, rmClassID("natives"));
			rmAddGroupingConstraint(ComancheVillageID, avoidImpassableLand);
			rmAddGroupingConstraint(ComancheVillageID, avoidTradeRoute);
			rmAddGroupingConstraint(ComancheVillageID, avoidTradeRouteSocket);
			rmAddGroupingConstraint(ComancheVillageID, nativesAvoidPlayers);
			rmAddGroupingConstraint(ComancheVillageID, avoidNatives);
			rmAddGroupingConstraint(ComancheVillageID, edgeConstraint);
			rmAddGroupingConstraint(ComancheVillageID, avoidCanyon);
			rmPlaceGroupingAtLoc(ComancheVillageID, 0, 0.5, 0.5);
			if (rmRandFloat(0,1) > 0.6)
			{
				rmPlaceGroupingAtLoc(ComancheVillageID, 0, 0.5, 0.5);
			}
		}
		else if(nativeChance < 0.63)
		{
			rmSetSubCiv(i, "Cree");
			rmEchoInfo("subCiv"+i+" is Cree");
			CreeVillageID = rmCreateGrouping("cree village "+i, "native cree village "+rmRandInt(1,5));
			rmSetGroupingMinDistance(CreeVillageID, 0);
			rmSetGroupingMaxDistance(CreeVillageID, rmXFractionToMeters(0.45));
			rmAddGroupingToClass(CreeVillageID, rmClassID("natives"));
			rmAddGroupingConstraint(CreeVillageID, avoidImpassableLand);
			rmAddGroupingConstraint(CreeVillageID, avoidTradeRoute);
			rmAddGroupingConstraint(CreeVillageID, avoidTradeRouteSocket);
			rmAddGroupingConstraint(CreeVillageID, nativesAvoidPlayers);
			rmAddGroupingConstraint(CreeVillageID, avoidNatives);
			rmAddGroupingConstraint(CreeVillageID, edgeConstraint);
			rmAddGroupingConstraint(CreeVillageID, avoidCanyon);
			rmPlaceGroupingAtLoc(CreeVillageID, 0, 0.5, 0.5);
			if (rmRandFloat(0,1) > 0.6)
			{
				rmPlaceGroupingAtLoc(CreeVillageID, 0, 0.5, 0.5);
			}
		}	
		else if(nativeChance < 0.68)
		{
			rmSetSubCiv(i, "Incas");
			rmEchoInfo("subCiv"+i+" is Incas");
			IncasVillageID = rmCreateGrouping("inca village "+i, "native inca village "+rmRandInt(1,5));
			rmSetGroupingMinDistance(IncasVillageID, 0);
			rmSetGroupingMaxDistance(IncasVillageID, rmXFractionToMeters(0.45));
			rmAddGroupingToClass(IncasVillageID, rmClassID("natives"));
			rmAddGroupingConstraint(IncasVillageID, avoidImpassableLand);
			rmAddGroupingConstraint(IncasVillageID, avoidTradeRoute);
			rmAddGroupingConstraint(IncasVillageID, avoidTradeRouteSocket);
			rmAddGroupingConstraint(IncasVillageID, nativesAvoidPlayers);
			rmAddGroupingConstraint(IncasVillageID, avoidNatives);
			rmAddGroupingConstraint(IncasVillageID, edgeConstraint);
			rmAddGroupingConstraint(IncasVillageID, avoidCanyon);
			rmPlaceGroupingAtLoc(IncasVillageID, 0, 0.5, 0.5);
			if (rmRandFloat(0,1) > 0.6)
			{
				rmPlaceGroupingAtLoc(IncasVillageID, 0, 0.5, 0.5);
			}
		}	
		else if(nativeChance < 0.72)
		{
			rmSetSubCiv(i, "Mapuche");
			rmEchoInfo("subCiv"+i+" is Mapuche");
			MapucheVillageID = rmCreateGrouping("mapuche village "+i, "native mapuche village "+rmRandInt(1,5));
			rmSetGroupingMinDistance(MapucheVillageID, 0);
			rmSetGroupingMaxDistance(MapucheVillageID, rmXFractionToMeters(0.45));
			rmAddGroupingToClass(MapucheVillageID, rmClassID("natives"));
			rmAddGroupingConstraint(MapucheVillageID, avoidImpassableLand);
			rmAddGroupingConstraint(MapucheVillageID, avoidTradeRoute);
			rmAddGroupingConstraint(MapucheVillageID, avoidTradeRouteSocket);
			rmAddGroupingConstraint(MapucheVillageID, nativesAvoidPlayers);
			rmAddGroupingConstraint(MapucheVillageID, avoidNatives);
			rmAddGroupingConstraint(MapucheVillageID, edgeConstraint);
			rmAddGroupingConstraint(MapucheVillageID, avoidCanyon);
			rmPlaceGroupingAtLoc(MapucheVillageID, 0, 0.5, 0.5);
			if (rmRandFloat(0,1) > 0.6)
			{
				rmPlaceGroupingAtLoc(MapucheVillageID, 0, 0.5, 0.5);
			}
		}	
		else if(nativeChance < 0.76)
		{
			rmSetSubCiv(i, "Klamath");
			rmEchoInfo("subCiv"+i+" is Klamath");
			KlamathVillageID = rmCreateGrouping("klamath village "+i, "native klamath village "+rmRandInt(1,5));
			rmSetGroupingMinDistance(KlamathVillageID, 0);
			rmSetGroupingMaxDistance(KlamathVillageID, rmXFractionToMeters(0.45));
			rmAddGroupingToClass(KlamathVillageID, rmClassID("natives"));
			rmAddGroupingConstraint(KlamathVillageID, avoidImpassableLand);
			rmAddGroupingConstraint(KlamathVillageID, avoidTradeRoute);
			rmAddGroupingConstraint(KlamathVillageID, avoidTradeRouteSocket);
			rmAddGroupingConstraint(KlamathVillageID, nativesAvoidPlayers);
			rmAddGroupingConstraint(KlamathVillageID, avoidNatives);
			rmAddGroupingConstraint(KlamathVillageID, edgeConstraint);
			rmAddGroupingConstraint(KlamathVillageID, avoidCanyon);
			rmPlaceGroupingAtLoc(KlamathVillageID, 0, 0.5, 0.5);
			if (rmRandFloat(0,1) > 0.6)
			{
				rmPlaceGroupingAtLoc(KlamathVillageID, 0, 0.5, 0.5);
			}
		}	
		else if(nativeChance < 0.80)
		{
			rmSetSubCiv(i, "Cheyenne");
			rmEchoInfo("subCiv"+i+" is Cheyenne");
			CheyenneVillageID = rmCreateGrouping("cheyenne village "+i, "native cheyenne village "+rmRandInt(1,5));
			rmSetGroupingMinDistance(CheyenneVillageID, 0);
			rmSetGroupingMaxDistance(CheyenneVillageID, rmXFractionToMeters(0.45));
			rmAddGroupingToClass(CheyenneVillageID, rmClassID("natives"));
			rmAddGroupingConstraint(CheyenneVillageID, avoidImpassableLand);
			rmAddGroupingConstraint(CheyenneVillageID, avoidTradeRoute);
			rmAddGroupingConstraint(CheyenneVillageID, avoidTradeRouteSocket);
			rmAddGroupingConstraint(CheyenneVillageID, nativesAvoidPlayers);
			rmAddGroupingConstraint(CheyenneVillageID, avoidNatives);
			rmAddGroupingConstraint(CheyenneVillageID, edgeConstraint);
			rmAddGroupingConstraint(CheyenneVillageID, avoidCanyon);
			rmPlaceGroupingAtLoc(CheyenneVillageID, 0, 0.5, 0.5);
			if (rmRandFloat(0,1) > 0.6)
			{
				rmPlaceGroupingAtLoc(CheyenneVillageID, 0, 0.5, 0.5);
			}
		}		
		else if(nativeChance < 0.85)
		{
			rmSetSubCiv(i, "Maya");
			rmEchoInfo("subCiv"+i+" is Maya");
			MayaVillageID = rmCreateGrouping("maya village "+i, "native maya village "+rmRandInt(1,5));
			rmSetGroupingMinDistance(MayaVillageID, 0);
			rmSetGroupingMaxDistance(MayaVillageID, rmXFractionToMeters(0.45));
			rmAddGroupingToClass(MayaVillageID, rmClassID("natives"));
			rmAddGroupingConstraint(MayaVillageID, avoidImpassableLand);
			rmAddGroupingConstraint(MayaVillageID, avoidTradeRoute);
			rmAddGroupingConstraint(MayaVillageID, avoidTradeRouteSocket);
			rmAddGroupingConstraint(MayaVillageID, nativesAvoidPlayers);
			rmAddGroupingConstraint(MayaVillageID, avoidNatives);
			rmAddGroupingConstraint(MayaVillageID, edgeConstraint);
			rmAddGroupingConstraint(MayaVillageID, avoidCanyon);
			rmPlaceGroupingAtLoc(MayaVillageID, 0, 0.5, 0.5);
			if (rmRandFloat(0,1) > 0.6)
			{
				rmPlaceGroupingAtLoc(MayaVillageID, 0, 0.5, 0.5);
			}
		}
		else if(nativeChance < 0.89)
		{
			rmSetSubCiv(i, "Nootka");
			rmEchoInfo("subCiv"+i+" is Nootka");
			NootkaVillageID = rmCreateGrouping("nootka village "+i, "native nootka village "+rmRandInt(1,5));
			rmSetGroupingMinDistance(NootkaVillageID, 0);
			rmSetGroupingMaxDistance(NootkaVillageID, rmXFractionToMeters(0.45));
			rmAddGroupingToClass(NootkaVillageID, rmClassID("natives"));
			rmAddGroupingConstraint(NootkaVillageID, avoidImpassableLand);
			rmAddGroupingConstraint(NootkaVillageID, avoidTradeRoute);
			rmAddGroupingConstraint(NootkaVillageID, avoidTradeRouteSocket);
			rmAddGroupingConstraint(NootkaVillageID, nativesAvoidPlayers);
			rmAddGroupingConstraint(NootkaVillageID, avoidNatives);
			rmAddGroupingConstraint(NootkaVillageID, edgeConstraint);
			rmAddGroupingConstraint(NootkaVillageID, avoidCanyon);
			rmPlaceGroupingAtLoc(NootkaVillageID, 0, 0.5, 0.5);
			if (rmRandFloat(0,1) > 0.6)
			{
				rmPlaceGroupingAtLoc(NootkaVillageID, 0, 0.5, 0.5);
			}
		}	
		else if(nativeChance < 0.93)
		{
			rmSetSubCiv(i, "Navajo");
			rmEchoInfo("subCiv"+i+" is Navajo");
			NavajoVillageID = rmCreateGrouping("navajo village "+i, "native navajo village "+rmRandInt(1,5));
			rmSetGroupingMinDistance(NavajoVillageID, 0);
			rmSetGroupingMaxDistance(NavajoVillageID, rmXFractionToMeters(0.45));
			rmAddGroupingToClass(NavajoVillageID, rmClassID("natives"));
			rmAddGroupingConstraint(NavajoVillageID, avoidImpassableLand);
			rmAddGroupingConstraint(NavajoVillageID, avoidTradeRoute);
			rmAddGroupingConstraint(NavajoVillageID, avoidTradeRouteSocket);
			rmAddGroupingConstraint(NavajoVillageID, nativesAvoidPlayers);
			rmAddGroupingConstraint(NavajoVillageID, avoidNatives);
			rmAddGroupingConstraint(NavajoVillageID, edgeConstraint);
			rmAddGroupingConstraint(NavajoVillageID, avoidCanyon);
			rmPlaceGroupingAtLoc(NavajoVillageID, 0, 0.5, 0.5);
			if (rmRandFloat(0,1) > 0.6)
			{
				rmPlaceGroupingAtLoc(NavajoVillageID, 0, 0.5, 0.5);
			}
		}	
		else if(nativeChance < 0.96)
		{
			rmSetSubCiv(i, "Seminoles");
			rmEchoInfo("subCiv"+i+" is Seminoles");
			SeminolesVillageID = rmCreateGrouping("seminoles village "+i, "native seminole village "+rmRandInt(1,5));
			rmSetGroupingMinDistance(SeminolesVillageID, 0);
			rmSetGroupingMaxDistance(SeminolesVillageID, rmXFractionToMeters(0.45));
			rmAddGroupingToClass(SeminolesVillageID, rmClassID("natives"));
			rmAddGroupingConstraint(SeminolesVillageID, avoidImpassableLand);
			rmAddGroupingConstraint(SeminolesVillageID, avoidTradeRoute);
			rmAddGroupingConstraint(SeminolesVillageID, avoidTradeRouteSocket);
			rmAddGroupingConstraint(SeminolesVillageID, nativesAvoidPlayers);
			rmAddGroupingConstraint(SeminolesVillageID, avoidNatives);
			rmAddGroupingConstraint(SeminolesVillageID, edgeConstraint);
			rmAddGroupingConstraint(SeminolesVillageID, avoidCanyon);
			rmPlaceGroupingAtLoc(SeminolesVillageID, 0, 0.5, 0.5);
			if (rmRandFloat(0,1) > 0.6)
			{
				rmPlaceGroupingAtLoc(SeminolesVillageID, 0, 0.5, 0.5);
			}
		}		
		else
		{
			rmSetSubCiv(i, "Tupi");
			rmEchoInfo("subCiv"+i+" is Tupi");
			TupiVillageID = rmCreateGrouping("tupi village "+i, "native tupi village "+rmRandInt(1,5));
			rmSetGroupingMinDistance(TupiVillageID, 0);
			rmSetGroupingMaxDistance(TupiVillageID, rmXFractionToMeters(0.45));
			rmAddGroupingToClass(TupiVillageID, rmClassID("natives"));
			rmAddGroupingConstraint(TupiVillageID, avoidImpassableLand);
			rmAddGroupingConstraint(TupiVillageID, avoidTradeRoute);
			rmAddGroupingConstraint(TupiVillageID, avoidTradeRouteSocket);
			rmAddGroupingConstraint(TupiVillageID, avoidPlayers);
			rmAddGroupingConstraint(TupiVillageID, avoidNatives);
			rmAddGroupingConstraint(TupiVillageID, edgeConstraint);
			rmAddGroupingConstraint(TupiVillageID, avoidCanyon);
			rmPlaceGroupingAtLoc(TupiVillageID, 0, 0.5, 0.5);
			if (rmRandFloat(0,1) > 0.6)
			{
				rmPlaceGroupingAtLoc(TupiVillageID, 0, 0.5, 0.5);
			}
		}	
	}


	// Text
   rmSetStatusText("", 0.6);


// ============= Add Cliffs =============

   int numTries=0;
   int failCount=0;



// ============= Add Ponds =============


	if(rmRandFloat(0,1) < 0.45 && sagTest==1 && riverExists==-1)
	{
		rmEchoInfo("ponds exist");
		int numPonds=rmRandInt(2, 3);
		for(i=0; <numPonds)
		{
			int smallPondID=rmCreateArea("small pond "+i);
			rmSetAreaSize(smallPondID, rmAreaTilesToFraction(170), rmAreaTilesToFraction(400));
			rmSetAreaWaterType(smallPondID, pondName);
			rmSetAreaMinBlobs(smallPondID, 1);
			rmSetAreaMaxBlobs(smallPondID, 5);
			rmSetAreaBaseHeight(smallPondID, 4);
			rmSetAreaMinBlobDistance(smallPondID, 5.0);
			rmSetAreaMaxBlobDistance(smallPondID, 70.0);
			rmAddAreaToClass(smallPondID, pondClass);
			rmSetAreaCoherence(smallPondID, 0.5);
			rmSetAreaSmoothDistance(smallPondID, 5);
			rmAddAreaConstraint(smallPondID, pondConstraint);
			rmAddAreaConstraint(smallPondID, avoidPlayers);
			rmAddAreaConstraint(smallPondID, avoidNatives);
			rmAddAreaConstraint(smallPondID, mediumAvoidImpassableLand);
			rmAddAreaConstraint(smallPondID, avoidCanyon);
			rmAddAreaConstraint(smallPondID, edgeConstraint);
			rmAddAreaConstraint(smallPondID, avoidTradeRoute);
			rmSetAreaWarnFailure(smallPondID, false);
			rmBuildArea(smallPondID);
		}
	}

	// Text
   rmSetStatusText("", 0.7);

// ============= Add Forests =============

	numTries=12*cNumberNonGaiaPlayers;
	failCount = 0;
	int sparseForests = -1;

   for (i=0; <numTries)
	{   
      int forest=rmCreateArea("forest "+i);
      rmSetAreaWarnFailure(forest, false);
      rmSetAreaSize(forest, rmAreaTilesToFraction(70), rmAreaTilesToFraction(100));
      rmSetAreaForestType(forest, forestName);
      rmSetAreaForestDensity(forest, 0.8);
      rmSetAreaForestClumpiness(forest, 0.6);
      rmSetAreaForestUnderbrush(forest, 0.0);
      rmSetAreaMinBlobs(forest, 1);
      rmSetAreaMaxBlobs(forest, 5);
      rmSetAreaMinBlobDistance(forest, 16.0);
      rmSetAreaMaxBlobDistance(forest, 60.0);
      rmSetAreaCoherence(forest, 0.4);
      rmSetAreaSmoothDistance(forest, 0);
      rmAddAreaToClass(forest, rmClassID("classForest")); 
      rmAddAreaConstraint(forest, forestConstraint);
      rmAddAreaConstraint(forest, avoidTC);
      rmAddAreaConstraint(forest, avoidCW);
      rmAddAreaConstraint(forest, avoidAll);
      rmAddAreaConstraint(forest, avoidCanyon);
      rmAddAreaConstraint(forest, mediumAvoidImpassableLand); 
      rmAddAreaConstraint(forest, avoidTradeRoute);

      if(rmBuildArea(forest)==false)
      {
         // Stop trying once we fail 3 times in a row.
         failCount++;
         if(failCount==5)
            break;
      }
      else
         failCount=0; 
	}
	
	// Text
   rmSetStatusText("", 0.8);

// ============= Starting Resources =============

// Silver

	int playerSilverID = rmCreateObjectDef("player silver");
	rmAddObjectDefItem(playerSilverID, "mine", 1, 0);
	rmAddObjectDefConstraint(playerSilverID, avoidTradeRoute);
	rmSetObjectDefMinDistance(playerSilverID, 18.0);
	rmSetObjectDefMaxDistance(playerSilverID, 22.0);
	rmAddObjectDefConstraint(playerSilverID, avoidAll);
	rmAddObjectDefConstraint(playerSilverID, avoidSilver1);
   rmAddObjectDefConstraint(playerSilverID, shortAvoidImpassableLand);

	int playerBerryID=rmCreateObjectDef("player berries");
   rmAddObjectDefItem(playerBerryID, "berryBush", rmRandInt(2,3), 2.0);
   rmSetObjectDefMinDistance(playerBerryID, 10);
   rmSetObjectDefMaxDistance(playerBerryID, 15);
	rmAddObjectDefConstraint(playerBerryID, avoidAll);
   rmAddObjectDefConstraint(playerBerryID, shortAvoidImpassableLand);

	int playerTreeID=rmCreateObjectDef("player trees");
   rmAddObjectDefItem(playerTreeID, treeName, 1, 0.0);
	rmAddObjectDefConstraint(playerTreeID, avoidTradeRoute);
   rmSetObjectDefMinDistance(playerTreeID, 8);
   rmSetObjectDefMaxDistance(playerTreeID, 12);
	rmAddObjectDefConstraint(playerTreeID, avoidAll);
   rmAddObjectDefConstraint(playerTreeID, shortAvoidImpassableLand);

   int nearDeerID=rmCreateObjectDef("herds near town");
   rmAddObjectDefItem(nearDeerID, critterOneName, 5, 6.0);
   rmSetObjectDefMinDistance(nearDeerID, 6);
   rmSetObjectDefMaxDistance(nearDeerID, 11);
   rmAddObjectDefConstraint(nearDeerID, avoidFood);
	rmAddObjectDefConstraint(nearDeerID, avoidAll);
   rmAddObjectDefConstraint(nearDeerID, avoidImpassableLand);
   rmSetObjectDefCreateHerd(nearDeerID, true);

	int farDeerID=rmCreateObjectDef("herds far away");
      rmAddObjectDefItem(farDeerID, critterTwoName, rmRandInt(14,16), 8.0);
   rmSetObjectDefMinDistance(farDeerID, 38);
   rmSetObjectDefMaxDistance(farDeerID, 52);
   rmAddObjectDefConstraint(farDeerID, avoidFood);
	rmAddObjectDefConstraint(farDeerID, avoidAll);
   rmAddObjectDefConstraint(farDeerID, avoidImpassableLand);
   rmAddObjectDefConstraint(farDeerID, avoidCanyon);
   rmAddObjectDefConstraint(farDeerID, avoidForestMin);
   rmAddObjectDefConstraint(farDeerID, avoidPond);
   rmAddObjectDefConstraint(farDeerID, avoidEdge);
   rmSetObjectDefCreateHerd(farDeerID, true);

	int startSilver3ID = rmCreateObjectDef("player farther silver");
	rmAddObjectDefItem(startSilver3ID, "mine", 1, 0.0);
	rmSetObjectDefMinDistance(startSilver3ID, 60.0);
	rmSetObjectDefMaxDistance(startSilver3ID, 65.0);
	rmAddObjectDefConstraint(startSilver3ID, avoidAll);
	rmAddObjectDefConstraint(startSilver3ID, avoidSilver);
	rmAddObjectDefConstraint(startSilver3ID, avoidEdge);

   // Extra tree clumps near players - to ensure fair access to wood
      int extraTreesID=rmCreateObjectDef("extra trees");
      rmAddObjectDefItem(extraTreesID, treeName, 6, 6.0);
      rmSetObjectDefMinDistance(extraTreesID, 20);
      rmSetObjectDefMaxDistance(extraTreesID, 23);
      rmAddObjectDefConstraint(extraTreesID, avoidAll);


	int nugget1= rmCreateObjectDef("nugget easy"); 
	rmAddObjectDefItem(nugget1, "Nugget", 1, 0.0);
	rmSetNuggetDifficulty(1, 1);
	rmAddObjectDefConstraint(nugget1, shortAvoidImpassableLand);
  	rmAddObjectDefConstraint(nugget1, avoidNugget);
  	rmAddObjectDefConstraint(nugget1, avoidTradeRoute);
  	rmAddObjectDefConstraint(nugget1, avoidAll);
	rmSetObjectDefMinDistance(nugget1, 28.0);
	rmSetObjectDefMaxDistance(nugget1, 35.0);

	int nugget2= rmCreateObjectDef("nugget medium"); 
	rmAddObjectDefItem(nugget2, "Nugget", 1, 0.0);
	rmSetNuggetDifficulty(1, 1);
	rmSetObjectDefMinDistance(nugget2, 0.0);
	rmSetObjectDefMaxDistance(nugget2, rmXFractionToMeters(0.5));
	rmAddObjectDefConstraint(nugget2, shortAvoidImpassableLand);
  	rmAddObjectDefConstraint(nugget2, avoidNugget);
  	rmAddObjectDefConstraint(nugget2, avoidTC);
  	rmAddObjectDefConstraint(nugget2, avoidCW);
  	rmAddObjectDefConstraint(nugget2, avoidCanyon);
  	rmAddObjectDefConstraint(nugget2, avoidTradeRoute);
  	rmAddObjectDefConstraint(nugget2, avoidAll);
	rmSetObjectDefMinDistance(nugget2, 28.0);
	rmSetObjectDefMaxDistance(nugget2, 35.0);

	int waterFlagID=rmCreateObjectDef("HC water flag");
	int placeWaterFlag = -1;
	rmAddObjectDefItem(waterFlagID, "HomeCityWaterSpawnFlag", 1, 0.0);
	rmSetObjectDefMinDistance(waterFlagID, 0.0);
	rmSetObjectDefMaxDistance(waterFlagID, rmXFractionToMeters(0.5));
   rmAddObjectDefConstraint(waterFlagID, edgeConstraint);
	rmAddObjectDefConstraint(waterFlagID, flagVsFlag);
	rmAddObjectDefConstraint(waterFlagID, fishLand);

	// Define a parm for placing water flags on water maps
	if (oceanMiddle == 1)
		placeWaterFlag = 1;
	else if (oceanOffCenter == 1)
		placeWaterFlag = 1;
	else if (oceanRing == 1)
		placeWaterFlag = 1;

	// Now place all these definitions

	float bonusSilverChance = rmRandFloat(0,1);
	float bonusTreeChance = rmRandFloat(0,1);
	float bonusNuggetChance1 = rmRandFloat(0,1);
	float bonusNuggetChance2 = rmRandFloat(0,1);
	float berryChance = rmRandFloat(0,1);
	float bonusFoodChance = rmRandFloat(0,1);

	for(i=1; <cNumberPlayers)
	{
		vector TCLocation = rmGetUnitPosition(rmGetUnitPlacedOfPlayer(startingTCID, i));
		vector closestPoint = rmFindClosestPointVector(TCLocation, rmXFractionToMeters(1.0));

		rmPlaceObjectDefAtLoc(startingUnits, i, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));

		// SILVER
		// Always two silver
		rmPlaceObjectDefAtLoc(playerSilverID, 0, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));
		rmPlaceObjectDefAtLoc(playerSilverID, 0, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));
		rmPlaceObjectDefAtLoc(startSilver3ID, 0, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));

		// TREES
		// Have 4-6 trees, unless sparse
		rmPlaceObjectDefAtLoc(playerTreeID, 0, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));
 		rmPlaceObjectDefAtLoc(playerTreeID, 0, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));
		rmPlaceObjectDefAtLoc(playerTreeID, 0, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));
		rmPlaceObjectDefAtLoc(playerTreeID, 0, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));
		if (bonusTreeChance > 0.5)
			rmPlaceObjectDefAtLoc(playerTreeID, 0, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));
		if (bonusTreeChance > 0.8)
			rmPlaceObjectDefAtLoc(playerTreeID, 0, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));
		// If sparse forests, add extra trees
		if (sparseForests == 1)
		{
			rmPlaceObjectDefAtLoc(playerTreeID, 0, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));
 			rmPlaceObjectDefAtLoc(playerTreeID, 0, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));
			rmPlaceObjectDefAtLoc(playerTreeID, 0, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));
			rmPlaceObjectDefAtLoc(playerTreeID, 0, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));
			rmPlaceObjectDefAtLoc(playerTreeID, 0, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));
			rmPlaceObjectDefAtLoc(playerTreeID, 0, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));
		}
		rmPlaceObjectDefAtLoc(extraTreesID, 0, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));
		// NUGGETS
		// Always 1 of type I. Can have +1 or +2 of type I and +1 or +2 of type II
		rmPlaceObjectDefAtLoc(nugget1, 0, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));
		rmPlaceObjectDefAtLoc(nugget2, 0, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));

		// FOOD
		// Always 1 near and 1 far. Sometimes +1 or +2 far.
		rmPlaceObjectDefAtLoc(nearDeerID, 0, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));
		rmPlaceObjectDefAtLoc(farDeerID, 0, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));

		// BERRIES
		// 30% of the time
		if (berryChance > 0.7)
			rmPlaceObjectDefAtLoc(playerBerryID, 0, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));


    // Monastery
    if(ypIsAsian(i) && rmGetNomadStart() == false)
      rmPlaceObjectDefAtLoc(ypMonasteryBuilder(i, 1), i, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));

		// WATER FLAG
		if (placeWaterFlag == 1)
			rmPlaceObjectDefAtLoc(waterFlagID, i, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));

	}


	// Text
   rmSetStatusText("", 0.9);


// ============= Other Resources =============


//Food
   int bisonID=rmCreateObjectDef("bison herd");
   rmAddObjectDefItem(bisonID, critterOneName, rmRandInt(12,16), 8.0);
   rmSetObjectDefMinDistance(bisonID, 0.0);
   rmSetObjectDefMaxDistance(bisonID, rmXFractionToMeters(0.5));
   rmAddObjectDefConstraint(bisonID, avoidAll);
   rmAddObjectDefConstraint(bisonID, avoidImpassableLand);
   rmAddObjectDefConstraint(bisonID, avoidPlayersFar1);
   rmAddObjectDefConstraint(bisonID, avoidFood1);
   rmAddObjectDefConstraint(bisonID, avoidFood2);
   rmAddObjectDefConstraint(bisonID, avoidEdge);
   rmAddObjectDefConstraint(bisonID, avoidForestMin);
   rmAddObjectDefConstraint(bisonID, avoidPond);
   rmSetObjectDefCreateHerd(bisonID, true);
   rmPlaceObjectDefAtLoc(bisonID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*2);

   int pronghornID=rmCreateObjectDef("pronghorn herd");
   rmAddObjectDefItem(pronghornID, critterTwoName, rmRandInt(7,8), 10.0);
   rmSetObjectDefMinDistance(pronghornID, 0.0);
   rmSetObjectDefMaxDistance(pronghornID, rmXFractionToMeters(0.5));
   rmAddObjectDefConstraint(pronghornID, avoidAll);
   rmAddObjectDefConstraint(pronghornID, avoidImpassableLand);
   rmAddObjectDefConstraint(pronghornID, avoidPlayersFar1);
   rmAddObjectDefConstraint(pronghornID, avoidFood1);
   rmAddObjectDefConstraint(pronghornID, avoidFood2);
   rmAddObjectDefConstraint(pronghornID, avoidEdge);
   rmAddObjectDefConstraint(pronghornID, avoidPond);
   rmAddObjectDefConstraint(pronghornID, avoidForestMin);
   rmSetObjectDefCreateHerd(pronghornID, true);
   rmPlaceObjectDefAtLoc(pronghornID, 0, 0.5, 0.5, 2*cNumberNonGaiaPlayers+1);

// Silver

	int silverID = -1;
	int silverCount = (cNumberNonGaiaPlayers*2);
	rmEchoInfo("silver count = "+silverCount);

	for(i=0; < silverCount)
	{
      silverID = rmCreateObjectDef("silver "+i);
	   rmAddObjectDefItem(silverID, "mine", 1, 0.0);
      rmSetObjectDefMinDistance(silverID, 0.0);
      rmSetObjectDefMaxDistance(silverID, rmXFractionToMeters(0.5));
		rmAddObjectDefConstraint(silverID, avoidSilver);
      rmAddObjectDefConstraint(silverID, avoidAll);
		if(oceanRing == 1)
			rmAddObjectDefConstraint(silverID, avoidPlayers);
		else
			rmAddObjectDefConstraint(silverID, avoidPlayersFar);
      rmAddObjectDefConstraint(silverID, avoidImpassableLand);
      rmAddObjectDefConstraint(silverID, avoidTradeRoute);
      rmAddObjectDefConstraint(silverID, avoidEdge);
		rmPlaceObjectDefAtLoc(silverID, 0, 0.5, 0.5);
   }

// Livestock

	int sheepID=rmCreateObjectDef("livestock");
	rmAddObjectDefItem(sheepID, livestockName, 2, 4.0);
	rmSetObjectDefMinDistance(sheepID, 0.0);
	rmSetObjectDefMaxDistance(sheepID, rmXFractionToMeters(0.5));
	rmAddObjectDefConstraint(sheepID, avoidFood);
	rmAddObjectDefConstraint(sheepID, avoidAll);
	if(oceanRing == 1)
		rmAddObjectDefConstraint(sheepID, avoidPlayers);
	else
		rmAddObjectDefConstraint(sheepID, avoidPlayersFar);
	rmAddObjectDefConstraint(sheepID, avoidCanyon);
	rmAddObjectDefConstraint(sheepID, avoidImpassableLand);
	if(rmRandFloat(0,1) > 0.85)
		rmPlaceObjectDefAtLoc(sheepID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*2);

// Treasures
   
	int nuggetID= rmCreateObjectDef("nugget"); 
	rmAddObjectDefItem(nuggetID, "Nugget", 1, 0.0);
	rmSetObjectDefMinDistance(nuggetID, 0.0);
	rmSetObjectDefMaxDistance(nuggetID, rmXFractionToMeters(0.5));
	rmAddObjectDefConstraint(nuggetID, shortAvoidImpassableLand);
  	rmAddObjectDefConstraint(nuggetID, avoidNugget);
  	rmAddObjectDefConstraint(nuggetID, avoidPlayersFar);
  	rmAddObjectDefConstraint(nuggetID, avoidTradeRoute);
  	rmAddObjectDefConstraint(nuggetID, avoidAll);
	rmSetNuggetDifficulty(1, 3);
	rmPlaceObjectDefAtLoc(nuggetID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*4);
  // check for KOTH game mode
  if(rmGetIsKOTH()) {
    
    int randLoc = rmRandInt(1,3);
    float xLoc = 0.5;
    float yLoc = 0.5;
    float walk = 0.05;
    
    //~ if(randLoc == 1 && blockedMiddle != 1)
      //~ yLoc = .5;
      
    //~ if(cNumberTeams > 2 && blockedMiddle != 1) {
      //~ yLoc = rmRandFloat(.25, .75);
      //~ walk = 0.25;
    //~ }
    
    //~ else if(cNumberTeams > 2){
      //~ yLoc = .3;
      //~ walk = 0.5;
    //~ }
    
    ypKingsHillPlacer(xLoc, yLoc, walk, avoidCanyon);
    rmEchoInfo("XLOC = "+xLoc);
    rmEchoInfo("XLOC = "+yLoc);
  }

// add fish if ocean
	if (placeWaterFlag == 1)
	{
		int fishID=rmCreateObjectDef("fish");
		rmAddObjectDefItem(fishID, fishName, 1, 0.0);
		rmSetObjectDefMinDistance(fishID, 0.0);
		rmSetObjectDefMaxDistance(fishID, rmXFractionToMeters(0.5));
		rmAddObjectDefConstraint(fishID, fishVsFishID);
		rmAddObjectDefConstraint(fishID, fishLand);
		rmPlaceObjectDefAtLoc(fishID, 0, 0.5, 0.5, 3*cNumberNonGaiaPlayers + 4);

		int whaleID=rmCreateObjectDef("whale");
		rmAddObjectDefItem(whaleID, whaleName, 1, 9.0);
		rmSetObjectDefMinDistance(whaleID, 0.0);
		rmSetObjectDefMaxDistance(whaleID, rmXFractionToMeters(0.5));
		rmAddObjectDefConstraint(whaleID, whaleVsWhaleID);
		rmAddObjectDefConstraint(whaleID, whaleLand);
		if(rmRandFloat(0,0.4) < 0.5)
			rmPlaceObjectDefAtLoc(whaleID, 0, 0.5, 0.5, cNumberNonGaiaPlayers + 1);
	}

  // Text
   rmSetStatusText("",1.0);

	// DONE!!!!


}