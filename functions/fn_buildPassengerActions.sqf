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
 * [vehicle player, player] call MIRA_fnc_buildPassengerActions
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
	if(_unit call FUNC(isBleeding) || _unit call FUNC(isUnconscious) || _unit call FUNC(isCardiacArrest)) exitWith {true};
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

	_bleeding = _unit call FUNC(isBleeding);
	_sleepy = _unit call FUNC(isUnconscious);
	_cardiac = _unit call FUNC(isCardiacArrest);
	// Modify the icon (3rd param)
	//Use ascending order of importance, cardiac > bleeding > unconscious
	//diag_log format["[B: %1, U: %2 , C: %3] - %4", _bleeding, _sleepy, _cardiac, str (_bleeding && _sleepy && cardiac)];
	if(!_sleepy && !_bleeding && !_cardiac) then {
		//healthy, default icon
		diag_log "Healthy";
		_actionData set [2, _statusIcons select 0];
	}
	else {
		if(_sleepy && !_bleeding && !_cardiac) then {
			//only unconscious, use unconscious icon
			diag_log "Sleepy";
			_actionData set [2, _statusIcons select 1];
		}
		else {
			if(!_cardiac) then {
				//not only unconscious, but not in cardiac, must be bleeding
				diag_log "Bleeding";
				_actionData set [2, _statusIcons select 2];
			}
			else {
				//must be in cardiac, takes priority over bleeding
				diag_log "Cardiac Arrest";
				_actionData set [2, _statusIcons select 3];
			};
		};
	};
};

 //foreach player/npc in vehicle
{
	_unit = _x;
	//ignore drone pilot(s)
	if(_unit != _player && { getText (configFile >> "CfgVehicles" >> typeOf _unit >> "simulation") != "UAVPilot" }) then {
		//get unit name from ace common to display
		 _unitname = [_unit] call FUNC_ACE(common,getName);
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
				[_unit] call FUNC_ACE(medical_menu,openMenu);
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
		] call FUNC_ACE(interact_menu,createAction);
		//add built action to array
		_actions pushBack[_action, [], _unit];
	};
	//I think this basically functions as a continue, not really sure.
	false
}count crew _vehicle;

_actions