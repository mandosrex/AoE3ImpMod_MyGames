// Missouri Valley 
// a random map for AOE3:TWC
// by RF_Gandalf

include "mercenaries.xs";

void main(void)
{  
   // Text
   rmSetStatusText("",0.01);

// Set up for variables
   string baseType = "";
   string forestFloor = "";
   string cliffType = "";
   string forestType = "";
   string treeType = "";
   string deerType = "";
   string deer2Type = "";
   string sheepType = "";
   string riverType = "";

// Set up for natives to appear on the map
   int subCiv0=-1;
   int subCiv1=-1;
   int subCiv2=-1;

   if (rmAllocateSubCivs(3) == true)
   {
	subCiv0=rmGetCivID("Comanche");
      if (subCiv0 >= 0)
         rmSetSubCiv(0, "Comanche");

	subCiv1=rmGetCivID("Cheyenne");
      if (subCiv1 >= 0)
         rmSetSubCiv(1, "Cheyenne");

	subCiv2=rmGetCivID("Cree");
      if (subCiv2 >= 0)
         rmSetSubCiv(2, "Cree");
   }

// Pick pattern for trees, terrain, features, etc.
   int patternChance = rmRandInt(1,2);   
   int variantChance = rmRandInt(1,8);
   int lightingChance = rmRandInt(1,14);
   int shallowPattern = rmRandInt(1,6);
   int nativeSetup = rmRandInt(1,4);
   int playerPos = rmRandInt(1,2);
   int playerSide = rmRandInt(1,2); 
   int vultures = 1;
   int eagles = 1;
   int carcass = 1;
   int decoChance = rmRandInt(1,4);
   if (decoChance == 3)
	vultures = 0; 
   if (decoChance == 4) 
	eagles = 0;
   if (decoChance == 2) 
	carcass = 0;
   int forestDist = rmRandInt(7,10);
   int sheepChance = rmRandInt(1,3);

// Pick the map size

/* ====================================== MAP SIZE REFERENCE =========================================================

						#players	size	longSide	   size*longSide  'area' ratio to 1 
  
   scalingNumber 1  			2		350	378 (sizex1.15)	141k		1

   if (scalingNumber == 2)		3-4		350	446 (sizex1.25)	147k		1.09

   else if (scalingNumber == 3)	5-6		350	527 (sizex1.35)	179k		1.17

   else if (scalingNumber == 4)	7-8		350	612 (sizex1.45)	214k		1.26	

=================================================================================================================  */

   int scalingNumber = 1;
   float scalingFactor = 0;
   int size = 1;
   int longSide = 1;

   if (cNumberNonGaiaPlayers == 2) 
   {   
      scalingNumber = 1;
      scalingFactor = 1.0;
      size = 350;
      longSide = 1.15*size;
   }	
   else if ((cNumberNonGaiaPlayers == 3) || (cNumberNonGaiaPlayers == 4))
   {
	scalingNumber = 2;
	scalingFactor = 1.1;
      size = 360;
      longSide = 1.25*size;
   }	
   else if (cNumberNonGaiaPlayers < 7)
   {
	scalingNumber = 3;
	scalingFactor = 1.2;
      size = 370;
      longSide = 1.4*size;
   }	
   else if (cNumberNonGaiaPlayers > 6)    // 7 or 8 players
   {
	scalingNumber = 4;
	scalingFactor = 1.3;
      size = 370;
      longSide = 1.55*size;
   }	
   rmSetMapSize(size, longSide);

// Elevation
  // rmSetMapElevationParameters(long type, float minFrequency, long numberOctaves, float persistence, float heightVariation)
   rmSetMapElevationParameters(cElevTurbulence, 0.4, 6, 0.7, 5.0);
   rmSetMapElevationHeightBlend(1.0);
   rmSetSeaLevel(0.0);

   // Text
   rmSetStatusText("",0.05);
	
// Pick terrain patterns and features 
   rmSetMapType("greatPlains");
   rmSetMapType("grass");

   if (lightingChance == 1)
	rmSetLightingSet("ottoman morning");
   else if (lightingChance == 2)
      rmSetLightingSet("pampas");
   else if (lightingChance == 3)
      rmSetLightingSet("great plains");
   else if (lightingChance == 4)  
      rmSetLightingSet("texas");
   else if (lightingChance == 5)
      rmSetLightingSet("302a");
   else if (lightingChance == 6)
	rmSetLightingSet("bayou");
   else if (lightingChance == 7)
      rmSetLightingSet("carribean");
   else if (lightingChance == 8)
	rmSetLightingSet("Great Lakes");
   else if (lightingChance == 9)
	rmSetLightingSet("seville morning");
   else if (lightingChance == 10)
	rmSetLightingSet("307a_beach");
   else if (lightingChance == 11)
      rmSetLightingSet("311b");
   else if (lightingChance == 12)
	rmSetLightingSet("324b");
   else if (lightingChance == 13)
      rmSetLightingSet("306a_caribbean");
   else 
      rmSetLightingSet("302a_base");

   if (patternChance == 1)
   {
      baseType = "great plains grass"; 
	forestFloor = "great_plains\ground1_gp";
      riverType = "Andes River";
   }
   else if (patternChance == 2)
   {
      baseType = "great plains drygrass";
	forestFloor = "great_plains\ground8_gp";
      riverType = "Pampas River";
   }

   forestType = "great plains forest";
   cliffType = "Great Plains";
   treeType = "TreeGreatPlains";

   if (variantChance == 1)
   {
      deerType = "bison";
      deer2Type = "deer";
   }
   else if (variantChance == 2)
   {     
      deerType = "deer";
      deer2Type = "bison";
   }
   else if (variantChance == 3)
   {     
      deerType = "pronghorn";
      deer2Type = "bison";
   }
   else if (variantChance == 4)
   {
      deerType = "bison";
      deer2Type = "pronghorn";
   }
   else if (variantChance == 5)
   {
      deerType = "bison";
      deer2Type = "elk";
   }
   else if (variantChance == 6)
   {     
      deerType = "elk";
      deer2Type = "bison";
   }
   else if (variantChance == 7)
   {
      deerType = "pronghorn";
      deer2Type = "elk";
   }
   else 
   {     
      deerType = "elk";
      deer2Type = "pronghorn";
   }
   if (sheepChance > 1)
      sheepType = "cow";
   else
      sheepType = "sheep";

   rmSetBaseTerrainMix(baseType);
   rmTerrainInitialize("great_plains\ground1_gp", 0);
   rmEnableLocalWater(false);
   rmSetMapType("land");

   rmSetWorldCircleConstraint(true);
   rmSetWindMagnitude(2.0); 
   chooseMercs();

// Define some classes.
   int classPlayer=rmDefineClass("player");
   rmDefineClass("classPatch");
   rmDefineClass("startingUnit");
   rmDefineClass("classForest");
   rmDefineClass("importantItem");
   rmDefineClass("natives");
   rmDefineClass("classCliff");
   rmDefineClass("center");
   rmDefineClass("classNugget");
   rmDefineClass("socketClass");
   int classHuntable=rmDefineClass("huntableFood");   
   int classHerdable=rmDefineClass("herdableFood"); 

   // Text
   rmSetStatusText("",0.10);

// -------------Define constraints
   // Map edge constraints
   int playerEdgeConstraint=rmCreateBoxConstraint("player edge of map", rmXTilesToFraction(10), rmZTilesToFraction(10), 1.0-rmXTilesToFraction(10), 1.0-rmZTilesToFraction(10), 0.01);
   int circleConstraint=rmCreatePieConstraint("circle Constraint", 0.5, 0.5, 0, rmZFractionToMeters(0.47), rmDegreesToRadians(0), rmDegreesToRadians(360));
   int treeBoxConstraint=rmCreateBoxConstraint("trees close to river", 0.27, 0.0, 0.73, 1.0, 0.01);

   // Player constraints
   int playerConstraintForest=rmCreateClassDistanceConstraint("forests kinda stay away from players", classPlayer, 15.0);
   int playerConstraint=rmCreateClassDistanceConstraint("stay away from players", classPlayer, 45.0);
   int mediumPlayerConstraint=rmCreateClassDistanceConstraint("medium stay away from players", classPlayer, 20.0);
   int nuggetPlayerConstraint=rmCreateClassDistanceConstraint("stay away from players a lot", classPlayer, 55.0);
   int farPlayerConstraint=rmCreateClassDistanceConstraint("stay away from players more", classPlayer, 85.0);
   int fartherPlayerConstraint=rmCreateClassDistanceConstraint("stay away from players the most", classPlayer, 105.0);
   int longPlayerConstraint=rmCreateClassDistanceConstraint("land stays away from players", classPlayer, 70.0); 

   // Nature avoidance
   int forestObjConstraint=rmCreateTypeDistanceConstraint("forest obj", "all", 6.0);
   int shortForestConstraint=rmCreateClassDistanceConstraint("patch vs. forest", rmClassID("classForest"), 15.0);
   int forestConstraint=rmCreateClassDistanceConstraint("forest vs. forest", rmClassID("classForest"), forestDist);
   int avoidResource=rmCreateTypeDistanceConstraint("resource avoid resource", "resource", 20.0);
   int avoidCoin=rmCreateTypeDistanceConstraint("avoid coin", "gold", 10.0);
   int shortAvoidSilver=rmCreateTypeDistanceConstraint("short gold avoid gold", "Mine", 20.0);
   int coinAvoidCoin=rmCreateTypeDistanceConstraint("coin avoids coin", "gold", 35.0);
   int longAvoidCoin=rmCreateTypeDistanceConstraint("coin avoids coin long", "gold", 55.0);
   int avoidStartResource=rmCreateTypeDistanceConstraint("start resource no overlap", "resource", 1.0);
   int avoidSheep=rmCreateClassDistanceConstraint("sheep avoids sheep etc", rmClassID("herdableFood"), 45.0);
   int huntableConstraint=rmCreateClassDistanceConstraint("huntable constraint", rmClassID("huntableFood"), 35.0);
   int longHuntableConstraint=rmCreateClassDistanceConstraint("long huntable constraint", rmClassID("huntableFood"), 55.0);
   int forestsAvoidBison=rmCreateClassDistanceConstraint("forest avoids bison", rmClassID("huntableFood"), 15.0);

   // Avoid impassable land, certain features
   int avoidImpassableLand=rmCreateTerrainDistanceConstraint("avoid impassable land", "Land", false, 4.0);
   int shortAvoidImpassableLand=rmCreateTerrainDistanceConstraint("short avoid impassable land", "Land", false, 2.0);
   int longAvoidImpassableLand=rmCreateTerrainDistanceConstraint("long avoid impassable land", "Land", false, 18.0);
   int patchConstraint=rmCreateClassDistanceConstraint("patch vs. patch", rmClassID("classPatch"), 8.0);
   int avoidCliffs=rmCreateClassDistanceConstraint("stuff vs. cliff", rmClassID("classCliff"), 10.0);
   int avoidCliffsShort=rmCreateClassDistanceConstraint("stuff vs. cliff short", rmClassID("classCliff"), 6.0);
   int avoidWater10 = rmCreateTerrainDistanceConstraint("avoid water mid-long", "Land", false, 10.0);
   int avoidWater5 = rmCreateTerrainDistanceConstraint("avoid water short", "Land", false, 5.0);
   int avoidWater20 = rmCreateTerrainDistanceConstraint("avoid water a little more", "Land", false, 20.0);
  
   // Unit avoidance
   int avoidStartingUnits=rmCreateClassDistanceConstraint("objects avoid starting units", rmClassID("startingUnit"), 30.0);
   int avoidStartingUnitsSmall=rmCreateClassDistanceConstraint("objects avoid starting units small", rmClassID("startingUnit"), 10.0);
   int avoidStartingUnitsLarge=rmCreateClassDistanceConstraint("objects avoid starting units large", rmClassID("startingUnit"), 50.0);
   int avoidImportantItem=rmCreateClassDistanceConstraint("things avoid each other", rmClassID("importantItem"), 10.0);
   int avoidImportantItemSmall=rmCreateClassDistanceConstraint("important item small avoidance", rmClassID("importantItem"), 7.0);
   int avoidNatives=rmCreateClassDistanceConstraint("stuff avoids natives", rmClassID("natives"), 60.0);
   int avoidNativesMed=rmCreateClassDistanceConstraint("stuff avoids natives medium", rmClassID("natives"), 37.0);
   int avoidNativesShort=rmCreateClassDistanceConstraint("stuff avoids natives shorter", rmClassID("natives"), 15.0);
   int avoidNugget=rmCreateClassDistanceConstraint("nugget vs. nugget", rmClassID("classNugget"), 42.0);
   int avoidNuggetMed=rmCreateClassDistanceConstraint("nugget vs. nugget med", rmClassID("classNugget"), 55.0);
   int avoidNuggetLong=rmCreateClassDistanceConstraint("nugget vs. nugget long", rmClassID("classNugget"), 70.0);
   int avoidNuggetSmall=rmCreateTypeDistanceConstraint("avoid nuggets by a little", "AbstractNugget", 10.0);
   int avoidAll=rmCreateTypeDistanceConstraint("avoid all", "all", 6.0);

   // Trade route avoidance.
   int avoidTradeRoute = rmCreateTradeRouteDistanceConstraint("trade route", 8.0);
   int avoidSocket=rmCreateClassDistanceConstraint("avoid sockets", rmClassID("socketClass"), 10.0);

// End of constraints ------------------------------------------------------------------------------------------------

   // Text
   rmSetStatusText("",0.15);

// Set up player starting locations
   if (cNumberTeams == 2)
   {
      if (playerPos == 1)
      {
         if (playerSide == 1)
         {
	        rmSetPlacementTeam(0);
         }
         else if (playerSide == 2)
         {
	  	  rmSetPlacementTeam(1);
         }
	   if (cNumberNonGaiaPlayers == 2)
	      rmPlacePlayersLine(0.1, 0.2, 0.1, 0.8, 10, 10);
	   else
	      rmPlacePlayersLine(0.09, 0.18, 0.09, 0.82, 10, 10);

         if (playerSide == 1)
         {
	        rmSetPlacementTeam(1);
         }
         else if (playerSide == 2)
         {
	  	  rmSetPlacementTeam(0);
         }
	   if (cNumberNonGaiaPlayers == 2)
	      rmPlacePlayersLine(0.9, 0.8, 0.9, 0.2, 10, 10);
	   else
	      rmPlacePlayersLine(0.91, 0.82, 0.91, 0.18, 10, 10);
      }
      else if (playerPos == 2)
      {
         if (playerSide == 1)
         {
	        rmSetPlacementTeam(0);
         }
         else if (playerSide == 2)
         {
	  	  rmSetPlacementTeam(1);
         }
	   if (cNumberNonGaiaPlayers == 2)
	      rmPlacePlayersLine(0.9, 0.2, 0.9, 0.8, 10, 10);
	   else
	      rmPlacePlayersLine(0.91, 0.18, 0.91, 0.82, 10, 10);

         if (playerSide == 1)
         {
	        rmSetPlacementTeam(1);
         }
         else if (playerSide == 2)
         {
	  	  rmSetPlacementTeam(0);
         }
	   if (cNumberNonGaiaPlayers == 2)
	      rmPlacePlayersLine(0.1, 0.8, 0.1, 0.2, 10, 10);
	   else
	      rmPlacePlayersLine(0.09, 0.82, 0.09, 0.18, 10, 10);
      }
   }
   else  // FFA
   {
         bool southSide = true;
	   if (rmRandInt(1,2) == 1) 
	      southSide = false;
	   float spacingIncrement = 0.58;  // 3, 4 players  
         float northStart = 0.82;  
         float northStop = 0.18;  
         float southStart = 0.18;
         float southStop = 0.82;

	   float nLat = 0.9;
	   float sLat = 0.1;

	   if (playerPos == 2)
	   {
	      nLat = 0.1;
	      sLat = 0.9;
	   }

	   if ((cNumberNonGaiaPlayers == 5) || (cNumberNonGaiaPlayers == 6))
	   {
 		spacingIncrement = 0.3;
	   }
	   else if ((cNumberNonGaiaPlayers == 7) || (cNumberNonGaiaPlayers == 8))
	   {
		spacingIncrement = 0.2;
	   } 

         float spacingSouth = 0;
         float spacingNorth = 0;

         for (i = 0; < cNumberNonGaiaPlayers)
         {
            if (southSide == true)
            {
               rmSetPlacementTeam(i);
               rmPlacePlayersLine(sLat, (southStart + spacingSouth), sLat, southStop, 10, 10);
	         rmSetTeamSpacingModifier(0.25);
               spacingSouth = spacingSouth + spacingIncrement;
            }
            else
            {
               rmSetPlacementTeam(i);
               rmPlacePlayersLine(nLat, (northStart - spacingNorth), nLat, northStop, 10, 10);
	         rmSetTeamSpacingModifier(0.25);
               spacingNorth = spacingNorth + spacingIncrement;
            }
            if (southSide == true)
            {
               southSide = false;
            }
            else
            {
               southSide = true;
            }
	   }
   }

   // Text
   rmSetStatusText("",0.20);
	
// Set up player areas.
   float playerFraction=rmAreaTilesToFraction(120);
   for(i=1; <cNumberPlayers)
   {
      int id=rmCreateArea("Player"+i);
      rmSetPlayerArea(i, id);
      rmSetAreaSize(id, playerFraction, playerFraction);
      rmAddAreaToClass(id, classPlayer);
      rmSetAreaMinBlobs(id, 1);
      rmSetAreaMaxBlobs(id, 1);
      rmAddAreaConstraint(id, playerConstraint); 
      rmAddAreaConstraint(id, longAvoidImpassableLand);
      rmAddAreaConstraint(id, playerEdgeConstraint); 
      rmSetAreaLocPlayer(id, i);
      rmSetAreaMix(id, baseType);
      rmSetAreaWarnFailure(id, false);
   }
   rmBuildAllAreas();

   // Text
   rmSetStatusText("",0.25);

// The River
   if (cNumberNonGaiaPlayers < 4)
   {
 	if (shallowPattern == 2)
	   shallowPattern = rmRandInt(3,6);
   }

   int singleRiver = rmRiverCreate(-1, riverType, 25, 10, 9, 11); 
   if (scalingNumber == 1)
      rmRiverSetConnections(singleRiver, 0.5, 0.0, 0.5, 1.16);
   else if (scalingNumber == 2)
      rmRiverSetConnections(singleRiver, 0.5, 0.0, 0.5, 1.26);
   else if (scalingNumber == 3)
      rmRiverSetConnections(singleRiver, 0.5, 0.0, 0.5, 1.41);
   else if (scalingNumber == 4)
      rmRiverSetConnections(singleRiver, 0.5, 0.0, 0.5, 1.56);

   if (shallowPattern == 6) // single larger centered 
   {
	   rmRiverSetShallowRadius(singleRiver, rmRandInt(15, 21));
	   rmRiverAddShallow(singleRiver, rmRandFloat(0.4, 0.6));
   }
   else
   {   
	if (shallowPattern < 3) // .4 and .6 crossings for 1 and 2
	{	
	   rmRiverSetShallowRadius(singleRiver, rmRandInt(8, 12));
	   rmRiverAddShallow(singleRiver, rmRandFloat(0.34, 0.42)); 

	   rmRiverSetShallowRadius(singleRiver, rmRandInt(8, 12));
	   rmRiverAddShallow(singleRiver, rmRandFloat(0.58, 0.66));
	}

	if (shallowPattern < 4) // end crossings, for 2-3
	{
	   if (shallowPattern >1)
	   {	
	      rmRiverSetShallowRadius(singleRiver, rmRandInt(7, 11));
	      rmRiverAddShallow(singleRiver, rmRandFloat(0.06, 0.2)); 

	      rmRiverSetShallowRadius(singleRiver, rmRandInt(7, 11));
	      rmRiverAddShallow(singleRiver, rmRandFloat(0.8, 0.94));
	   }
	}

	if (shallowPattern > 3) // end crossings for 4, 5
	{	
	   rmRiverSetShallowRadius(singleRiver, rmRandInt(8, 13));
	   rmRiverAddShallow(singleRiver, rmRandFloat(0.1, 0.29)); 

	   rmRiverSetShallowRadius(singleRiver, rmRandInt(8, 13));
	   rmRiverAddShallow(singleRiver, rmRandFloat(0.71, 0.9));
	}

      if (shallowPattern > 2) // center for patterns 3, 4
	{
	   if (shallowPattern < 5)
	   {	
	      rmRiverSetShallowRadius(singleRiver, rmRandInt(8, 12));
	      rmRiverAddShallow(singleRiver, rmRandFloat(0.45, 0.55));
	   }
      }
   }
   rmRiverSetBankNoiseParams(singleRiver, 0.07, 2, 1.5, 10.0, 0.667, 3.0); 
   rmRiverBuild(singleRiver);

   // Text
   rmSetStatusText("",0.30);

// Trade Routes
   // first route
   int tradeRouteID = rmCreateTradeRoute();
   rmAddTradeRouteWaypoint(tradeRouteID, 0.26, 1.0);
   rmAddTradeRouteWaypoint(tradeRouteID, 0.35, 0.92);
   rmAddTradeRouteWaypoint(tradeRouteID, 0.35, 0.65);
   rmAddTradeRouteWaypoint(tradeRouteID, 0.35, 0.5);
   rmAddTradeRouteWaypoint(tradeRouteID, 0.35, 0.35);
   rmAddTradeRouteWaypoint(tradeRouteID, 0.35, 0.08);
   rmAddTradeRouteWaypoint(tradeRouteID, 0.26, 0.0);
   rmBuildTradeRoute(tradeRouteID, "dirt");

   // second route
   int tradeRouteID2 = rmCreateTradeRoute();
   rmAddTradeRouteWaypoint(tradeRouteID2, 0.74, 0.0);
   rmAddTradeRouteWaypoint(tradeRouteID2, 0.65, 0.08);
   rmAddTradeRouteWaypoint(tradeRouteID2, 0.65, 0.4);
   rmAddTradeRouteWaypoint(tradeRouteID2, 0.65, 0.5);
   rmAddTradeRouteWaypoint(tradeRouteID2, 0.65, 0.6);
   rmAddTradeRouteWaypoint(tradeRouteID2, 0.65, 0.92);
   rmAddTradeRouteWaypoint(tradeRouteID2, 0.74, 1.0);
   rmBuildTradeRoute(tradeRouteID2, "carolinas\trade_route");	

// Trade sockets
   int socketID=rmCreateObjectDef("sockets to dock Trade Posts");
   rmAddObjectDefItem(socketID, "SocketTradeRoute", 1, 0.0);
   rmSetObjectDefAllowOverlap(socketID, true);
   rmAddObjectDefToClass(socketID, rmClassID("importantItem"));
   rmSetObjectDefMinDistance(socketID, 0.0);
   rmSetObjectDefMaxDistance(socketID, 6.0);

   // add the meeting poles along the trade route.
   rmSetObjectDefTradeRouteID(socketID, tradeRouteID);
   vector socketLoc = rmGetTradeRouteWayPoint(tradeRouteID, 0.15);
   rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);
   if (scalingNumber > 2)
   {
      socketLoc = rmGetTradeRouteWayPoint(tradeRouteID, 0.5);
      rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);
   }
   socketLoc = rmGetTradeRouteWayPoint(tradeRouteID, 0.85);
   rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);

   // change the trade route for the new sockets
   rmSetObjectDefTradeRouteID(socketID, tradeRouteID2);
   socketLoc = rmGetTradeRouteWayPoint(tradeRouteID2, 0.15);
   rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);
   if (scalingNumber > 2)
   {
      socketLoc = rmGetTradeRouteWayPoint(tradeRouteID2, 0.5);
      rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);
   }
   socketLoc = rmGetTradeRouteWayPoint(tradeRouteID2, 0.85);
   rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);

   //Text
   rmSetStatusText("",0.35);

