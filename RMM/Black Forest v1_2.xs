//SH+D The Black Forest
//by Sir_Hans and Dewinner


/*
Bisher eingebaut :
- Team : Undurchdriglicher Wald erstellt
- Start TCs in Teamgames positioniert
- 6 Startschafe
- Goldminenplatzierung
- Start TCs FFA
- FFA Wald (von 3 - 8 Spieler !) --> Mitte der Map Waldkreis
- Herde : Rehe
- Schafe Platzierung	
- Schätze von Praerie
- Tag - Nachtwechsel (10 Min bis zum kompletten Wechsel)
- Reliequien -> Spieleranzahl - 1
- Untergrund Patagonien
- 4v4 Mapfix / P7 Fix

Fehlend / Ideen :

- Ruinen																						
- Reliquien 5 Stück egal wieviele Spieler --> DOR ESK YP Münzrikscha       vllt mit wächter --> Wird vorerst nicht umgesetzt
- Handelsposten -> Special Version?
- Handelsroute im FFA
- Anderer Tag - Nachtwechsel
- Special Map -> Nur Nacht / Dunkle Lichtverhältnisse
- Eye Candy
- Andere Schätze
- Anderer Untergrund
- Wald abändern / dichter Hinzufügen


*/

include "mercenaries.xs";
include "ypAsianInclude.xs";


// trigger
void PlayerUnitCount(int PUCplayer=0, string PUCunit="", string PUCop="", int PUCcount=0)
{
	rmAddTriggerCondition("Player Unit Count");
	rmSetTriggerConditionParamInt("PlayerID", PUCplayer);
	rmSetTriggerConditionParam("ProtoUnit", PUCunit);
	rmSetTriggerConditionParam("Op", PUCop);
	rmSetTriggerConditionParamInt("Count", PUCcount);
}

void UnitsInArea(int UIAobject=0, int UIAplayer=0, string UIAunit="", string UIAop="", int UIAcount=0)
{
	rmAddTriggerCondition("Units in Area");
	rmSetTriggerConditionParamInt("DstObject", rmGetUnitPlaced(UIAobject,0));
	rmSetTriggerConditionParamInt("Player", UIAplayer);
	rmSetTriggerConditionParam("UnitType", UIAunit);
	rmSetTriggerConditionParamInt("Dist", 15);
	rmSetTriggerConditionParam("Op", UIAop);
	rmSetTriggerConditionParamInt("Count", UIAcount);
}

void UnitsOwned(int UOplayer=0, int UOcenter=0)
{
	rmAddTriggerCondition("Units Owned");
	rmSetTriggerConditionParamInt("Player", UOplayer);
	rmSetTriggerConditionParamInt("SrcObject", rmGetUnitPlaced(UOcenter,0));
}

void Timer(int Ttime=0)
{
	rmAddTriggerCondition("Timer");
	rmSetTriggerConditionParamInt("Param1", Ttime);
}

void UnitMakeInvulnerable(int UMIcenter=0, string UMIenable="true")
{
	rmAddTriggerEffect("Unit Make Invulnerable");
	rmSetTriggerEffectParamInt("DstObject", rmGetUnitPlaced(UMIcenter,0));
	rmSetTriggerEffectParam("Enable", UMIenable);
}

void PlayerGrantResources(int PGRplayer=0, string PGRresource="", int PGRamount=0)
{
	rmAddTriggerEffect("Grant Resources");
	rmSetTriggerEffectParamInt("PlayerID", PGRplayer);
	rmSetTriggerEffectParam("ResName", PGRresource);
	rmSetTriggerEffectParamInt("Amount", PGRamount);
}

void Convert(int Ccenter=0, int Cplayer=0)
{
	rmAddTriggerEffect("Convert");
	rmSetTriggerEffectParamInt("SrcObject", rmGetUnitPlaced(Ccenter,0));
	rmSetTriggerEffectParamInt("PlayerID", Cplayer);
}

// mittelwald
int num=0;

void placetrees(float fx =.5,float fy =.5){

	int Forest=rmCreateArea("Forest"+num);
		rmSetAreaSize(Forest, .001, .001);
		rmSetAreaForestType(Forest, "patagonia forest");
		rmSetAreaLocation(Forest, fx, fy);
		rmSetAreaMinBlobs(Forest, 1);
		rmSetAreaMaxBlobs(Forest, 1);
		rmSetAreaCoherence(Forest, 1);
		rmSetAreaSmoothDistance(Forest, 1);
		rmBuildArea(Forest);
		
	int tree = rmCreateObjectDef("Tree"+num);
		rmAddObjectDefItem(tree,"TreePatagoniaDirt",1,10);
		rmPlaceObjectDefInArea(tree,0,Forest,2000);
	num=num+1;
}

