// Gold Rush
// a map for AOE3: TAD 
// by RF_Gandalf

include "ypAsianInclude.xs";
include "ypKOTHInclude.xs";
include "mercenaries.xs";

void main(void)
{
// Text
   rmSetStatusText("",0.01);

// Set up for variables
   string baseType = "";
   string cliffType = "";
   string forestType = "";
   string treeType = "";
   string tree2Type = "";
   string oasisTreeType = "";
   string deerType = "";
   string deer2Type = "";
   string sheepType = "";
   string centerHerdType = "";
   string native1Name = "";
   string native2Name = "";

// Pick pattern for trees, terrain, features, etc.
   int handedness = rmRandInt(1,2);
   int patternChance = rmRandInt(1,6);   
   int variantChance = rmRandInt(1,2);
   int lightingChance = rmRandInt(1,2);
   int socketPattern = rmRandInt(1,2);   
   int nativePattern = rmRandInt(1,10);
   int endPosition = rmRandInt(1,3);
   int sidePosition = rmRandInt(1,3);
   int sheepChance = rmRandInt(1,2);
   int makeCliffs = -1; 
   int cliffVariety = rmRandInt(1,2);
   int placeBerries = 1;
   int forestDist = rmRandInt(12,18);
   int circChance = rmRandInt(1,5);
   int placeCircular = 0;
   int playerSide = rmRandInt(1,2);   
   int twoChoice = rmRandInt(1,2);
   int threeChoice = rmRandInt(1,3);
   int fourChoice = rmRandInt(1,4);
   int fiveChoice = rmRandInt(1,5);
   int placeGold = rmRandInt(1,5);
   int coverUp = 0;
   int forestCoverUp = 0;
   int trPattern = rmRandInt(1,2);
   int texasProp = 0;
   int eaglerock = 0;
   oasisTreeType = "TreeGreatPlains";

// Picks the map size
   int playerTiles = 15000;  // 2 pl
   if (cNumberNonGaiaPlayers >6)
	playerTiles = 11000;   // 7,8 pl
   else if (cNumberNonGaiaPlayers >4)
      playerTiles = 13000;   // 5,6 pl
   else if (cNumberNonGaiaPlayers >2)
      playerTiles = 14000;   // 3,4 pl			

   int size=2.0*sqrt(cNumberNonGaiaPlayers*playerTiles);
   rmEchoInfo("Map size="+size+"m x "+size+"m");
   rmSetMapSize(size, size);

// Elevation
   rmSetSeaLevel(6.0);
   rmSetMapElevationParameters(cElevTurbulence, 0.4, 6, 0.7, 5.0);
   rmSetMapElevationHeightBlend(1.0);

// Pick terrain patterns
   if (patternChance == 1) // texas desert
   {   
      rmSetMapType("texas");
	rmSetMapType("grass");
      if (lightingChance == 1)
         rmSetLightingSet("texas");
      else
         rmSetLightingSet("pampas");
      baseType = "texas_dirt";
	forestType = "texas forest dirt";
      cliffType = "Texas";
	treeType = "TreeTexasDirt";
	tree2Type = "TreeSonora";
      if (variantChance == 1)
	{
         deerType = "bison";
         deer2Type = "deer";
         centerHerdType = "pronghorn";
	}
      else 
	{     
         deerType = "pronghorn";
         deer2Type = "bison";
         centerHerdType = "bison";
	}
	coverUp = 1;
      texasProp = 1;
	rmTerrainInitialize("texas\ground2_tex", 2.0);
   }
   else if (patternChance == 2) // sonora
   {   
      rmSetMapType("sonora");
	rmSetMapType("grass");
      if (lightingChance == 1)
         rmSetLightingSet("sonora");
      else
         rmSetLightingSet("pampas");
      baseType = "sonora_dirt";
	forestType = "sonora forest";
      cliffType = "Sonora";
	treeType = "TreeSonora";
	tree2Type = "TreeSonora";
      if (variantChance == 1)
	{
         deerType = "pronghorn";
         deer2Type = "bison";
         centerHerdType = "bighornsheep";         
	}
      else 
	{     
         deerType = "pronghorn";
         deer2Type = "bighornsheep";
         centerHerdType = "bison";         
	}
	eaglerock = 1;
      rmTerrainInitialize("sonora\ground6_son", 2.0);
   }
   else if (patternChance == 3) // mexican palm desert
   {   
      rmSetMapType("sonora");
	rmSetMapType("grass");
      if (lightingChance == 1)
         rmSetLightingSet("caribbean");
      else
         rmSetLightingSet("pampas");
      baseType = "texas_dirt";
	forestType = "caribbean palm forest";
      cliffType = "Texas";
	treeType = "TreeCaribbean";
	tree2Type = "TreeSonora";
	oasisTreeType = "TreeCaribbean";
      if (variantChance == 1)
	{
         deerType = "deer";
         deer2Type = "turkey";
         centerHerdType = "deer";
	}
      else 
	{     
         deerType = "deer";
         deer2Type = "deer";
         centerHerdType = "turkey";
	}
	coverUp = 1;
      forestCoverUp = 1;
      texasProp = 1;
	rmTerrainInitialize("texas\ground2_tex", 2.0);
	nativePattern = rmRandInt(7,10);
   }
   else if (patternChance == 4) // painted desert
   {   
      rmSetMapType("sonora");
	rmSetMapType("desert");
      if (lightingChance == 1)
         rmSetLightingSet("caribbean");
      else
          rmSetLightingSet("pampas");
      baseType = "painteddesert_groundmix_3";
	forestType = "painteddesert forest";
      cliffType = "Painteddesert";
	treeType = "TreePaintedDesert";
	tree2Type = "TreeSonora";
      if (variantChance == 1)
	{
         deerType = "pronghorn";
         deer2Type = "pronghorn";
         centerHerdType = "bighornsheep";         
	}
      else 
	{     
         deerType = "pronghorn";
         deer2Type = "bighornsheep";
         centerHerdType = "bison";         
	}
	eaglerock = 1;
	rmTerrainInitialize("painteddesert\pd_ground_diffuse_h", 2.0);
   }
   else if (patternChance == 5) // cal desert
   {   
      rmSetMapType("andes");
	rmSetMapType("grass");
      if (lightingChance == 1)
         rmSetLightingSet("caribbean");
      else
         rmSetLightingSet("andes");      
      baseType = "andes_grass_a";
	forestType = "andes forest";
      cliffType = "andes";
	treeType = "TreeMadrone";
	tree2Type = "treePuya";
      if (variantChance == 1)
	{
         deerType = "elk";
         deer2Type = "pronghorn";
         centerHerdType = "bighornsheep";         
	}
      else 
	{     
         deerType = "pronghorn";
         deer2Type = "deer";
         centerHerdType = "pronghorn";         
	}
	coverUp = 1;
	rmTerrainInitialize("andes\ground10_and", 2.0);
   }
   else if (patternChance == 6) // great plains
   { 
      rmSetMapType("greatPlains");
      rmSetMapType("grass");
      if (lightingChance == 1)
         rmSetLightingSet("great plains");
      else
         rmSetLightingSet("andes");
      baseType = "great plains drygrass";
	forestType = "California pine forest";
      cliffType = "Great Plains";
	treeType = "TreePonderosaPine";
	tree2Type = "TreePinonPine";
      if (variantChance == 1)
	{
         deerType = "bison";
         deer2Type = "pronghorn";
         centerHerdType = "elk";
	}
      else 
	{     
         deerType = "pronghorn";
         deer2Type = "elk";
         centerHerdType = "bison";
	}
	coverUp = 1;
      forestCoverUp = 1;
	rmTerrainInitialize("great_plains\ground2_gp", 2.0);
	nativePattern = rmRandInt(1,6);
   }

   if (sheepChance == 1)
      sheepType = "sheep";
   else
      sheepType = "cow";

// Other map definitions
   rmEnableLocalWater(false);
   rmSetBaseTerrainMix(baseType);
   rmSetMapType("land");
   rmSetWorldCircleConstraint(true);
   rmSetWindMagnitude(2.0);
   chooseMercs();

// Native patterns
  if (nativePattern == 1)
  {
      rmSetSubCiv(0, "Navajo");
      native1Name = "native navajo village ";
      rmSetSubCiv(1, "Cheyenne");
      native2Name = "native cheyenne village ";
  }
  else if (nativePattern == 2)
  {
      rmSetSubCiv(0, "Apache");
      native1Name = "native apache village ";
      rmSetSubCiv(1, "Cheyenne");
      native2Name = "native cheyenne village ";
  }
  else if (nativePattern == 3)
  {
      rmSetSubCiv(0, "Navajo");
      native1Name = "native navajo village ";
      rmSetSubCiv(1, "Comanche");
      native2Name = "native comanche village ";
  }
  else if (nativePattern == 4)
  {
      rmSetSubCiv(0, "Apache");
      native1Name = "native apache village ";
      rmSetSubCiv(1, "Comanche");
      native2Name = "native comanche village ";
  }
  else if (nativePattern == 5)
  {
      rmSetSubCiv(0, "Apache");
      native1Name = "native apache village ";
      rmSetSubCiv(1, "Navajo");
      native2Name = "native navajo village ";
  }
  else if (nativePattern == 6)
  {
      rmSetSubCiv(0, "Comanche");
      native1Name = "native comanche village ";
      rmSetSubCiv(1, "Cheyenne");
      native2Name = "native cheyenne village ";
  }
  else if (nativePattern == 7)
  {
      rmSetSubCiv(0, "Zapotec");
      native1Name = "native zapotec village ";
      rmSetSubCiv(1, "Cheyenne");
      native2Name = "native cheyenne village ";
  }
  else if (nativePattern == 8)
  {
      rmSetSubCiv(0, "Apache");
      native1Name = "native apache village ";
      rmSetSubCiv(1, "Zapotec");
      native2Name = "native zapotec village ";
  }
  else if (nativePattern == 9)
  {
      rmSetSubCiv(0, "Zapotec");
      native1Name = "native zapotec village ";
      rmSetSubCiv(1, "Comanche");
      native2Name = "native comanche village ";
  }
  else if (nativePattern == 10)
  {
      rmSetSubCiv(0, "Navajo");
      native1Name = "native navajo village ";
      rmSetSubCiv(1, "Zapotec");
      native2Name = "native zapotec village ";
  }

// Define some classes. These are used later for constraints.
   int classPlayer=rmDefineClass("player");
   rmDefineClass("classCliff");
   rmDefineClass("classLittleCliff");
   int classbigContinent=rmDefineClass("big continent");
   rmDefineClass("startingUnit");
   rmDefineClass("classForest");
   rmDefineClass("importantItem");
   rmDefineClass("classInvis");
   rmDefineClass("inland");
   int classHuntable=rmDefineClass("huntableFood");  
   rmDefineClass("center");
   rmDefineClass("classPatch");

// ----------------------------------Define constraints

   // Player constraints
   int playerConstraint=rmCreateTypeDistanceConstraint("TC avoid same", "TownCenter", 25.0);
   if ( rmGetNomadStart())
	playerConstraint=rmCreateTypeDistanceConstraint("TC avoid same", "CoveredWagon", 25.0);

   int longPlayerConstraint=rmCreateTypeDistanceConstraint("avoid TC long", "TownCenter", rmXFractionToMeters(0.15));
   if ( rmGetNomadStart())
	longPlayerConstraint=rmCreateTypeDistanceConstraint("avoid TC long", "CoveredWagon", rmXFractionToMeters(0.15));

   int farPlayerConstraint= rmCreateTypeDistanceConstraint("avoid TC far", "TownCenter", 70.0);     
   if ( rmGetNomadStart())
	farPlayerConstraint= rmCreateTypeDistanceConstraint("avoid TC far", "CoveredWagon", 70.0);     

   int fartherPlayerConstraint=rmCreateTypeDistanceConstraint("avoid TC farther", "TownCenter", 90.0); 
   if ( rmGetNomadStart())
	fartherPlayerConstraint=rmCreateTypeDistanceConstraint("avoid TC farther", "CoveredWagon", 90.0); 

   int cliffPlayerConstraint=rmCreateTypeDistanceConstraint("avoid TC by 63", "TownCenter", 63.0); 
   if ( rmGetNomadStart())
	cliffPlayerConstraint=rmCreateTypeDistanceConstraint("avoid TC by 63", "CoveredWagon", 63.0); 

   int medPlayerConstraint=rmCreateTypeDistanceConstraint("avoid TC med", "TownCenter", 50.0);
   if ( rmGetNomadStart())	
	medPlayerConstraint=rmCreateTypeDistanceConstraint("avoid TC med", "CoveredWagon", 50.0);     
   
   // Area constraints
   int circleConstraint=rmCreatePieConstraint("circle Constraint", 0.5, 0.5, 0, rmZFractionToMeters(0.46), rmDegreesToRadians(0), rmDegreesToRadians(360)); 
   int invisConstraint=rmCreateClassDistanceConstraint("continent avoid invis continent", rmClassID("classInvis"), rmXFractionToMeters(0.18));
   if (cNumberNonGaiaPlayers >6)
      invisConstraint=rmCreateClassDistanceConstraint("continent avoid invis continent large map", rmClassID("classInvis"), rmXFractionToMeters(0.20));
   int inlandConstraint=rmCreateClassDistanceConstraint("avoid inland area", rmClassID("inland"), 2.0);
   int bigContinentConstraint=rmCreateClassDistanceConstraint("avoid continent long", classbigContinent, 10.0);   // was 16
   int shortContinentConstraint=rmCreateClassDistanceConstraint("avoid continent short", classbigContinent, 10.0);
   int centerConstraintShort=rmCreateClassDistanceConstraint("stay away from center short", rmClassID("center"), 12.0);
   int patchConstraint=rmCreateClassDistanceConstraint("patch vs. patch", rmClassID("classPatch"), 8.0);
   int NEquadrantConstraint=rmCreatePieConstraint("NE circle Constraint", 0.5, 0.5, rmZFractionToMeters(0.09), rmZFractionToMeters(0.47), rmDegreesToRadians(30), rmDegreesToRadians(150)); 
   int NWquadrantConstraint=rmCreatePieConstraint("NW circle Constraint", 0.5, 0.5, rmZFractionToMeters(0.09), rmZFractionToMeters(0.47), rmDegreesToRadians(300), rmDegreesToRadians(60)); 

   // Resource avoidance
   int forestConstraint=rmCreateClassDistanceConstraint("forest vs. forest", rmClassID("classForest"), 18.0);
   int shortForestConstraint=rmCreateClassDistanceConstraint("short dist vs. forest", rmClassID("classForest"), 5.0);
   int avoidDeer=rmCreateTypeDistanceConstraint("deer avoids deer", "deer", 40.0);
   int avoidBerries=rmCreateTypeDistanceConstraint("berry vs berry", "berryBush", 60.0);
   int avoidSheep=rmCreateTypeDistanceConstraint("sheep avoids sheep", "sheep", 40.0);
   int avoidCow=rmCreateTypeDistanceConstraint("cow avoids cow", "cow", 40.0);
   int avoidFastCoin=rmCreateTypeDistanceConstraint("fast coin avoids coin", "gold", 30.0);
   int avoidNugget=rmCreateTypeDistanceConstraint("nugget avoid nugget", "abstractNugget", 30.0);
   int huntableConstraint=rmCreateClassDistanceConstraint("huntable constraint", rmClassID("huntableFood"), 30.0);
   int longHuntableConstraint=rmCreateClassDistanceConstraint("long huntable constraint", rmClassID("huntableFood"), 40.0);

   // Avoid impassable land
   int avoidImpassableLand=rmCreateTerrainDistanceConstraint("avoid impassable land", "Land", false, 6.0);
   int longAvoidImpassableLand=rmCreateTerrainDistanceConstraint("long avoid impassable land", "Land", false, 20.0);
   if (cNumberNonGaiaPlayers < 3)
	longAvoidImpassableLand=rmCreateTerrainDistanceConstraint("long avoid impassable land small map", "Land", false, 12.0);
   int shortAvoidImpassableLand=rmCreateTerrainDistanceConstraint("short avoid impassable land", "Land", false, 4.0);

   // Cliff constraints
   int avoidCliffs=rmCreateClassDistanceConstraint("stuff vs. cliff", rmClassID("classCliff"), 25.0);
   int avoidCliffsMed=rmCreateClassDistanceConstraint("stuff vs. cliff med", rmClassID("classCliff"), 13.0);
   int cliffsAvoidCliffs=rmCreateClassDistanceConstraint("cliffs vs. cliffs", rmClassID("classCliff"), 20.0);   
   int avoidCliffsShort=rmCreateClassDistanceConstraint("stuff vs. cliff short", rmClassID("classCliff"), 8.0);
   int avoidLittleCliffsShort=rmCreateClassDistanceConstraint("stuff vs. cliff short", rmClassID("classLittleCliff"), 8.0);
   int avoidLittleCliffsMed=rmCreateClassDistanceConstraint("stuff vs. cliff med", rmClassID("classLittleCliff"), 12.0);
   
   // Unit avoidance
   int avoidAll=rmCreateTypeDistanceConstraint("avoid all", "all", 4.0);
   int forestvsTC=rmCreateTypeDistanceConstraint("forest vs. TC", "TownCenter", 38.0);
   int forestvsCW=rmCreateTypeDistanceConstraint("forest vs. CW", "CoveredWagon", 35.0);
   int avoidTC=rmCreateTypeDistanceConstraint("stuff vs TC", "TownCenter", 60.0);
   int shortAvoidTC=rmCreateTypeDistanceConstraint("stuff less vs TC", "TownCenter", 20.0);
   int shortestAvoidTC=rmCreateTypeDistanceConstraint("stuff least vs TC", "TownCenter", 14.0);
   int avoidCW=rmCreateTypeDistanceConstraint("stuff vs CW", "CoveredWagon", 60.0);
   int avoidNatives=rmCreateClassDistanceConstraint("stuff avoids natives", rmClassID("natives"), 50.0);
   int avoidNativesMed=rmCreateClassDistanceConstraint("stuff avoids natives medium", rmClassID("natives"), 25.0);

   // Important object avoidance
   int avoidTradeRoute = rmCreateTradeRouteDistanceConstraint("trade route", 8.0);
   int shortAvoidTradeRouteSocket = rmCreateTypeDistanceConstraint("short avoid trade route socket", "socketTradeRoute", 8.0);
   int nativeAvoidTradeRouteSocket = rmCreateTypeDistanceConstraint("avoid trade route socket", "socketTradeRoute", 20.0);
   int avoidImportantItem=rmCreateClassDistanceConstraint("sockets avoid each other", rmClassID("importantItem"), 15.0);
   int silverAvoidImportantItem=rmCreateClassDistanceConstraint("silver avoids sockets", rmClassID("importantItem"), 12.0);
   int avoidKOTH=rmCreateTypeDistanceConstraint("avoid KOTH", "ypKingsHill", 15.0);

// Text
   rmSetStatusText("",0.10);

// Player placement
   if (handedness == 1)  // NW cliffs
   {
	// If only 2 players place as 2 points
	if(cNumberNonGaiaPlayers == 2)
	{
		rmPlacePlayer(1, 0.87, 0.45);
		rmPlacePlayer(2, 0.13, 0.45);
	}
	// Place by team if 2 teams and sane teams
	else if(cNumberTeams == 2 && rmGetNumberPlayersOnTeam(0) < 5 && rmGetNumberPlayersOnTeam(1) < 5)
	{
	   if (cNumberNonGaiaPlayers < 5)
	   {
		rmSetPlacementTeam(0);
		rmSetPlacementSection(0.26, 0.40);
		rmPlacePlayersCircular(0.4, 0.4, rmDegreesToRadians(5.0));
		rmSetPlacementTeam(1);
		rmSetPlacementSection(0.60, 0.74);
		rmPlacePlayersCircular(0.4, 0.4, rmDegreesToRadians(5.0));
	   }
	   else if (cNumberNonGaiaPlayers < 7)
	   {
		rmSetPlacementTeam(0);
		rmSetPlacementSection(0.22, 0.42);
		rmPlacePlayersCircular(0.4, 0.4, rmDegreesToRadians(5.0));
		rmSetPlacementTeam(1);
		rmSetPlacementSection(0.58, 0.78);
		rmPlacePlayersCircular(0.4, 0.4, rmDegreesToRadians(5.0));
	   }
	   else
	   {
		rmSetPlacementTeam(0);
		rmSetPlacementSection(0.2, 0.42);
		rmPlacePlayersCircular(0.4, 0.4, rmDegreesToRadians(5.0));
		rmSetPlacementTeam(1);
		rmSetPlacementSection(0.58, 0.8);
		rmPlacePlayersCircular(0.4, 0.4, rmDegreesToRadians(5.0));
	   }
	}
	// otherwise just place in one arc FFA style
	else
	{
		if (cNumberNonGaiaPlayers > 6)
		   rmSetPlacementSection(0.25, 0.75);
		else
		   rmSetPlacementSection(0.26, 0.74);
		rmPlacePlayersCircular(0.4, 0.4, rmDegreesToRadians(5.0));
	}
   }
   else // NE cliffs
   {
	// If only 2 players place as 2 points
	if(cNumberNonGaiaPlayers == 2)
	{
		rmPlacePlayer(1, 0.45, 0.87);
		rmPlacePlayer(2, 0.45, 0.13);
	}
	// Place by team if 2 teams and sane teams
	else if(cNumberTeams == 2 && rmGetNumberPlayersOnTeam(0) < 5 && rmGetNumberPlayersOnTeam(1) < 5)
	{
	   if (cNumberNonGaiaPlayers < 5)
	   {
		rmSetPlacementTeam(0);
		rmSetPlacementSection(0.85, 0.0);
		rmPlacePlayersCircular(0.4, 0.4, rmDegreesToRadians(5.0));
		rmSetPlacementTeam(1);
		rmSetPlacementSection(0.50, 0.65);
		rmPlacePlayersCircular(0.4, 0.4, rmDegreesToRadians(5.0));
	   }
	   else if (cNumberNonGaiaPlayers < 7)
	   {
		rmSetPlacementTeam(0);
		rmSetPlacementSection(0.82, 0.02);
		rmPlacePlayersCircular(0.4, 0.4, rmDegreesToRadians(5.0));
		rmSetPlacementTeam(1);
		rmSetPlacementSection(0.48, 0.68);
		rmPlacePlayersCircular(0.4, 0.4, rmDegreesToRadians(5.0));
	   }
	   else
	   {
		rmSetPlacementTeam(0);
		rmSetPlacementSection(0.82, 0.04);
		rmPlacePlayersCircular(0.4, 0.4, rmDegreesToRadians(5.0));
		rmSetPlacementTeam(1);
		rmSetPlacementSection(0.46, 0.68);
		rmPlacePlayersCircular(0.4, 0.4, rmDegreesToRadians(5.0));
	   }
	}
	// otherwise just place in one arc FFA style
	else
	{
		if (cNumberNonGaiaPlayers > 6)
		   rmSetPlacementSection(0.46, 0.03);
		else
		   rmSetPlacementSection(0.47, 0.02);
		rmPlacePlayersCircular(0.4, 0.4, rmDegreesToRadians(5.0));
	}
   }

// Text
   rmSetStatusText("",0.15);

// Set up player areas.
   float playerFraction=rmAreaTilesToFraction(1200);
   for(i=1; <cNumberPlayers)
   {
      int id=rmCreateArea("Player"+i);
      rmSetPlayerArea(i, id);
	rmSetAreaWarnFailure(id, false);
      rmSetAreaSize(id, playerFraction, playerFraction);
	rmAddAreaToClass(id, classPlayer);
      rmSetAreaMinBlobs(id, 1);
      rmSetAreaMaxBlobs(id, 1);
      rmAddAreaConstraint(id, playerConstraint);
      rmSetAreaLocPlayer(id, i);
	rmSetAreaCoherence(id, 0.9);
   }
   rmBuildAllAreas();

// Text
   rmSetStatusText("",0.20);

// Center area
   int centerArea=rmCreateArea("TheCenter");
   rmSetAreaSize(centerArea, 0.02, 0.02);
   rmSetAreaLocation(centerArea, 0.5, 0.5);
   rmAddAreaToClass(centerArea, rmClassID("center"));
   rmBuildArea(centerArea); 

// Invisible continent added to have big continent avoid cliffs
   int invisContinentID=rmCreateArea("invisible continent for constraint");
   rmSetAreaSize(invisContinentID, 0.07, 0.07);
   rmSetAreaWarnFailure(invisContinentID, false);
   if (handedness == 1) // NW cliffs
   {
	rmSetAreaLocation(invisContinentID, 0.5, 0.89);
	rmAddAreaInfluenceSegment(invisContinentID, 0.5, 0.99, 0.3, 0.7);
	rmAddAreaInfluenceSegment(invisContinentID, 0.5, 0.99, 0.7, 0.7);
	rmAddAreaInfluenceSegment(invisContinentID, 0.5, 0.99, 0.5, 0.65);
   }
   else // NE cliffs
   {			
	rmSetAreaLocation(invisContinentID, 0.89, 0.5);
	rmAddAreaInfluenceSegment(invisContinentID, 0.99, 0.5, 0.7, 0.30);
	rmAddAreaInfluenceSegment(invisContinentID, 0.99, 0.5, 0.7, 0.70);
	rmAddAreaInfluenceSegment(invisContinentID, 0.99, 0.5, 0.65, 0.5);
   }
   rmAddAreaToClass(invisContinentID, rmClassID("classInvis"));
   rmSetAreaCoherence(invisContinentID, 0.8);
   rmBuildArea(invisContinentID);

// Text
   rmSetStatusText("",0.25);

// Build up big continent called "big continent"
   int bigContinentID = -1;
   bigContinentID=rmCreateArea("big continent");
   rmSetAreaSize(bigContinentID, 0.65, 0.65); 
   rmSetAreaWarnFailure(bigContinentID, false);
   rmAddAreaConstraint(bigContinentID, invisConstraint);
   rmAddAreaToClass(bigContinentID, classbigContinent);
   rmSetAreaMinBlobs(bigContinentID, 10);
   rmSetAreaMaxBlobs(bigContinentID, 10);
   rmSetAreaMinBlobDistance(bigContinentID, rmXFractionToMeters(0.1));
   rmSetAreaMaxBlobDistance(bigContinentID, rmXFractionToMeters(0.4));
   rmSetAreaSmoothDistance(bigContinentID, 20);
   rmSetAreaMix(bigContinentID, baseType);
   rmSetAreaCoherence(bigContinentID, 0.8);
   // CHOOSE RIGHT OR LEFT-HANDED CLIFF AREA
   if (handedness == 1) // NW cliffs
   {
      rmSetAreaLocation(bigContinentID, 0.5, 0.25);
	rmAddAreaInfluenceSegment(bigContinentID, 0.0, 0.5, 1.0, 0.5); 
	rmAddAreaInfluenceSegment(bigContinentID, 0.65, 0.0, 0.65, 0.5);
	rmAddAreaInfluenceSegment(bigContinentID, 0.5, 0.0, 0.5, 0.5);
	rmAddAreaInfluenceSegment(bigContinentID, 0.35, 0.0, 0.35, 0.5);
   }
   else // NE cliffs
   {
      rmSetAreaLocation(bigContinentID, 0.25, 0.5);
	rmAddAreaInfluenceSegment(bigContinentID, 0.5, 0.0, 0.5, 1.0); 
	rmAddAreaInfluenceSegment(bigContinentID, 0.0, 0.65, 0.5, 0.65);
	rmAddAreaInfluenceSegment(bigContinentID, 0.0, 0.5, 0.5, 0.5);
	rmAddAreaInfluenceSegment(bigContinentID, 0.0, 0.35, 0.5, 0.35);
   }
   rmSetAreaEdgeFilling(bigContinentID, 10);
   rmSetAreaObeyWorldCircleConstraint(bigContinentID, false);
   rmBuildArea(bigContinentID);

// Text
   rmSetStatusText("",0.30); 

// TRADE ROUTES
if (trPattern == 1)
{
   int tradeRouteID = rmCreateTradeRoute();
   vector tradeRoutePoint = cOriginVector;

   if (handedness == 1) // cliffs to NW
   {
	if (cNumberNonGaiaPlayers == 2)
	{
	tradeRoutePoint = rmFindClosestPoint(0.05, 0.15, 10.0);
	rmAddTradeRouteWaypoint(tradeRouteID, rmXMetersToFraction(xsVectorGetX(tradeRoutePoint)), rmZMetersToFraction(xsVectorGetZ(tradeRoutePoint)));

	rmAddRandomTradeRouteWaypoints(tradeRouteID, 0.5, 0.4, 5, 6);

	tradeRoutePoint = rmFindClosestPoint(0.95, 0.15, 10.0);
	rmAddRandomTradeRouteWaypoints(tradeRouteID, rmXMetersToFraction(xsVectorGetX(tradeRoutePoint)), rmZMetersToFraction(xsVectorGetZ(tradeRoutePoint)), 5, 6);
	}
	else
	{
	tradeRoutePoint = rmFindClosestPoint(0.05, 0.3, 10.0);
	rmAddTradeRouteWaypoint(tradeRouteID, rmXMetersToFraction(xsVectorGetX(tradeRoutePoint)), rmZMetersToFraction(xsVectorGetZ(tradeRoutePoint)));

	rmAddRandomTradeRouteWaypoints(tradeRouteID, 0.5, 0.5, 5, 6);

	tradeRoutePoint = rmFindClosestPoint(0.95, 0.3, 10.0);
	rmAddRandomTradeRouteWaypoints(tradeRouteID, rmXMetersToFraction(xsVectorGetX(tradeRoutePoint)), rmZMetersToFraction(xsVectorGetZ(tradeRoutePoint)), 5, 6);
	}
   }
   else // cliffs to NE
   {
	if (cNumberNonGaiaPlayers == 2)
	{
	tradeRoutePoint = rmFindClosestPoint(0.15, 0.05, 10.0);
	rmAddTradeRouteWaypoint(tradeRouteID, rmXMetersToFraction(xsVectorGetX(tradeRoutePoint)), rmZMetersToFraction(xsVectorGetZ(tradeRoutePoint)));

	rmAddRandomTradeRouteWaypoints(tradeRouteID, 0.4, 0.5, 5, 6);
	tradeRoutePoint = rmFindClosestPoint(0.15, 0.95, 10.0);
	rmAddRandomTradeRouteWaypoints(tradeRouteID, rmXMetersToFraction(xsVectorGetX(tradeRoutePoint)), rmZMetersToFraction(xsVectorGetZ(tradeRoutePoint)), 5, 6);
	}
	else
	{
	tradeRoutePoint = rmFindClosestPoint(0.3, 0.05, 10.0);
	rmAddTradeRouteWaypoint(tradeRouteID, rmXMetersToFraction(xsVectorGetX(tradeRoutePoint)), rmZMetersToFraction(xsVectorGetZ(tradeRoutePoint)));

	rmAddRandomTradeRouteWaypoints(tradeRouteID, 0.5, 0.5, 5, 6);
	tradeRoutePoint = rmFindClosestPoint(0.3, 0.95, 10.0);
	rmAddRandomTradeRouteWaypoints(tradeRouteID, rmXMetersToFraction(xsVectorGetX(tradeRoutePoint)), rmZMetersToFraction(xsVectorGetZ(tradeRoutePoint)), 5, 6);
	}
   } 

   bool placedTradeRoute = rmBuildTradeRoute(tradeRouteID, "dirt");
   if(placedTradeRoute == false)
      rmEchoError("Failed to place trade route");  
}
else if (trPattern == 2)  // 2 side-to-side routes
{
   int tradeRouteID8A = rmCreateTradeRoute();
   if (handedness == 1) // cliffs to NW
   {
	tradeRoutePoint = rmFindClosestPoint(0.9, 0.8, 10.0);
	rmAddTradeRouteWaypoint(tradeRouteID8A, rmXMetersToFraction(xsVectorGetX(tradeRoutePoint)), rmZMetersToFraction(xsVectorGetZ(tradeRoutePoint)));

	rmAddRandomTradeRouteWaypoints(tradeRouteID8A, 0.68, 0.6, 4, 6);

	tradeRoutePoint = rmFindClosestPoint(0.61, 0.0, 12.0);
	rmAddRandomTradeRouteWaypoints(tradeRouteID8A, rmXMetersToFraction(xsVectorGetX(tradeRoutePoint)), rmZMetersToFraction(xsVectorGetZ(tradeRoutePoint)), 6, 12);
   }
   else  // NE cliffs
   {
	tradeRoutePoint = rmFindClosestPoint(0.8, 0.9, 10.0);
	rmAddTradeRouteWaypoint(tradeRouteID8A, rmXMetersToFraction(xsVectorGetX(tradeRoutePoint)), rmZMetersToFraction(xsVectorGetZ(tradeRoutePoint)));

	rmAddRandomTradeRouteWaypoints(tradeRouteID8A, 0.6, 0.68, 4, 6);

	tradeRoutePoint = rmFindClosestPoint(0.0, 0.61, 12.0);
	rmAddRandomTradeRouteWaypoints(tradeRouteID8A, rmXMetersToFraction(xsVectorGetX(tradeRoutePoint)), rmZMetersToFraction(xsVectorGetZ(tradeRoutePoint)), 6, 12);
   }
   rmBuildTradeRoute(tradeRouteID8A, "carolinas\trade_route");

   int tradeRouteID8B = rmCreateTradeRoute();
   if (handedness == 1) // cliffs to NW
   {
	tradeRoutePoint = rmFindClosestPoint(0.1, 0.8, 10.0);
	rmAddTradeRouteWaypoint(tradeRouteID8B, rmXMetersToFraction(xsVectorGetX(tradeRoutePoint)), rmZMetersToFraction(xsVectorGetZ(tradeRoutePoint)));

	rmAddRandomTradeRouteWaypoints(tradeRouteID8B, 0.32, 0.6, 4, 6);

	tradeRoutePoint = rmFindClosestPoint(0.39, 0.0, 12.0);
	rmAddRandomTradeRouteWaypoints(tradeRouteID8B, rmXMetersToFraction(xsVectorGetX(tradeRoutePoint)), rmZMetersToFraction(xsVectorGetZ(tradeRoutePoint)), 6, 12);
   }
   else // NE cliffs
   {
	tradeRoutePoint = rmFindClosestPoint(0.8, 0.1, 10.0);
	rmAddTradeRouteWaypoint(tradeRouteID8B, rmXMetersToFraction(xsVectorGetX(tradeRoutePoint)), rmZMetersToFraction(xsVectorGetZ(tradeRoutePoint)));

	rmAddRandomTradeRouteWaypoints(tradeRouteID8B, 0.6, 0.32, 4, 6);

	tradeRoutePoint = rmFindClosestPoint(0.0, 0.39, 12.0);
	rmAddRandomTradeRouteWaypoints(tradeRouteID8B, rmXMetersToFraction(xsVectorGetX(tradeRoutePoint)), rmZMetersToFraction(xsVectorGetZ(tradeRoutePoint)), 6, 12);
   }
   rmBuildTradeRoute(tradeRouteID8B, "dirt");
}

// Text
   rmSetStatusText("",0.35);

// Trade Route Sockets
   int socketID=rmCreateObjectDef("sockets for Trade Route");
   rmAddObjectDefItem(socketID, "SocketTradeRoute", 1, 0.0);
   rmAddObjectDefToClass(socketID, rmClassID("importantItem"));
   rmSetObjectDefAllowOverlap(socketID, true);
   rmSetObjectDefMinDistance(socketID, 0.0);
   rmSetObjectDefMaxDistance(socketID, 7.0);
   variantChance = rmRandInt(1,2);
if (trPattern == 1)
{
   if (variantChance == 1)
   {  
      // add the sockets along the trade route.
      rmSetObjectDefTradeRouteID(socketID, tradeRouteID);
      vector socketLoc = rmGetTradeRouteWayPoint(tradeRouteID, 0.19);
      rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);

      socketLoc = rmGetTradeRouteWayPoint(tradeRouteID, 0.39);
      rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);

      socketLoc = rmGetTradeRouteWayPoint(tradeRouteID, 0.61);
      rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);

      socketLoc = rmGetTradeRouteWayPoint(tradeRouteID, 0.81);
      rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);
   }
   else
   {  
      // add the sockets along the trade route.
      rmSetObjectDefTradeRouteID(socketID, tradeRouteID);
      socketLoc = rmGetTradeRouteWayPoint(tradeRouteID, 0.22);
      rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);

      socketLoc = rmGetTradeRouteWayPoint(tradeRouteID, 0.5);
      rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);

      socketLoc = rmGetTradeRouteWayPoint(tradeRouteID, 0.78);
      rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);
   }
}
else if (trPattern == 2)
{
   rmSetObjectDefTradeRouteID(socketID, tradeRouteID8A);
   if (variantChance == 1) // 3 sockets per route
   { 
      socketLoc = rmGetTradeRouteWayPoint(tradeRouteID8A, 0.2);
      rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);

      socketLoc = rmGetTradeRouteWayPoint(tradeRouteID8A, 0.5);
      rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);

      socketLoc = rmGetTradeRouteWayPoint(tradeRouteID8A, 0.8);
      rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);
   }
   else  // 2 or 4 sockets per route
   {
      socketLoc = rmGetTradeRouteWayPoint(tradeRouteID8A, 0.2);
      rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);

	if (cNumberNonGaiaPlayers > 4)
	{
         socketLoc = rmGetTradeRouteWayPoint(tradeRouteID8A, 0.4);
         rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);

         socketLoc = rmGetTradeRouteWayPoint(tradeRouteID8A, 0.6);
         rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);
	}

      socketLoc = rmGetTradeRouteWayPoint(tradeRouteID8A, 0.8);
      rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);
   }

   // change the trade route for the new sockets
   rmSetObjectDefTradeRouteID(socketID, tradeRouteID8B);
   if (variantChance == 1) // 3 sockets per route
   { 
      socketLoc = rmGetTradeRouteWayPoint(tradeRouteID8B, 0.2);
      rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);

      socketLoc = rmGetTradeRouteWayPoint(tradeRouteID8B, 0.5);
      rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);

      socketLoc = rmGetTradeRouteWayPoint(tradeRouteID8B, 0.8);
      rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);
   }
   else  // 2 or 4 sockets per route
   {
      socketLoc = rmGetTradeRouteWayPoint(tradeRouteID8B, 0.2);
      rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);

	if (cNumberNonGaiaPlayers > 4)
	{
         socketLoc = rmGetTradeRouteWayPoint(tradeRouteID8B, 0.4);
         rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);

         socketLoc = rmGetTradeRouteWayPoint(tradeRouteID8B, 0.6);
         rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);
	}

      socketLoc = rmGetTradeRouteWayPoint(tradeRouteID8B, 0.8);
      rmPlaceObjectDefAtPoint(socketID, 0, socketLoc);
   }
}
   rmClearClosestPointConstraints();