// Starting TCs and units 		
   int startingUnits = rmCreateStartingUnitsObjectDef(5.0);
   rmAddObjectDefToClass(startingUnits, rmClassID("startingUnit"));
   rmSetObjectDefMinDistance(startingUnits, 5.0);
   rmSetObjectDefMaxDistance(startingUnits, 10.0);
   rmAddObjectDefConstraint(startingUnits, avoidAll);

   int startingTCID= rmCreateObjectDef("startingTC");
   rmAddObjectDefToClass(startingTCID, rmClassID("startingUnit"));
   rmSetObjectDefMaxDistance(startingTCID, 18.0);
   rmAddObjectDefConstraint(startingTCID, avoidAll);
   rmAddObjectDefConstraint(startingTCID, avoidTradeRoute);
   rmAddObjectDefConstraint(startingTCID, longAvoidImpassableLand );                
   if ( rmGetNomadStart())
   {
	rmAddObjectDefItem(startingTCID, "CoveredWagon", 1, 0.0);
   }
   else
   {
      rmAddObjectDefItem(startingTCID, "TownCenter", 1, 0.0);
   }

   for(i=1; <cNumberPlayers)
   {	
      rmPlaceObjectDefAtLoc(startingTCID, i, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));
      rmPlaceObjectDefAtLoc(startingUnits, i, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));
   }
 
   // Text
   rmSetStatusText("",0.40);

