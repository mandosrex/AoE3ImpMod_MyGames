// Northern Lakes
// a random map for AOE3: TAD
// by RF_Gandalf

include "mercenaries.xs";
include "ypAsianInclude.xs";
include "ypKOTHInclude.xs";

void main(void)
{
   // Text
   rmSetStatusText("",0.01);

// Set up for variables
   string baseType = "";
   string seaType = "";
   string forestType = "";
   string patchType = "";
   string treeType = "";
   string sheepType = "";

// Map variation variables
   int whichVariation = rmRandInt(1,2);
   int nativeSetup = rmRandInt(1,6);
   int whichNative = rmRandInt(1,7);

// Which trade route?
   int whichTradeRoute = rmRandInt(1,3);  // if 3 there are 2 trade routes.
   if ( cNumberTeams > 2 ) // if FFA, do single route.
   {
 	whichTradeRoute = 1;
   }

// Chooses which natives appear on the map
   int subCiv0=-1;
   int subCiv1=-1;
   int subCiv2=-1;
   int subCiv3=-1;

   if (rmAllocateSubCivs(4) == true)
   {
      subCiv0=rmGetCivID("Cree");
      rmEchoInfo("subCiv0 is Cree "+subCiv0);
      if (subCiv0 >= 0)
         rmSetSubCiv(0, "Cree");

	subCiv1=rmGetCivID("Cree");
      rmEchoInfo("subCiv1 is Cree "+subCiv1);
	if (subCiv1 >= 0)
	   rmSetSubCiv(1, "Cree");
	 
	subCiv2=rmGetCivID("Huron");
      rmEchoInfo("subCiv2 is Huron "+subCiv2);
      if (subCiv2 >= 0)
         rmSetSubCiv(2, "Huron");

	subCiv3=rmGetCivID("Huron");
      rmEchoInfo("subCiv3 is Huron "+subCiv3);
      if (subCiv3 >= 0)
         rmSetSubCiv(3, "Huron");
   }

   // Text
   rmSetStatusText("",0.05);

// Picks the map size
   int playerTiles=11500;
   if (cNumberNonGaiaPlayers >2)
	playerTiles = 11000;
   if (cNumberNonGaiaPlayers >4)
	playerTiles = 10000;
   if (cNumberNonGaiaPlayers >6)
	playerTiles = 9000;
   int size=2.0*sqrt(cNumberNonGaiaPlayers*playerTiles);
   rmEchoInfo("Map size="+size+"m x "+size+"m");
   rmSetMapSize(size, size);

// Picks a default water height
   rmSetSeaLevel(1.0);

// Picks default terrain and water
   // rmSetMapElevationParameters(long type, float minFrequency, long numberOctaves, float persistence, float heightVariation)
   rmSetMapElevationParameters(cElevTurbulence, 0.1, 4, 0.3, 2.0);

   int patternChance = rmRandInt(1,3);

   if (patternChance == 1)
   {
      rmSetLightingSet("saguenay");
      rmSetSeaType("hudson bay");
      rmSetMapType("saguenay");
      rmSetBaseTerrainMix("saguenay tundra");
      baseType = "saguenay tundra";
      seaType = "hudson bay";
	patchType = "saguenay grass";
      forestType = "great lakes forest";
      treeType = "TreeGreatLakes";
   }
   else if (patternChance == 2)
   {
      rmSetLightingSet("nwterritory");
      rmSetSeaType("Northwest Territory Water");   
      rmSetMapType("northwestTerritory");
      rmSetBaseTerrainMix("nwt_grass1");
      baseType =  "nwt_grass1";
      seaType = "Northwest Territory Water";
	patchType = "nwt_grass1";
	if (rmRandInt(1,2) == 1)
	{
         forestType = "NW Territory Birch Forest";
         treeType = "TreeGreatLakes";
	}
	else
	{
	   forestType = "NW Territory Forest";
	   treeType = "TreeGreatPlains"; 
	} 
   }
   else if (patternChance == 3)
   {
      rmSetLightingSet("siberia");
      rmSetSeaType("great lakes ice");
      rmSetMapType("yukon");
      rmSetBaseTerrainMix("rockies_grass_snowb");
      baseType = "rockies_grass_snowb";
      seaType = "great lakes ice";
	patchType = "rockies_snow";
	forestType = "Yukon Snow Forest";
	treeType = "TreeYukonSnow";
   }

   rmTerrainInitialize("saguenay\ground1_sag",3);
   rmSetMapType("water");
   rmSetMapType("grass");
   rmEnableLocalWater(false);
   rmSetWorldCircleConstraint(true);

// Choose mercs.
   chooseMercs();

// Define some classes. These are used later for constraints.
   int classPlayer=rmDefineClass("player");
   rmDefineClass("classCliff");
   rmDefineClass("classPatch");
   int classbigContinent=rmDefineClass("big continent");
   rmDefineClass("starting settlement");
   rmDefineClass("startingUnit");
   rmDefineClass("classForest");
   rmDefineClass("importantItem");
   rmDefineClass("nuggets");
   rmDefineClass("bay");
   rmDefineClass("classSocket");
   rmDefineClass("natives");
   int classHuntable=rmDefineClass("huntableFood");   

// -------------Define constraints
   // Map edge constraints
   int playerEdgeConstraint=rmCreateBoxConstraint("player edge of map", rmXTilesToFraction(20), rmZTilesToFraction(20), 1.0-rmXTilesToFraction(20), 1.0-rmZTilesToFraction(20), 0.01);
   int circleConstraint=rmCreatePieConstraint("circle Constraint", 0.5, 0.5, 0, rmZFractionToMeters(0.47), rmDegreesToRadians(0), rmDegreesToRadians(360));

   // Player constraints
   int playerConstraint=rmCreateClassDistanceConstraint("stay away from players", classPlayer, 15.0);
   int medPlayerConstraint=rmCreateClassDistanceConstraint("stay away from players med", classPlayer, 35.0);
   int longPlayerConstraint=rmCreateClassDistanceConstraint("land stays away from players", classPlayer, 45.0); 
   int farPlayerConstraint=rmCreateClassDistanceConstraint("stay away from players more", classPlayer, 55.0);
   int nativePlayerConstraint=rmCreateClassDistanceConstraint("native stays away from players", classPlayer, 24.0);

   // Bonus area constraint.
   int bigContinentConstraint=rmCreateClassDistanceConstraint("avoid bonus island", classbigContinent, 20.0);

   // Resource avoidance
   int forestConstraint=rmCreateClassDistanceConstraint("forest vs. forest", rmClassID("classForest"), 20.0);
   int avoidStartResource=rmCreateTypeDistanceConstraint("start resource no overlap", "resource", 1.0);
   int avoidCoin=rmCreateTypeDistanceConstraint("avoid coin", "gold", 50.0);
   int avoidCoinShort=rmCreateTypeDistanceConstraint("avoid coin short", "gold", 25.0);
   int avoidNugget=rmCreateTypeDistanceConstraint("nugget avoid nugget", "AbstractNugget", 50.0);
   int huntableConstraint=rmCreateClassDistanceConstraint("huntable constraint", rmClassID("huntableFood"), 30.0);
   int shortHuntableConstraint=rmCreateClassDistanceConstraint("short huntable constraint", rmClassID("huntableFood"), 20.0);
   int longHuntableConstraint=rmCreateClassDistanceConstraint("long huntable constraint", rmClassID("huntableFood"), 37.0);
   int fishVsFishID=rmCreateTypeDistanceConstraint("fish v fish", "fish", 18.0);
   int fishLand = rmCreateTerrainDistanceConstraint("fish land", "land", true, 6.0);
   int whaleLand = rmCreateTerrainDistanceConstraint("whale v. land", "land", true, 15.0);
   int avoidSheep=rmCreateTypeDistanceConstraint("sheep avoids sheep", "sheep", 40.0);

   // Avoid impassable land
   int avoidImpassableLand=rmCreateTerrainDistanceConstraint("avoid impassable land", "Land", false, 10.0);
   int shortAvoidImpassableLand=rmCreateTerrainDistanceConstraint("short avoid impassable land", "Land", false, 2.0);
   int avoidCliffs=rmCreateClassDistanceConstraint("cliff vs. cliff", rmClassID("classCliff"), 30.0);
   int patchConstraint=rmCreateClassDistanceConstraint("patch vs. patch", rmClassID("classPatch"), 5.0);
   int avoidHudsonSmall=rmCreateClassDistanceConstraint("inner land avoids bay", rmClassID("bay"), rmXFractionToMeters(0.15));
   int avoidHudsonLarge=rmCreateClassDistanceConstraint("outer land avoids bay", rmClassID("bay"), rmXFractionToMeters(0.3));

   // Unit avoidance
   int avoidStartingUnits=rmCreateClassDistanceConstraint("objects avoid starting units", rmClassID("startingUnit"), 20.0);
   int avoidStartingUnitsSmall=rmCreateClassDistanceConstraint("objects avoid starting units small", rmClassID("startingUnit"), 5.0);
   int avoidStartingUnitsBay=rmCreateClassDistanceConstraint("bay avoids starting units", rmClassID("startingUnit"), 35.0);
   int avoidImportantItem = rmCreateClassDistanceConstraint("avoid important objects", rmClassID("importantItem"), 50.0);
   int avoidAll=rmCreateTypeDistanceConstraint("avoid all", "all", 6.0);
   int avoidNativesMed=rmCreateClassDistanceConstraint("stuff avoids natives medium", rmClassID("natives"), 35.0);
   int avoidNativesShort=rmCreateClassDistanceConstraint("stuff avoids natives short", rmClassID("natives"), 12.0);

   // Trade route avoidance.
   int avoidTradeRoute = rmCreateTradeRouteDistanceConstraint("trade route", 6.0);
   int avoidTradeRouteFar = rmCreateTradeRouteDistanceConstraint("trade route long", 15.0);
   int avoidSocket = rmCreateClassDistanceConstraint("avoid socket", rmClassID("classSocket"), 10.0);

   // Constraint to avoid water.
   int avoidWater8 = rmCreateTerrainDistanceConstraint("avoid water", "Land", false, 8.0);
   int avoidWater16 = rmCreateTerrainDistanceConstraint("avoid water 16", "Land", false, 13.0);

   // Cardinal Direction
   int Southward=rmCreatePieConstraint("southMapConstraint", 0.5, 0.5, 0, rmZFractionToMeters(0.5), rmDegreesToRadians(135), rmDegreesToRadians(315));
   int Eastward=rmCreatePieConstraint("eastMapConstraint", 0.5, 0.5, 0, rmZFractionToMeters(0.5), rmDegreesToRadians(45), rmDegreesToRadians(225));
   int Westward=rmCreatePieConstraint("westMapConstraint", 0.5, 0.5, 0, rmZFractionToMeters(0.5), rmDegreesToRadians(225), rmDegreesToRadians(45));

   // Text
   rmSetStatusText("",0.10);

   int OuterLandID=rmCreateArea("main land area");
   rmSetAreaWarnFailure(OuterLandID, false);
   rmSetAreaLocation(OuterLandID, 0.5, 0.5);
   rmSetAreaSize(OuterLandID, 1, 1);
   rmSetAreaBaseHeight(OuterLandID, 3.0);
   rmSetAreaElevationType(OuterLandID, cElevTurbulence);
   rmSetAreaElevationVariation(OuterLandID, 2.0);
   rmSetAreaElevationMinFrequency(OuterLandID, 0.1);
   rmSetAreaElevationOctaves(OuterLandID, 4);
   rmSetAreaElevationPersistence(OuterLandID, 0.4);
   rmSetAreaMix(OuterLandID, baseType);
   rmBuildArea(OuterLandID);

   int InnerLandID=rmCreateArea("smaller area center");
   rmSetAreaWarnFailure(InnerLandID, false);
   rmSetAreaLocation(InnerLandID, 0.5, 0.5);
   rmSetAreaSize(InnerLandID, 0.35, 0.35);
   rmSetAreaBaseHeight(InnerLandID, 3.0);
   rmSetAreaElevationType(InnerLandID, cElevTurbulence);
   rmSetAreaElevationVariation(InnerLandID, 2.0);
   rmSetAreaElevationMinFrequency(InnerLandID, 0.1);
   rmSetAreaElevationOctaves(InnerLandID, 4);
   rmSetAreaElevationPersistence(InnerLandID, 0.5);
   rmSetAreaMinBlobs(InnerLandID, 8);
   rmSetAreaMaxBlobs(InnerLandID, 10);
   rmSetAreaMinBlobDistance(InnerLandID, 10);
   rmSetAreaMaxBlobDistance(InnerLandID, 20);
   rmSetAreaMix(InnerLandID, patchType);

   // Text
   rmSetStatusText("",0.15);

// KOTH game mode
   if(rmGetIsKOTH())
   {
      float xLoc = 0.5;
      float yLoc = 0.5;
      float walk = 0.03;
      
      ypKingsHillPlacer(yLoc, yLoc, walk, 0);
      rmEchoInfo("XLOC = "+yLoc);
      rmEchoInfo("XLOC = "+yLoc);

 	whichTradeRoute = 3;
   }

// Trade routes 
   // rmAddTradeRouteWaypoint(tradeRouteID, xFraction, zFraction)
   // rmAddRandomTradeRouteWaypoints(tradeRouteID, endXFraction, endZFraction, count, maxVariation) 

   int socketID=rmCreateObjectDef("sockets");
   rmAddObjectDefItem(socketID, "SocketTradeRoute", 1, 0.0);
   rmSetObjectDefAllowOverlap(socketID, true);
   rmAddObjectDefToClass(socketID, rmClassID("classSocket"));
   rmSetObjectDefMinDistance(socketID, 0.0);
   rmSetObjectDefMaxDistance(socketID, 8.0);

if (whichTradeRoute == 3)
{
   // N trade route 
   int tradeRouteNID = rmCreateTradeRoute();
   rmAddTradeRouteWaypoint(tradeRouteNID, 0.58, 1.0);  
   rmAddRandomTradeRouteWaypoints(tradeRouteNID, 0.41, 0.65, 3, 10);
   rmAddRandomTradeRouteWaypoints(tradeRouteNID, 0.45, 0.56, 2, 5); 
   rmBuildTradeRoute(tradeRouteNID, "dirt");

   // add the meeting poles along the trade route.
   rmSetObjectDefTradeRouteID(socketID, tradeRouteNID);

   vector socketLoc = rmGetTradeRouteWayPoint(tradeRouteNID, 0);
   socketLoc = rmGetTradeRouteWayPoint(tradeRouteNID, 0.3);
   rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);

   socketLoc = rmGetTradeRouteWayPoint(tradeRouteNID, 0.67);
   rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);

   // S trade route 
   int tradeRouteSID = rmCreateTradeRoute();
   rmAddTradeRouteWaypoint(tradeRouteSID, 0.42, 0.0);  
   rmAddRandomTradeRouteWaypoints(tradeRouteSID, 0.59, 0.35, 3, 10);
   rmAddRandomTradeRouteWaypoints(tradeRouteSID, 0.55, 0.44, 2, 5); 
   rmBuildTradeRoute(tradeRouteSID, "dirt");

   // add the meeting poles along the trade route.
   rmSetObjectDefTradeRouteID(socketID, tradeRouteSID);

   socketLoc = rmGetTradeRouteWayPoint(tradeRouteSID, 0.3);
   rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);

   socketLoc = rmGetTradeRouteWayPoint(tradeRouteSID, 0.67);
   rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);

}
else
{
   int tradeRouteID = rmCreateTradeRoute();
   rmAddTradeRouteWaypoint(tradeRouteID, 0.58, 1.0);  
   rmAddRandomTradeRouteWaypoints(tradeRouteID, 0.41, 0.65, 4, 12);
   rmAddRandomTradeRouteWaypoints(tradeRouteID, 0.59, 0.35, 3, 8); 
   rmAddRandomTradeRouteWaypoints(tradeRouteID, 0.42, 0.0, 4, 12);
   rmBuildTradeRoute(tradeRouteID, "dirt");

   // add the meeting poles along the trade route.
   rmSetObjectDefTradeRouteID(socketID, tradeRouteID);
   socketLoc = rmGetTradeRouteWayPoint(tradeRouteID, 0.08);
   rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);
   if ( whichVariation == 1 )
   {
	socketLoc = rmGetTradeRouteWayPoint(tradeRouteID, 0.28);
	rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);

      socketLoc = rmGetTradeRouteWayPoint(tradeRouteID, 0.5);
      rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);

	socketLoc = rmGetTradeRouteWayPoint(tradeRouteID, 0.72);
	rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);
   }
   else
   {
	socketLoc = rmGetTradeRouteWayPoint(tradeRouteID, 0.39);
	rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);

	socketLoc = rmGetTradeRouteWayPoint(tradeRouteID, 0.61);
	rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);
   }
   socketLoc = rmGetTradeRouteWayPoint(tradeRouteID, 0.92);
   rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);
}

   // Text
   rmSetStatusText("",0.20);

