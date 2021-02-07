#include "function_macros.hpp"

// [player, player, [player]] call MIRA_Vehicle_Medical_fnc_buildStableActions;
params["_target", "_player", "_params"];

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

// Fractures
if(GVAR(Stable_TrackFractures) && [_patient] call FUNC(hasFractures)) then {
	LOGF_1("'%1' has fractures", _patient);
	private _numFractures = [_patient] call FUNC(getNumberOfFractures);
	private _fracturesMessage =  format["Fractures (%1)", _numFractures];
	if(_numFractures == 0) then {
		LOG_ERROR("Found no fractures despite fractures being non default");
		_fracturesMessage = "Fractures (Error Fetching Amount)"
	};
	private _action = ["MIRA_Fractures", _fracturesMessage, QUOTE(ICON_PATH(fracture)), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_patient"];
			[_patient] call FUNC(openMedicalMenu);
		}, {true}, {}, [_patient]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _patient];
};


// Splinted Fractures
if(GVAR(Stable_TrackSplints) && [_patient, true] call FUNC(hasFractures)) then {
	LOGF_1("'%1' has splinted fractures", _patient);
	private _numLegFractures = [_patient, true] call FUNC(getNumberOfFractures);
	private _fracturesMessage =  format["Splinted Fractures (%1)", _numLegFractures];
	if(_numLegFractures == 0) then {
		LOG_ERROR("Found no fractures despite fractures being non default");
		_fracturesMessage = "Splinted Fractures (Error Fetching Amount)"
	};
	private _action = ["MIRA_Splinted_Fractures", _fracturesMessage, QUOTE(ICON_PATH(splint)), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_patient"];
			[_patient] call FUNC(openMedicalMenu);
		}, {true}, {}, [_patient]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _patient];
};

// TODO: Add an action that shows if they've still got tourniquets on
_actions