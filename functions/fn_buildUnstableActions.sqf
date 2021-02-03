#include "function_macros.hpp"
/*
 * Author: M3ales
 * Builds a set of subactions for a given passenger, listing their afflictions.
 * Currently marked afflictions are: Bleeding (actively), Unconscious, and Cardiac Arrest
 *
 * Arguments:
 * 0: Target <OBJECT>
 * 1: Player <OBJECT>
 * 2: Parameters <OBJECT>
 *
 * Return Value:
 * Children actions <ARRAY>
 *
 * Example:
 * [_player,_target,[_patient, _isMedic]] call MIRA_fnc_buildUnstableActions
 *
 * Public: Yes
 */
 //discard default _player and _target params, don't need them, called by ace.

params ["_target", "_player", "_parameters"];

if!(alive _target) exitWith {
	[]
};

_parameters params [
	"_patient"
];

private _isMedic = _player call FUNC(isMedic);
private _actions = [];

// Cardiac Arrest Action
private _cardiacArrest = GVAR(Unstable_TrackCardiacArrest) && [_patient] call FUNC(isCardiacArrest);
if (_cardiacArrest) then {
	LOG(format["'%1' is in Cardiac Arrest", _patient]);
	_action = ["MIRA_Cardiac", "Cardiac Arrest", QUOTE(ICON_PATH(cardiac_arrest_red)), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_patient"];
			[_patient] call FUNC(openMedicalMenu);
		}, {true}, {}, [_patient]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _patient];
};

// Bleeding Action
private _isBleeding = GVAR(Unstable_TrackBleeding) && _patient call FUNC(isBleeding);
//add bleeding action if applicable
if (_isBleeding) then {
	//TODO: collect all wounds, and colour icon based on severity, only have red done for now
	_icon = [
		QUOTE(ICON_PATH(bleeding_red)),
		QUOTE(ICON_PATH(bleeding_yellow)),
		QUOTE(ICON_PATH(bleeding_white))
	] select 0;
	LOG(format["'%1' is Bleeding", _patient]);
	_action = ["MIRA_Bleeding", "Bleeding", _icon, {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_patient"];
			[_patient] call FUNC(openMedicalMenu);
		}, {true}, {}, [_patient]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _patient];
};

// Unconscious Action
private _isUncon = GVAR(Unstable_TrackUnconscious) && _patient call FUNC(isUnconscious);
if (_isUncon) then {
	LOG(format["'%1' is Unconscious", _patient]);
	private _action = ["MIRA_Sleepy", "Unconscious", QUOTE(ICON_PATH(unconscious_white)), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_patient"];
			[_patient] call FUNC(openMedicalMenu);
		}, {true}, {}, [_patient]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _patient];
};

// Low Blood Pressure Action
private _hasLowBP = GVAR(Unstable_TrackLowBP) && [_patient, _isMedic] call FUNC(hasLowBP);
if(_hasLowBP) then {
	LOG(format["'%1' has low BP", _patient]);
	private _bp = [_patient, _isMedic] call FUNC(displayBP);
	private _name = format["Blood Pressure (%1)", _bp];
	if(GVAR(Unstable_TrackIV)) then {
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

// Low HeartRate Action
private _hasLowHR = GVAR(Unstable_TrackLowHR) && [_patient, _isMedic] call FUNC(hasLowHR);
if(_hasLowHR) then {
	LOG(format["'%1' has low HR", _patient]);
	private _hr = [_patient, _isMedic] call FUNC(displayHR);
	private _action = ["MIRA_LowHR", format["Heart Rate (%1)", _hr], QUOTE(ICON_PATH(hr_low)), {
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
	LOG(format["'%1' has fractures", _patient]);
	_numLegFractures = (_fractures select HITPOINT_INDEX_LLEG) + (_fractures select HITPOINT_INDEX_RLEG);
	private _action = ["MIRA_Fractures", format["Leg Fractures (%1)", _numLegFractures], QUOTE(ICON_PATH(hr_low)), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_patient"];
			[_patient] call FUNC(openMedicalMenu);
		}, {true}, {}, [_patient]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _patient];
};

// Medication Action
_actions