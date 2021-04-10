params["_patient", "_medic"];

["ace_unloadPersonEvent", [_patient, vehicle _patient, _medic], _patient] call CBA_fnc_targetEvent;

[
	{
		params ["_patient"];
		(alive _patient) && {(vehicle _patient) != _patient}
	},
	{
		params ["_patient"];
	},
	[_patient],
	2, 
	{
		params ["_patient"];
		if (!alive _patient) exitWith {};
		unassignVehicle _patient;
		[_patient] orderGetIn false;
		_patient action ["Eject", vehicle _patient];
		if (vehicle _patient != _patient) then {
			moveOut _patient;
		};
		[_patient, false, "ace_common_fnc_loadPerson", side group _patient] call ace_common_fnc_switchToGroupSide;
	}
] call CBA_fnc_waitUntilAndExecute;