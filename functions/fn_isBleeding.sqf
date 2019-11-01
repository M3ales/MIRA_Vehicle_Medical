/*
 * Author: M3ales
 * Locally defined fuction which grabs the bleeding status of a given unit
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * If bleeding or not <BOOLEAN>
 *
 * Example:
 * 	
 *
 * Public: Yes
 */
params["_unit"];

[_unit] call ace_medical_blood_fnc_isBleeding;