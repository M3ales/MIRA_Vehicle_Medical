#define PREP(var1) FUNC(var1) = compileFinal preProcessFileLineNumbers QUOTE(ADDON\functions\CONCAT(fn_,var1).sqf); diag_log format["PREP fnc_%1", QUOTE(var1)]
PREP(buildUnstablePassengerActions);
PREP(buildUnstableActions);
PREP(isBleeding);
PREP(isCardiacArrest);
PREP(isUnconscious);
PREP(buildStablePassengerActions);
PREP(buildStableActions);
PREP(getOpenWounds);
PREP(getStitchableWounds);
PREP(needsBandage);
PREP(hasLowHR);
PREP(displayHR);
PREP(hasLowBP);
PREP(displayBP);
PREP(getTotalIV);
PREP(openMedicalMenu);
PREP(getBloodPressure);
PREP(isMedic);
PREP(getFractures);
PREP(getNumberOfWoundsToBandage);
PREP(isStable);
PREP(getStitchedWounds);
PREP(getHeartRate);
PREP(hasLegFractures);
PREP(hasFractures);
PREP(getVersion);
PREP(isUnstable);
PREP(getNumberOfFractures);
PREP(getNumberOfLegFractures);

// KAT Integration
PREP(kat_isUnstable);
PREP(kat_getAirwayObstruction);
PREP(kat_getAirwayOcclusion);
PREP(kat_getAirwayStatus);
PREP(kat_getHemoPneumothorax);
PREP(kat_getPneumothorax);
PREP(kat_getTensionPneumothorax);

//Localisation Caching
PREP(cachedLocalisationCall);