// Player placement 
   int playerSide = rmRandInt(1,2);
   if (cNumberTeams == 2)
   {
	if (cNumberNonGaiaPlayers == 2)
      {
         rmSetPlacementTeam(0);
	   if (playerSide == 1)
	   {
            rmSetPlacementSection(0.27, 0.28);
	   }
	   else
	   {
            rmSetPlacementSection(0.83, 0.84);
	   }
	   rmPlacePlayersCircular(0.37, 0.375, 0.0);

	   rmSetPlacementTeam(1);
	   if (playerSide == 1)
	   {
            rmSetPlacementSection(0.77, 0.78);
	   }
	   else
	   {
            rmSetPlacementSection(0.33, 0.34);
	   }
	   rmPlacePlayersCircular(0.37, 0.375, 0.0);
	}
	else if (cNumberNonGaiaPlayers < 5)
      {
         rmSetPlacementTeam(0);
	   if (playerSide == 1)
	   {
            rmSetPlacementSection(0.27, 0.4);
	   }
	   else
	   {
            rmSetPlacementSection(0.77, 0.93);
	   }
	   rmPlacePlayersCircular(0.39, 0.4, 0.0);

	   rmSetPlacementTeam(1);
	   if (playerSide == 1)
	   {
            rmSetPlacementSection(0.77, 0.9);
	   }
	   else
	   {
            rmSetPlacementSection(0.27, 0.43);
	   }
	   rmPlacePlayersCircular(0.39, 0.4, 0.0);
	}
	else  // 5 or more players
      {
         rmSetPlacementTeam(0);
	   if (playerSide == 1)
	   {
            rmSetPlacementSection(0.2, 0.4);
	   }
	   else
	   {
            rmSetPlacementSection(0.7, 0.9);
	   }
	   rmPlacePlayersCircular(0.41, 0.415, 0.0);

	   rmSetPlacementTeam(1);
	   if (playerSide == 1)
	   {
            rmSetPlacementSection(0.7, 0.9);
	   }
	   else
	   {
            rmSetPlacementSection(0.2, 0.4);
	   }
	   rmPlacePlayersCircular(0.41, 0.415, 0.0);
	}
   }
   else
   {
      if (cNumberNonGaiaPlayers == 3)
      {
   		   rmPlacePlayer(1, 0.31, 0.83);
		   rmPlacePlayer(2, 0.87, 0.5);
		   rmPlacePlayer(3, 0.69, 0.17);
	}
      else if (cNumberNonGaiaPlayers == 4)
      {
   		   rmPlacePlayer(1, 0.31, 0.87);
		   rmPlacePlayer(2, 0.9, 0.5);
		   rmPlacePlayer(3, 0.69, 0.13);
		   rmPlacePlayer(4, 0.1, 0.5);
	}
      else if (cNumberNonGaiaPlayers == 5)
      {
   		   rmPlacePlayer(1, 0.31, 0.87);
		   rmPlacePlayer(2, 0.9, 0.5);
		   rmPlacePlayer(3, 0.69, 0.13);
		   rmPlacePlayer(4, 0.1, 0.5);
		   rmPlacePlayer(5, 0.2, 0.68);
	}
      else if (cNumberNonGaiaPlayers == 6)
      {
   		   rmPlacePlayer(1, 0.31, 0.87);
		   rmPlacePlayer(2, 0.9, 0.5);
		   rmPlacePlayer(3, 0.69, 0.13);
		   rmPlacePlayer(4, 0.1, 0.5);
		   rmPlacePlayer(5, 0.2, 0.68);
		   rmPlacePlayer(6, 0.7, 0.32);
	}
	else
	{
	   rmSetPlacementSection(0.22, 1.0);
	   rmPlacePlayersCircular(0.42, 0.425, 0.1);
	}
   }