// Text
   rmSetStatusText("",0.40);

// Invisible block
   int inlandID=rmCreateArea("invisible block area");
   rmAddAreaToClass(inlandID, rmClassID("inland"));
   rmSetAreaSize(inlandID, 0.01, 0.015);
   rmSetAreaWarnFailure(inlandID, false);
   if (handedness == 1) // NW cliffs
   {
	rmSetAreaLocation(inlandID, 0.5, 0.98);
   }
   else // NE cliffs
   {			
	rmSetAreaLocation(inlandID, 0.98, 0.5);
   }
   rmSetAreaMinBlobs(inlandID, 1);
   rmSetAreaMaxBlobs(inlandID, 3);
   rmSetAreaMinBlobDistance(inlandID, 20.0);
   rmSetAreaMaxBlobDistance(inlandID, 25.0);
   rmSetAreaCoherence(inlandID, 0.3);
   rmSetAreaSmoothDistance(inlandID, 15);
   rmBuildArea(inlandID);

// Plateau 
   int failCount=0;
   for (i=0; <1)
   { 
	int bigMesaID=rmCreateArea("big mesa");
	if (trPattern == 1)
	   rmSetAreaSize(bigMesaID, 0.2, 0.26);
	else
	   rmSetAreaSize(bigMesaID, 0.2, 0.22);  
	rmSetAreaCliffType(bigMesaID, cliffType);
	rmAddAreaToClass(bigMesaID, rmClassID("classCliff"));
	if (patternChance == 6)
	{
	   if (cNumberNonGaiaPlayers > 4)
	      rmSetAreaCliffEdge(bigMesaID, 8, 0.05, 0.01, 1.0, 0); 
	   else
	      rmSetAreaCliffEdge(bigMesaID, 6, 0.06, 0.01, 1.0, 0);
	   rmSetAreaCliffPainting(bigMesaID, true, true, true, 1.5, true);
	}
	else
	{
	   if (cNumberNonGaiaPlayers > 4)
	      rmSetAreaCliffEdge(bigMesaID, 8, 0.08, 0.01, 1.0, 0); 
	   else
	      rmSetAreaCliffEdge(bigMesaID, 6, 0.09, 0.01, 1.0, 0); 
     	   rmSetAreaCliffPainting(bigMesaID, false, true, true, 1.5, true);
	}
	rmSetAreaCliffHeight(bigMesaID, 6, 1.0, 1.0);
	rmSetAreaMinBlobs(bigMesaID, 3);
	rmSetAreaMaxBlobs(bigMesaID, 5);
	rmSetAreaMinBlobDistance(bigMesaID, 25.0);
	rmSetAreaMaxBlobDistance(bigMesaID, 35.0);
	rmSetAreaCoherence(bigMesaID, 0.5);
      rmSetAreaSmoothDistance(bigMesaID, 20);
      if (handedness == 2)
      {
		rmSetAreaLocation(bigMesaID, 0.79, 0.5);  
		rmAddAreaInfluencePoint(bigMesaID, 0.69, 0.5);
		rmAddAreaInfluencePoint(bigMesaID, 0.75, 0.2);
		rmAddAreaInfluencePoint(bigMesaID, 0.70, 0.18);
		rmAddAreaInfluencePoint(bigMesaID, 0.75, 0.8);
		rmAddAreaInfluencePoint(bigMesaID, 0.70, 0.82);
		rmAddAreaConstraint(bigMesaID, NEquadrantConstraint);
      }
      else
      {
		rmSetAreaLocation(bigMesaID, 0.5, 0.79);
		rmAddAreaInfluencePoint(bigMesaID, 0.5, 0.69);
		rmAddAreaInfluencePoint(bigMesaID, 0.2, 0.75);
		rmAddAreaInfluencePoint(bigMesaID, 0.8, 0.75);
		rmAddAreaInfluencePoint(bigMesaID, 0.18, 0.70);
		rmAddAreaInfluencePoint(bigMesaID, 0.82, 0.70);
		rmAddAreaConstraint(bigMesaID, NWquadrantConstraint);
      }
      rmAddAreaConstraint(bigMesaID, inlandConstraint);
	rmAddAreaConstraint(bigMesaID, cliffPlayerConstraint);
	rmAddAreaConstraint(bigMesaID, bigContinentConstraint);
      rmAddAreaConstraint(bigMesaID, circleConstraint);
      rmAddAreaConstraint(bigMesaID, centerConstraintShort);
      rmAddAreaConstraint(bigMesaID, shortAvoidTradeRouteSocket);
      rmAddAreaConstraint(bigMesaID, avoidTradeRoute);
      if(rmBuildArea(bigMesaID)==false)
      {
         // Stop trying once we fail 5 times in a row.
         failCount++;
         if(failCount==5)
            break;
      }
      else
         failCount=0; 
   }

