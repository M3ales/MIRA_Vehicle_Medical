#include "function_macros.hpp"

// [player, player, [player]] call MIRA_Vehicle_Medical_fnc_buildStableActions;
params["_target", "_player", "_params"];

if!(alive _target) exitWith {
	[]
};

_params params[
	"_patient"
];

private _actions = [];
private _isMedic = _player call FUNC(isMedic);


// Bandagable Wounds Action
private _needsBandage = GVAR(Stable_TrackNeedsBandage) && _patient call FUNC(needsBandage);
if(_needsBandage) then {
	private _requiredBandages = [_patient] call FUNC(getNumberOfWoundsToBandage);
	LOGF_1("'%1' has unbandadged wounds", _patient);
	private _action = ["MIRA_Bandage", format["Bandage (%1)", _requiredBandages] , QUOTE(ICON_PATH(bandage)), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_patient"];
			[_patient] call FUNC(openMedicalMenu);
		}, {true}, {}, [_patient]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _patient];
};

// Stitchable Wounds Action
private _stitchWounds = _patient call FUNC(getStitchableWounds);
private _needsStitch = GVAR(Stable_TrackStitchableWounds) && count _stitchWounds > 0;
if (_needsStitch) then {
	LOGF_1("'%1' has stitchable wounds", _patient);
	private _action = ["MIRA_Stitch", format["Stitch (%1)", count _stitchWounds] , QUOTE(ICON_PATH(stitch)), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_patient"];
			[_patient] call FUNC(openMedicalMenu);
		}, {true}, {}, [_patient]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _patient];
};

// Low Heartrate Action
private _hasLowHR = GVAR(Stable_TrackLowHR) && [_patient, _isMedic] call FUNC(hasLowHR);
if(_hasLowHR) then {
	LOGF_1("'%1' has low HR", _patient);
	private _hr = [_patient, _isMedic] call FUNC(displayHR);
	private _action = ["MIRA_LowHR", format["Heart Rate (%1)", _hr], QUOTE(ICON_PATH(hr_low)), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_patient"];
			[_patient] call FUNC(openMedicalMenu);
		}, {true}, {}, [_patient]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _patient];
};

// Low Blood Pressure Action
private _hasLowBP = GVAR(Stable_TrackLowBP) && [_patient, _isMedic] call FUNC(hasLowBP);
if(_hasLowBP) then {
	LOGF_1("'%1' has low BP", _patient);
	private _bp = [_patient, _isMedic] call FUNC(displayBP);
	private _name = format["Blood Pressure (%1)", _bp];
	if(GVAR(Stable_TrackIV)) then {
		private _iv =  _patient call FUNC(getTotalIV);
		if(_iv > 0) then {
			_name = format["Blood Pressure (%1) [%2ml]", _bp, _iv];
		};
	};
	private _action = ["MIRA_LowBP", _name, QUOTE(ICON_PATH(bp_low)), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_patient"];
			[_patient] call FUNC(openMedicalMenu);
		}, {true}, {}, [_patient]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _patient];
};

#include "ace_medical_macros.hpp"
// Fractures (Legs)
private _fractures = [_patient] call FUNC(getFractures);
if!(_fractures isEqualTo DEFAULT_FRACTURE_VALUES) then {
	LOGF_1("'%1' has fractures", _patient);
	private _action = ["MIRA_Fractures", format["Fractures (%1)", count _fractures], QUOTE(ICON_PATH(fracture)), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_patient"];
			[_patient] call FUNC(openMedicalMenu);
		}, {true}, {}, [_patient]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _patient];
};

// Add an action that shows if they've still got tourniquets on
_actions