// Set up player areas.
   float playerFraction=rmAreaTilesToFraction(100);
   for(i=1; <cNumberPlayers)
   {
      int id=rmCreateArea("Player"+i);
      rmSetPlayerArea(i, id);
      rmAddAreaToClass(id, classPlayer);
      rmSetAreaSize(id, playerFraction, playerFraction);
      rmAddAreaToClass(id, classPlayer);
      rmSetAreaMinBlobs(id, 1);
      rmSetAreaMaxBlobs(id, 1);
	rmAddAreaConstraint(id, avoidTradeRouteFar); 
	rmAddAreaConstraint(id, avoidSocket); 
      rmAddAreaConstraint(id, playerEdgeConstraint); 
      rmSetAreaLocPlayer(id, i);
      rmSetAreaWarnFailure(id, false);
   }
   rmBuildAllAreas();

   // Text
   rmSetStatusText("",0.30);

// Create first water area.
   int northLakeID=rmCreateArea("first lake");
   if ( cNumberNonGaiaPlayers < 8 )
   {
	rmSetAreaSize(northLakeID, 0.08, 0.08);
   }
   else
   {
   	rmSetAreaSize(northLakeID, 0.07, 0.07);
   }
   rmSetAreaLocation(northLakeID, 0.9, 0.9);
   rmAddAreaInfluenceSegment(northLakeID, 1.0, 1.0, 0.68, 0.68);
   rmSetAreaWaterType(northLakeID, seaType);
   rmSetAreaBaseHeight(northLakeID, 2.0); 
   rmSetAreaMinBlobs(northLakeID, 8);
   rmSetAreaMaxBlobs(northLakeID, 10);
   rmSetAreaMinBlobDistance(northLakeID, 10);
   rmSetAreaMaxBlobDistance(northLakeID, 20);
   rmSetAreaSmoothDistance(northLakeID, 50);
   rmSetAreaCoherence(northLakeID, 0.3);
   rmAddAreaConstraint(northLakeID, playerConstraint); 
   rmAddAreaConstraint(northLakeID, avoidStartingUnitsBay); 
   rmAddAreaToClass(northLakeID, rmClassID("bay"));
   rmSetAreaObeyWorldCircleConstraint(northLakeID, false);
   rmBuildArea(northLakeID);

   // Text
   rmSetStatusText("",0.40);

