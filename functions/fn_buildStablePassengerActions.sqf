/*
 * Author: esteldunedain, with minor changes by M3ales
 * Builds an array of actions, one for each passenger, with their name as the display.
 * Essentially a copy of https://github.com/acemod/ACE3/blob/e78016d7f7e193691f92bac10c3e437d64a4bfd0/addons/interaction/functions/fnc_addPassengersActions.sqf
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Player <OBJECT>
 *
 * Return Value:
 * Children actions <ARRAY>
 *
 * Example:
 * [vehicle player, player] call MIRA_fnc_buildUnstablePassengerActions
 *
 * Public: Yes
 */
#include "function_macros.hpp"

params["_vehicle", "_player"];

//diag_log format["Building actions for vehicle '%1'", _vehicle];

 _actions = [];

//conditions to display the unit's action
_conditions = {
	params ["", "", "_parameters"];
	_parameters params ["_unit"];
	//display action if any are true
	if(_unit call FUNC(isBleeding) || _unit call FUNC(isUnconscious)) exitWith {false};
	if(_unit call FUNC(needsBandage) || count (_unit call FUNC(getStitchableWounds)) > 0) exitWith {true};
	false
};

//modify the icon to show the worst 'wound' type
_modifierFunc = {
	params ["_target", "_player", "_parameters", "_actionData"];
	_parameters params ["_unit"];

	_statusIcons = [
		"",
		"\MIRA_Vehicle_Medical\ui\unconscious_white.paa",
		"\MIRA_Vehicle_Medical\ui\bleeding_red.paa",
		"\MIRA_Vehicle_Medical\ui\cardiac_arrest_red.paa"
	];
};

 //foreach player/npc in vehicle
{
	_unit = _x;
	//ignore drone pilot(s)
	if(_unit != _player && { getText (configFile >> "CfgVehicles" >> typeOf _unit >> "simulation") != "UAVPilot" }) then {
		//get unit name from ace common to display
		 _unitname = [_unit] call ace_common_fnc_getName;
		//diag_log format["Adding action for '%1' (%2)", _unit, _unitname];
		//icon is blank, defined by modififer func
		_icon = "";
		//build the action, use additional params to have runOnHover = true
		_action = [
			format["%1", _unit],
			_unitname,
			_icon,
			{
				params ["", "", "_parameters"];
				_parameters params ["_unit"];
				[_unit] call ace_medical_menu_fnc_openMenu;
			},
			_conditions,
			{
				//when creating children, only create children of unit who is being hovered over, otherwise empty children
				//probably performance thing, unsure
				if(ace_interact_menu_selectedTarget isEqualTo _target) then {
					_this call FUNC(buildStableActions);
				}else {
					[]
				};
			},
			[_unit],
			{[0, 0, 0]},
			2,
			[false, false, false, false, false],
			_modifierFunc
		] call ace_interact_menu_fnc_createAction;
		//add built action to array
		_actions pushBack[_action, [], _unit];
	};
	//I think this basically functions as a continue, not really sure.
	false
}count crew _vehicle;

_actions