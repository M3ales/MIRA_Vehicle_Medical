#include "function_macros.hpp"
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

params["_vehicle", "_player"];
 _actions = [];

//conditions to display the unit's action
_conditions = {
	params ["", "", "_parameters"];
	_parameters params ["_unit"];
	//display action if any are true
	if(_unit call FUNC(needsBandage) || count (_unit call FUNC(getStitchableWounds)) > 0) exitWith {true};
	false
};

//modify the icon to show the worst 'wound' type
_modifierFunc = {
	params ["_target", "_player", "_parameters", "_actionData"];
	_parameters params ["_unit"];

	_statusIcons = [
		"",
		QUOTE(ICON_PATH(unconscious_white)),
		QUOTE(ICON_PATH(bleeding_red)),
		QUOTE(ICON_PATH(cardiac_arrest_red))
	];
};

 //foreach player/npc in vehicle
{
	_unit = _x;
	//ignore drone pilot(s)
	if(getText (configFile >> "CfgVehicles" >> typeOf _unit >> "simulation") != "UAVPilot") then {
		//get unit name from ace common to display
		 _unitname = [_unit] call ace_common_fnc_getName;
		//icon is blank, defined by modififer func
		_icon = "";
		//build the action, use additional params to have runOnHover = true
		if(_unit == _player) then {
			_unitname = "You";
		};
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