// Create second water area.
   int southLakeID=rmCreateArea("second lake");
   if ( cNumberNonGaiaPlayers < 8 )
   {
	rmSetAreaSize(southLakeID, 0.08, 0.08);
   }
   else
   {
   	rmSetAreaSize(southLakeID, 0.07, 0.07);
   }
   rmSetAreaLocation(southLakeID, 0.1, 0.1);
   rmAddAreaInfluenceSegment(southLakeID, 0.0, 0.0, 0.32, 0.32);
   rmSetAreaWaterType(southLakeID, seaType);
   rmSetAreaBaseHeight(southLakeID, 2.0); 
   rmSetAreaMinBlobs(southLakeID, 8);
   rmSetAreaMaxBlobs(southLakeID, 10);
   rmSetAreaMinBlobDistance(southLakeID, 10);
   rmSetAreaMaxBlobDistance(southLakeID, 20);
   rmSetAreaSmoothDistance(southLakeID, 50);
   rmSetAreaCoherence(southLakeID, 0.3);
   rmAddAreaConstraint(southLakeID, playerConstraint); 
   rmAddAreaConstraint(southLakeID, avoidStartingUnitsBay); 
   rmAddAreaToClass(southLakeID, rmClassID("bay"));
   rmSetAreaObeyWorldCircleConstraint(southLakeID, false);
   rmBuildArea(southLakeID);   

   // Text
   rmSetStatusText("",0.50);

 // Starting units and objects
   int startingUnits = rmCreateStartingUnitsObjectDef(5.0);
   rmSetObjectDefMinDistance(startingUnits, 5.0);
   rmSetObjectDefMaxDistance(startingUnits, 10.0);
   rmAddObjectDefToClass(startingUnits, rmClassID("startingUnit"));
   rmAddObjectDefConstraint(startingUnits, avoidAll);
   rmAddObjectDefConstraint(startingUnits, avoidSocket);
   rmAddObjectDefConstraint(startingUnits, avoidWater8);
   rmAddObjectDefConstraint(startingUnits, avoidTradeRoute);

   int startingTCID= rmCreateObjectDef("startingTC");
   if ( rmGetNomadStart())
   {
	rmAddObjectDefItem(startingTCID, "CoveredWagon", 1, 0.0);
   }
   else
   {
	rmAddObjectDefItem(startingTCID, "TownCenter", 1, 0.0);
   }
   rmSetObjectDefMinDistance(startingTCID, 0.0);
   rmSetObjectDefMaxDistance(startingTCID, 8.0);
   rmAddObjectDefToClass(startingTCID, rmClassID("startingUnit"));
   rmAddObjectDefConstraint(startingTCID, avoidSocket);
   rmAddObjectDefConstraint(startingTCID, avoidWater8);
   rmAddObjectDefConstraint(startingTCID, avoidTradeRoute);

   int StartAreaTreeID=rmCreateObjectDef("starting trees");
   rmAddObjectDefItem(StartAreaTreeID, treeType, 1, 0.0);
   rmSetObjectDefMinDistance(StartAreaTreeID, 10.0);
   rmSetObjectDefMaxDistance(StartAreaTreeID, 15.0);
   rmAddObjectDefConstraint(StartAreaTreeID, avoidStartingUnitsSmall);

   int StartDeerID=rmCreateObjectDef("starting deer");
   rmAddObjectDefToClass(StartDeerID, rmClassID("huntableFood"));
   rmAddObjectDefItem(StartDeerID, "deer", 3, 4.0);
   rmSetObjectDefMinDistance(StartDeerID, 12.0);
   rmSetObjectDefMaxDistance(StartDeerID, 18.0);
   rmSetObjectDefCreateHerd(StartDeerID, true);
   rmAddObjectDefConstraint(StartDeerID, avoidStartingUnitsSmall);

   int startElkID=rmCreateObjectDef("starting elk herd");
   if (patternChance == 3)
      rmAddObjectDefItem(startElkID, "muskOx", rmRandInt(6,7), 6.0);
   else if (patternChance == 2)
      rmAddObjectDefItem(startElkID, "elk", rmRandInt(7,8), 6.0);
   else
      rmAddObjectDefItem(startElkID, "caribou", rmRandInt(7,8), 6.0);
      
 // rmAddObjectDefItem(startElkID, "ypYak", 2, 5.0);  // ========================================================= test

   rmAddObjectDefToClass(startElkID, rmClassID("huntableFood"));
   rmSetObjectDefCreateHerd(startElkID, true);
   rmSetObjectDefMinDistance(startElkID, 35.0);
   rmSetObjectDefMaxDistance(startElkID, 42.0);
   rmAddObjectDefConstraint(startElkID, shortHuntableConstraint);
   rmAddObjectDefConstraint(startElkID, avoidAll);
   rmAddObjectDefConstraint(startElkID, avoidImpassableLand);