// Cliffs
   //northwest
   int longCliff1ID=rmCreateArea("nw long cliff"); 
   rmSetAreaWarnFailure(longCliff1ID, false);
   rmAddAreaToClass(longCliff1ID, rmClassID("classCliff"));
   rmSetAreaCliffType(longCliff1ID, cliffType);
   rmSetAreaLocation(longCliff1ID, 0.25, 0.58);
   rmAddAreaInfluenceSegment(longCliff1ID, 0.25, 0.58, 0.25, 0.95);  
   rmSetAreaSize(longCliff1ID, rmAreaTilesToFraction(scalingFactor*530), rmAreaTilesToFraction(scalingFactor*570));
   if (rmRandInt(1,2) == 1)
      rmSetAreaCliffEdge(longCliff1ID, 1, 0.8, 0.1, 1.0, 1.0);
   else
      rmSetAreaCliffEdge(longCliff1ID, 2, 0.42, 0.06, 0.10, 1.0); 
   rmSetAreaCliffPainting(longCliff1ID, true, true, true, 1.5, true);
   rmSetAreaCliffHeight(longCliff1ID, 7, 1.0, 1.0);
   rmSetAreaCoherence(longCliff1ID, rmRandFloat(0.65, 0.71));
   rmSetAreaSmoothDistance(longCliff1ID, 10);
   rmAddAreaConstraint(longCliff1ID, avoidWater10);
   rmAddAreaConstraint(longCliff1ID, avoidSocket);
   rmAddAreaConstraint(longCliff1ID, avoidTradeRoute);
   rmBuildArea(longCliff1ID);

   // northeast
   int longCliff2ID=rmCreateArea("ne long cliff"); 
   rmSetAreaWarnFailure(longCliff2ID, false);
   rmAddAreaToClass(longCliff2ID, rmClassID("classCliff"));
   rmSetAreaCliffType(longCliff2ID, cliffType);
   rmSetAreaLocation(longCliff2ID, 0.75, 0.58);
   rmAddAreaInfluenceSegment(longCliff2ID, 0.75, 0.58, 0.75, 0.95);
   rmSetAreaSize(longCliff2ID, rmAreaTilesToFraction(scalingFactor*530), rmAreaTilesToFraction(scalingFactor*570));
   if (rmRandInt(1,2) == 1)
      rmSetAreaCliffEdge(longCliff2ID, 1, 0.8, 0.1, 1.0, 1.0);
   else
      rmSetAreaCliffEdge(longCliff2ID, 2, 0.42, 0.06, 0.10, 1.0);
   rmSetAreaCliffPainting(longCliff2ID, true, true, true, 1.5, true);
   rmSetAreaCliffHeight(longCliff2ID, 7, 1.0, 1.0);
   rmSetAreaCoherence(longCliff2ID, rmRandFloat(0.65, 0.71));
   rmSetAreaSmoothDistance(longCliff2ID, 10);
   rmAddAreaConstraint(longCliff2ID, avoidWater10);
   rmAddAreaConstraint(longCliff2ID, avoidSocket);
   rmAddAreaConstraint(longCliff2ID, avoidTradeRoute);
   rmBuildArea(longCliff2ID);

   // southwest
   int longCliff3ID=rmCreateArea("sw long cliff"); 
   rmSetAreaWarnFailure(longCliff3ID, false);
   rmAddAreaToClass(longCliff3ID, rmClassID("classCliff"));
   rmSetAreaCliffType(longCliff3ID, cliffType);
   rmSetAreaLocation(longCliff3ID, 0.25, 0.4);
   rmAddAreaInfluenceSegment(longCliff3ID, 0.25, 0.4, 0.25, 0.05);
   rmSetAreaSize(longCliff3ID, rmAreaTilesToFraction(scalingFactor*530), rmAreaTilesToFraction(scalingFactor*570));
   if (rmRandInt(1,2) == 1)
      rmSetAreaCliffEdge(longCliff3ID, 1, 0.8, 0.1, 1.0, 1.0);
   else
      rmSetAreaCliffEdge(longCliff3ID, 2, 0.42, 0.06, 0.10, 1.0);  
   rmSetAreaCliffPainting(longCliff3ID, true, true, true, 1.5, true);
   rmSetAreaCliffHeight(longCliff3ID, 7, 1.0, 1.0);
   rmSetAreaCoherence(longCliff3ID, rmRandFloat(0.65, 0.71));
   rmSetAreaSmoothDistance(longCliff3ID, 10);
   rmAddAreaConstraint(longCliff3ID, avoidWater10);
   rmAddAreaConstraint(longCliff3ID, avoidSocket);
   rmAddAreaConstraint(longCliff3ID, avoidTradeRoute);
   rmBuildArea(longCliff3ID);

   // southeast
   int longCliff4ID=rmCreateArea("se long cliff"); 
   rmSetAreaWarnFailure(longCliff4ID, false);
   rmAddAreaToClass(longCliff4ID, rmClassID("classCliff"));
   rmSetAreaCliffType(longCliff4ID, cliffType);
   rmSetAreaLocation(longCliff4ID, 0.75, 0.4);
   rmAddAreaInfluenceSegment(longCliff4ID, 0.75, 0.4, 0.75, 0.05);
   rmSetAreaSize(longCliff4ID, rmAreaTilesToFraction(scalingFactor*530), rmAreaTilesToFraction(scalingFactor*570));
   if (rmRandInt(1,2) == 1)
      rmSetAreaCliffEdge(longCliff4ID, 1, 0.8, 0.1, 1.0, 1.0);
   else
      rmSetAreaCliffEdge(longCliff4ID, 2, 0.42, 0.06, 0.10, 1.0);
   rmSetAreaCliffPainting(longCliff4ID, true, true, true, 1.5, true);
   rmSetAreaCliffHeight(longCliff4ID, 7, 1.0, 1.0);
   rmSetAreaCoherence(longCliff4ID, rmRandFloat(0.65, 0.71));
   rmSetAreaSmoothDistance(longCliff4ID, 10);
   rmAddAreaConstraint(longCliff4ID, avoidWater10);
   rmAddAreaConstraint(longCliff4ID, avoidSocket);
   rmAddAreaConstraint(longCliff4ID, avoidTradeRoute);
   rmBuildArea(longCliff4ID);

   // Text
   rmSetStatusText("",0.45);