// Text
   rmSetStatusText("",0.45); 
  
// PLAYER STARTING RESOURCES
   int TCID = rmCreateObjectDef("player TC");
   if ( rmGetNomadStart())
 	rmAddObjectDefItem(TCID, "coveredWagon", 1, 0);
   else
	rmAddObjectDefItem(TCID, "townCenter", 1, 0);
   rmSetObjectDefMinDistance(TCID, 0.0);
   rmSetObjectDefMaxDistance(TCID, 15.0);
   if (cNumberTeams > 2)
      rmSetObjectDefMaxDistance(TCID, 20.0);   
   else if (cNumberNonGaiaPlayers == 2) 
      rmSetObjectDefMaxDistance(TCID, 10.0);
   rmAddObjectDefConstraint(TCID, avoidTradeRoute);
   rmAddObjectDefConstraint(TCID, medPlayerConstraint);
   rmAddObjectDefConstraint(TCID, avoidImpassableLand);
   for(i=1; <cNumberPlayers)
   {
	rmPlaceObjectDefAtLoc(TCID, i, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));
   }

   int startingUnits = rmCreateStartingUnitsObjectDef(5.0);
   rmSetObjectDefMinDistance(startingUnits, 6.0);
   rmSetObjectDefMaxDistance(startingUnits, 10.0);
   rmAddObjectDefConstraint(startingUnits, avoidAll);
   rmAddObjectDefConstraint(startingUnits, shortAvoidImpassableLand);

   int playerSilverID = rmCreateObjectDef("player silver");
   rmAddObjectDefItem(playerSilverID, "mine", 1, 0);
   rmAddObjectDefConstraint(playerSilverID, avoidTradeRoute);
   rmSetObjectDefMinDistance(playerSilverID, 15.0);
   rmSetObjectDefMaxDistance(playerSilverID, 23.0);
   rmAddObjectDefConstraint(playerSilverID, avoidAll);
   rmAddObjectDefConstraint(playerSilverID, shortAvoidImpassableLand);

   int playerBerryID=rmCreateObjectDef("player berries");
   rmAddObjectDefItem(playerBerryID, "berryBush", rmRandInt(3,4), 2.0);
   rmSetObjectDefMinDistance(playerBerryID, 10);
   rmSetObjectDefMaxDistance(playerBerryID, 15);
   rmAddObjectDefConstraint(playerBerryID, avoidAll);
   rmAddObjectDefConstraint(playerBerryID, shortAvoidImpassableLand);

   int playerTreeID=rmCreateObjectDef("player trees");
   rmAddObjectDefItem(playerTreeID, treeType, 1, 0.0);
   rmSetObjectDefMinDistance(playerTreeID, 11);
   rmSetObjectDefMaxDistance(playerTreeID, 16);
   rmAddObjectDefConstraint(playerTreeID, avoidAll);
   rmAddObjectDefConstraint(playerTreeID, shortAvoidImpassableLand);

   // Nuggets per player
   int nugget1= rmCreateObjectDef("nugget easy"); 
   rmAddObjectDefItem(nugget1, "Nugget", 1, 0.0);
   rmSetNuggetDifficulty(1, 1);
   rmAddObjectDefConstraint(nugget1, shortAvoidImpassableLand);
   rmAddObjectDefConstraint(nugget1, avoidNugget);
   rmAddObjectDefConstraint(nugget1, avoidTradeRoute);
   rmAddObjectDefConstraint(nugget1, avoidAll);
   rmAddObjectDefConstraint(nugget1, circleConstraint);
   rmSetObjectDefMinDistance(nugget1, 33.0);
   rmSetObjectDefMaxDistance(nugget1, 40.0);

   int nugget2= rmCreateObjectDef("nugget medium"); 
   rmAddObjectDefItem(nugget2, "Nugget", 1, 0.0);
   rmSetNuggetDifficulty(2, 2);
   rmAddObjectDefConstraint(nugget2, shortAvoidImpassableLand);
   rmAddObjectDefConstraint(nugget2, avoidNugget);
   rmAddObjectDefConstraint(nugget2, avoidTC);
   rmAddObjectDefConstraint(nugget2, avoidCW);
   rmAddObjectDefConstraint(nugget2, avoidTradeRoute);
   rmAddObjectDefConstraint(nugget2, avoidAll);
   rmAddObjectDefConstraint(nugget2, circleConstraint);
   rmSetObjectDefMinDistance(nugget2, 42.0);
   rmSetObjectDefMaxDistance(nugget2, 50.0);
	
