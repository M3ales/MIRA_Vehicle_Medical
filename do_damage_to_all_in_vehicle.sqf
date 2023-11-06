private _fnc_damageTarget = {
	params["_target", "_numberOfWounds"];
	private _parts = ["Head", "Body", "LeftArm", "RightArm", "LeftLeg", "RightLeg"];
	private _damageTypes = ["bullet"];

	for [{
		private _i = 0
	}, {
		_i < _numberOfWounds
	}, {
		_i = _i + 1
	}] do {
	[_target, 1, selectRandom _parts, selectRandom _damageTypes] call ace_medical_fnc_addDamageToUnit;
};
};

private _numberOfWounds = 5;
private _vehicle = vehicle player;
{
	if ((driver _vehicle != _x) && _x != player) then {
		[_x, _numberOfWounds] call _fnc_damageTarget;
	};
} forEach(crew _vehicle);


// [player, player] call ace_medical_treatment_fnc_fullHeal; 