// NATIVE AMERICANS
   // Village A 
   int villageAID = -1;
   int whichNative = rmRandInt(1,3);
   int villageType = rmRandInt(1,5);

   if (whichNative == 1)
      villageAID = rmCreateGrouping("village A", "native cheyenne village "+villageType);
   else if (whichNative == 2)
      villageAID = rmCreateGrouping("village A", "native comanche village "+villageType);
   else if (whichNative == 3)
      villageAID = rmCreateGrouping("village A", "native cree village "+villageType);
   rmAddGroupingToClass(villageAID, rmClassID("natives"));
   rmAddGroupingToClass(villageAID, rmClassID("importantItem"));
   rmSetGroupingMinDistance(villageAID, 0.0);
   rmSetGroupingMaxDistance(villageAID, rmXFractionToMeters(0.13));
   rmAddGroupingConstraint(villageAID, avoidImpassableLand);
   rmAddGroupingConstraint(villageAID, avoidTradeRoute);
   rmAddGroupingConstraint(villageAID, avoidCliffs);
   rmAddGroupingConstraint(villageAID, avoidWater10);
   rmAddGroupingConstraint(villageAID, avoidSocket);
   rmAddGroupingConstraint(villageAID, avoidNativesMed);
   rmAddGroupingConstraint(villageAID, nuggetPlayerConstraint);

   // Village D - opposite type from A 
   int villageDID = -1;
   villageType = rmRandInt(1,5);
   int twoChoice = rmRandInt(1,2);

   if (whichNative == 1)
   {
	if (twoChoice == 1)
	   villageDID = rmCreateGrouping("village D", "native comanche village "+villageType);
	else if (twoChoice == 2)
	   villageDID = rmCreateGrouping("village D", "native cree village "+villageType);  
   }
   else if (whichNative == 2)
   {
	if (twoChoice == 1)
	   villageDID = rmCreateGrouping("village D", "native cheyenne village "+villageType);
	else if (twoChoice == 2)
	   villageDID = rmCreateGrouping("village D", "native cree village "+villageType);  
   }
   else if (whichNative == 3)
   {
	if (twoChoice == 1)
	   villageDID = rmCreateGrouping("village D", "native cheyenne village "+villageType); 
	else if (twoChoice == 2)
	   villageDID = rmCreateGrouping("village D", "native comanche village "+villageType);
   }
   rmAddGroupingToClass(villageDID, rmClassID("natives"));
   rmAddGroupingToClass(villageDID, rmClassID("importantItem"));
   rmSetGroupingMinDistance(villageDID, 0.0);
   rmSetGroupingMaxDistance(villageDID, rmXFractionToMeters(0.13));
   rmAddGroupingConstraint(villageDID, avoidImpassableLand);
   rmAddGroupingConstraint(villageDID, avoidTradeRoute);
   rmAddGroupingConstraint(villageDID, avoidCliffs);
   rmAddGroupingConstraint(villageDID, avoidWater10);
   rmAddGroupingConstraint(villageDID, avoidSocket);
   rmAddGroupingConstraint(villageDID, avoidNativesMed);
   rmAddGroupingConstraint(villageDID, nuggetPlayerConstraint);

   // Text
   rmSetStatusText("",0.50);

