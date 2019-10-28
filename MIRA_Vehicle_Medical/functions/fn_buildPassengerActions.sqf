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

private _actions = [];
{
	private _unit = _x;
	if(_unit != _player && { getText (configFile >> "CfgVehicles" >> typeOf _unit >> "simulation") != "UAVPilot" }) then {
		private _unitname = [_unit] call ace_common_fnc_getName;
		diag_log format["Adding action for '%1'", _unitname];
		private _icon = [
			"",
			"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",
			"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",
			"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_commander_ca.paa"
		] select (([driver _vehicle, gunner _vehicle, commander _vehicle] find _unit) + 1);
		private _conditions = {
			params ["", "", "_parameters"];
			_parameters params ["_unit"];
			private _bleeding = [_unit] call ace_medical_blood_fnc_isBleeding;
			private _uncon = _unit getVariable ["ACE_isUnconscious", false];
			private _cardiacArrest = _unit getVariable ["ace_medical_inCardiacArrest", false];
			if(_bleeding || _uncon || _cardiacArrest) exitWith {true};
			false
		};
		private _action = [
			format["%1", _unit],
			_unitname,
			_icon,
			{
				[vehicle _target, "ace_interact_menu_ATCache_ACE_SelfActions"] call ace_common_fnc_eraseCache;
			},
			_conditions,
			{
				if(ace_interact_menu_selectedTarget isEqualTo _target) then {
					_this call MIRA_fnc_buildUnstableActions;
				}else {
					[]
				};
			},
			[_unit],
			{[0, 0, 0]},
			2,
			[false, false, false, true, false]
		] call ace_interact_menu_fnc_createAction;
		_actions pushBack[_action, [], _unit];
	};
	false
}count crew _vehicle;

_actions