
// *** RMS Generator File ***  09.04.2012 *** 16:15:19


void main(void)
{
int Tiles = 15000;
int MapSize = 2.0*sqrt(cNumberNonGaiaPlayers * Tiles);
rmSetMapSize(MapSize,MapSize);
rmSetMapElevationParameters(cElevTurbulence, 0.02, 2.0, 0.5, 5.0);
rmTerrainInitialize("new_england\ground1_ne",6);
rmSetMapType("greatPlains");
rmSetMapType("grass");
rmSetMapType("default");
rmSetMapType("water");
rmSetMapType("land");
rmSetLightingSet("new england");
rmSetStatusText("",0.10);
int TRADE = rmCreateTradeRouteDistanceConstraint("trade route", 10.0);
int TC = rmCreateTypeDistanceConstraint("TCNORM", "TownCenter", 33.0);
int SEE = rmCreateTerrainDistanceConstraint("WASSER", "Water", true, 10.0);
int LAND = rmCreateTerrainDistanceConstraint("LAND", "Land", true, 15.0);
int POSTEN = rmCreateTypeDistanceConstraint("POSTEN", "socketTradeRoute", 25.0);
int SILBERMINE = rmCreateTypeDistanceConstraint("SILBERMINE", "mine", 25.0);
int SCHATZ = rmCreateTypeDistanceConstraint("SCHATZ", "abstractNugget", 50.0);
int ALL = rmCreateTypeDistanceConstraint("ALLES", "all", 4.0);
int GOLDMINE = rmCreateTypeDistanceConstraint("GOLDMINE", "mineGold", 30.0);
int TCSHORT = rmCreateTypeDistanceConstraint("TCKURZ", "TownCenter", 8.0);
int TCMIDDLE = rmCreateTypeDistanceConstraint("TCMITTEL", "TownCenter", 12.0);
int TCLONG = rmCreateTypeDistanceConstraint("TCLANG", "TownCenter", 60.0);
rmSetStatusText("",0.15);
int subCiv00=-1;
int subCiv01=-1;
int subCiv02=-1;
int subCiv03=-1;
subCiv00=rmGetCivID("Cherokee");
rmSetSubCiv(0, "Cherokee");
subCiv01=rmGetCivID("Cherokee");
rmSetSubCiv(1, "Cherokee");
subCiv02=rmGetCivID("Comanche");
rmSetSubCiv(2, "Comanche");
subCiv03=rmGetCivID("Comanche");
rmSetSubCiv(3,"Comanche");
rmSetStatusText("",0.20);
rmPlacePlayersCircular(0.380, 0.380, rmDegreesToRadians(10.0));
for(i = 1; <= cNumberNonGaiaPlayers)
{
int id = rmCreateArea("Player"+i);
rmSetAreaWarnFailure(id, false);
rmSetAreaSize(id, rmAreaTilesToFraction(800), rmAreaTilesToFraction(800));
rmSetAreaTerrainType(id,"new_england\ground1_ne");
rmSetAreaBaseHeight(id,6);
rmSetAreaCoherence(id,1);
rmSetAreaHeightBlend(id,1.5);
rmSetAreaLocPlayer(id,i);
rmSetPlayerArea(i,id);
rmAddAreaConstraint(id, TRADE);
rmAddAreaConstraint(id, TC);
rmAddAreaConstraint(id, SEE);
rmAddAreaConstraint(id, POSTEN);
rmBuildArea(id);
int TCID = rmCreateObjectDef("Starting Towncenter"+i);
rmAddObjectDefItem(TCID,"TownCenter",1,0);
rmAddObjectDefConstraint(TCID, TRADE);
rmPlaceObjectDefAtLoc(TCID,i,rmPlayerLocXFraction(i),rmPlayerLocZFraction(i),1);
}
int Explorereinheit = rmCreateStartingUnitsObjectDef(5.0);
rmSetObjectDefMinDistance(Explorereinheit, 2.0);
rmSetObjectDefMaxDistance(Explorereinheit, 3.0);
int SilberID = rmCreateObjectDef("Silber am DZ");
rmAddObjectDefItem(SilberID, "mine", 1, 4);
rmSetObjectDefMinDistance(SilberID, 30.0);
rmSetObjectDefMaxDistance(SilberID, 50.0);
rmAddObjectDefConstraint(SilberID, TCSHORT);
int BeerenID = rmCreateObjectDef("Beeren am DZ");
rmAddObjectDefItem(BeerenID, "berryBush",5, 4.0);
rmSetObjectDefMinDistance(BeerenID, 18);
rmSetObjectDefMaxDistance(BeerenID, 18);
rmAddObjectDefConstraint(BeerenID, TCSHORT);
int BaumID=rmCreateObjectDef("Baeume am DZ");
rmAddObjectDefItem(BaumID, "TreeGreatLakes", 1, 4.0);
rmSetObjectDefMinDistance(BaumID,18);
rmSetObjectDefMaxDistance(BaumID,18);
rmAddObjectDefConstraint(BaumID, TCSHORT);
int Tiere1ID=rmCreateObjectDef("Tiere nahe am DZ");
rmAddObjectDefItem(Tiere1ID,"deer", 10, 10.0);
rmSetObjectDefMinDistance(Tiere1ID, 20);
rmSetObjectDefMaxDistance(Tiere1ID, 30);
rmAddObjectDefConstraint(Tiere1ID, TCSHORT);
rmSetObjectDefCreateHerd(Tiere1ID, true);
int Tiere2ID=rmCreateObjectDef("Tiere entfernt vom DZ");
rmAddObjectDefItem(Tiere2ID, "deer",15, 10.0);
rmSetObjectDefMinDistance(Tiere2ID, 100);
rmSetObjectDefMaxDistance(Tiere2ID, 125);
rmSetObjectDefCreateHerd(Tiere2ID, true);
int ExtrasID=rmCreateObjectDef("bonus starting crates");
rmAddObjectDefItem(ExtrasID, "crateOfFood", 3, 4.0);
rmAddObjectDefItem(ExtrasID, "crateOfWood", 3, 4.0);
rmAddObjectDefItem(ExtrasID, "crateOfCoin", 3, 4.0);
rmSetObjectDefMinDistance(ExtrasID,12);
rmSetObjectDefMaxDistance(ExtrasID,12);
rmAddObjectDefConstraint(ExtrasID, TCSHORT);
rmSetStatusText("",0.40);
int Schatz=rmCreateObjectDef("Schaetze");
rmAddObjectDefItem(Schatz, "Nugget",3, 300.0);
rmSetObjectDefMinDistance(Schatz, 50);
rmSetObjectDefMaxDistance(Schatz, 250.0);
rmAddObjectDefConstraint(Schatz, TCLONG);
rmAddObjectDefConstraint(Schatz, SCHATZ);
rmAddObjectDefConstraint(Schatz, GOLDMINE);
rmAddObjectDefConstraint(Schatz, SILBERMINE);
rmAddObjectDefConstraint(Schatz, TRADE);
int ExtraSilber= rmCreateObjectDef("Silberminen");
rmAddObjectDefItem(ExtraSilber, "mine",1, 500.0);
rmSetObjectDefMinDistance(ExtraSilber, 50);
rmSetObjectDefMaxDistance(ExtraSilber, 500.0);
rmAddObjectDefConstraint(ExtraSilber, TC);
rmAddObjectDefConstraint(ExtraSilber, SCHATZ);
rmAddObjectDefConstraint(ExtraSilber, GOLDMINE);
rmAddObjectDefConstraint(ExtraSilber, SILBERMINE);
rmAddObjectDefConstraint(ExtraSilber, TRADE);
int ExtraGold= rmCreateObjectDef("Goldminen");
rmAddObjectDefItem(ExtraGold, "mineGold", 2, 500.0);
rmSetObjectDefMinDistance(ExtraGold, 50);
rmSetObjectDefMaxDistance(ExtraGold, 500.0);
rmAddObjectDefConstraint(ExtraGold, TC);
rmAddObjectDefConstraint(ExtraGold, SCHATZ);
rmAddObjectDefConstraint(ExtraGold, GOLDMINE);
rmAddObjectDefConstraint(ExtraGold, SILBERMINE);
rmAddObjectDefConstraint(ExtraGold, TRADE);
rmSetStatusText("",0.50);
for (PlayerID=1;<=cNumberNonGaiaPlayers)
{
vector TCLocation = rmGetUnitPosition(rmGetUnitPlacedOfPlayer(TCID, PlayerID));
rmPlaceObjectDefAtLoc(Explorereinheit, PlayerID,rmPlayerLocXFraction(PlayerID),rmPlayerLocZFraction(PlayerID));
rmPlaceObjectDefAtLoc(BaumID, 0, rmPlayerLocXFraction(PlayerID), rmPlayerLocZFraction(PlayerID));
rmPlaceObjectDefAtLoc(BaumID, 0, rmPlayerLocXFraction(PlayerID), rmPlayerLocZFraction(PlayerID));
rmPlaceObjectDefAtLoc(BaumID, 0, rmPlayerLocXFraction(PlayerID), rmPlayerLocZFraction(PlayerID));
rmPlaceObjectDefAtLoc(BaumID, 0, rmPlayerLocXFraction(PlayerID), rmPlayerLocZFraction(PlayerID));
rmPlaceObjectDefAtLoc(BeerenID, 0, rmPlayerLocXFraction(PlayerID), rmPlayerLocZFraction(PlayerID));
rmPlaceObjectDefAtLoc(SilberID, 0, rmPlayerLocXFraction(PlayerID), rmPlayerLocZFraction(PlayerID));
rmPlaceObjectDefAtLoc(Tiere1ID, 0, rmPlayerLocXFraction(PlayerID), rmPlayerLocZFraction(PlayerID));
rmPlaceObjectDefAtLoc(ExtrasID, PlayerID,rmPlayerLocXFraction(PlayerID),rmPlayerLocZFraction(PlayerID));
rmPlaceObjectDefAtLoc(Tiere2ID, 0, rmPlayerLocXFraction(PlayerID), rmPlayerLocZFraction(PlayerID));
rmPlaceObjectDefAtLoc(Schatz, 0, rmPlayerLocXFraction(PlayerID), rmPlayerLocZFraction(PlayerID));
rmPlaceObjectDefAtLoc(ExtraSilber, 0, rmPlayerLocXFraction(PlayerID), rmPlayerLocZFraction(PlayerID));
rmPlaceObjectDefAtLoc(ExtraGold, 0, rmPlayerLocXFraction(PlayerID), rmPlayerLocZFraction(PlayerID));
}
int HPostenID=rmCreateObjectDef("Handelsposten");
rmAddObjectDefItem(HPostenID, "SocketTradeRoute", 1, 0.0);
rmAddObjectDefConstraint(HPostenID, TC);
rmSetObjectDefAllowOverlap(HPostenID, true);
rmSetObjectDefMinDistance(HPostenID, 0.0);
rmSetObjectDefMaxDistance(HPostenID, 8.0);
vector tradeRoutePoint = cOriginVector;
rmSetStatusText("",0.55);
int tradeRoute = rmCreateTradeRoute();
tradeRoutePoint = rmFindClosestPoint(0.2, 0.97, 1);
rmAddTradeRouteWaypoint(tradeRoute, rmXMetersToFraction(xsVectorGetX(tradeRoutePoint)), rmZMetersToFraction(xsVectorGetZ(tradeRoutePoint)));
rmAddRandomTradeRouteWaypoints(tradeRoute, 0.5, 0.5,10,10);
tradeRoutePoint = rmFindClosestPoint(0.5, 0.01, 1);
rmAddRandomTradeRouteWaypoints(tradeRoute, rmXMetersToFraction(xsVectorGetX(tradeRoutePoint)), rmZMetersToFraction(xsVectorGetZ(tradeRoutePoint)),10,10);
rmBuildTradeRoute(tradeRoute, "dirt");
rmSetStatusText("",0.55);
rmSetObjectDefTradeRouteID(HPostenID, tradeRoute);
vector HPostenPosition = rmGetTradeRouteWayPoint(tradeRoute, 0.20);
rmPlaceObjectDefAtPoint(HPostenID, 0, HPostenPosition);
HPostenPosition = rmGetTradeRouteWayPoint(tradeRoute, 0.35);
rmPlaceObjectDefAtPoint(HPostenID, 0, HPostenPosition);
HPostenPosition = rmGetTradeRouteWayPoint(tradeRoute, 0.50);
rmPlaceObjectDefAtPoint(HPostenID, 0, HPostenPosition);
HPostenPosition = rmGetTradeRouteWayPoint(tradeRoute, 0.65);
rmPlaceObjectDefAtPoint(HPostenID, 0, HPostenPosition);
HPostenPosition = rmGetTradeRouteWayPoint(tradeRoute, 0.80);
rmPlaceObjectDefAtPoint(HPostenID, 0, HPostenPosition);
int SeaSize = cNumberNonGaiaPlayers*100;
for (I=0;<20)
{
int Sea=rmCreateArea("Sea"+I);
rmSetAreaSize(Sea, rmAreaTilesToFraction(SeaSize), rmAreaTilesToFraction(SeaSize));
rmSetAreaWaterType(Sea, "Great Lakes");
rmSetAreaWarnFailure(Sea, false);
rmSetAreaBaseHeight(Sea, 4.8);
float X = rmRandFloat(0.18,0.84);
float Z = rmRandFloat(0.18,0.84);
rmSetAreaLocation(Sea, X, Z);
rmSetAreaCoherence(Sea, 0.45);
//rmAddAreaConstraint(Sea, Rand_1);
rmAddAreaConstraint(Sea, TRADE);
rmAddAreaConstraint(Sea, TC);
rmAddAreaConstraint(Sea, SEE);
rmBuildArea(Sea);
}
rmSetStatusText("",0.70);
int Anzahl=16*cNumberNonGaiaPlayers;
int failCount=0;
for (i=0; <Anzahl)
{
int forest=rmCreateArea("forest "+i);
rmSetAreaWarnFailure(forest, false);
rmSetAreaSize(forest, rmAreaTilesToFraction(150), rmAreaTilesToFraction(150));
rmSetAreaForestType(forest, "Great Lakes Forest");
rmSetAreaForestDensity(forest, 0.8);
rmSetAreaForestClumpiness(forest, 0.6);
rmSetAreaForestUnderbrush(forest, 0.0);
rmSetAreaCoherence(forest, 0.4);
rmAddAreaConstraint(forest, TRADE);
rmAddAreaConstraint(forest, TCMIDDLE);
rmAddAreaConstraint(forest, ALL);
if(rmBuildArea(forest)==false)
{
failCount++;
if(failCount==5)
break;
}
else
failCount=0;
}
rmSetStatusText("",0.80);
int VillageID1 = rmCreateGrouping("Cherokee village1", "native cherokee village 4");
rmSetGroupingMinDistance(VillageID1, 0.0);
rmSetGroupingMaxDistance(VillageID1,rmXFractionToMeters(0.5));
rmAddGroupingConstraint(VillageID1,TC);
rmAddGroupingConstraint(VillageID1,TRADE);
rmPlaceGroupingAtLoc(VillageID1, 0, 0.5, 0.5);
rmSetStatusText("",0.81);
int VillageID2 = rmCreateGrouping("Cherokee village2", "native cherokee village 4");
rmSetGroupingMinDistance(VillageID2, 0.0);
rmSetGroupingMaxDistance(VillageID2,rmXFractionToMeters(0.5));
rmAddGroupingConstraint(VillageID2,TC);
rmAddGroupingConstraint(VillageID2,TRADE);
rmPlaceGroupingAtLoc(VillageID2, 0, 0.5, 0.5);
rmSetStatusText("",0.82);
int VillageID3 = rmCreateGrouping("Comanche village3", "native comanche village 4");
rmSetGroupingMinDistance(VillageID3, 0.0);
rmSetGroupingMaxDistance(VillageID3,rmXFractionToMeters(0.5));
rmAddGroupingConstraint(VillageID3,TC);
rmAddGroupingConstraint(VillageID3,TRADE);
rmPlaceGroupingAtLoc(VillageID3, 0, 0.5, 0.5);
rmSetStatusText("",0.83);
int VillageID4 = rmCreateGrouping("Comanche village4", "native comanche village 4");
rmSetGroupingMinDistance(VillageID4, 0.0);
rmSetGroupingMaxDistance(VillageID4,rmXFractionToMeters(0.5));
rmAddGroupingConstraint(VillageID4,TC);
rmAddGroupingConstraint(VillageID4,TRADE);
rmPlaceGroupingAtLoc(VillageID4, 0, 0.5, 0.5);
rmSetStatusText("",0.84);
rmSetStatusText("",0.95);
//*******************************************************************Ende
}