// Placement of Native Americans
   if (cNumberNonGaiaPlayers == 2)     // 1 village per side
	nativeSetup = rmRandInt(1,3);
   else if (cNumberNonGaiaPlayers < 5) // 1 village per side
	nativeSetup = rmRandInt(2,3);
   else if (cNumberNonGaiaPlayers < 7) // 1 or 2 villages per side
	nativeSetup = rmRandInt(2,5);
   else					
      nativeSetup = rmRandInt(4,5);    // 2 villages per side

   if (nativeSetup == 1)
   {
	if (playerPos == 1)
	{
         rmPlaceGroupingAtLoc(villageAID, 0, 0.11, 0.85);
         rmPlaceGroupingAtLoc(villageAID, 0, 0.89, 0.15);
	}
	else if (playerPos == 2)
	{
         rmPlaceGroupingAtLoc(villageAID, 0, 0.89, 0.85);
         rmPlaceGroupingAtLoc(villageAID, 0, 0.11, 0.15);
	}
   }
   else if (nativeSetup == 2)
   {
         rmPlaceGroupingAtLoc(villageAID, 0, 0.39, 0.5);
         rmPlaceGroupingAtLoc(villageAID, 0, 0.61, 0.5);
   }
   else if (nativeSetup == 3)
   {
         rmPlaceGroupingAtLoc(villageAID, 0, 0.31, 0.5);
         rmPlaceGroupingAtLoc(villageAID, 0, 0.69, 0.5);
   }
   else if (nativeSetup == 4)
   {
	if (rmRandInt(1,2) == 1)
	{
         rmPlaceGroupingAtLoc(villageAID, 0, 0.39, 0.55);
         rmPlaceGroupingAtLoc(villageAID, 0, 0.61, 0.45);

         rmPlaceGroupingAtLoc(villageAID, 0, 0.33, 0.45);
         rmPlaceGroupingAtLoc(villageAID, 0, 0.67, 0.55);
	}
	else
	{
         rmPlaceGroupingAtLoc(villageAID, 0, 0.39, 0.45);
         rmPlaceGroupingAtLoc(villageAID, 0, 0.61, 0.55);

         rmPlaceGroupingAtLoc(villageAID, 0, 0.33, 0.55);
         rmPlaceGroupingAtLoc(villageAID, 0, 0.67, 0.45);
	}
   }
   else if (nativeSetup == 5)
   {
	if (rmRandInt(1,2) == 1)
	{
         rmPlaceGroupingAtLoc(villageDID, 0, 0.39, 0.45);
         rmPlaceGroupingAtLoc(villageDID, 0, 0.61, 0.55);

         rmPlaceGroupingAtLoc(villageAID, 0, 0.33, 0.55);
         rmPlaceGroupingAtLoc(villageAID, 0, 0.67, 0.45);
	}
	else
	{
         rmPlaceGroupingAtLoc(villageDID, 0, 0.39, 0.45);
         rmPlaceGroupingAtLoc(villageDID, 0, 0.61, 0.55);

         rmPlaceGroupingAtLoc(villageAID, 0, 0.33, 0.55);
         rmPlaceGroupingAtLoc(villageAID, 0, 0.67, 0.45);
	}
   }

   // Text
   rmSetStatusText("",0.55);

// Player Nuggets
   int playerNuggetID=rmCreateObjectDef("player nugget");
   rmAddObjectDefItem(playerNuggetID, "nugget", 1, 0.0);
   rmAddObjectDefToClass(playerNuggetID, rmClassID("classNugget"));
   rmSetObjectDefMinDistance(playerNuggetID, 35.0);
   rmSetObjectDefMaxDistance(playerNuggetID, 45.0);
   rmAddObjectDefConstraint(playerNuggetID, avoidStartingUnitsSmall);
   rmAddObjectDefConstraint(playerNuggetID, avoidTradeRoute);
   rmAddObjectDefConstraint(playerNuggetID, avoidSocket);
   rmAddObjectDefConstraint(playerNuggetID, avoidNugget);
   rmAddObjectDefConstraint(playerNuggetID, avoidWater10);
   rmAddObjectDefConstraint(playerNuggetID, avoidCliffsShort);

   for(i=1; <cNumberPlayers)
   {
 	rmSetNuggetDifficulty(1, 1);
	rmPlaceObjectDefAtLoc(playerNuggetID, 0, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));
	rmPlaceObjectDefAtLoc(playerNuggetID, 0, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));
   }

   // Text
   rmSetStatusText("",0.60);

// Random Nuggets
   int nugget2= rmCreateObjectDef("nugget medium"); 
   rmAddObjectDefItem(nugget2, "Nugget", 1, 0.0);
   rmSetNuggetDifficulty(2, 2);
   rmAddObjectDefToClass(nugget2, rmClassID("classNugget"));
   rmSetObjectDefMinDistance(nugget2, 60.0);
   rmSetObjectDefMaxDistance(nugget2, 110.0);
   rmAddObjectDefConstraint(nugget2, shortAvoidImpassableLand);
   rmAddObjectDefConstraint(nugget2, avoidSocket);
   rmAddObjectDefConstraint(nugget2, avoidTradeRoute);
   rmAddObjectDefConstraint(nugget2, nuggetPlayerConstraint);
   rmAddObjectDefConstraint(nugget2, avoidNuggetMed);
   rmAddObjectDefConstraint(nugget2, circleConstraint);
   rmAddObjectDefConstraint(nugget2, avoidWater10);
   rmAddObjectDefConstraint(nugget2, avoidAll);
   rmPlaceObjectDefPerPlayer(nugget2, false, 1);

   int nugget3= rmCreateObjectDef("nugget hard"); 
   rmAddObjectDefItem(nugget3, "Nugget", 1, 0.0);
   rmSetNuggetDifficulty(3, 3);
   rmAddObjectDefToClass(nugget3, rmClassID("classNugget"));
   rmSetObjectDefMinDistance(nugget3, 80.0);
   rmSetObjectDefMaxDistance(nugget3, rmXFractionToMeters(0.6));
   rmAddObjectDefConstraint(nugget3, shortAvoidImpassableLand);
   rmAddObjectDefConstraint(nugget3, avoidSocket);
   rmAddObjectDefConstraint(nugget3, avoidTradeRoute);
   rmAddObjectDefConstraint(nugget3, longPlayerConstraint);
   rmAddObjectDefConstraint(nugget3, avoidNuggetLong);
   rmAddObjectDefConstraint(nugget3, circleConstraint);
   rmAddObjectDefConstraint(nugget3, avoidWater10);
   rmAddObjectDefConstraint(nugget3, avoidAll);
   rmPlaceObjectDefPerPlayer(nugget3, false, 1);

   rmAddObjectDefConstraint(nugget3, farPlayerConstraint);
   rmSetNuggetDifficulty(2, 3);
   rmPlaceObjectDefPerPlayer(nugget3, false, 1);

   int nugget4= rmCreateObjectDef("nugget nuts"); 
   rmAddObjectDefItem(nugget4, "Nugget", 1, 0.0);
   rmSetNuggetDifficulty(4, 4);
   rmAddObjectDefToClass(nugget4, rmClassID("classNugget"));
   rmSetObjectDefMinDistance(nugget4, 80.0);
   rmSetObjectDefMaxDistance(nugget4, rmXFractionToMeters(0.4));
   rmAddObjectDefConstraint(nugget4, shortAvoidImpassableLand);
   rmAddObjectDefConstraint(nugget4, avoidSocket);
   rmAddObjectDefConstraint(nugget4, avoidTradeRoute);
   rmAddObjectDefConstraint(nugget4, farPlayerConstraint);
   rmAddObjectDefConstraint(nugget4, avoidNuggetLong);
   rmAddObjectDefConstraint(nugget4, circleConstraint);
   rmAddObjectDefConstraint(nugget4, avoidWater10);
   rmAddObjectDefConstraint(nugget4, avoidAll);
   rmPlaceObjectDefPerPlayer(nugget4, false, 1);

   // Text
   rmSetStatusText("",0.65);