// FOOD	
   int nearDeerID=rmCreateObjectDef("deer herds near town");
   rmAddObjectDefItem(nearDeerID, deerType, rmRandInt(6,7), 8.0);
   rmAddObjectDefToClass(nearDeerID, rmClassID("huntableFood"));
   rmSetObjectDefMinDistance(nearDeerID, 25);
   rmSetObjectDefMaxDistance(nearDeerID, 30);
   rmAddObjectDefConstraint(nearDeerID, huntableConstraint);
   rmAddObjectDefConstraint(nearDeerID, avoidAll);
   rmAddObjectDefConstraint(nearDeerID, avoidImpassableLand);
   rmSetObjectDefCreateHerd(nearDeerID, true);

   int farDeerID=rmCreateObjectDef("deer herds far away");
   int bonusChance=rmRandFloat(0, 1);
   if(bonusChance<0.5)   
      rmAddObjectDefItem(farDeerID, deer2Type, rmRandInt(6,7), 8.0);
   else
      rmAddObjectDefItem(farDeerID, deer2Type, rmRandInt(8,9), 10.0);
   rmAddObjectDefToClass(farDeerID, rmClassID("huntableFood"));
   rmSetObjectDefMinDistance(farDeerID, 51);
   rmSetObjectDefMaxDistance(farDeerID, 60);
   rmAddObjectDefConstraint(farDeerID, huntableConstraint);
   rmAddObjectDefConstraint(farDeerID, avoidAll);
   rmAddObjectDefConstraint(farDeerID, medPlayerConstraint);
   rmAddObjectDefConstraint(farDeerID, avoidImpassableLand);
   rmAddObjectDefConstraint(farDeerID, circleConstraint);
   rmAddObjectDefConstraint(farDeerID, avoidLittleCliffsShort);
   rmSetObjectDefCreateHerd(farDeerID, true);

   int farHuntableID=rmCreateObjectDef("far huntable");
   rmAddObjectDefItem(farHuntableID, centerHerdType, rmRandInt(6,9), 6.0);
   rmAddObjectDefToClass(farHuntableID, rmClassID("huntableFood"));
   rmSetObjectDefMinDistance(farHuntableID, 70);
   rmSetObjectDefMaxDistance(farHuntableID, 80);
   rmAddObjectDefConstraint(farHuntableID, avoidImportantItem);
   rmAddObjectDefConstraint(farHuntableID, farPlayerConstraint);
   rmAddObjectDefConstraint(farHuntableID, huntableConstraint);
   rmAddObjectDefConstraint(farHuntableID, avoidAll);
   rmAddObjectDefConstraint(farHuntableID, avoidCliffsShort);
   rmAddObjectDefConstraint(farHuntableID, avoidLittleCliffsShort);
   rmSetObjectDefCreateHerd(farHuntableID, true);
   
