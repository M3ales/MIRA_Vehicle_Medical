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

if!(alive _vehicle) exitWith { 
	[] 
};

private _actions = [];

//conditions to display the unit's action
_conditions = {
	params ["", "", "_parameters"];
	_parameters params ["_unit"];
	if(!alive _unit) exitWith {false};
	_bleeding = GVAR(Unstable_TrackBleeding) && _unit call FUNC(isBleeding);
	_sleepy = GVAR(Unstable_TrackUnconscious) && _unit call FUNC(isUnconscious);
	_cardiac = GVAR(Unstable_TrackCardiacArrest) && _unit call FUNC(isCardiacArrest);
	//display action if any are true
	if(_bleeding || _sleepy || _cardiac) exitWith {true};
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
	_bleeding = GVAR(Unstable_TrackBleeding) && _unit call FUNC(isBleeding);
	_sleepy = GVAR(Unstable_TrackUnconscious) && _unit call FUNC(isUnconscious);
	_cardiac = GVAR(Unstable_TrackCardiacArrest) && _unit call FUNC(isCardiacArrest);
	// Modify the icon (3rd param)
	//Use ascending order of importance, cardiac > bleeding > unconscious
	if(!_sleepy && !_bleeding && !_cardiac) then {
		//healthy, default icon
		_actionData set [2, _statusIcons select 0];
	}
	else {
		if(_sleepy && !_bleeding && !_cardiac) then {
			//only unconscious, use unconscious icon
			_actionData set [2, _statusIcons select 1];
		}
		else {
			if(!_cardiac) then {
				//not only unconscious, but not in cardiac, must be bleeding
				if(GVAR(Unstable_TrackBleeding)) then {
					_actionData set [2, _statusIcons select 2];
				};
			}
			else {
				//must be in cardiac, takes priority over bleeding
				_actionData set [2, _statusIcons select 3];
			};
		};
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
		if(_unit == _player) then {
			_unitname = "You";
		};
		//build the action, use additional params to have runOnHover = true
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
					_this call FUNC(buildUnstableActions);
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