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
 * [vehicle player, player] call MIRA_Vehicle_Medical_fnc_buildUnstablePassengerActions
 *
 * Public: Yes
 */

params["_vehicle", "_player"];

if!(alive _vehicle) exitWith { 
	[] 
};

 _actions = [];

//conditions to display the unit's action
_conditions = {
	params ["", "", "_parameters"];
	_parameters params ["_unit"];
	_unit call FUNC(isStable);
};

//modify the icon to show the worst 'wound' type
_modifierFunc = {
	params ["_target", "_player", "_parameters", "_actionData"];
	_parameters params ["_unit"];
	_statusIcons = [
		"",
		QUOTE(ICON_PATH(bandage)),
		QUOTE(ICON_PATH(stitch)),
		QUOTE(ICON_PATH(bp_low)),
		QUOTE(ICON_PATH(hr_low))
	];
	_lowHR = GVAR(Stable_TrackLowHR) && _unit call FUNC(hasLowHR);
	if(_lowHR) then {
		_actionData set [2, _statusIcons select 4];
	};
	_lowBP = GVAR(Stable_TrackLowBP) && _unit call FUNC(hasLowBP);
	if(_lowBP) then {
		_actionData set [2, _statusIcons select 3];
	};
	if(GVAR(Stable_TrackNeedsBandage) && _unit call FUNC(needsBandage)) then {
		_actionData set [2, _statusIcons select 1];
	};
	_stitch = _unit call FUNC(getStitchableWounds);
	if(GVAR(Stable_TrackStitchableWounds) && count _stitch > 0) then {
		_actionData set [2, _statusIcons select 2];
	};
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
				[_unit] call FUNC(openMedicalMenu);
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