// Text
   rmSetStatusText("",0.50);

// Place player starting resources
   for(i=1; <cNumberPlayers)
   {
	vector TCLocation = rmGetUnitPosition(rmGetUnitPlacedOfPlayer(TCID, i));
      vector closestPoint = rmFindClosestPointVector(TCLocation, rmXFractionToMeters(1.0));

	rmPlaceObjectDefAtLoc(startingUnits, i, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));

      if(ypIsAsian(i) && rmGetNomadStart() == false)
         rmPlaceObjectDefAtLoc(ypMonasteryBuilder(i), i, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));
	rmPlaceObjectDefAtLoc(playerBerryID, 0, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));
	rmPlaceObjectDefAtLoc(playerSilverID, 0, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));
	rmPlaceObjectDefAtLoc(playerTreeID, 0, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));
	rmPlaceObjectDefAtLoc(playerTreeID, 0, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));
	rmPlaceObjectDefAtLoc(playerTreeID, 0, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));
	rmPlaceObjectDefAtLoc(playerTreeID, 0, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));	
	rmPlaceObjectDefAtLoc(nugget1, 0, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));
	rmPlaceObjectDefAtLoc(nugget1, 0, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));
	rmPlaceObjectDefAtLoc(nugget2, 0, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));
	rmPlaceObjectDefAtLoc(nearDeerID, 0, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));
	rmPlaceObjectDefAtLoc(farDeerID, 0, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));
	rmPlaceObjectDefAtLoc(farHuntableID, 0, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));
   }
   rmClearClosestPointConstraints();

// Text
   rmSetStatusText("",0.55);

// Oases       
   int numTrees = -1;
   int oasisTreesID=rmCreateObjectDef("oasis trees");
   rmAddObjectDefItem(oasisTreesID, oasisTreeType, 2, 3.0);
   rmSetObjectDefMinDistance(oasisTreesID, 0);
   rmSetObjectDefMaxDistance(oasisTreesID, 1);
   rmAddObjectDefConstraint(oasisTreesID, avoidAll);
   rmAddObjectDefConstraint(oasisTreesID, shortAvoidTradeRouteSocket);
   rmAddObjectDefConstraint(oasisTreesID, avoidTradeRoute);
   rmAddObjectDefConstraint(oasisTreesID, shortAvoidTC);

   for(i=1; <cNumberPlayers)   
   {
	int smallPondID=rmCreateArea("Player"+i+"small pond", rmAreaID("Player"+i));
	rmSetAreaSize(smallPondID, rmAreaTilesToFraction(75), rmAreaTilesToFraction(90));
      rmSetAreaWaterType(smallPondID, "texas pond");
      rmSetAreaBaseHeight(smallPondID, 1);
	rmSetAreaHeightBlend(smallPondID, 3.0);
      rmSetAreaMinBlobs(smallPondID, 1);
      rmSetAreaMaxBlobs(smallPondID, 2);
      rmSetAreaMinBlobDistance(smallPondID, 5.0);
      rmSetAreaMaxBlobDistance(smallPondID, 9.0);
      rmAddAreaConstraint(smallPondID, shortestAvoidTC);
      rmAddAreaConstraint(smallPondID, avoidNativesMed);
      rmAddAreaConstraint(smallPondID, avoidTradeRoute);
      rmAddAreaConstraint(smallPondID, shortAvoidTradeRouteSocket);
      rmAddAreaConstraint(smallPondID, avoidAll);
      rmSetAreaCoherence(smallPondID, rmRandFloat(0.7,0.9));
      rmSetAreaWarnFailure(smallPondID, false);
      rmBuildArea(smallPondID);

      numTrees = rmRandInt(12,15);
      for (j=0; <numTrees)   
         rmPlaceObjectDefInArea(oasisTreesID, 0, rmAreaID("Player"+i+"small pond"), rmRandInt(2,3));
   }