void placetrees2(float fx =.3,float fy =.3){

	int Forest=rmCreateArea("Forest"+num);
		rmSetAreaSize(Forest, .0001, .0001);
		rmSetAreaForestType(Forest, "patagonia forest");	
		rmSetAreaLocation(Forest, fx, fy);
		rmSetAreaMinBlobs(Forest, 1);
		rmSetAreaMaxBlobs(Forest, 1);
		rmSetAreaCoherence(Forest, 1);
		rmSetAreaSmoothDistance(Forest, 1);
		rmBuildArea(Forest);
		
	int tree = rmCreateObjectDef("Tree"+num);
		rmAddObjectDefItem(tree,"TreePatagoniaDirt",1,10);
		rmPlaceObjectDefInArea(tree,0,Forest,2000);
	num=num+1;
}



// Anfang des Quelltextes


void main(void) 
{ 
	rmSetLightingSet("amazon");

	rmSetStatusText("",0.01); 
	
	rmDefineClass("classForest");
	
	// avoid
	int avoidNugget					=rmCreateTypeDistanceConstraint("avoid nugget", "AbstractNugget", 40.0);
	int avoidAll					=rmCreateTypeDistanceConstraint("avoid all", "all", 6.0);
	int avoidTC						=rmCreateTypeDistanceConstraint("avoid TC", "towncenter", 30.0);
	int avoidTCf					=rmCreateTypeDistanceConstraint("avoid TCf", "towncenter", 40.0);
	int avoidBison					=rmCreateTypeDistanceConstraint("avoid bison", "deer", 40.0);
	int avoidMine					=rmCreateTypeDistanceConstraint("avoid mine", "mine", 60.0);
	int avoidSheep     				=rmCreateTypeDistanceConstraint("avoid sheep", "sheep", 40.0);
	int avoidCoinWagon     			=rmCreateTypeDistanceConstraint("avoid CoinWagon", "YPSPCCoinWagon", 200.0);	


	int avoidForest					=rmCreateClassDistanceConstraint("avoid forest", rmClassID("classForest"), 10.0);
	int lightingChance = rmRandInt(1,14);

// Mapgröße
	int myTiles = 10000; 
	if(cMapSize == 1) 
	{ 
		myTiles = 16000; 
		rmEchoInfo("Large map"); 
	}

	int size=2*sqrt(cNumberNonGaiaPlayers*myTiles);
	rmEchoInfo("Map size="+size+"m x "+size+"m");
	rmSetMapSize(size, size);
	// Hügel auf der Map einbauen
	rmSetMapElevationParameters(cElevTurbulence, 0.02, 2.0, 0.5, 5.0);
	rmTerrainInitialize("patagonia\groundforest_pat", 4); 
	rmSetMapType("greatPlains");
	rmSetMapType("land");
	rmSetMapType("grass");

// Mapgröße Ende

	rmSetStatusText("",0.20); 

// Spielerpositionen

	bool weird = false;
	int teamZeroCount = rmGetNumberPlayersOnTeam(0);
	int teamOneCount = rmGetNumberPlayersOnTeam(1);

	// FFA and imbalanced teams
	if ( cNumberTeams > 2 || ((teamZeroCount - teamOneCount) > 2) || ((teamOneCount - teamZeroCount) > 2) )
		weird = true;

	float teamSide = rmRandFloat(0, 1);
  
	if (weird == false) {

		if(teamSide > .5) {
			if(cNumberNonGaiaPlayers > 7) { 
				rmSetPlacementTeam(0);
				rmSetPlacementSection(.5, .8);
				rmPlacePlayersCircular(.35, .35, 0);

				rmSetPlacementTeam(1);
				rmSetPlacementSection(.0, .3);
				rmPlacePlayersCircular(.35, .35, 0);
			}		

			else if(cNumberNonGaiaPlayers > 5) {
				rmSetPlacementTeam(0);
				rmSetPlacementSection(.6, .9);
				rmPlacePlayersCircular(.35, .35, 0);

				rmSetPlacementTeam(1);
				rmSetPlacementSection(.1, .4);
				rmPlacePlayersCircular(.35, .35, 0);
			}

			else if(cNumberNonGaiaPlayers > 3) {
				rmSetPlacementTeam(0);
				rmSetPlacementSection(.55, .75);
				rmPlacePlayersCircular(.35, .35, 0);

				rmSetPlacementTeam(1);
				rmSetPlacementSection(.05, .25);
				rmPlacePlayersCircular(.35, .35, 0);

			}

		
			else {
				rmSetPlacementTeam(0);
				rmSetPlacementSection(.74, .75);
				rmPlacePlayersCircular(.35, .35, 0);

				rmSetPlacementTeam(1);
				rmSetPlacementSection(.24, .25);
				rmPlacePlayersCircular(.35, .35, 0);
			}
		}

		else {
			if(cNumberNonGaiaPlayers > 7) { 
				rmSetPlacementTeam(1);
				rmSetPlacementSection(.5, .8);
				rmPlacePlayersCircular(.35, .35, 0);

				rmSetPlacementTeam(0);
				rmSetPlacementSection(.0, .3);
				rmPlacePlayersCircular(.35, .35, 0);
			}

			else if(cNumberNonGaiaPlayers > 5) {
				rmSetPlacementTeam(1);
				rmSetPlacementSection(.6, .9);
				rmPlacePlayersCircular(.35, .35, 0);

				rmSetPlacementTeam(0);
				rmSetPlacementSection(.1, .4);
				rmPlacePlayersCircular(.35, .35, 0);
			}

			else if(cNumberNonGaiaPlayers > 3) {
				rmSetPlacementTeam(1);
				rmSetPlacementSection(.55, .75);
				rmPlacePlayersCircular(.35, .35, 0);

				rmSetPlacementTeam(0);
				rmSetPlacementSection(.05, .25);
				rmPlacePlayersCircular(.35, .35, 0);

			}

			else {
				rmSetPlacementTeam(1);
				rmSetPlacementSection(.74, .75);
				rmPlacePlayersCircular(.35, .35, 0);

				rmSetPlacementTeam(0);
				rmSetPlacementSection(.24, .25);
				rmPlacePlayersCircular(.35, .35, 0);
			}
		}
	}

	// ffa
	else {
		rmSetTeamSpacingModifier(0.5);
		rmPlacePlayersCircular(.375, .375, 0.05);
	}

// Startrohstoffe , Herden , Einheiten etc 
  
	int silverID = rmCreateObjectDef("silver mines");
		rmAddObjectDefItem(silverID, "mine", 1, 0.0);
		rmSetObjectDefMinDistance(silverID, 0.0);
		rmSetObjectDefMaxDistance(silverID, rmXFractionToMeters(0.2));
		rmAddObjectDefConstraint(silverID, avoidAll);
		rmAddObjectDefConstraint(silverID, avoidTCf);
		rmAddObjectDefConstraint(silverID, avoidMine);
		
	int bisonID=rmCreateObjectDef("bison2");
		rmAddObjectDefItem(bisonID, "deer", rmRandInt(8,10), 10.0);
		rmSetObjectDefMinDistance(bisonID, 0.0);
		rmSetObjectDefMaxDistance(bisonID, rmXFractionToMeters(0.2));
		rmAddObjectDefConstraint(bisonID, avoidAll);
		rmAddObjectDefConstraint(bisonID, avoidTCf);
		rmAddObjectDefConstraint(bisonID, avoidBison);
		rmSetObjectDefCreateHerd(bisonID, true);
	
	int playerNuggetID=rmCreateObjectDef("player nugget");
		rmAddObjectDefItem(playerNuggetID, "nugget", 1, 0.0);
		rmSetNuggetDifficulty(1, 1);
		rmSetObjectDefMinDistance(playerNuggetID, 15.0);
		rmSetObjectDefMaxDistance(playerNuggetID, 20.0);
		rmAddObjectDefConstraint(playerNuggetID, avoidAll);

	int StartBisonID=rmCreateObjectDef("starting herd");
		rmAddObjectDefItem(StartBisonID, "deer", 8, 4.0);
		rmSetObjectDefMinDistance(StartBisonID, 12.0);
		rmSetObjectDefMaxDistance(StartBisonID, 18.0);
		rmSetObjectDefCreateHerd(StartBisonID, true);
		rmAddObjectDefConstraint(StartBisonID, avoidAll); 

	int StartAreaTreeID=rmCreateObjectDef("starting trees");
		rmAddObjectDefItem(StartAreaTreeID, "TreePatagoniaDirt", 6, 6.0);
		rmSetObjectDefMinDistance(StartAreaTreeID, 16);
		rmSetObjectDefMaxDistance(StartAreaTreeID, 22);
		rmAddObjectDefConstraint(StartAreaTreeID, avoidAll);
		
	int StartSilverID = rmCreateObjectDef("starting silver");
		rmAddObjectDefItem(StartSilverID, "mine", 1, 0);
		rmSetObjectDefMinDistance(StartSilverID, 12.0);
		rmSetObjectDefMaxDistance(StartSilverID, 20.0);
		rmAddObjectDefConstraint(StartSilverID, avoidAll);
		
	int StartGoldID = rmCreateObjectDef("starting gold");
		rmAddObjectDefItem(StartGoldID, "minegold", 1, 0);
		rmSetObjectDefMinDistance(StartGoldID, 35.0);
		rmSetObjectDefMaxDistance(StartGoldID, 35.0);
		rmAddObjectDefConstraint(StartGoldID, avoidAll);
		
	int StartSheepID=rmCreateObjectDef("starting sheep");
		rmAddObjectDefItem(StartSheepID, "sheep", 6, 4.0);
		rmSetObjectDefMinDistance(StartSheepID, 13.0);
		rmSetObjectDefMaxDistance(StartSheepID, 15.0);
		rmAddObjectDefConstraint(StartSheepID, avoidAll);

	int startingUnits = rmCreateStartingUnitsObjectDef(5.0);
		rmSetObjectDefMinDistance(startingUnits, 5.0);
		rmSetObjectDefMaxDistance(startingUnits, 10.0);
		rmAddObjectDefConstraint(startingUnits, avoidAll);
  
	int startingTCID= rmCreateObjectDef("startingTC");
	if (rmGetNomadStart()) {
		rmAddObjectDefItem(startingTCID, "CoveredWagon", 1, 0.0);
	}
	else {
		rmAddObjectDefItem(startingTCID, "townCenter", 1, 0.0);
	}
  
	rmPlacePlayersCircular(0.3, 0.3, rmDegreesToRadians(0.0));

	for(i = 1; <= cNumberNonGaiaPlayers) 
	{
		int placedTC = rmPlaceObjectDefAtLoc(startingTCID, i, rmPlayerLocXFraction(i), rmPlayerLocZFraction(i));
		vector TCLocation=rmGetUnitPosition(rmGetUnitPlacedOfPlayer(startingTCID, i));
		rmPlaceObjectDefAtLoc(startingUnits, i, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));
		rmPlaceObjectDefAtLoc(StartAreaTreeID, 0, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));
		rmPlaceObjectDefAtLoc(StartSilverID, 0, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));
		rmPlaceObjectDefAtLoc(StartBisonID, 0, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));
		rmPlaceObjectDefAtLoc(StartGoldID, 0, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));
		rmPlaceObjectDefAtLoc(StartSheepID, i, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));
		rmPlaceObjectDefAtLoc(playerNuggetID, 0, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));
		
		for(j=0; <7){
		rmPlaceObjectDefAtLoc(bisonID, 0, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));
		rmPlaceObjectDefAtLoc(silverID, 0, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));
		}
		
		if(ypIsAsian(i) && rmGetNomadStart() == false)
			rmPlaceObjectDefAtLoc(ypMonasteryBuilder(i, 1), i, rmXMetersToFraction(xsVectorGetX(TCLocation)), rmZMetersToFraction(xsVectorGetZ(TCLocation)));

}
	