//   rmAddObjectDefConstraint(startElkID, avoidSocket);
//   rmAddObjectDefConstraint(startElkID, avoidTradeRoute);
   if (cNumberNonGaiaPlayers > 3)
      rmAddObjectDefConstraint(startElkID, medPlayerConstraint);

   int startMooseID=rmCreateObjectDef("starting moose herd");
   rmAddObjectDefItem(startMooseID, "moose", rmRandInt(4,5), 8.0);
   rmAddObjectDefToClass(startMooseID, rmClassID("huntableFood"));
   rmSetObjectDefCreateHerd(startMooseID, true);
   rmSetObjectDefMinDistance(startMooseID, 45.0);
   rmSetObjectDefMaxDistance(startMooseID, 52.0);
   rmAddObjectDefConstraint(startMooseID, shortHuntableConstraint);
   rmAddObjectDefConstraint(startMooseID, avoidAll);
   rmAddObjectDefConstraint(startMooseID, avoidImpassableLand);
//   rmAddObjectDefConstraint(startMooseID, avoidSocket);
//   rmAddObjectDefConstraint(startMooseID, avoidTradeRoute);
   if (cNumberNonGaiaPlayers > 3)
      rmAddObjectDefConstraint(startMooseID, longPlayerConstraint);

   int silverID = -1;
   int silverType = rmRandInt(1,10);
   int playerGoldID = -1;
   int playerGold2ID = -1;

   // Everyone gets two ore mines, one pretty close, the other a little further away.
   silverType = rmRandInt(1,10);
   playerGoldID = rmCreateObjectDef("player silver "+i);
   rmAddObjectDefItem(playerGoldID, "mine", 1, 0.0);
   // rmAddGroupingToClass(playerGoldID, rmClassID("importantItem"));
   rmAddObjectDefConstraint(playerGoldID, avoidTradeRoute);
   rmAddObjectDefConstraint(playerGoldID, avoidStartingUnitsSmall);
   rmSetObjectDefMinDistance(playerGoldID, 15.0);
   rmSetObjectDefMaxDistance(playerGoldID, 20.0);

   silverType = rmRandInt(1,10);
   playerGold2ID = rmCreateObjectDef("player silver further "+i);
   rmAddObjectDefItem(playerGold2ID, "mine", 1, 0.0);
   rmAddObjectDefConstraint(playerGold2ID, avoidTradeRoute);
   rmAddObjectDefConstraint(playerGold2ID, avoidCoinShort);
   rmAddObjectDefConstraint(playerGold2ID, medPlayerConstraint);
   rmAddObjectDefConstraint(playerGold2ID, avoidAll);
   rmSetObjectDefMinDistance(playerGold2ID, 40.0);
   rmSetObjectDefMaxDistance(playerGold2ID, 46.0);
	
   // Player nugget
   int playerNuggetID=rmCreateObjectDef("player nugget");
   rmAddObjectDefItem(playerNuggetID, "nugget", 1, 0.0);
   rmAddObjectDefToClass(playerNuggetID, rmClassID("nuggets"));
   rmSetObjectDefMinDistance(playerNuggetID, 30.0);
   rmSetObjectDefMaxDistance(playerNuggetID, 35.0);
   rmAddObjectDefConstraint(playerNuggetID, avoidStartingUnitsSmall);
   rmAddObjectDefConstraint(playerNuggetID, avoidNugget);
   rmAddObjectDefConstraint(playerNuggetID, circleConstraint);

// Place all start area objects 
   for(i=1; <cNumberPlayers)
   {
	rmPlaceObjectDefAtLoc(startingTCID, i, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));
	vector TCLocation=rmGetUnitPosition(rmGetUnitPlacedOfPlayer(startingTCID, i));
	
	rmPlaceObjectDefAtLoc(startingUnits, i, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));
		
	rmPlaceObjectDefAtLoc(StartAreaTreeID, 0, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));
	rmPlaceObjectDefAtLoc(StartAreaTreeID, 0, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));
	rmPlaceObjectDefAtLoc(StartAreaTreeID, 0, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));
	rmPlaceObjectDefAtLoc(StartAreaTreeID, 0, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));
		
	rmPlaceObjectDefAtLoc(StartDeerID, 0, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));
	rmPlaceObjectDefAtLoc(StartDeerID, 0, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));
	rmPlaceObjectDefAtLoc(startElkID, 0, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));
	rmPlaceObjectDefAtLoc(startMooseID, 0, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));
		
	rmPlaceObjectDefAtLoc(playerGoldID, 0, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));
	rmPlaceObjectDefAtLoc(playerGold2ID, 0, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));

	// Player nuggets
	rmSetNuggetDifficulty(1, 1);
	rmPlaceObjectDefAtLoc(playerNuggetID, 0, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));
	rmPlaceObjectDefAtLoc(playerNuggetID, 0, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));
   }

   // Text
   rmSetStatusText("",0.55);