// KOTH game mode 
   if(rmGetIsKOTH())
   {
      int randLoc = rmRandInt(1,2);
      float xLoc = 0.5;
      float yLoc = 0.5;
      float walk = 0.05;
    
      ypKingsHillLandfill(xLoc, yLoc, 0.0075, 2.0, baseType, 0);
      ypKingsHillPlacer(xLoc, yLoc, walk, 0);
   }

// Text
   rmSetStatusText("",0.60);

// Natives
   int villageType = rmRandInt(1,5); 
   int nativeType = rmRandInt(1,2); 
 
   int village1ID = -1;  //  edge center
   if (nativeType == 1) 
      village1ID = rmCreateGrouping("native village 1", native1Name+villageType);
   else
      village1ID = rmCreateGrouping("native village 1", native2Name+villageType);
   rmSetGroupingMinDistance(village1ID, 0.0);
   rmSetGroupingMaxDistance(village1ID, 30);
   rmAddGroupingConstraint(village1ID, avoidImpassableLand);
   rmAddGroupingToClass(village1ID, rmClassID("importantItem"));
   rmAddGroupingConstraint(village1ID, avoidTradeRoute);
   rmAddGroupingConstraint(village1ID, avoidImportantItem);
   rmAddGroupingConstraint(village1ID, nativeAvoidTradeRouteSocket);
   rmAddGroupingConstraint(village1ID, avoidTC);
   rmAddGroupingConstraint(village1ID, avoidCW);
   rmAddGroupingConstraint(village1ID, avoidKOTH);
   if (cNumberTeams == 2)
   {
      if (handedness == 1)
         rmPlaceGroupingAtLoc(village1ID, 0, 0.5, 0.07);
      else 
         rmPlaceGroupingAtLoc(village1ID, 0, 0.07, 0.5);
   }
   else  // away from edge to avoid middle player
   {
      if (handedness == 1)
         rmPlaceGroupingAtLoc(village1ID, 0, 0.5, 0.25);
      else 
         rmPlaceGroupingAtLoc(village1ID, 0, 0.25, 0.5);
   }

   int village2ID = -1;   // in mts
   villageType = rmRandInt(1,5);
   nativeType = rmRandInt(1,2); 
   if (nativeType == 1) 
      village2ID = rmCreateGrouping("native village 2", native1Name+villageType);
   else
      village2ID = rmCreateGrouping("native village 2", native2Name+villageType); 
   rmSetGroupingMinDistance(village2ID, 0.0);
   rmSetGroupingMaxDistance(village2ID, 40);
   rmAddGroupingConstraint(village2ID, avoidImpassableLand);
   rmAddGroupingToClass(village2ID, rmClassID("importantItem"));
   rmAddGroupingConstraint(village2ID, avoidTradeRoute);
   rmAddGroupingConstraint(village2ID, avoidImportantItem);
   rmAddGroupingConstraint(village2ID, nativeAvoidTradeRouteSocket);
   rmAddGroupingConstraint(village2ID, avoidTC);
   rmAddGroupingConstraint(village2ID, avoidCW);
   rmAddGroupingConstraint(village2ID, avoidKOTH);
   if (handedness == 1)
      rmPlaceGroupingAtLoc(village2ID, 0, 0.5, 0.81); 
   else 
      rmPlaceGroupingAtLoc(village2ID, 0, 0.81, 0.5); 

// Text
   rmSetStatusText("",0.65);
  
   int village3ID = -1;   // paired, away from mts
   villageType = rmRandInt(1,5);
   nativeType = rmRandInt(1,2); 
   if (nativeType == 1) 
      village3ID = rmCreateGrouping("native village 3", native1Name+villageType);
   else
      village3ID = rmCreateGrouping("native village 3", native2Name+villageType); 
   rmSetGroupingMinDistance(village3ID, 0.0);
   rmSetGroupingMaxDistance(village3ID, 45);
   rmAddGroupingConstraint(village3ID, avoidImpassableLand);
   rmAddGroupingToClass(village3ID, rmClassID("importantItem"));
   rmAddGroupingConstraint(village3ID, avoidTradeRoute);
   rmAddGroupingConstraint(village3ID, avoidImportantItem);
   rmAddGroupingConstraint(village3ID, nativeAvoidTradeRouteSocket);
   rmAddGroupingConstraint(village3ID, avoidTC);
   rmAddGroupingConstraint(village3ID, avoidCW);
   if (handedness == 1)
   {
      rmPlaceGroupingAtLoc(village3ID, 0, 0.3, 0.38); 
      rmPlaceGroupingAtLoc(village3ID, 0, 0.7, 0.38);
   } 
   else
   {
      rmPlaceGroupingAtLoc(village3ID, 0, 0.38, 0.3);
	rmPlaceGroupingAtLoc(village3ID, 0, 0.38, 0.7);
   }  

   if (cNumberNonGaiaPlayers > 4) // extra near center for larger player numbers
   {
      if (handedness == 2)
      {
	   if (rmRandInt(1,2) == 1)
	      rmPlaceGroupingAtLoc(village1ID, 0, 0.58, 0.5);
	   else
	      rmPlaceGroupingAtLoc(village2ID, 0, 0.58, 0.5); 
      } 
      else
      {
	   if (rmRandInt(1,2) == 1)
	      rmPlaceGroupingAtLoc(village2ID, 0, 0.5, 0.58);
	   else
	      rmPlaceGroupingAtLoc(village1ID, 0, 0.5, 0.58); 
      }
   }

// Text
   rmSetStatusText("",0.70); 

// Mountain Trees
   int StragglerTreeID=rmCreateObjectDef("straggler trees");
   rmAddObjectDefItem(StragglerTreeID, tree2Type, 1, 0.0);
   rmAddObjectDefConstraint(StragglerTreeID, avoidAll);
   rmSetObjectDefMinDistance(StragglerTreeID, 0);
   rmSetObjectDefMaxDistance(StragglerTreeID, 10);

// Mountain Rams
   int mtRamsID=rmCreateObjectDef("mountain rams");
   rmAddObjectDefItem(mtRamsID, "BighornSheep", rmRandInt(2,3), 3.0);
   rmSetObjectDefMinDistance(mtRamsID, 0);
   rmSetObjectDefMaxDistance(mtRamsID, 10);
   rmAddObjectDefConstraint(mtRamsID, avoidAll);
   rmSetObjectDefCreateHerd(mtRamsID, true);

// Define Far Mines
   int farMineID = -1;
   int silverType = -1;
   int ramChance = rmRandInt(1,5);

   for (i=0; <cNumberNonGaiaPlayers*2)
   {
	silverType = rmRandInt(1,10);
      farMineID = rmCreateObjectDef("silver "+i);
      rmAddObjectDefItem(farMineID, "minegold", 1, 0.0);
      rmSetObjectDefMinDistance(farMineID, 0.0);
      rmSetObjectDefMaxDistance(farMineID, 5.0);
      rmAddObjectDefConstraint(farMineID, avoidFastCoin);
      rmAddObjectDefConstraint(farMineID, avoidTradeRoute);
      rmAddObjectDefConstraint(farMineID, farPlayerConstraint);
      rmPlaceObjectDefInArea(farMineID, 0, rmAreaID("big mesa"), 1);

	if (cNumberNonGaiaPlayers < 5)
         rmPlaceObjectDefInArea(farMineID, 0, rmAreaID("big mesa"), 1);
	else
	{
	   if (rmRandInt(1,4) < 4)
            rmPlaceObjectDefInArea(farMineID, 0, rmAreaID("big mesa"), 1);
	}

      rmPlaceObjectDefInArea(StragglerTreeID, 0, rmAreaID("big mesa"), rmRandInt(2,5));

	if (ramChance > 1)
         rmPlaceObjectDefInArea(mtRamsID, 0, rmAreaID("big mesa"));

	if (rmRandInt(1,4) > 1)
         rmPlaceObjectDefInArea(StragglerTreeID, 0, rmAreaID("big mesa"), 2);

	ramChance = rmRandInt(1,5);
      if (cNumberNonGaiaPlayers > 4)
	   ramChance = rmRandInt(1,4);
      if (cNumberNonGaiaPlayers > 6)
	   ramChance = rmRandInt(1,3);
   }

// Text
   rmSetStatusText("",0.75);

// Random Cliffs - away from mesa
   int numCliffs = cNumberNonGaiaPlayers;
   if (cNumberNonGaiaPlayers == 2)
	numCliffs = 3;
   if (patternChance == 6)
	numCliffs = 0;
   int cliffHt = 0;
   for (i=0; <numCliffs)
   {
	cliffHt = rmRandInt(5,7);    
	int lilCliffID=rmCreateArea("little cliff" +i, rmAreaID("big continent"));   
	rmSetAreaWarnFailure(lilCliffID, false);
	rmSetAreaCliffType(lilCliffID, cliffType);
	rmAddAreaToClass(lilCliffID, rmClassID("classLittleCliff"));
	if (cliffVariety == 1) // like Patagonia
	{
   	   rmSetAreaSize(lilCliffID, rmAreaTilesToFraction(170), rmAreaTilesToFraction(300));
         if (rmRandInt(1,2) == 1)
            rmSetAreaCliffEdge(lilCliffID, 2, 0.38, 0.1, 1.0, 0);
	   else
            rmSetAreaCliffEdge(lilCliffID, 3, 0.28, 0.1, 1.0, 0);
         rmSetAreaCliffPainting(lilCliffID, false, true, true, 1.5, true);
	   rmSetAreaCliffHeight(lilCliffID, cliffHt, 2.0, 0.5);
	   rmSetAreaCoherence(lilCliffID, 0.6);
	   rmSetAreaSmoothDistance(lilCliffID, 5);
	   rmSetAreaHeightBlend(lilCliffID, 1.0);
	   rmSetAreaMinBlobs(lilCliffID, 1);
	   rmSetAreaMaxBlobs(lilCliffID, 3);
	   rmSetAreaMinBlobDistance(lilCliffID, 10.0);
	   rmSetAreaMaxBlobDistance(lilCliffID, 20.0);
	}
	else if (cliffVariety == 2)  // kinda random, kinda like Texas or NE
	{
   	   rmSetAreaSize(lilCliffID, rmAreaTilesToFraction(170), rmAreaTilesToFraction(300));
         if (rmRandInt(1,2) == 1)
	      rmSetAreaCliffEdge(lilCliffID, 1, 0.6, 0.2, 1.0, 0);
	   else
	      rmSetAreaCliffEdge(lilCliffID, 1, 0.8, 0.07, 1.0, 0);
	   rmSetAreaCliffPainting(lilCliffID, false, true, true, 1.5, true);
	   rmSetAreaCliffHeight(lilCliffID, cliffHt, 2.0, 1.0);
	   rmSetAreaCoherence(lilCliffID, rmRandFloat(0.6, 0.9));
	   rmSetAreaSmoothDistance(lilCliffID, 15);
	   rmSetAreaHeightBlend(lilCliffID, 1.0);
	   rmSetAreaMinBlobs(lilCliffID, 1);
	   rmSetAreaMaxBlobs(lilCliffID, 4);
	   rmSetAreaMinBlobDistance(lilCliffID, 8.0);
	   rmSetAreaMaxBlobDistance(lilCliffID, 15.0);
	}
	rmAddAreaConstraint(lilCliffID, avoidImportantItem);
	rmAddAreaConstraint(lilCliffID, avoidTradeRoute);
      rmAddAreaConstraint(lilCliffID, avoidNativesMed);
	rmAddAreaConstraint(lilCliffID, cliffsAvoidCliffs);
	rmAddAreaConstraint(lilCliffID, avoidLittleCliffsMed);
      rmAddAreaConstraint(lilCliffID, cliffPlayerConstraint);
	rmBuildArea(lilCliffID);
      rmPlaceObjectDefInArea(StragglerTreeID, 0, rmAreaID("little cliff" +i), rmRandInt(1,3));
   }