// Schätze	


	rmSetStatusText("",0.60); 


// Reliquien

	int reliquie1 = rmCreateObjectDef("Reliquie1");
		rmAddObjectDefItem(reliquie1,"YPSPCCoinWagon",1,0.0);
		rmSetObjectDefMinDistance(reliquie1, 0.0);
		rmSetObjectDefMaxDistance(reliquie1, rmXFractionToMeters(0.5));
		rmAddObjectDefConstraint(reliquie1, avoidAll);
		rmAddObjectDefConstraint(reliquie1, avoidCoinWagon);
		rmAddObjectDefConstraint(reliquie1, avoidTC);
		rmPlaceObjectDefAtLoc(reliquie1, 0, 0.5, 0.5);
		
	if (cNumberNonGaiaPlayers > 2)
	{
	int reliquie2 = rmCreateObjectDef("Reliquie2");
		rmAddObjectDefItem(reliquie2,"YPSPCCoinWagon",1,0.0);
		rmSetObjectDefMinDistance(reliquie2, 0.0);
		rmSetObjectDefMaxDistance(reliquie2, rmXFractionToMeters(0.5));
		rmAddObjectDefConstraint(reliquie2, avoidAll);
		rmAddObjectDefConstraint(reliquie2, avoidCoinWagon);
		rmAddObjectDefConstraint(reliquie2, avoidTC);
		rmPlaceObjectDefAtLoc(reliquie2, 0, 0.5, 0.5);
	}
	
	if (cNumberNonGaiaPlayers > 3)
	{
	int reliquie3 = rmCreateObjectDef("Reliquie3");
		rmAddObjectDefItem(reliquie3,"YPSPCCoinWagon",1,0.0);
		rmSetObjectDefMinDistance(reliquie3, 0.0);
		rmSetObjectDefMaxDistance(reliquie3, rmXFractionToMeters(0.5));
		rmAddObjectDefConstraint(reliquie3, avoidAll);
		rmAddObjectDefConstraint(reliquie3, avoidCoinWagon);
		rmAddObjectDefConstraint(reliquie3, avoidTC);
		rmPlaceObjectDefAtLoc(reliquie3, 0, 0.5, 0.5);
	}
	
	if (cNumberNonGaiaPlayers > 4)
	{
	int reliquie4 = rmCreateObjectDef("Reliquie4");
		rmAddObjectDefItem(reliquie4,"YPSPCCoinWagon",1,0.0);
		rmSetObjectDefMinDistance(reliquie4, 0.0);
		rmSetObjectDefMaxDistance(reliquie4, rmXFractionToMeters(0.5));
		rmAddObjectDefConstraint(reliquie4, avoidAll);
		rmAddObjectDefConstraint(reliquie4, avoidCoinWagon);
		rmAddObjectDefConstraint(reliquie4, avoidTC);
		rmPlaceObjectDefAtLoc(reliquie4, 0, 0.5, 0.5);
	}
	
	if (cNumberNonGaiaPlayers > 5)
	{
	int reliquie5 = rmCreateObjectDef("Reliquie5");
		rmAddObjectDefItem(reliquie5,"YPSPCCoinWagon",1,0.0);
		rmSetObjectDefMinDistance(reliquie5, 0.0);
		rmSetObjectDefMaxDistance(reliquie5, rmXFractionToMeters(0.5));
		rmAddObjectDefConstraint(reliquie5, avoidAll);
		rmAddObjectDefConstraint(reliquie5, avoidCoinWagon);
		rmAddObjectDefConstraint(reliquie5, avoidTC);
		rmPlaceObjectDefAtLoc(reliquie5, 0, 0.5, 0.5);
	}
	
	if (cNumberNonGaiaPlayers > 6)
	{
	int reliquie6 = rmCreateObjectDef("Reliquie6");
		rmAddObjectDefItem(reliquie6,"YPSPCCoinWagon",1,0.0);
		rmSetObjectDefMinDistance(reliquie6, 0.0);
		rmSetObjectDefMaxDistance(reliquie6, rmXFractionToMeters(0.5));
		rmAddObjectDefConstraint(reliquie6, avoidAll);
		rmAddObjectDefConstraint(reliquie6, avoidCoinWagon);
		rmAddObjectDefConstraint(reliquie6, avoidTC);
		rmPlaceObjectDefAtLoc(reliquie6, 0, 0.5, 0.5);
	}
	
	if (cNumberNonGaiaPlayers > 7)
	{
	int reliquie7 = rmCreateObjectDef("Reliquie7");
		rmAddObjectDefItem(reliquie7,"YPSPCCoinWagon",1,0.0);
		rmSetObjectDefMinDistance(reliquie7, 0.0);
		rmSetObjectDefMaxDistance(reliquie7, rmXFractionToMeters(0.5));
		rmAddObjectDefConstraint(reliquie7, avoidAll);
		rmAddObjectDefConstraint(reliquie7, avoidCoinWagon);
		rmAddObjectDefConstraint(reliquie7, avoidTC);
		rmPlaceObjectDefAtLoc(reliquie7, 0, 0.5, 0.5);
	}



	
		
