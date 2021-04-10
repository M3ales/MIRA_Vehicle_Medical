#include "function_macros.hpp"

params["_vehicle", "_player"];

if!(alive _vehicle) exitWith { 
	LOGF_1("%1 not alive, exiting.", _vehicle);
	[]
};

_modifierFunc = {
	params ["_target", "_player", "_parameters", "_actionData"];
	_parameters params ["_patient"];
	
};

private _actions = [];

private _action = ["MIRA_UnloadAll", 
	[LSTRING(Incapacitated,Unload)] call FUNC(cachedLocalisationCall), 
	QUOTE(ICON_PATH(bandage)), 
	{
		params ["_target", "_player", "_parameters"];
		_parameters params ["_vehicle"];
		[_vehicle, _player, {
			params["_patient"]; 
			_patient != player && ([_patient] call FUNC(isUnconscious) || !(alive _patient))
		}] call FUNC(unloadAllWithCondition);
	},
	{true},
	{},
	[_vehicle]
] call ace_interact_menu_fnc_createAction;

_actions pushBack [_action, [], player];

 //foreach player/npc in vehicle
{
	private _unit = _x;
	//ignore drone pilot(s)
	if(getText (configFile >> "CfgVehicles" >> typeOf _unit >> "simulation") != "UAVPilot") then {
		//get unit name from ace common to display
		private _unitName = [_unit] call ace_common_fnc_getName;
		//icon is blank, defined by modififer func
		private _icon = "";

		private _conditions = {
			params["_target", "_player", "_parameters"];

			_parameters params [
				"_patient"
			];

			!(alive _patient) || _patient call FUNC(isUnconscious)
		};

		private _action = [
			format["%1", _unit],
			_unitName,
			_icon,
			{
				params ["", "", "_parameters"];
				_parameters params ["_unit"];
				[_unit] call FUNC(openMedicalMenu);
			},
			_conditions,
			{
				params["_target", "_player", "_parameters"];
				
				_parameters params [
					"_patient"
				];
				//when creating children, only create children of unit who is being hovered over, otherwise empty children
				//probably performance thing, unsure
				if(ace_interact_menu_selectedTarget isEqualTo _target) then {
					private _subActions = [];
					private _isMedic = _player call FUNC(isMedic);

					if([_patient] call FUNC(isUnconscious) || !alive _patient) then {
						private _action = ["MIRA_Unload", [LSTRING(Incapacitated,Unload)] call FUNC(cachedLocalisationCall), QUOTE(ICON_PATH(bandage)), {
								params ["_target", "_player", "_parameters"];
								_parameters params ["_patient"];
								[_patient, _player] call FUNC(unloadPatient);
							}, {true}, {}, [_patient]] call ace_interact_menu_fnc_createAction;
						_subActions pushBack [_action, [], _patient];
					};

					_subActions
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