// Define and place the Native Villages 
   // Village A 
   int villageAID = -1;
   int villageType = rmRandInt(1,5);
   if (whichNative < 5)
	   villageAID = rmCreateGrouping("village A", "native cree village "+villageType);
   else 
	   villageAID = rmCreateGrouping("village A", "native huron village "+villageType);
   rmAddGroupingToClass(villageAID, rmClassID("natives"));
   rmAddGroupingToClass(villageAID, rmClassID("importantItem"));
   rmSetGroupingMinDistance(villageAID, 0.0);
   rmSetGroupingMaxDistance(villageAID, rmXFractionToMeters(0.12));
   rmAddGroupingConstraint(villageAID, avoidImpassableLand);
   rmAddGroupingConstraint(villageAID, avoidTradeRoute);
   rmAddGroupingConstraint(villageAID, avoidNativesMed);
   rmAddGroupingConstraint(villageAID, avoidSocket);
   rmAddGroupingConstraint(villageAID, nativePlayerConstraint);
   rmAddGroupingConstraint(villageAID, avoidImportantItem);
   rmAddGroupingConstraint(villageAID, avoidWater16);

   // Village B - randomly same or opposite village A
   int villageBID = -1;	
   villageType = rmRandInt(1,5);
   whichNative = rmRandInt(1,2);
   if (whichNative == 1)
	   villageBID = rmCreateGrouping("village B", "native cree village "+villageType);
   else if (whichNative == 2)
	   villageBID = rmCreateGrouping("village B", "native huron village "+villageType);
   rmAddGroupingToClass(villageBID, rmClassID("importantItem"));
   rmAddGroupingToClass(villageBID, rmClassID("natives"));
   rmSetGroupingMinDistance(villageBID, 0.0);
   rmSetGroupingMaxDistance(villageBID, rmXFractionToMeters(0.12));
   rmAddGroupingConstraint(villageBID, avoidImpassableLand);
   rmAddGroupingConstraint(villageBID, avoidTradeRoute);
   rmAddGroupingConstraint(villageBID, avoidWater16);
   rmAddGroupingConstraint(villageBID, avoidNativesMed);
   rmAddGroupingConstraint(villageBID, avoidSocket);
   rmAddGroupingConstraint(villageBID, avoidImportantItem);
   rmAddGroupingConstraint(villageBID, nativePlayerConstraint);
 
   if (nativeSetup == 1)
   {
       rmPlaceGroupingAtLoc(villageAID, 0, 0.9, 0.6);
       rmPlaceGroupingAtLoc(villageAID, 0, 0.1, 0.4);
   }
   else if (nativeSetup == 2)
   {
       rmPlaceGroupingAtLoc(villageAID, 0, 0.45, 0.88);
       rmPlaceGroupingAtLoc(villageAID, 0, 0.55, 0.12);
   }
   else if (nativeSetup == 3)
   {
       rmPlaceGroupingAtLoc(villageAID, 0, 0.41, 0.56);
       rmPlaceGroupingAtLoc(villageAID, 0, 0.59, 0.44);
   }
   else if (nativeSetup == 4)
   {
       rmPlaceGroupingAtLoc(villageAID, 0, 0.35, 0.67);
       rmPlaceGroupingAtLoc(villageAID, 0, 0.65, 0.33);
   }
   else if (nativeSetup == 5)
   {
       rmPlaceGroupingAtLoc(villageAID, 0, 0.41, 0.56);
       rmPlaceGroupingAtLoc(villageAID, 0, 0.59, 0.42);

       rmPlaceGroupingAtLoc(villageBID, 0, 0.9, 0.6);
       rmPlaceGroupingAtLoc(villageBID, 0, 0.1, 0.4);
   }
   else if (nativeSetup == 6)
   {
       rmPlaceGroupingAtLoc(villageAID, 0, 0.9, 0.6);
       rmPlaceGroupingAtLoc(villageAID, 0, 0.1, 0.4);

       rmPlaceGroupingAtLoc(villageBID, 0, 0.45, 0.88);
       rmPlaceGroupingAtLoc(villageBID, 0, 0.55, 0.12);
   }
   else if (nativeSetup == 7)
   {
       rmPlaceGroupingAtLoc(villageAID, 0, 0.41, 0.56);
       rmPlaceGroupingAtLoc(villageAID, 0, 0.59, 0.42);

       rmPlaceGroupingAtLoc(villageBID, 0, 0.45, 0.88);
       rmPlaceGroupingAtLoc(villageBID, 0, 0.55, 0.12);
   }

   // Text
   rmSetStatusText("",0.65);

// Fish   
   int fishID=rmCreateObjectDef("fish");
   rmAddObjectDefItem(fishID, "FishSalmon", 2, 7.0);
   rmSetObjectDefMinDistance(fishID, 0.0);
   rmSetObjectDefMaxDistance(fishID, rmXFractionToMeters(0.3));
   rmAddObjectDefConstraint(fishID, fishVsFishID);
   rmAddObjectDefConstraint(fishID, fishLand);

   rmPlaceObjectDefAtLoc(fishID, 0, 0.1, 0.1, 4*cNumberNonGaiaPlayers);
   rmPlaceObjectDefAtLoc(fishID, 0, 0.9, 0.9, 4*cNumberNonGaiaPlayers);

   // Text
   rmSetStatusText("",0.70);

// Mines
   silverType = -1;
   silverID = -1;
   int silverCount = cNumberNonGaiaPlayers*2;

   for(i=0; < silverCount)
   {
	silverType = rmRandInt(1,10);
	silverID = rmCreateObjectDef("silver east"+i);
	rmAddObjectDefItem(silverID, "mine", 1, 0.0);
	rmSetObjectDefMinDistance(silverID, 0.0);
	rmSetObjectDefMaxDistance(silverID, rmXFractionToMeters(0.5));
	rmAddObjectDefConstraint(silverID, avoidCoin);
	rmAddObjectDefConstraint(silverID, avoidAll);
	rmAddObjectDefConstraint(silverID, avoidImpassableLand);
	rmAddObjectDefConstraint(silverID, avoidTradeRoute);
	rmAddObjectDefConstraint(silverID, avoidSocket);
	rmAddObjectDefConstraint(silverID, farPlayerConstraint);
	rmAddObjectDefConstraint(silverID, Eastward);
	rmPlaceObjectDefAtLoc(silverID, 0, 0.5, 0.5);
   }

   for(i=0; < silverCount)
   {
	silverType = rmRandInt(1,10);
	silverID = rmCreateObjectDef("silver west"+i);
	rmAddObjectDefItem(silverID, "mine", 1, 0.0);
	rmSetObjectDefMinDistance(silverID, 0.0);
	rmSetObjectDefMaxDistance(silverID, rmXFractionToMeters(0.5));
	rmAddObjectDefConstraint(silverID, avoidCoin);
	rmAddObjectDefConstraint(silverID, avoidAll);
	rmAddObjectDefConstraint(silverID, avoidImpassableLand);
	rmAddObjectDefConstraint(silverID, avoidTradeRoute);
	rmAddObjectDefConstraint(silverID, avoidSocket);
	rmAddObjectDefConstraint(silverID, farPlayerConstraint);
	rmAddObjectDefConstraint(silverID, Westward);
	rmPlaceObjectDefAtLoc(silverID, 0, 0.5, 0.5);
   }

   // Text
   rmSetStatusText("",0.75);