//Zufallswald

	int RandForestTreeID = rmCreateObjectDef("randforesttree");
		rmAddObjectDefItem(RandForestTreeID,"TreePatagoniaDirt",1,10);
		
int forestTreeID = 0;
	int numTries=20*cNumberNonGaiaPlayers;

	int failCount=0;
	for (i=0; <numTries)
	{   
		int forest=rmCreateArea("forest "+i);
		rmAddAreaToClass(forest, rmClassID("classForest"));
		rmSetAreaWarnFailure(forest, false);
		rmSetAreaSize(forest, rmAreaTilesToFraction(200), rmAreaTilesToFraction(400));
		rmSetAreaForestType(forest, "patagonia forest");
		rmSetAreaForestDensity(forest, 1.0);
		rmSetAreaForestClumpiness(forest, 0.0);
		rmSetAreaForestUnderbrush(forest, 0.0);
		rmSetAreaMinBlobs(forest, 1);
		rmSetAreaMaxBlobs(forest, 8);
		rmSetAreaMinBlobDistance(forest, 12.0);
		rmSetAreaMaxBlobDistance(forest, 20.0);
		rmSetAreaCoherence(forest, 1.0);
		rmSetAreaSmoothDistance(forest, 0);
	
        rmAddAreaConstraint(forest, avoidAll);
        rmAddAreaConstraint(forest, avoidTC);
        rmAddAreaConstraint(forest, avoidForest);
		
		if(rmBuildArea(forest)==false)
		{
		failCount++;
		if(failCount==10)
		   break;
		}
		else
		{
		rmPlaceObjectDefInArea(RandForestTreeID,0,forest,5);
		failCount=0;
		} 
	} failCount=0;

