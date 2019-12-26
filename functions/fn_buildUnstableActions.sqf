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
 * [_player,_target,[_unit]] call MIRA_fnc_buildUnstableActions
 *
 * Public: Yes
 */
 //discard default _player and _target params, don't need them, called by ace.

params ["_target", "_player", "_parameters"];
_parameters params ["_unit"];

_actions = [];

//add cardiac arrest action if applicable
_cardiacArrest = GVAR(Unstable_TrackCardiacArrest) &&_unit call FUNC(isCardiacArrest);
if (_cardiacArrest) then {
	LOG(format["'%1' is in Cardiac Arrest", _unit]);
	_action = ["MIRA_Cardiac", "Cardiac Arrest", QUOTE(ICON_PATH(cardiac_arrest_red)), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_unit"];
			[_unit] call ace_medical_menu_fnc_openMenu;
		}, {true}, {}, [_unit]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _unit];
};

_isBleeding = GVAR(Unstable_TrackBleeding) && _unit call FUNC(isBleeding);
//add bleeding action if applicable
if (_isBleeding) then {
	//TODO: collect all wounds, and colour icon based on severity, only have red done for now
	_icon = [
		QUOTE(ICON_PATH(bleeding_red)),
		QUOTE(ICON_PATH(bleeding_yellow)),
		QUOTE(ICON_PATH(bleeding_white))
	] select 0;
	LOG(format["'%1' is Bleeding", _unit]);
	_action = ["MIRA_Bleeding", "Bleeding", _icon, {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_unit"];
			[_unit] call ace_medical_menu_fnc_openMenu;
		}, {true}, {}, [_unit]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _unit];
};

//add unconscious action if applicable
_isUncon = GVAR(Unstable_TrackUnconscious) && _unit call FUNC(isUnconscious);
if (_isUncon) then {
	LOG(format["'%1' is Unconscious", _unit]);
	_action = ["MIRA_Sleepy", "Unconscious", QUOTE(ICON_PATH(unconscious_white)), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_unit"];
			[_unit] call ace_medical_menu_fnc_openMenu;
		}, {true}, {}, [_unit]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _unit];
};

_hasLowBP = GVAR(Unstable_TrackLowBP) && [_unit, _player, false] call FUNC(hasLowBP);
if(_hasLowBP) then {
	LOG(format["'%1' has low BP", _unit]);
	_bp = [_player, _unit] call FUNC(displayBP);
	_name = format["Blood Pressure (%1)", _bp];
	if(GVAR(Unstable_TrackIV)) then {
		_iv =  _unit call FUNC(getTotalIV);
		if(_iv > 0) then {
			_name = format["Blood Pressure (%1) [%2ml]", _bp, _iv];
		};
	};
	_action = ["MIRA_LowBP", _name, QUOTE(ICON_PATH(bp_low)), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_unit"];
			[_unit] call ace_medical_menu_fnc_openMenu;
		}, {true}, {}, [_unit]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _unit];
};

_hasLowHR = GVAR(Unstable_TrackLowHR) && [_unit, _player, false] call FUNC(hasLowHR);
if(_hasLowHR) then {
	LOG(format["'%1' has low HR", _unit]);
	_hr = [_player, _unit] call FUNC(displayHR);
	_action = ["MIRA_LowHR", format["Heart Rate (%1)", _hr], QUOTE(ICON_PATH(hr_low)), {
			params ["_target", "_player", "_parameters"];
			_parameters params ["_unit"];
			[_unit] call ace_medical_menu_fnc_openMenu;
		}, {true}, {}, [_unit]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _unit];
};

_actions