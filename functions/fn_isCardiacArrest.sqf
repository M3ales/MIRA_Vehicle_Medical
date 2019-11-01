/*
 * Author: M3ales
 * Locally defined fuction which grabs if a unit is in cardiac arrest
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * If in cardiac arrest or not <BOOLEAN>
 *
 * Example:
 * [_unit] call MIRA_Vehicle_Medical_fnc_isCardiacArrest
 *
 * Public: Yes
 */
params["_unit"];

_unit getVariable ["ace_medical_inCardiacArrest", false];