// Place extra nuggets not per player
   int nugget3= rmCreateObjectDef("nugget hard"); 
   rmAddObjectDefItem(nugget3, "Nugget", 1, 0.0);
   rmSetNuggetDifficulty(3, 3);
   rmSetObjectDefMinDistance(nugget3, 0.0);
   rmSetObjectDefMaxDistance(nugget3, rmXFractionToMeters(0.5));
   rmAddObjectDefConstraint(nugget3, shortAvoidImpassableLand);
   rmAddObjectDefConstraint(nugget3, avoidNugget);
   rmAddObjectDefConstraint(nugget3, avoidTC);
   rmAddObjectDefConstraint(nugget3, avoidCW);
   rmAddObjectDefConstraint(nugget3, avoidTradeRoute);
   rmAddObjectDefConstraint(nugget3, avoidAll);
   rmAddObjectDefConstraint(nugget3, circleConstraint);
   rmPlaceObjectDefAtLoc(nugget3, 0, 0.5, 0.5, cNumberNonGaiaPlayers);

   int nugget4= rmCreateObjectDef("nugget nuts"); 
   rmAddObjectDefItem(nugget4, "Nugget", 1, 0.0);
   rmSetNuggetDifficulty(4, 4);
   rmSetObjectDefMinDistance(nugget4, 0.0);
   rmSetObjectDefMaxDistance(nugget4, rmXFractionToMeters(0.12));
   rmAddObjectDefConstraint(nugget4, shortAvoidImpassableLand);
   rmAddObjectDefConstraint(nugget4, avoidNugget);
   rmAddObjectDefConstraint(nugget4, avoidTC);
   rmAddObjectDefConstraint(nugget4, avoidCW);
   rmAddObjectDefConstraint(nugget4, bigContinentConstraint);
   rmAddObjectDefConstraint(nugget4, avoidTradeRoute);
   rmAddObjectDefConstraint(nugget4, avoidAll);
   rmAddObjectDefConstraint(nugget4, circleConstraint);
   rmPlaceObjectDefAtLoc(nugget4, 0, 0.5, 0.5, rmRandInt(1,2));

// Text
   rmSetStatusText("",0.80);

// FORESTS
   int failCount2 = 0;
   int forestTreeID = 0;
   int numTries=10*cNumberNonGaiaPlayers;
   if (cNumberNonGaiaPlayers == 3)
      numTries=7*cNumberNonGaiaPlayers;
   else if (cNumberNonGaiaPlayers == 4)
      numTries=7*cNumberNonGaiaPlayers;
   else if (cNumberNonGaiaPlayers > 6)
      numTries=5*cNumberNonGaiaPlayers;
   else if (cNumberNonGaiaPlayers >4)
      numTries=6*cNumberNonGaiaPlayers;
   int forestSize = 0;
   int patchSize = 0;
   int forest = 0;
   int coverForestPatchID = 0;
   for (i=0; <numTries)
   { 
      failCount=0;
	forestSize = rmRandInt(150,300);
  	patchSize = forestSize + 60;
      forest=rmCreateArea("forest "+i);
      rmSetAreaWarnFailure(forest, false);
      rmSetAreaSize(forest, rmAreaTilesToFraction(forestSize), rmAreaTilesToFraction(forestSize));
      rmSetAreaForestType(forest, forestType);
      rmSetAreaForestDensity(forest, 0.8);
      rmSetAreaForestClumpiness(forest, rmRandFloat(0.5,0.8));
      rmSetAreaForestUnderbrush(forest, 0.0);
      rmSetAreaMinBlobs(forest, 1);
      rmSetAreaMaxBlobs(forest, 3);
      rmSetAreaMinBlobDistance(forest, 16.0);
      rmSetAreaMaxBlobDistance(forest, 40.0);
      rmSetAreaCoherence(forest, 0.4);
      rmSetAreaSmoothDistance(forest, 10);
      rmAddAreaToClass(forest, rmClassID("classForest")); 
      rmAddAreaConstraint(forest, forestConstraint);
      rmAddAreaConstraint(forest, avoidAll);
      rmAddAreaConstraint(forest, forestvsTC);
      rmAddAreaConstraint(forest, forestvsCW); 
      rmAddAreaConstraint(forest, longAvoidImpassableLand); 
      rmAddAreaConstraint(forest, avoidTradeRoute);
      rmAddAreaConstraint(forest, avoidCliffsShort);
      rmAddAreaConstraint(forest, avoidLittleCliffsShort);
      if(rmBuildArea(forest)==false)
      {
         // Stop trying once we fail 3 times in a row.
         failCount++;
         if(failCount==3)
            break;
      }
      else
         failCount=0; 

      if (forestCoverUp == 1)
	{
   	   failCount2=0; 
         coverForestPatchID = rmCreateArea("cover forest patch"+i, rmAreaID("forest "+i));   
         rmSetAreaWarnFailure(coverForestPatchID, false);
         rmSetAreaSize(coverForestPatchID, rmAreaTilesToFraction(patchSize), rmAreaTilesToFraction(patchSize));
         rmSetAreaCoherence(coverForestPatchID, 0.99);
         rmSetAreaMix(coverForestPatchID, baseType);
         if(rmBuildArea(coverForestPatchID)==false)
         {
            // Stop trying once we fail 3 times in a row.
            failCount2++;
            if(failCount2==3)
               break;
         }
         else
            failCount2=0; 
	}
   }

// Text
   rmSetStatusText("",0.85);

// More mines
   int farMine2ID = rmCreateObjectDef("more mines");
   silverType = rmRandInt(1,10);
   rmAddObjectDefItem(farMine2ID, "minegold", 1, 0.0);
   rmSetObjectDefMinDistance(farMine2ID, 0.0);
   rmSetObjectDefMaxDistance(farMine2ID, rmXFractionToMeters(0.4));
   rmAddObjectDefConstraint(farMine2ID, avoidFastCoin);
   rmAddObjectDefConstraint(farMine2ID, avoidTradeRoute);
   rmAddObjectDefConstraint(farMine2ID, farPlayerConstraint);
   rmAddObjectDefConstraint(farMine2ID, bigContinentConstraint);
   rmAddObjectDefConstraint(farMine2ID, circleConstraint);
   rmAddObjectDefConstraint(farMine2ID, forestConstraint);
   if (handedness == 2)
   {
	rmAddObjectDefConstraint(farMine2ID, NEquadrantConstraint);
	rmPlaceObjectDefAtLoc(farMine2ID, 0, 0.9, 0.5, 2*cNumberNonGaiaPlayers);
   }
   else
   {
      rmAddObjectDefConstraint(farMine2ID, NWquadrantConstraint);
	rmPlaceObjectDefAtLoc(farMine2ID, 0, 0.5, 0.9, 2*cNumberNonGaiaPlayers);
   }

// more far huntable
   int huntChoice = rmRandInt(1,3);
   int farHuntable2ID=rmCreateObjectDef("2nd far huntable");
   if (huntChoice == 1)
      rmAddObjectDefItem(farHuntable2ID, centerHerdType, rmRandInt(6,7), 6.0);
   else if (huntChoice == 2)
      rmAddObjectDefItem(farHuntable2ID, deer2Type, rmRandInt(6,7), 6.0);
   else
      rmAddObjectDefItem(farHuntable2ID, deerType, rmRandInt(6,7), 6.0);
   rmAddObjectDefToClass(farHuntable2ID, rmClassID("huntableFood"));
   rmSetObjectDefMinDistance(farHuntable2ID, 90);
   rmSetObjectDefMaxDistance(farHuntable2ID, 105);
   rmAddObjectDefConstraint(farHuntable2ID, avoidImportantItem);
   rmAddObjectDefConstraint(farHuntable2ID, fartherPlayerConstraint);
   rmAddObjectDefConstraint(farHuntable2ID, longHuntableConstraint);
   rmAddObjectDefConstraint(farHuntable2ID, avoidAll);
   rmAddObjectDefConstraint(farHuntable2ID, avoidCliffsShort);
   rmSetObjectDefCreateHerd(farHuntable2ID, true);
   rmPlaceObjectDefPerPlayer(farHuntable2ID, false, 1);

   huntChoice = rmRandInt(1,3);
   int farHuntable3ID=rmCreateObjectDef("3rd far huntable");
   if (huntChoice == 1)
      rmAddObjectDefItem(farHuntable3ID, centerHerdType, rmRandInt(5,7), 6.0);
   else if (huntChoice == 2)
      rmAddObjectDefItem(farHuntable3ID, deer2Type, rmRandInt(5,7), 6.0);
   else
      rmAddObjectDefItem(farHuntable3ID, deerType, rmRandInt(5,7), 6.0);
   rmAddObjectDefToClass(farHuntable3ID, rmClassID("huntableFood"));
   rmSetObjectDefMinDistance(farHuntable3ID, 0);
   rmSetObjectDefMaxDistance(farHuntable3ID, 15);
   rmAddObjectDefConstraint(farHuntable3ID, avoidImportantItem);
   rmAddObjectDefConstraint(farHuntable3ID, fartherPlayerConstraint);
   rmAddObjectDefConstraint(farHuntable3ID, longHuntableConstraint);
   rmAddObjectDefConstraint(farHuntable3ID, avoidAll);
   rmAddObjectDefConstraint(farHuntable3ID, avoidCliffsShort);
   rmSetObjectDefCreateHerd(farHuntable3ID, true);
   if (handedness == 1)
   {
	rmPlaceObjectDefAtLoc(farHuntable3ID, 0, 0.5, 0.55, 1);
	rmPlaceObjectDefAtLoc(farHuntable3ID, 0, 0.5, 0.3, 1);
   }
   else
   {
	rmPlaceObjectDefAtLoc(farHuntable3ID, 0, 0.5, 0.55, 1);
	rmPlaceObjectDefAtLoc(farHuntable3ID, 0, 0.3, 0.5, 1);
   }