// Position der Bäume (fest)


if (weird == false) {
// 8 Spieler Map --> Oben Unten Teilung
if(cNumberNonGaiaPlayers > 7)
{


placetrees(1,0);
placetrees(.0,1);
placetrees(.9,.1);
placetrees(.1,.9);
placetrees(.8,.2);
placetrees(.2,.8);
placetrees(.7,.3);
placetrees(.3,.7);
placetrees(.6,.4);
placetrees(.4,.6);

placetrees(.95,05);
placetrees(.05,95);
placetrees(.85,.15);
placetrees(.15,.85);
placetrees(.75,.25);
placetrees(.25,.75);
placetrees(.65,.35);
placetrees(.35,.65);
placetrees(.55,.45);
placetrees(.45,.55);

placetrees(.975,025);
placetrees(.025,975);
placetrees(.875,.125);
placetrees(.125,.875);
placetrees(.775,.225);
placetrees(.225,.775);
placetrees(.675,.325);
placetrees(.325,.675);
placetrees(.575,.425);
placetrees(.425,.575);

placetrees(.925,075);
placetrees(.075,925);
placetrees(.825,.175);
placetrees(.175,.825);
placetrees(.725,.275);
placetrees(.275,.725);
placetrees(.625,.375);
placetrees(.375,.625);



}

// 6 Spieler --> Diagonale Teilung Links oben Rechts unten
else if(cNumberNonGaiaPlayers > 5)
{
placetrees(.5,0.0);
placetrees(.5,.1);
placetrees(.5,.2);
placetrees(.5,.3);
placetrees(.5,.4);

placetrees(.5,.6);
placetrees(.5,.7);
placetrees(.5,.8);
placetrees(.5,.9);
placetrees(.5,1.0);

placetrees(.5,.05);
placetrees(.5,.15);
placetrees(.5,.25);
placetrees(.5,.35);
placetrees(.5,.45);

placetrees2(.5,.55);
placetrees(.5,.65);
placetrees(.5,.75);
placetrees(.5,.85);
placetrees(.5,.95);
placetrees(.5,1.0);

}

// 4 Spieler Map --> Oben Unten Teilung
else if(cNumberNonGaiaPlayers > 3)
{


placetrees(1,0);
placetrees(.0,1);
placetrees(.9,.1);
placetrees(.1,.9);
placetrees(.8,.2);
placetrees(.2,.8);
placetrees(.7,.3);
placetrees(.3,.7);
placetrees(.6,.4);
placetrees(.4,.6);

placetrees(.95,.05);
placetrees(.05,.95);
placetrees(.85,.15);
placetrees(.15,.85);
placetrees(.75,.25);
placetrees(.25,.75);
placetrees(.65,.35);
placetrees(.35,.65);
placetrees(.55,.45);
placetrees(.45,.55);

placetrees(.975,.025);
placetrees(.025,.975);
placetrees(.875,.125);
placetrees(.125,.875);
placetrees(.775,.225);
placetrees(.225,.775);
placetrees(.675,.325);
placetrees(.325,.675);
placetrees(.575,.425);
placetrees(.425,.575);

placetrees(.925,.075);
placetrees(.075,.925);
placetrees(.825,.175);
placetrees(.175,.825);
placetrees(.725,.275);
placetrees(.275,.725);
placetrees(.625,.375);
placetrees(.375,.625);



}

else{
placetrees(.5,0.0);
placetrees(.5,.1);
placetrees(.5,.2);
placetrees(.5,.3);
placetrees(.5,.4);
placetrees(.5,.6);
placetrees(.5,.7);
placetrees(.5,.8);
placetrees(.5,.9);
placetrees(.5,1.0);
}

}
else 
{
placetrees(.5,.5);
}