// Define and place Forests
   int numTries=6*cNumberNonGaiaPlayers;
   int failCount=0;
   int forestSize=0;
   int patchSize=0;
   int forest=0;
   int coverForestPatchID = 0;
   for (i=0; <numTries)
   {
	   forestSize = rmRandInt(240,370);   
         forest=rmCreateArea("forest "+i);
         rmSetAreaWarnFailure(forest, false);
         rmSetAreaSize(forest, rmAreaTilesToFraction(forestSize), rmAreaTilesToFraction(forestSize));
         rmSetAreaForestType(forest, forestType);
         rmSetAreaForestDensity(forest, 0.8);
         rmSetAreaForestClumpiness(forest, 0.8);
         rmSetAreaForestUnderbrush(forest, 0.0);
         rmSetAreaMinBlobs(forest, 1);
         rmSetAreaMaxBlobs(forest, 5);
         rmSetAreaMinBlobDistance(forest, 10.0);
         rmSetAreaMaxBlobDistance(forest, 30.0);
         rmSetAreaCoherence(forest, 0.4);
         rmSetAreaSmoothDistance(forest, 10);
         rmAddAreaToClass(forest, rmClassID("classForest")); 
         rmAddAreaConstraint(forest, forestConstraint);
         rmAddAreaConstraint(forest, avoidAll);
         rmAddAreaConstraint(forest, avoidImpassableLand); 
         rmAddAreaConstraint(forest, avoidTradeRoute); 
	   rmAddAreaConstraint(forest, avoidSocket); 
	   rmAddAreaConstraint(forest, avoidStartingUnits); 
	   rmAddAreaConstraint(forest, avoidNativesShort);
         if(rmBuildArea(forest)==false)
         {
            // Stop trying once we fail 3 times in a row.
            failCount++;
            if(failCount==5)
               break;
         }
         else
            failCount=0; 
	   
	   if (patternChance == 1)
	   {
	      patchSize = forestSize + 50;
            coverForestPatchID = rmCreateArea("cover forest patch"+i, rmAreaID("forest "+i));   
            rmSetAreaWarnFailure(coverForestPatchID, false);
            rmSetAreaSize(coverForestPatchID, rmAreaTilesToFraction(patchSize), rmAreaTilesToFraction(patchSize));
            rmSetAreaCoherence(coverForestPatchID, 0.99);
            rmSetAreaMix(coverForestPatchID, patchType);
            rmBuildArea(coverForestPatchID);
	   }
   } 

   // Text
   rmSetStatusText("",0.80);

   numTries=3*cNumberNonGaiaPlayers;
   failCount=0;
   for (i=0; <numTries)
   {
	   forestSize = rmRandInt(100,150);   
         forest=rmCreateArea("small forest "+i);
         rmSetAreaWarnFailure(forest, false);
         rmSetAreaSize(forest, rmAreaTilesToFraction(forestSize), rmAreaTilesToFraction(forestSize));
         rmSetAreaForestType(forest, forestType);
         rmSetAreaForestDensity(forest, 0.8);
         rmSetAreaForestClumpiness(forest, 0.8);
         rmSetAreaForestUnderbrush(forest, 0.0);
         rmSetAreaMinBlobs(forest, 1);
         rmSetAreaMaxBlobs(forest, 3);
         rmSetAreaMinBlobDistance(forest, 8.0);
         rmSetAreaMaxBlobDistance(forest, 20.0);
         rmSetAreaCoherence(forest, 0.4);
         rmSetAreaSmoothDistance(forest, 10);
         rmAddAreaToClass(forest, rmClassID("classForest")); 
         rmAddAreaConstraint(forest, forestConstraint);
         rmAddAreaConstraint(forest, avoidAll);
         rmAddAreaConstraint(forest, avoidImpassableLand); 
         rmAddAreaConstraint(forest, avoidTradeRoute); 
	   rmAddAreaConstraint(forest, avoidSocket); 
	   rmAddAreaConstraint(forest, avoidStartingUnits); 
	   rmAddAreaConstraint(forest, avoidNativesShort);
         if(rmBuildArea(forest)==false)
         {
            // Stop trying once we fail 3 times in a row.
            failCount++;
            if(failCount==5)
               break;
         }
         else
            failCount=0; 
	   
	   if (patternChance == 1)
	   {
	      patchSize = forestSize + 40;
            coverForestPatchID = rmCreateArea("cover small forest patch"+i, rmAreaID("small forest "+i));   
            rmSetAreaWarnFailure(coverForestPatchID, false);
            rmSetAreaSize(coverForestPatchID, rmAreaTilesToFraction(patchSize), rmAreaTilesToFraction(patchSize));
            rmSetAreaCoherence(coverForestPatchID, 0.99);
            rmSetAreaMix(coverForestPatchID, patchType);
            rmBuildArea(coverForestPatchID);
	   }
   } 
  
   // Text
   rmSetStatusText("",0.85);

// Far herds
   int elkNum=rmRandInt(7,8);
   int mooseNum=rmRandInt(4,5);
   int elkID=rmCreateObjectDef("east elk herd");
   if (patternChance == 3)
      rmAddObjectDefItem(elkID, "muskOx", elkNum, 6.0);
   else if (patternChance == 2)
      rmAddObjectDefItem(elkID, "elk", elkNum, 6.0);
   else
      rmAddObjectDefItem(elkID, "caribou", elkNum, 6.0);
   rmAddObjectDefToClass(elkID, rmClassID("huntableFood"));
   rmSetObjectDefCreateHerd(elkID, true);
   rmSetObjectDefMinDistance(elkID, 10.0);
   rmSetObjectDefMaxDistance(elkID, rmXFractionToMeters(0.5));
   rmAddObjectDefConstraint(elkID, longHuntableConstraint);
   rmAddObjectDefConstraint(elkID, avoidAll);
   rmAddObjectDefConstraint(elkID, avoidImpassableLand);