// start area trees 
   int StartAreaTreeID=rmCreateObjectDef("starting trees");
   rmAddObjectDefItem(StartAreaTreeID, treeType, 1, 0.0);
   rmSetObjectDefMinDistance(StartAreaTreeID, 8);
   rmSetObjectDefMaxDistance(StartAreaTreeID, 12);
   rmAddObjectDefConstraint(StartAreaTreeID, avoidStartingUnitsSmall);
   rmAddObjectDefConstraint(StartAreaTreeID, avoidTradeRoute);
   rmAddObjectDefConstraint(StartAreaTreeID, avoidAll);
   rmAddObjectDefConstraint(StartAreaTreeID, avoidCliffs);
   rmPlaceObjectDefPerPlayer(StartAreaTreeID, false, 3);

// berry bushes
   int berryNum = rmRandInt(2,5);
   int StartBerryBushID=rmCreateObjectDef("starting berry bush");
   rmAddObjectDefItem(StartBerryBushID, "BerryBush", rmRandInt(2,4), 4.0);
   rmSetObjectDefMinDistance(StartBerryBushID, 10.0);
   rmSetObjectDefMaxDistance(StartBerryBushID, 16.0);
   rmAddObjectDefConstraint(StartBerryBushID, avoidStartingUnitsSmall);
   rmAddObjectDefConstraint(StartBerryBushID, avoidCliffsShort);
   rmPlaceObjectDefPerPlayer(StartBerryBushID, false, 1);

   rmAddObjectDefConstraint(StartBerryBushID, playerConstraint);
   rmSetObjectDefMinDistance(StartBerryBushID, 55.0);
   rmSetObjectDefMaxDistance(StartBerryBushID, 65.0);
   if (rmRandInt(1,3) > 1)
      rmPlaceObjectDefPerPlayer(StartBerryBushID, false, 1);

// start area huntable
   int deerNum = rmRandInt(5, 8);
   int startPronghornID=rmCreateObjectDef("starting pronghorn");
   rmAddObjectDefItem(startPronghornID, deerType, deerNum, 5.0);
   rmAddObjectDefToClass(startPronghornID, rmClassID("huntableFood"));
   rmSetObjectDefMinDistance(startPronghornID, 16);
   rmSetObjectDefMaxDistance(startPronghornID, 22);
   rmAddObjectDefConstraint(startPronghornID, avoidStartResource);
   rmAddObjectDefConstraint(startPronghornID, shortAvoidImpassableLand);
   rmAddObjectDefConstraint(startPronghornID, avoidAll);
   rmAddObjectDefConstraint(startPronghornID, avoidCliffsShort);
   rmSetObjectDefCreateHerd(startPronghornID, true);
   rmPlaceObjectDefPerPlayer(startPronghornID, false, 1);

// second huntable
   int deer2Num = rmRandInt(4, 8);
   int farPronghornID=rmCreateObjectDef("far pronghorn");
   rmAddObjectDefItem(farPronghornID, deer2Type, deer2Num, 5.0);
   rmAddObjectDefToClass(farPronghornID, rmClassID("huntableFood"));
   rmSetObjectDefMinDistance(farPronghornID, 42.0);
   rmSetObjectDefMaxDistance(farPronghornID, 65.0);
   rmAddObjectDefConstraint(farPronghornID, avoidStartResource);
   rmAddObjectDefConstraint(farPronghornID, playerConstraint);
   rmAddObjectDefConstraint(farPronghornID, shortAvoidImpassableLand);
   rmAddObjectDefConstraint(farPronghornID, avoidNativesShort);
   rmAddObjectDefConstraint(farPronghornID, huntableConstraint);
   rmAddObjectDefConstraint(farPronghornID, avoidAll);
   rmAddObjectDefConstraint(farPronghornID, avoidCliffsShort);
   rmSetObjectDefCreateHerd(farPronghornID, true);
   rmPlaceObjectDefPerPlayer(farPronghornID, false, 1);

// additional second huntable for low player numbers
   if (cNumberNonGaiaPlayers < 4)
   {
      rmAddObjectDefConstraint(farPronghornID, farPlayerConstraint);
      rmSetObjectDefMinDistance(farPronghornID, rmXFractionToMeters(0.25));
      rmSetObjectDefMaxDistance(farPronghornID, rmXFractionToMeters(0.35));
      rmPlaceObjectDefPerPlayer(farPronghornID, false, 1);
   }

// Silver mines - players
   int silverType = -1;
   silverType = rmRandInt(1,10);
   int playerGoldID=rmCreateObjectDef("player silver closer");
   rmAddObjectDefItem(playerGoldID, "mine", 1, 0.0);
   rmAddObjectDefConstraint(playerGoldID, avoidTradeRoute);
   rmAddObjectDefConstraint(playerGoldID, avoidSocket);
   rmAddObjectDefConstraint(playerGoldID, coinAvoidCoin);
   rmAddObjectDefConstraint(playerGoldID, avoidImportantItemSmall);
   rmAddObjectDefConstraint(playerGoldID, circleConstraint);
   rmAddObjectDefConstraint(playerGoldID, avoidAll);
   rmAddObjectDefConstraint(playerGoldID, avoidCliffsShort);
   rmAddObjectDefConstraint(playerGoldID, avoidWater10);
   rmSetObjectDefMinDistance(playerGoldID, 18.0);
   rmSetObjectDefMaxDistance(playerGoldID, 23.0);
   rmPlaceObjectDefPerPlayer(playerGoldID, false, 1);

   silverType = rmRandInt(1,10);
   int GoldMediumID=rmCreateObjectDef("player silver med");
   rmAddObjectDefItem(GoldMediumID, "mine", 1, 0.0);
   rmAddObjectDefConstraint(GoldMediumID, avoidTradeRoute);
   rmAddObjectDefConstraint(GoldMediumID, avoidSocket);
   rmAddObjectDefConstraint(GoldMediumID, coinAvoidCoin);
   rmAddObjectDefConstraint(GoldMediumID, avoidCliffsShort);
   rmAddObjectDefConstraint(GoldMediumID, avoidImportantItemSmall);
   rmAddObjectDefConstraint(GoldMediumID, playerConstraint);
   rmAddObjectDefConstraint(GoldMediumID, circleConstraint);
   rmAddObjectDefConstraint(GoldMediumID, avoidAll);
   rmAddObjectDefConstraint(GoldMediumID, avoidWater5);
   rmSetObjectDefMinDistance(GoldMediumID, 60.0);
   rmSetObjectDefMaxDistance(GoldMediumID, 75.0);
   rmPlaceObjectDefPerPlayer(GoldMediumID, false, 1);

// Extra tree clumps near players - to ensure fair access to wood
   int extraTreesID=rmCreateObjectDef("extra trees");
   rmAddObjectDefItem(extraTreesID, treeType, 5, 5.0);
   rmSetObjectDefMinDistance(extraTreesID, 14);
   rmSetObjectDefMaxDistance(extraTreesID, 18);
   rmAddObjectDefConstraint(extraTreesID, avoidAll);
   rmAddObjectDefConstraint(extraTreesID, avoidCoin);
   rmAddObjectDefConstraint(extraTreesID, avoidCliffsShort);
   rmAddObjectDefConstraint(extraTreesID, avoidStartingUnitsSmall);
   for(i=1; <cNumberPlayers)
      rmPlaceObjectDefInArea(extraTreesID, 0, rmAreaID("player"+i), 1);

   int extraTrees2ID=rmCreateObjectDef("more extra trees");
   rmAddObjectDefItem(extraTrees2ID, treeType, 6, 6.0);
   rmSetObjectDefMinDistance(extraTrees2ID, 19);
   rmSetObjectDefMaxDistance(extraTrees2ID, 30);
   rmAddObjectDefConstraint(extraTrees2ID, avoidAll);
   rmAddObjectDefConstraint(extraTrees2ID, avoidCoin);
   rmAddObjectDefConstraint(extraTrees2ID, avoidCliffsShort);
   rmAddObjectDefConstraint(extraTrees2ID, avoidStartingUnitsSmall);
   for(i=1; <cNumberPlayers)
      rmPlaceObjectDefInArea(extraTrees2ID, 0, rmAreaID("player"+i), 2);

   // Text
   rmSetStatusText("",0.70);

