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
 * ["","",[_unit]] call MIRA_fnc_buildUnstableActions
 *
 * Public: No
 */
params ["", "", "_parameters"];
_parameters params ["_unit"];
diag_log format["Building actions for unstable unit '%1'", _unit];
private _actions = [];
private _bleeding = [_unit] call ace_medical_blood_fnc_isBleeding;
if (_bleeding) then {
	diag_log format["'%1' is Bleeding", _unit];
	private _action = ["MIRA_Bleeding", "Bleeding", "", {
			params ["", "", "_parameters"];
			_parameters params ["_unit"];
			[_unit] call ace_medical_gui_fnc_openMenu;
		}, {true}, {}, [_unit]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _unit];
};
private _uncon = _unit getVariable ["ACE_isUnconscious", false];
if (_uncon) then {
	diag_log format["'%1' is Unconscious", _unit];
	private _action = ["MIRA_Sleepy", "Unconscious", "", {
			params ["", "", "_parameters"];
			_parameters params ["_unit"];
			[_unit] call ace_medical_gui_fnc_openMenu;
		}, {true}, {}, [_unit]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _unit];
};
private _cardiacArrest = _unit getVariable ["ace_medical_inCardiacArrest", false];
if (_cardiacArrest) then {
	diag_log format["'%1' is in Cardiac Arrest", _unit];
	private _action = ["MIRA_Cardiac", "Cardiac Arrest", "", {
		params ["", "", "_parameters"];
		_parameters params ["_unit"];
		[_unit] call ace_medical_gui_fnc_openMenu;
		}, {true}, {}, [_unit]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _unit];
};
_actions