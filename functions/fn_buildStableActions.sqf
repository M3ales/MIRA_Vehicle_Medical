#include "function_macros.hpp"

// [player, player, [player]] call MIRA_Vehicle_Medical_fnc_buildStableActions;
params["_target", "_player", "_params"];
_params params["_unit"];
_actions = [];

if(!alive _target) exitWith {
	[]
};

_stitchWounds = _unit call FUNC(getStitchableWounds);
_needsStitch = GVAR(Stable_TrackStitchableWounds) && count _stitchWounds > 0;
if (_needsStitch) then {
	LOG(format["'%1' has stitchable wounds", _unit]);
	_action = ["MIRA_Stitch", format["Stitch (%1)", count _stitchWounds] , QUOTE(ICON_PATH(stitch)), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_unit"];
			[_unit] call FUNC(openMedicalMenu);
		}, {true}, {}, [_unit]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _unit];
};

_needsBandage = GVAR(Stable_TrackNeedsBandage) && _unit call FUNC(needsBandage);
if(_needsBandage) then {
	_requiredBandages = ([_unit] call FUNC(getNumberOfWoundsToBandage));
	LOG(format["'%1' has unbandadged wounds", _unit]);
	_action = ["MIRA_Bandage", format["Bandage (%1)", (_requiredBandages - (count _stitchWounds))] , QUOTE(ICON_PATH(bandage)), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_unit"];
			[_unit] call FUNC(openMedicalMenu);
		}, {true}, {}, [_unit]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _unit];
};

_hasLowBP = GVAR(Stable_TrackLowBP) && [_unit, _player, true] call FUNC(hasLowBP);
if(_hasLowBP) then {
	LOG(format["'%1' has low BP", _unit]);
	_bp = [_player, _unit] call FUNC(displayBP);
	_name = format["Blood Pressure (%1)", _bp];
	if(GVAR(Stable_TrackIV)) then {
		_iv =  _unit call FUNC(getTotalIV);
		if(_iv > 0) then {
			_name = format["Blood Pressure (%1) [%2ml]", _bp, _iv];
		};
	};
	_action = ["MIRA_LowBP", _name, QUOTE(ICON_PATH(bp_low)), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_unit"];
			[_unit] call FUNC(openMedicalMenu);
		}, {true}, {}, [_unit]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _unit];
};

_hasLowHR = GVAR(Stable_TrackLowHR) && [_unit, _player, true] call FUNC(hasLowHR);
if(_hasLowHR) then {
	LOG(format["'%1' has low HR", _unit]);
	_hr = [_player, _unit] call FUNC(displayHR);
	_action = ["MIRA_LowHR", format["Heart Rate (%1)", _hr], QUOTE(ICON_PATH(hr_low)), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_unit"];
			[_unit] call FUNC(openMedicalMenu);
		}, {true}, {}, [_unit]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _unit];
};

// Add an action that shows if they've still got tourniquets on
_actions