// Main forests
   int coverForestPatchID = 0;
   int failCount=0;
   int numTries=18*scalingFactor;

   for (i=0; <numTries)
   {
      int forest=rmCreateArea("forest "+i);
      rmSetAreaWarnFailure(forest, false);
      rmSetAreaSize(forest, rmAreaTilesToFraction(100), rmAreaTilesToFraction(200));
      rmSetAreaForestType(forest, forestType);
      rmSetAreaForestDensity(forest, rmRandFloat(0.7, 1.0));
      rmSetAreaForestClumpiness(forest, rmRandFloat(0.7, 0.9));
      rmSetAreaCoherence(forest, rmRandFloat(0.65, 0.7));
      rmSetAreaSmoothDistance(forest, rmRandInt(10,20));
      rmAddAreaToClass(forest, rmClassID("classForest")); 
	rmAddAreaConstraint(forest, mediumPlayerConstraint);
      rmAddAreaConstraint(forest, forestConstraint);
      rmAddAreaConstraint(forest, avoidAll); 
	rmAddAreaConstraint(forest, avoidCoin);  
      rmAddAreaConstraint(forest, avoidImpassableLand); 
      rmAddAreaConstraint(forest, avoidTradeRoute);
	rmAddAreaConstraint(forest, avoidStartingUnits);
	rmAddAreaConstraint(forest, avoidSocket);
      rmAddAreaConstraint(forest, avoidCliffsShort); 
	rmAddAreaConstraint(forest, avoidNativesShort);
      rmAddAreaConstraint(forest, forestsAvoidBison); 

      if(rmBuildArea(forest)==false)
      {
         // Stop trying once we fail 3 times in a row.
         failCount++;
         if(failCount==5)
            break;
      }
      else
         failCount=0; 

      coverForestPatchID = rmCreateArea("cover forest patch"+i, rmAreaID("forest "+i));   
      rmSetAreaWarnFailure(coverForestPatchID, false);
      rmSetAreaSize(coverForestPatchID, rmAreaTilesToFraction(225), rmAreaTilesToFraction(225));
      rmSetAreaCoherence(coverForestPatchID, 0.99);
	rmSetAreaTerrainType(coverForestPatchID, forestFloor);
	rmBuildArea(coverForestPatchID);
   } 

   // Text
   rmSetStatusText("",0.75);

// Extra silver mines - distant
   silverType = rmRandInt(1,10);
   int extraGoldID = rmCreateObjectDef("extra silver");
   rmAddObjectDefItem(extraGoldID, "mine", 1, 0.0);
   rmAddObjectDefToClass(extraGoldID, rmClassID("importantItem"));
   rmAddObjectDefConstraint(extraGoldID, avoidTradeRoute);
   rmAddObjectDefConstraint(extraGoldID, avoidSocket);
   rmAddObjectDefConstraint(extraGoldID, longAvoidCoin);
   rmAddObjectDefConstraint(extraGoldID, avoidCliffsShort);
   rmAddObjectDefConstraint(extraGoldID, avoidImportantItemSmall);
   rmAddObjectDefConstraint(extraGoldID, fartherPlayerConstraint);
   rmAddObjectDefConstraint(extraGoldID, avoidWater5);
   rmAddObjectDefConstraint(extraGoldID, avoidAll);
   rmSetObjectDefMinDistance(extraGoldID, 0.0);
   rmSetObjectDefMaxDistance(extraGoldID, 0.5*longSide);
   rmPlaceObjectDefAtLoc(extraGoldID, 0, 0.5, 0.5, scalingNumber);
   rmPlaceObjectDefAtLoc(extraGoldID, 0, 0.5, 0.5, 3);

   silverType = rmRandInt(1,10);
   int GoldFarID=rmCreateObjectDef("silver far");
   rmAddObjectDefItem(GoldFarID, "mine", 1, 0.0);
   rmAddObjectDefConstraint(GoldFarID, avoidTradeRoute);
   rmAddObjectDefConstraint(GoldFarID, avoidSocket);
   rmAddObjectDefConstraint(GoldFarID, longAvoidCoin);
   rmAddObjectDefConstraint(GoldFarID, avoidCliffsShort);
   rmAddObjectDefConstraint(GoldFarID, avoidImportantItemSmall);
   rmAddObjectDefConstraint(GoldFarID, circleConstraint);
   rmAddObjectDefConstraint(GoldFarID, avoidAll);
   rmAddObjectDefConstraint(GoldFarID, fartherPlayerConstraint);
   rmAddObjectDefConstraint(GoldFarID, avoidWater5);
   rmSetObjectDefMinDistance(GoldFarID, 75.0);
   rmSetObjectDefMaxDistance(GoldFarID, 110.0);
   rmPlaceObjectDefPerPlayer(GoldFarID, false, 1);

   // Text
   rmSetStatusText("",0.80);

// sheep etc
   int sheepID=rmCreateObjectDef("herdable animal");
   rmAddObjectDefItem(sheepID, sheepType, 2, 4.0);
   rmAddObjectDefToClass(sheepID, rmClassID("herdableFood"));
   rmSetObjectDefMinDistance(sheepID, 45.0);
   rmSetObjectDefMaxDistance(sheepID, rmXFractionToMeters(0.3));
   rmAddObjectDefConstraint(sheepID, avoidSheep);
   rmAddObjectDefConstraint(sheepID, avoidAll);
   rmAddObjectDefConstraint(sheepID, playerConstraint);
   rmAddObjectDefConstraint(sheepID, avoidCliffsShort);
   rmAddObjectDefConstraint(sheepID, avoidImpassableLand);
   rmPlaceObjectDefPerPlayer(sheepID, false, 2);

   rmAddObjectDefConstraint(sheepID, farPlayerConstraint);
   rmSetObjectDefMinDistance(sheepID, 80.0);
   rmSetObjectDefMaxDistance(sheepID, longSide*0.5);
   rmPlaceObjectDefPerPlayer(sheepID, false, rmRandInt(1,2)); 

   rmAddObjectDefConstraint(sheepID, fartherPlayerConstraint);
   rmSetObjectDefMinDistance(sheepID, 20.0);
   rmSetObjectDefMaxDistance(sheepID, longSide*0.4);
   rmPlaceObjectDefAtLoc(sheepID, 0, 0.2, 0.5, scalingNumber);
   rmPlaceObjectDefAtLoc(sheepID, 0, 0.8, 0.5, scalingNumber);

   // Text
   rmSetStatusText("",0.85);

// Bison herds
   int centralHerdID=rmCreateObjectDef("central herd");  
   rmAddObjectDefItem(centralHerdID, "bison", rmRandInt(7,10), 6.0);
   rmAddObjectDefToClass(centralHerdID, rmClassID("huntableFood"));
   rmSetObjectDefMinDistance(centralHerdID, rmXFractionToMeters(0.05));
   rmSetObjectDefMaxDistance(centralHerdID, longSide*0.35);
   rmAddObjectDefConstraint(centralHerdID, avoidTradeRoute);
   rmAddObjectDefConstraint(centralHerdID, avoidImportantItem);
   rmAddObjectDefConstraint(centralHerdID, avoidWater10);
   rmAddObjectDefConstraint(centralHerdID, avoidCliffsShort);
   rmAddObjectDefConstraint(centralHerdID, farPlayerConstraint);
   rmAddObjectDefConstraint(centralHerdID, longHuntableConstraint);
   rmSetObjectDefCreateHerd(centralHerdID, true);
   rmPlaceObjectDefAtLoc(centralHerdID, 0, 0.5, 0.5, cNumberNonGaiaPlayers);

   int centralHerd2ID=rmCreateObjectDef("second central herd");  
   rmAddObjectDefItem(centralHerd2ID, "bison", rmRandInt(6,9), 6.0);
   rmAddObjectDefToClass(centralHerd2ID, rmClassID("huntableFood"));
   rmSetObjectDefMinDistance(centralHerd2ID, 10);
   rmSetObjectDefMaxDistance(centralHerd2ID, longSide*0.35);
   rmAddObjectDefConstraint(centralHerd2ID, avoidTradeRoute);
   rmAddObjectDefConstraint(centralHerd2ID, avoidImportantItem);
   rmAddObjectDefConstraint(centralHerd2ID, avoidWater10);
   rmAddObjectDefConstraint(centralHerd2ID, avoidCliffsShort);
   rmAddObjectDefConstraint(centralHerd2ID, fartherPlayerConstraint);
   rmAddObjectDefConstraint(centralHerd2ID, huntableConstraint);
   rmSetObjectDefCreateHerd(centralHerd2ID, true);
   rmPlaceObjectDefAtLoc(centralHerd2ID, 0, 0.2, 0.5, 2);
   rmPlaceObjectDefAtLoc(centralHerd2ID, 0, 0.8, 0.5, 2);

