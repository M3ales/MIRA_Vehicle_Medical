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
 * Public: No
 */
params["_vehicle", "_player"];

diag_log format["Building actions for vehicle '%1'", _vehicle];

 _actions = [];

//cache commonly redefined static vars here instead of in foreach
 _roleIcons = [
	"",
	"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",
	"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",
	"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_commander_ca.paa"
];

//conditions to display the unit's action
_conditions = {
	params ["", "", "_parameters"];
	_parameters params ["_unit"];
	//display action if any are true
	if(_unit call MIRA_Vehicle_Medical_fnc_isBleeding || _unit call MIRA_Vehicle_Medical_fnc_isUnconscious || _unit call MIRA_Vehicle_Medical_fnc_isCardiacArrest) exitWith {true};
	false
};

//modify the icon to show the worst 'wound' type
_modifierFunc = {
	params ["_target", "_player", "_params", "_actionData"];
	_parameters params ["_unit"];
	
	_statusIcons = [
		"\MIRA_Vehicle_Medical\ui\unconscious_white.paa",
		"\MIRA_Vehicle_Medical\ui\bleeding_red.paa",
		"\MIRA_Vehicle_Medical\ui\cardiac_arrest_red.paa"
	];

	_bleeding = _unit call MIRA_Vehicle_Medical_fnc_isBleeding;
	_sleepy = _unit call MIRA_Vehicle_Medical_fnc_isUnconscious;
	_cardiac = _unit call MIRA_Vehicle_Medical_fnc_isCardiacArrest;
	// Modify the icon (3rd param)
	//Use ascending order of importance, cardiac > bleeding > unconscious
	if(_sleepy && !_bleeding && !_cardiac) exitWith {
		_actionData set [2, _statusIcons select 0];
	};
	if(_bleeding && !_cardiac) exitWith {
		_actionData set [2, _statusIcons select 1];
	};
	_actionData set [2, _statusIcons select 2];
};

 //foreach player/npc in vehicle
{
	_unit = _x;
	//ignore drone pilot(s)
	if(_unit != _player && { getText (configFile >> "CfgVehicles" >> typeOf _unit >> "simulation") != "UAVPilot" }) then {
		//get unit name from ace common to display
		 _unitname = [_unit] call ace_common_fnc_getName;
		diag_log format["Adding action for '%1' (%2)", _unit, _unitname];
		//get the icon, picks one based on crew role
		_icon = _roleIcons select (([driver _vehicle, gunner _vehicle, commander _vehicle] find _unit) + 1);
		//build the action, use additional params to have runOnHover = true
		_action = [
			format["%1", _unit],
			_unitname,
			_icon,
			{
				//erase self actions from cache for vehicle to make sure no duplicates and up to date
				[vehicle _target, "ace_interact_menu_ATCache_ACE_SelfActions"] call ace_common_fnc_eraseCache;
			},
			_conditions,
			{
				//when creating children, only create children of unit who is being hovered over, otherwise empty children
				//probably performance thing, unsure
				if(ace_interact_menu_selectedTarget isEqualTo _target) then {
					_this call MIRA_Vehicle_Medical_fnc_buildUnstableActions;
				}else {
					[]
				};
			},
			[_unit],
			{[0, 0, 0]},
			2,
			[false, false, false, true, false],
			_modifierFunc
		] call ace_interact_menu_fnc_createAction;
		//add built action to array
		_actions pushBack[_action, [], _unit];
	};
	//I think this basically functions as a continue, not really sure.
	false
}count crew _vehicle;

_actions