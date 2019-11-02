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
params ["", "", "_parameters"];
_parameters params ["_unit"];

diag_log format["Building actions for unstable unit '%1'", _unit];

_actions = [];


//add cardiac arrest action if applicable
if (_unit call MIRA_Vehicle_Medical_fnc_isCardiacArrest) then {
	diag_log format["'%1' is in Cardiac Arrest", _unit];
	_action = ["MIRA_Cardiac", "Cardiac Arrest", "\MIRA_Vehicle_Medical\ui\cardiac_arrest_red.paa", {
			params ["_player", "_target", "_parameters"];
			_parameters params ["_unit"];
			diag_log format["Unit is: %1 -- %2", _unit, _target];
			[_unit] call ace_medical_menu_fnc_openMenu;
		}, {true}, {}, [_unit]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _unit];
};

//add bleeding action if applicable
if (_unit call MIRA_Vehicle_Medical_fnc_isBleeding) then {
	//TODO: collect all wounds, and colour icon based on severity, only have red done for now
	_icon = [
		"\MIRA_Vehicle_Medical\ui\bleeding_red.paa",
		"\MIRA_Vehicle_Medical\ui\bleeding_yellow.paa",
		"\MIRA_Vehicle_Medical\ui\bleeding_white.paa"
	] select 0;
	diag_log format["'%1' is Bleeding", _unit];
	_action = ["MIRA_Bleeding", "Bleeding", _icon, {
			params ["", "", "_parameters"];
			_parameters params ["_unit"];
			[_unit] call ace_medical_menu_fnc_openMenu;
		}, {true}, {}, [_unit]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _unit];
};

//add unconscious action if applicable
if (_unit call MIRA_Vehicle_Medical_fnc_isUnconscious) then {
	diag_log format["'%1' is Unconscious", _unit];
	_action = ["MIRA_Sleepy", "Unconscious", "\MIRA_Vehicle_Medical\ui\unconscious_white.paa", {
			params ["", "", "_parameters"];
			_parameters params ["_unit"];
			[_unit] call ace_medical_menu_fnc_openMenu;
		}, {true}, {}, [_unit]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _unit];
};

_actions