// Text
   rmSetStatusText("",0.90);

// Sheep 
   int sheepID=rmCreateObjectDef("herdable animal");
   rmAddObjectDefItem(sheepID, sheepType, 2, 4.0);
   rmSetObjectDefMinDistance(sheepID, 50.0);
   rmSetObjectDefMaxDistance(sheepID, rmXFractionToMeters(0.28));
   rmAddObjectDefConstraint(sheepID, avoidSheep);
   rmAddObjectDefConstraint(sheepID, avoidCow);
   rmAddObjectDefConstraint(sheepID, avoidAll);
   rmAddObjectDefConstraint(sheepID, medPlayerConstraint);
   rmAddObjectDefConstraint(sheepID, avoidImpassableLand);
   rmAddObjectDefConstraint(sheepID, circleConstraint);
   if (rmRandInt(1,2) == 1)
      rmPlaceObjectDefPerPlayer(sheepID, false, 2);
   else 
      rmPlaceObjectDefPerPlayer(sheepID, false, 3);
   rmAddObjectDefConstraint(sheepID, farPlayerConstraint);
   rmSetObjectDefMaxDistance(sheepID, rmXFractionToMeters(0.4));
   rmPlaceObjectDefPerPlayer(sheepID, false, rmRandInt(1,2));  

// Patch to cover forest floor, cliffs in some patterns
   if (patternChance == 6)
	coverUp = 0;	
   if (coverUp == 1)
   {
      int desertID = rmCreateArea("desert");
      rmSetAreaLocation(desertID, 0.5, 0.5); 
      rmSetAreaWarnFailure(desertID, false);
      rmSetAreaSize(desertID, 0.99, 0.99);
      rmSetAreaCoherence(desertID, 0.99);
      rmSetAreaMix(desertID, baseType);
	rmAddAreaConstraint(desertID, avoidCliffsShort);
      rmBuildArea(desertID);

      int desert2ID = rmCreateArea("desert 2");
      rmSetAreaLocation(desert2ID, 0.5, 0.5); 
      rmSetAreaWarnFailure(desert2ID, false);
      rmSetAreaSize(desert2ID, 0.99, 0.99);
      rmSetAreaCoherence(desert2ID, 0.99);
      rmSetAreaMix(desert2ID, baseType);
	rmAddAreaConstraint(desert2ID, avoidCliffsShort);
      rmBuildArea(desert2ID);
   }

// Text
   rmSetStatusText("",0.95);

// Deco patches for great plains version
   if (patternChance == 6)
   {
	int gpPatchA = -1;
      for (i=0; <cNumberNonGaiaPlayers*8)   
      {
	   gpPatchA=rmCreateArea("GP patch A"+i);
	   rmSetAreaWarnFailure(gpPatchA, false);
	   rmSetAreaSize(gpPatchA, rmAreaTilesToFraction(40), rmAreaTilesToFraction(70));
         rmSetAreaTerrainType(gpPatchA, "great_plains\ground2_gp");
	   rmAddAreaToClass(gpPatchA, rmClassID("classPatch"));
	   rmSetAreaMinBlobs(gpPatchA, 2);
	   rmSetAreaMaxBlobs(gpPatchA, 4);
	   rmSetAreaMinBlobDistance(gpPatchA, 5.0);
	   rmSetAreaMaxBlobDistance(gpPatchA, 12.0);
	   rmSetAreaCoherence(gpPatchA, 0.3);
	   rmSetAreaSmoothDistance(gpPatchA, 10);
	   rmAddAreaConstraint(gpPatchA, shortForestConstraint);
	   rmAddAreaConstraint(gpPatchA, avoidCliffsMed);
	   rmAddAreaConstraint(gpPatchA, avoidLittleCliffsShort);
	   rmAddAreaConstraint(gpPatchA, patchConstraint);
	   rmBuildArea(gpPatchA); 
      }

      int gpPatchD = -1;
      for (i=0; <cNumberNonGaiaPlayers*8)   
      {
	   gpPatchD=rmCreateArea("GP patch D"+i);
	   rmSetAreaWarnFailure(gpPatchD, false);
	   rmSetAreaSize(gpPatchD, rmAreaTilesToFraction(40), rmAreaTilesToFraction(90));
         rmSetAreaTerrainType(gpPatchD, "great_plains\ground3_gp");
	   rmAddAreaToClass(gpPatchD, rmClassID("classPatch"));
	   rmSetAreaMinBlobs(gpPatchD, 3);
	   rmSetAreaMaxBlobs(gpPatchD, 5);
	   rmSetAreaMinBlobDistance(gpPatchD, 12.0);
	   rmSetAreaMaxBlobDistance(gpPatchD, 20.0);
	   rmSetAreaCoherence(gpPatchD, 0.1);
	   rmSetAreaSmoothDistance(gpPatchD, 10);
	   rmAddAreaConstraint(gpPatchD, shortForestConstraint);
	   rmAddAreaConstraint(gpPatchD, avoidCliffsShort);
	   rmAddAreaConstraint(gpPatchD, avoidLittleCliffsShort);
	   rmAddAreaConstraint(gpPatchD, patchConstraint);
	   rmBuildArea(gpPatchD); 
      }
   }

// Deco
	int vultureID=rmCreateObjectDef("perching vultures");
	int avoidVultures=rmCreateTypeDistanceConstraint("avoid other vultures", "PropVulturePerching", 30.0);
	rmAddObjectDefItem(vultureID, "PropVulturePerching", 1, 0.0);
	rmSetObjectDefMinDistance(vultureID, 0.0);
	rmSetObjectDefMaxDistance(vultureID, rmXFractionToMeters(0.5));
	rmAddObjectDefConstraint(vultureID, avoidAll);
	rmAddObjectDefConstraint(vultureID, avoidImportantItem);
	rmAddObjectDefConstraint(vultureID, avoidImpassableLand);
	rmAddObjectDefConstraint(vultureID, avoidTradeRoute);
	rmAddObjectDefConstraint(vultureID, avoidCliffs);
	rmAddObjectDefConstraint(vultureID, avoidVultures);
	rmAddObjectDefConstraint(vultureID, medPlayerConstraint);
	rmAddObjectDefConstraint(vultureID, shortForestConstraint);
	rmPlaceObjectDefAtLoc(vultureID, 0, 0.5, 0.5, 2);
      if (cNumberNonGaiaPlayers > 4)
	   rmPlaceObjectDefAtLoc(vultureID, 0, 0.5, 0.5, 1);

      int buzzardFlockID=rmCreateObjectDef("buzzards");
	int avoidBuzzards=rmCreateTypeDistanceConstraint("buzzard avoid buzzard", "BuzzardFlock", 70.0);
	rmAddObjectDefItem(buzzardFlockID, "BuzzardFlock", 1, 3.0);
	rmSetObjectDefMinDistance(buzzardFlockID, 0.0);
	rmSetObjectDefMaxDistance(buzzardFlockID, rmXFractionToMeters(0.45));
	rmAddObjectDefConstraint(buzzardFlockID, avoidBuzzards);
	rmAddObjectDefConstraint(buzzardFlockID, avoidAll);
	rmAddObjectDefConstraint(buzzardFlockID, playerConstraint);
	rmAddObjectDefConstraint(buzzardFlockID, shortForestConstraint);
	rmPlaceObjectDefAtLoc(buzzardFlockID, 0, 0.5, 0.5, cNumberNonGaiaPlayers);

	int bisonCarcass=rmCreateGrouping("Bison Carcass", "gp_carcass_bison");
	rmSetGroupingMinDistance(bisonCarcass, 0.0);
	rmSetGroupingMaxDistance(bisonCarcass, rmXFractionToMeters(0.48));
	rmAddGroupingConstraint(bisonCarcass, avoidImpassableLand);
	rmAddGroupingConstraint(bisonCarcass, avoidCliffs);
	rmAddGroupingConstraint(bisonCarcass, avoidTradeRoute);
	rmAddGroupingConstraint(bisonCarcass, avoidImportantItem);
	rmAddGroupingConstraint(bisonCarcass, medPlayerConstraint);
	rmAddGroupingConstraint(bisonCarcass, avoidAll);
	rmAddGroupingConstraint(bisonCarcass, avoidCliffsShort);
	rmAddGroupingConstraint(bisonCarcass, avoidLittleCliffsShort);
	rmAddGroupingConstraint(bisonCarcass, shortForestConstraint);
	rmPlaceGroupingAtLoc(bisonCarcass, 0, 0.5, 0.5, 2);

   if (texasProp == 1) 
   {
	int bigDecorationID=rmCreateObjectDef("Big Texas Things");
	rmAddObjectDefItem(bigDecorationID, "BigPropTexas", 1, 0.0);
	rmSetObjectDefMinDistance(bigDecorationID, 0.0);
	rmSetObjectDefMaxDistance(bigDecorationID, rmXFractionToMeters(0.48));
	rmAddObjectDefConstraint(bigDecorationID, avoidAll);
	rmAddObjectDefConstraint(bigDecorationID, avoidImportantItem);
	rmAddObjectDefConstraint(bigDecorationID, avoidImpassableLand);
	rmAddObjectDefConstraint(bigDecorationID, avoidTradeRoute);
	rmAddObjectDefConstraint(bigDecorationID, avoidCliffs);
	rmAddObjectDefConstraint(bigDecorationID, shortAvoidTradeRouteSocket);
      rmAddObjectDefConstraint(bigDecorationID, avoidLittleCliffsShort);
	rmAddObjectDefConstraint(bigDecorationID, longPlayerConstraint);
	rmPlaceObjectDefAtLoc(bigDecorationID, 0, 0.5, 0.5, 2);
   }

   if (eaglerock == 1)
   {
      int specialPropID=rmCreateObjectDef("eagle rock prop");
      rmAddObjectDefItem(specialPropID, "PropEaglesRocks", 1, 0.0);
      rmSetObjectDefMinDistance(specialPropID, 0.0);
      rmSetObjectDefMaxDistance(specialPropID, rmXFractionToMeters(0.48));
      rmAddObjectDefConstraint(specialPropID, avoidAll);
      rmAddObjectDefConstraint(specialPropID, shortAvoidTradeRouteSocket);
      rmAddObjectDefConstraint(specialPropID, avoidTradeRoute);
      rmAddObjectDefConstraint(specialPropID, avoidImpassableLand);
      rmAddObjectDefConstraint(specialPropID, avoidCliffs);
      rmAddObjectDefConstraint(specialPropID, avoidImportantItem);
      rmAddObjectDefConstraint(specialPropID, avoidLittleCliffsShort);
      rmAddObjectDefConstraint(specialPropID, longPlayerConstraint);
      rmPlaceObjectDefAtLoc(specialPropID, 0, 0.5, 0.5, 2);
   }
  
// Text
   rmSetStatusText("",0.99);    
}  