//   rmAddObjectDefConstraint(elkID, avoidSocket);
//   rmAddObjectDefConstraint(elkID, avoidTradeRoute);
   rmAddObjectDefConstraint(elkID, farPlayerConstraint);
   rmAddObjectDefConstraint(elkID, Eastward);
   rmPlaceObjectDefAtLoc(elkID, 0, 0.5, 0.5, cNumberNonGaiaPlayers);

   int westElkID=rmCreateObjectDef("west elk herd");
   if (patternChance == 3)
      rmAddObjectDefItem(westElkID, "muskOx", elkNum, 6.0);
   else if (patternChance == 2)
      rmAddObjectDefItem(westElkID, "elk", elkNum, 6.0);
   else
      rmAddObjectDefItem(westElkID, "caribou", elkNum, 6.0);
   rmAddObjectDefToClass(westElkID, rmClassID("huntableFood"));
   rmSetObjectDefCreateHerd(westElkID, true);
   rmSetObjectDefMinDistance(westElkID, 10.0);
   rmSetObjectDefMaxDistance(westElkID, rmXFractionToMeters(0.5));
   rmAddObjectDefConstraint(westElkID, longHuntableConstraint);
   rmAddObjectDefConstraint(westElkID, avoidAll);
   rmAddObjectDefConstraint(westElkID, avoidImpassableLand);
 //  rmAddObjectDefConstraint(westElkID, avoidSocket);
//   rmAddObjectDefConstraint(westElkID, avoidTradeRoute);
   rmAddObjectDefConstraint(westElkID, farPlayerConstraint);
   rmAddObjectDefConstraint(westElkID, Westward);
   rmPlaceObjectDefAtLoc(westElkID, 0, 0.5, 0.5, cNumberNonGaiaPlayers);
 
   int numMooseHerds=(cNumberNonGaiaPlayers - 1);
   int mooseID=rmCreateObjectDef("east moose herd");
   rmAddObjectDefItem(mooseID, "moose", mooseNum, 8.0);
   rmAddObjectDefToClass(mooseID, rmClassID("huntableFood"));
   rmSetObjectDefCreateHerd(mooseID, true);
   rmSetObjectDefMinDistance(mooseID, 10.0);
   rmSetObjectDefMaxDistance(mooseID, rmXFractionToMeters(0.5));
   rmAddObjectDefConstraint(mooseID, longHuntableConstraint);
   rmAddObjectDefConstraint(mooseID, avoidAll);
   rmAddObjectDefConstraint(mooseID, avoidImpassableLand);
//   rmAddObjectDefConstraint(mooseID, avoidSocket);
//   rmAddObjectDefConstraint(mooseID, avoidTradeRoute);
   rmAddObjectDefConstraint(mooseID, farPlayerConstraint);
   rmAddObjectDefConstraint(mooseID, Eastward);
   rmPlaceObjectDefAtLoc(mooseID, 0, 0.5, 0.5, numMooseHerds);

   int westMooseID=rmCreateObjectDef("west moose herd");
   rmAddObjectDefItem(westMooseID, "moose", mooseNum, 8.0);
   rmAddObjectDefToClass(westMooseID, rmClassID("huntableFood"));
   rmSetObjectDefCreateHerd(westMooseID, true);
   rmSetObjectDefMinDistance(westMooseID, 10.0);
   rmSetObjectDefMaxDistance(westMooseID, rmXFractionToMeters(0.5));
   rmAddObjectDefConstraint(westMooseID, longHuntableConstraint);
   rmAddObjectDefConstraint(westMooseID, avoidAll);
   rmAddObjectDefConstraint(westMooseID, avoidImpassableLand);
//   rmAddObjectDefConstraint(westMooseID, avoidSocket);
//   rmAddObjectDefConstraint(westMooseID, avoidTradeRoute);
   rmAddObjectDefConstraint(westMooseID, farPlayerConstraint);
   rmAddObjectDefConstraint(westMooseID, Westward);
   rmPlaceObjectDefAtLoc(westMooseID, 0, 0.5, 0.5, numMooseHerds);

   // Text
   rmSetStatusText("",0.90);

// Define and place Nuggets
   int nuggetID= rmCreateObjectDef("nugget"); 
   rmAddObjectDefItem(nuggetID, "Nugget", 1, 0.0);
   rmSetObjectDefMinDistance(nuggetID, 0.0);
   rmSetObjectDefMaxDistance(nuggetID, rmXFractionToMeters(0.5));
   rmAddObjectDefConstraint(nuggetID, avoidImpassableLand);
   rmAddObjectDefConstraint(nuggetID, avoidNugget);
   rmAddObjectDefConstraint(nuggetID, avoidAll);
   rmAddObjectDefConstraint(nuggetID, avoidTradeRoute);
   rmAddObjectDefConstraint(nuggetID, avoidStartingUnits);
   rmAddObjectDefConstraint(nuggetID, circleConstraint);
   rmAddObjectDefConstraint(nuggetID, medPlayerConstraint);
   rmSetNuggetDifficulty(1, 3);
   rmPlaceObjectDefAtLoc(nuggetID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*3);

   rmAddObjectDefConstraint(nuggetID, farPlayerConstraint);
   rmSetNuggetDifficulty(3, 4);
   rmPlaceObjectDefAtLoc(nuggetID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*2);

   // Text
   rmSetStatusText("",0.95);

// Sheep
   int sheepID=rmCreateObjectDef("sheep");
   rmAddObjectDefItem(sheepID, "sheep", 2, 3.0);
   rmSetObjectDefMinDistance(sheepID, 0.0);
   rmSetObjectDefMaxDistance(sheepID, rmXFractionToMeters(0.5));
   rmAddObjectDefConstraint(sheepID, avoidSheep);
   rmAddObjectDefConstraint(sheepID, huntableConstraint);
   rmAddObjectDefConstraint(sheepID, avoidAll);
   rmAddObjectDefConstraint(sheepID, avoidImpassableLand);
   rmAddObjectDefConstraint(sheepID, avoidSocket);
   rmAddObjectDefConstraint(sheepID, avoidTradeRoute);
   rmAddObjectDefConstraint(sheepID, avoidStartingUnits);
   if (patternChance < 3)
      rmPlaceObjectDefAtLoc(sheepID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*3);

   // Text
   rmSetStatusText("",1.0);      
}