// far huntable
   int farHuntableID=rmCreateObjectDef("far huntable");
   rmAddObjectDefItem(farHuntableID, deerType, rmRandInt(5,9), 6.0);
   rmAddObjectDefToClass(farHuntableID, rmClassID("huntableFood"));
   rmSetObjectDefMinDistance(farHuntableID, rmXFractionToMeters(0.33));
   rmSetObjectDefMaxDistance(farHuntableID, rmXFractionToMeters(0.4));
   rmAddObjectDefConstraint(farHuntableID, avoidTradeRoute);
   rmAddObjectDefConstraint(farHuntableID, avoidImportantItem);
   rmAddObjectDefConstraint(farHuntableID, avoidWater10);
   rmAddObjectDefConstraint(farHuntableID, avoidCliffsShort);
   rmAddObjectDefConstraint(farHuntableID, fartherPlayerConstraint);
   rmAddObjectDefConstraint(farHuntableID, huntableConstraint);
   rmAddObjectDefConstraint(farHuntableID, avoidAll);
   rmSetObjectDefCreateHerd(farHuntableID, true);
   rmPlaceObjectDefPerPlayer(farHuntableID, false, 1);

   // Text
   rmSetStatusText("",0.90);

// Riverbank trees
   for(i=0; <scalingFactor*10)
   {
      int riverbankTreeID=rmCreateObjectDef("riverbank trees"+i);
      rmAddObjectDefItem(riverbankTreeID, treeType, rmRandInt(2,7), 6.0);
      rmAddObjectDefConstraint(riverbankTreeID, avoidAll);
      rmAddObjectDefConstraint(riverbankTreeID, avoidCoin);
      rmAddObjectDefConstraint(riverbankTreeID, avoidCliffsShort);
      rmAddObjectDefConstraint(riverbankTreeID, avoidSocket);
      rmAddObjectDefConstraint(riverbankTreeID, treeBoxConstraint);
      rmAddObjectDefConstraint(riverbankTreeID, avoidWater5);
      rmSetObjectDefMinDistance(riverbankTreeID, 30.0);
      rmSetObjectDefMaxDistance(riverbankTreeID, longSide*0.25);
      rmPlaceObjectDefAtLoc(riverbankTreeID, 0, 0.5, 0.24);
      rmPlaceObjectDefAtLoc(riverbankTreeID, 0, 0.5, 0.76);
   }

// Random trees
   int StragglerTreeID=rmCreateObjectDef("stragglers");
   rmAddObjectDefItem(StragglerTreeID, treeType, 1, 0.0);
   rmAddObjectDefConstraint(StragglerTreeID, avoidAll);
   rmAddObjectDefConstraint(StragglerTreeID, avoidStartingUnitsSmall);
   rmAddObjectDefConstraint(StragglerTreeID, avoidCoin);
   rmAddObjectDefConstraint(StragglerTreeID, avoidCliffsShort);
   rmAddObjectDefConstraint(StragglerTreeID, avoidWater10);
   rmSetObjectDefMinDistance(StragglerTreeID, 10.0);
   rmSetObjectDefMaxDistance(StragglerTreeID, longSide*0.5);
   for(i=0; <scalingFactor*15)
      rmPlaceObjectDefAtLoc(StragglerTreeID, 0, 0.5, 0.5);

   // Text
   rmSetStatusText("",0.95);

// Deco
   if (carcass == 1)
   {
	int bisonCarcass=rmCreateGrouping("Bison Carcass", "gp_carcass_bison");
	rmSetGroupingMinDistance(bisonCarcass, 0.0);
	rmSetGroupingMaxDistance(bisonCarcass, rmXFractionToMeters(0.5));
	rmAddGroupingConstraint(bisonCarcass, avoidImpassableLand);
	rmAddGroupingConstraint(bisonCarcass, longPlayerConstraint);
	rmAddGroupingConstraint(bisonCarcass, avoidTradeRoute);
	rmAddGroupingConstraint(bisonCarcass, avoidSocket);
	rmAddGroupingConstraint(bisonCarcass, avoidCliffsShort);
	rmAddGroupingConstraint(bisonCarcass, avoidStartingUnits);
	rmAddGroupingConstraint(bisonCarcass, avoidAll);
	rmAddGroupingConstraint(bisonCarcass, avoidNuggetSmall);
	rmPlaceGroupingAtLoc(bisonCarcass, 0, 0.5, 0.5, rmRandInt(2,3));
   }

   if (vultures == 1)
   { 
	int vultureID=rmCreateObjectDef("perching vultures");
	int avoidVultures=rmCreateTypeDistanceConstraint("avoid other vultures", "PropVulturePerching", 60.0);
	rmAddObjectDefItem(vultureID, "PropVulturePerching", 1, 0.0);
	rmSetObjectDefMinDistance(vultureID, 0.0);
	rmSetObjectDefMaxDistance(vultureID, rmXFractionToMeters(0.5));
	rmAddObjectDefConstraint(vultureID, avoidAll);
	rmAddObjectDefConstraint(vultureID, avoidImportantItem);
	rmAddObjectDefConstraint(vultureID, avoidCoin);
	rmAddObjectDefConstraint(vultureID, avoidImpassableLand);
	rmAddObjectDefConstraint(vultureID, avoidTradeRoute);
	rmAddObjectDefConstraint(vultureID, avoidSocket);
	rmAddObjectDefConstraint(vultureID, avoidCliffsShort);
	rmAddObjectDefConstraint(vultureID, avoidVultures);
	rmAddObjectDefConstraint(vultureID, avoidWater20);
	rmAddObjectDefConstraint(vultureID, longPlayerConstraint);
	rmPlaceObjectDefAtLoc(vultureID, 0, 0.5, 0.5, 2);
      if (cNumberNonGaiaPlayers > 4)
	   rmPlaceObjectDefAtLoc(vultureID, 0, 0.5, 0.5, 1);
   }

   if (eagles == 1)
   {
	int avoidEagles=rmCreateTypeDistanceConstraint("avoids Eagles", "EaglesNest", 60.0);
	int randomEagleTreeID=rmCreateObjectDef("random eagle tree");
	rmAddObjectDefItem(randomEagleTreeID, "EaglesNest", 1, 0.0);
	rmSetObjectDefMinDistance(randomEagleTreeID, 0.0);
	rmSetObjectDefMaxDistance(randomEagleTreeID, rmXFractionToMeters(0.5));
	rmAddObjectDefConstraint(randomEagleTreeID, avoidAll);
	rmAddObjectDefConstraint(randomEagleTreeID, shortAvoidImpassableLand);
	rmAddObjectDefConstraint(randomEagleTreeID, avoidEagles);
	rmAddObjectDefConstraint(randomEagleTreeID, avoidTradeRoute);
	rmAddObjectDefConstraint(randomEagleTreeID, avoidSocket);
	rmAddObjectDefConstraint(randomEagleTreeID, avoidCliffsShort);
	rmAddObjectDefConstraint(randomEagleTreeID, nuggetPlayerConstraint);
	rmPlaceObjectDefAtLoc(randomEagleTreeID, 0, 0.5, 0.5, 2);
      if (cNumberNonGaiaPlayers > 4)
	   rmPlaceObjectDefAtLoc(randomEagleTreeID, 0, 0.5, 0.5, 1);
   }

   // Text
   rmSetStatusText("",0.99);
}