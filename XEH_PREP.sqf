#define PREP(var1) FUNC(var1) = compileFinal preProcessFileLineNumbers QUOTE(ADDON\functions\CONCAT(fn_,var1).sqf)
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