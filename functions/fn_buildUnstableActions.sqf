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

// Dead
if!(alive _patient) then {
	LOGF_1("'%1' is dead", _patient);
	private _action = ["MIRA_Bandage", "Dead" , QUOTE(ICON_PATH(dead)), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_patient"];
			[_patient] call FUNC(openMedicalMenu);
			if(GVAR(WarnViewingDead)) then {
				private _patientName = [_patient] call ace_common_fnc_getName;
				[format["You are viewing %1 who is currently deceased.", _patientName], true, 4, 1] call ACE_common_fnc_displayText;
			};
		}, {true}, {}, [_patient]] call ace_interact_menu_fnc_createAction;
	[[_action, [], _patient]];
};

// Cardiac Arrest Action
private _cardiacArrest = GVAR(Unstable_TrackCardiacArrest) && [_patient] call FUNC(isCardiacArrest);
if (_cardiacArrest) then {
	LOGF_1("'%1' is in Cardiac Arrest", _patient);
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
	LOGF_1("'%1' is Bleeding", _patient);
	_action = ["MIRA_Bleeding", "Bleeding", _icon, {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_patient"];
			[_patient] call FUNC(openMedicalMenu);
		}, {true}, {}, [_patient]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _patient];
};

// Low HeartRate Action
private _hasLowHR = GVAR(Unstable_TrackLowHR) && [_patient, _isMedic] call FUNC(hasLowHR);
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
private _hasLowBP = GVAR(Unstable_TrackLowBP) && [_patient, _isMedic] call FUNC(hasLowBP);
if(_hasLowBP) then {
	LOGF_1("'%1' has low BP", _patient);
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

// Unconscious Action
private _isUncon = GVAR(Unstable_TrackUnconscious) && _patient call FUNC(isUnconscious);
if (_isUncon) then {
	LOGF_1("'%1' is Unconscious", _patient);
	private _action = ["MIRA_Sleepy", "Unconscious", QUOTE(ICON_PATH(unconscious_white)), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_patient"];
			[_patient] call FUNC(openMedicalMenu);
		}, {true}, {}, [_patient]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _patient];
};

// Fractures (Legs)
if([_patient] call FUNC(hasLegFractures)) then {
	LOGF_1("'%1' has leg fractures", _patient);
	private _numLegFractures = [_patient] call FUNC(getNumberOfLegFractures);
	private _action = ["MIRA_Fractures", format["Leg Fractures (%1)", _numLegFractures], QUOTE(ICON_PATH(fracture)), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_patient"];
			[_patient] call FUNC(openMedicalMenu);
		}, {true}, {}, [_patient]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _patient];
};

// Medication Action
_actions