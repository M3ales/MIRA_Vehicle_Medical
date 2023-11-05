private _heal = false;
private _vehicle = vehicle player;
private _parts = ["rightleg","leftleg"];
private _damageTypes = ["bullet"];
private _numberOfDamageInstances = 10;

{
	if(_heal == true) then {
		[_x, _x] call ace_medical_treatment_fnc_fullHeal; 
	}
	else {
		if(_x != player) then {
			for "_i" from 0 to _numberOfDamageInstances do {
				[_x, random 1, selectRandom _parts, selectRandom _damageTypes] call ace_medical_fnc_addDamageToUnit;
			}
		};
	};
} forEach (crew _vehicle);