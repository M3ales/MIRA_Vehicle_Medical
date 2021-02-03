// Mostly copied directly from: https://github.com/acemod/ACE3/blob/v3.13.5/addons/medical_engine/script_macros_medical.hpp
#define EMPTY_WOUND [-1, -1, 0, 0, 0]

#define DEFAULT_FRACTURE_VALUES [0,0,0,0,0,0]
#define DEFAULT_TOURNIQUET_VALUES [0,0,0,0,0,0]

#define ALL_BODY_PARTS ["head", "body", "leftarm", "rightarm", "leftleg", "rightleg"]
#define ALL_SELECTIONS ["head", "body", "hand_l", "hand_r", "leg_l", "leg_r"]
#define ALL_HITPOINTS ["HitHead", "HitBody", "HitLeftArm", "HitRightArm", "HitLeftLeg", "HitRightLeg"]

#define HITPOINT_INDEX_HEAD 0
#define HITPOINT_INDEX_BODY 1
#define HITPOINT_INDEX_LARM 2
#define HITPOINT_INDEX_RARM 3
#define HITPOINT_INDEX_LLEG 4
#define HITPOINT_INDEX_RLEG 5

#define VAR_BLOOD_PRESS       "ace_medical,bloodPressure"
#define VAR_BLOOD_VOL         "ace_medical_bloodVolume"
#define VAR_WOUND_BLEEDING    "ace_medical_woundBleeding"
#define VAR_CRDC_ARRST        "ace_medical_inCardiacArrest"
#define VAR_HEART_RATE        "ace_medical_heartRate"
#define VAR_PAIN              "ace_medical_pain"
#define VAR_PAIN_SUPP         "ace_medical_painSuppress"
#define VAR_PERIPH_RES        "ace_medical_peripheralResistance"
#define VAR_UNCON             "ACE_isUnconscious"
#define VAR_OPEN_WOUNDS       "ace_medical_openWounds"
#define VAR_BANDAGED_WOUNDS   "ace_medical_bandagedWounds"
#define VAR_STITCHED_WOUNDS   "ace_medical_stitchedWounds"
// These variables track gradual adjustments (from medication, etc.)
#define VAR_MEDICATIONS       "ace_medical_medications"
// These variables track the current state of status values above
#define VAR_HEMORRHAGE        "ace_medical_hemorrhage"
#define VAR_IN_PAIN           "ace_medical_inPain"
#define VAR_TOURNIQUET        "ace_medical_tourniquets"
#define VAR_FRACTURES         "ace_medical_fractures"

#define DEFAULT_BLOOD_VOLUME 6.0 // in liters

#define BLOOD_VOLUME_CLASS_1_HEMORRHAGE 6.000 // lost less than 15% blood, Class I Hemorrhage
#define BLOOD_VOLUME_CLASS_2_HEMORRHAGE 5.100 // lost more than 15% blood, Class II Hemorrhage
#define BLOOD_VOLUME_CLASS_3_HEMORRHAGE 4.200 // lost more than 30% blood, Class III Hemorrhage
#define BLOOD_VOLUME_CLASS_4_HEMORRHAGE 3.600 // lost more than 40% blood, Class IV Hemorrhage
#define BLOOD_VOLUME_FATAL 3.0 // Lost more than 50% blood, Unrecoverable


#define GET_BLOOD_VOLUME(unit)      (unit getVariable [VAR_BLOOD_VOL, DEFAULT_BLOOD_VOLUME])

// Bleed rate rather than number of wounds present
#define GET_WOUND_BLEEDING(unit)    (unit getVariable [VAR_WOUND_BLEEDING, 0]) 

#define GET_HEART_RATE(unit)        (unit getVariable [VAR_HEART_RATE, DEFAULT_HEART_RATE])
// Current hemmorrhage class, see above
#define GET_HEMORRHAGE(unit)        (unit getVariable [VAR_HEMORRHAGE, 0])
#define GET_PAIN(unit)              (unit getVariable [VAR_PAIN, 0])
#define GET_PAIN_SUPPRESS(unit)     (unit getVariable [VAR_PAIN_SUPP, 0])
#define GET_TOURNIQUETS(unit)       (unit getVariable [VAR_TOURNIQUET, DEFAULT_TOURNIQUET_VALUES])
#define GET_FRACTURES(unit)         (unit getVariable [VAR_FRACTURES, DEFAULT_FRACTURE_VALUES])
#define IN_CRDC_ARRST(unit)         (unit getVariable [VAR_CRDC_ARRST, false])
#define IS_BLEEDING(unit)           (GET_WOUND_BLEEDING(unit) > 0)
#define IS_IN_PAIN(unit)            (unit getVariable [VAR_IN_PAIN, false])
#define IS_UNCONSCIOUS(unit)        (unit getVariable [VAR_UNCON, false])
#define GET_OPEN_WOUNDS(unit)       (unit getVariable [VAR_OPEN_WOUNDS, []])
#define GET_BANDAGED_WOUNDS(unit)   (unit getVariable [VAR_BANDAGED_WOUNDS, []])
#define GET_STITCHED_WOUNDS(unit)   (unit getVariable [VAR_STITCHED_WOUNDS, []])

// The following function calls are defined here just for consistency
#define GET_BLOOD_LOSS(unit)        ([unit] call ace_medical_status_fnc_getBloodLoss)
#define GET_BLOOD_PRESSURE(unit)    ([unit] call ace_medical_status_fnc_getBloodPressure)