// Herden und Minen Zufällig
	
	int nuggetID= rmCreateObjectDef("nugget"); 
		rmAddObjectDefItem(nuggetID, "Nugget", 1, 0.0);
		rmSetNuggetDifficulty(1, 3);
		rmSetObjectDefMinDistance(nuggetID, 0.0);
		rmSetObjectDefMaxDistance(nuggetID, rmXFractionToMeters(0.5));
		rmAddObjectDefConstraint(nuggetID, avoidTC);
		rmAddObjectDefConstraint(nuggetID, avoidNugget);
		rmAddObjectDefConstraint(nuggetID, avoidAll);
		rmPlaceObjectDefAtLoc(nuggetID, 0, 0.5, 0.5, cNumberNonGaiaPlayers*7);

	rmSetStatusText("",0.80); 

// Schafe erstellen / verteilen

 int sheepID=rmCreateObjectDef("sheep");
  rmAddObjectDefItem(sheepID, "sheep", 2, 4.0);
  rmSetObjectDefMinDistance(sheepID, 0.0);
  rmSetObjectDefMaxDistance(sheepID, rmXFractionToMeters(0.25));
  rmAddObjectDefConstraint(sheepID, avoidSheep);
  rmAddObjectDefConstraint(sheepID, avoidAll);
  rmAddObjectDefConstraint(sheepID, avoidTC);
  rmPlaceObjectDefAtLoc(sheepID, 0, 0.25, 0.25, cNumberNonGaiaPlayers/2*3);	
  
 int sheepID2=rmCreateObjectDef("sheep2");
  rmAddObjectDefItem(sheepID2, "sheep", 2, 4.0);
  rmSetObjectDefMinDistance(sheepID2, 0.0);
  rmSetObjectDefMaxDistance(sheepID2, rmXFractionToMeters(0.25));
  rmAddObjectDefConstraint(sheepID2, avoidSheep);
  rmAddObjectDefConstraint(sheepID2, avoidAll);
  rmAddObjectDefConstraint(sheepID2, avoidTC);
  rmPlaceObjectDefAtLoc(sheepID2, 0, 0.75, 0.75, cNumberNonGaiaPlayers/2*3);	



	//nicht angreifbar 
	
	rmCreateTrigger("Invulnerable");
	
	rmSwitchToTrigger(rmTriggerID("Invulnerable"));
		rmAddTriggerCondition("Always");
		UnitMakeInvulnerable(reliquie1, "true");
		if (cNumberNonGaiaPlayers > 2) UnitMakeInvulnerable(reliquie2, "true");
		if (cNumberNonGaiaPlayers > 3) UnitMakeInvulnerable(reliquie3, "true");
		if (cNumberNonGaiaPlayers > 4) UnitMakeInvulnerable(reliquie4, "true");
		if (cNumberNonGaiaPlayers > 5) UnitMakeInvulnerable(reliquie5, "true");
		if (cNumberNonGaiaPlayers > 6) UnitMakeInvulnerable(reliquie6, "true");
		if (cNumberNonGaiaPlayers > 7) UnitMakeInvulnerable(reliquie7, "true");
		rmSetTriggerPriority(4);
		rmSetTriggerActive(true);
		rmSetTriggerRunImmediately(true);
		rmSetTriggerLoop(false);
		
	for (i=1; <=cNumberNonGaiaPlayers) 
	{
		rmCreateTrigger("convertrg1"+i);
	}
	for (i=1; <=cNumberNonGaiaPlayers) 
	{
		rmCreateTrigger("convertrg2"+i);
	}
	for (i=1; <=cNumberNonGaiaPlayers) 
	{
		rmCreateTrigger("convertrg3"+i);
	}
	for (i=1; <=cNumberNonGaiaPlayers) 
	{
		rmCreateTrigger("convertrg4"+i);
	}
	for (i=1; <=cNumberNonGaiaPlayers) 
	{
		rmCreateTrigger("convertrg5"+i);
	}
	for (i=1; <=cNumberNonGaiaPlayers) 
	{
		rmCreateTrigger("convertrg6"+i);
	}
	for (i=1; <=cNumberNonGaiaPlayers) 
	{
		rmCreateTrigger("convertrg7"+i);
	}
	
	for (i=1; <=cNumberNonGaiaPlayers) 
	{
		rmSwitchToTrigger(rmTriggerID("convertrg1"+i));
			UnitsInArea(reliquie1, i, "Unit", ">", 0);
			for (j=1; <=cNumberNonGaiaPlayers) 
			{
				if (j != i)
				UnitsInArea(reliquie1, j, "Unit", "-1 <=", 0);
			}
			Convert(reliquie1, i);
			rmSetTriggerPriority(4);
			rmSetTriggerActive(true);
			rmSetTriggerRunImmediately(true);
			rmSetTriggerLoop(true);
	}
	
	if (cNumberNonGaiaPlayers > 2)
	{
	for (i=1; <=cNumberNonGaiaPlayers) 
	{
		rmSwitchToTrigger(rmTriggerID("convertrg2"+i));
			UnitsInArea(reliquie2, i, "Unit", ">", 0);
			for (j=1; <=cNumberNonGaiaPlayers) 
			{
				if (j != i)
				UnitsInArea(reliquie2, j, "Unit", "-1 <=", 0);
			}
			Convert(reliquie2, i);
			rmSetTriggerPriority(4);
			rmSetTriggerActive(true);
			rmSetTriggerRunImmediately(true);
			rmSetTriggerLoop(true);
	}}
	
	if (cNumberNonGaiaPlayers > 3)
	{
	for (i=1; <=cNumberNonGaiaPlayers) 
	{
		rmSwitchToTrigger(rmTriggerID("convertrg3"+i));
			UnitsInArea(reliquie3, i, "Unit", ">", 0);
			for (j=1; <=cNumberNonGaiaPlayers) 
			{
				if (j != i)
				UnitsInArea(reliquie3, j, "Unit", "-1 <=", 0);
			}
			Convert(reliquie3, i);
			rmSetTriggerPriority(4);
			rmSetTriggerActive(true);
			rmSetTriggerRunImmediately(true);
			rmSetTriggerLoop(true);
	}}
	
	if (cNumberNonGaiaPlayers > 4)
	{
	for (i=1; <=cNumberNonGaiaPlayers) 
	{
		rmSwitchToTrigger(rmTriggerID("convertrg4"+i));
			UnitsInArea(reliquie4, i, "Unit", ">", 0);
			for (j=1; <=cNumberNonGaiaPlayers) 
			{
				if (j != i)
				UnitsInArea(reliquie4, j, "Unit", "-1 <=", 0);
			}
			Convert(reliquie4, i);
			rmSetTriggerPriority(4);
			rmSetTriggerActive(true);
			rmSetTriggerRunImmediately(true);
			rmSetTriggerLoop(true);
	}}
	
	if (cNumberNonGaiaPlayers > 5)
	{
	for (i=1; <=cNumberNonGaiaPlayers) 
	{
		rmSwitchToTrigger(rmTriggerID("convertrg5"+i));
			UnitsInArea(reliquie5, i, "Unit", ">", 0);
			for (j=1; <=cNumberNonGaiaPlayers) 
			{
				if (j != i)
				UnitsInArea(reliquie5, j, "Unit", "-1 <=", 0);
			}
			Convert(reliquie5, i);
			rmSetTriggerPriority(4);
			rmSetTriggerActive(true);
			rmSetTriggerRunImmediately(true);
			rmSetTriggerLoop(true);
	}}
	
	if (cNumberNonGaiaPlayers > 6)
	{
	for (i=1; <=cNumberNonGaiaPlayers) 
	{
		rmSwitchToTrigger(rmTriggerID("convertrg6"+i));
			UnitsInArea(reliquie6, i, "Unit", ">", 0);
			for (j=1; <=cNumberNonGaiaPlayers) 
			{
				if (j != i)
				UnitsInArea(reliquie6, j, "Unit", "-1 <=", 0);
			}
			Convert(reliquie6, i);
			rmSetTriggerPriority(4);
			rmSetTriggerActive(true);
			rmSetTriggerRunImmediately(true);
			rmSetTriggerLoop(true);
	}}
	
	if (cNumberNonGaiaPlayers > 7)
	{
	for (i=1; <=cNumberNonGaiaPlayers) 
	{
		rmSwitchToTrigger(rmTriggerID("convertrg7"+i));
			UnitsInArea(reliquie7, i, "Unit", ">", 0);
			for (j=1; <=cNumberNonGaiaPlayers) 
			{
				if (j != i)
				UnitsInArea(reliquie7, j, "Unit", "-1 <=", 0);
			}
			Convert(reliquie7, i);
			rmSetTriggerPriority(4);
			rmSetTriggerActive(true);
			rmSetTriggerRunImmediately(true);
			rmSetTriggerLoop(true);
	}}
	
	for (i=1; <=cNumberNonGaiaPlayers) 
	{
		rmCreateTrigger("convertrg1get"+i);
	}
	for (i=1; <=cNumberNonGaiaPlayers) 
	{
		rmCreateTrigger("convertrg2get"+i);
	}
	for (i=1; <=cNumberNonGaiaPlayers) 
	{
		rmCreateTrigger("convertrg3get"+i);
	}
	for (i=1; <=cNumberNonGaiaPlayers) 
	{
		rmCreateTrigger("convertrg4get"+i);
	}
	for (i=1; <=cNumberNonGaiaPlayers) 
	{
		rmCreateTrigger("convertrg5get"+i);
	}
	for (i=1; <=cNumberNonGaiaPlayers) 
	{
		rmCreateTrigger("convertrg6get"+i);
	}
	for (i=1; <=cNumberNonGaiaPlayers) 
	{
		rmCreateTrigger("convertrg7get"+i);
	}
	
	int amountg=7;
	
	for (i=1; <=cNumberNonGaiaPlayers) 
	{
		rmSwitchToTrigger(rmTriggerID("convertrg1get"+i));
			Timer(10);
			UnitsOwned(i, reliquie1);
			
			PlayerGrantResources(i, "Gold", amountg);
			rmSetTriggerPriority(4);
			rmSetTriggerActive(true);
			rmSetTriggerRunImmediately(true);
			rmSetTriggerLoop(true);
	}
	
	if (cNumberNonGaiaPlayers > 2)
	{
	for (i=1; <=cNumberNonGaiaPlayers) 
	{
		rmSwitchToTrigger(rmTriggerID("convertrg2get"+i));
			Timer(10);
			UnitsOwned(i, reliquie2);
			
			PlayerGrantResources(i, "Gold", amountg);
			rmSetTriggerPriority(4);
			rmSetTriggerActive(true);
			rmSetTriggerRunImmediately(true);
			rmSetTriggerLoop(true);
	}}
	
	if (cNumberNonGaiaPlayers > 3)
	{
	for (i=1; <=cNumberNonGaiaPlayers) 
	{
		rmSwitchToTrigger(rmTriggerID("convertrg3get"+i));
			Timer(10);
			UnitsOwned(i, reliquie3);
			
			PlayerGrantResources(i, "Gold", amountg);
			rmSetTriggerPriority(4);
			rmSetTriggerActive(true);
			rmSetTriggerRunImmediately(true);
			rmSetTriggerLoop(true);
	}}
	
	if (cNumberNonGaiaPlayers > 4)
	{
	for (i=1; <=cNumberNonGaiaPlayers) 
	{
		rmSwitchToTrigger(rmTriggerID("convertrg4get"+i));
			Timer(10);
			UnitsOwned(i, reliquie4);
			
			PlayerGrantResources(i, "Gold", amountg);
			rmSetTriggerPriority(4);
			rmSetTriggerActive(true);
			rmSetTriggerRunImmediately(true);
			rmSetTriggerLoop(true);
	}}
	
	if (cNumberNonGaiaPlayers > 5)
	{
	for (i=1; <=cNumberNonGaiaPlayers) 
	{
		rmSwitchToTrigger(rmTriggerID("convertrg5get"+i));
			Timer(10);
			UnitsOwned(i, reliquie5);
			
			PlayerGrantResources(i, "Gold", amountg);
			rmSetTriggerPriority(4);
			rmSetTriggerActive(true);
			rmSetTriggerRunImmediately(true);
			rmSetTriggerLoop(true);
	}}
	
	if (cNumberNonGaiaPlayers > 6)
	{
	for (i=1; <=cNumberNonGaiaPlayers) 
	{
		rmSwitchToTrigger(rmTriggerID("convertrg6get"+i));
			Timer(10);
			UnitsOwned(i, reliquie6);
			
			PlayerGrantResources(i, "Gold", amountg);
			rmSetTriggerPriority(4);
			rmSetTriggerActive(true);
			rmSetTriggerRunImmediately(true);
			rmSetTriggerLoop(true);
	}}
	
	if (cNumberNonGaiaPlayers > 7)
	{
	for (i=1; <=cNumberNonGaiaPlayers) 
	{
		rmSwitchToTrigger(rmTriggerID("convertrg7get"+i));
			Timer(10);
			UnitsOwned(i, reliquie7);
			
			PlayerGrantResources(i, "Gold", amountg);
			rmSetTriggerPriority(4);
			rmSetTriggerActive(true);
			rmSetTriggerRunImmediately(true);
			rmSetTriggerLoop(true);
	}}
	
			
	chooseMercs();

	// Make it rain
   rmSetGlobalRain( 0.9 );


	rmSetStatusText("",1.00); 
}