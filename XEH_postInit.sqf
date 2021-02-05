#include "functions\function_macros.hpp"

["ace_interact_menu_newControllableObject", {
    params ["_type"]; // string of the object's classname
	private _validTypes = [];

	if(GVAR(Vehicles_EnableHelicopter)) then {
		_validTypes pushBackUnique "Helicopter";
	};
	if(GVAR(Vehicles_EnableCar)) then {
		_validTypes pushBackUnique "Car";
	};
	if(GVAR(Vehicles_EnableTank)) then {
		_validTypes pushBackUnique "Tank";
	};
	if(GVAR(Vehicles_EnablePlane)) then {
		_validTypes pushBackUnique "Plane";
	};
	if(GVAR(Vehicles_EnableShip)) then {
		_validTypes pushBackUnique "Ship";
	};

    if (_validTypes findIf { _type isKindOf (_x) } == -1) exitWith {};    
    private _action = 
		[
			"MIRA_Medical",
			"Medical",
			"",
			{ if(true) exitWith{} },
			{ true },
			{[]},
			"",
			4,
			[false, false, false, false, true]
		] call ace_interact_menu_fnc_createAction;
    [_type, 1, ["ACE_SelfActions"], _action, false] call ace_interact_menu_fnc_addActionToClass;
	 _action = 
		[
			"MIRA_Stable",
			"Stable",
			"",
			{ /* Leave statement blank to make ace not show it unless there are visible child actions */ },
			{ GVAR(EnableStable) },
			{ _this call FUNC(buildStablePassengerActions) },
			{ [] },
			"",
			4,
			[false, false, false, false, true]
		] call ace_interact_menu_fnc_createAction;
    [_type, 1, ["ACE_SelfActions", "MIRA_Medical"], _action, false] call ace_interact_menu_fnc_addActionToClass;
	 _action = 
		[
			"MIRA_Unstable",
			"Unstable",
			"",
			{ /* Leave statement blank to make ace not show it unless there are visible child actions */ }, 
			{ GVAR(EnableUnstable) },
			{ _this call FUNC(buildUnstablePassengerActions) },
			{ [] },
			"",
			4,
			[false, false, false, false, true]
		] call ace_interact_menu_fnc_createAction;
    [_type, 1, ["ACE_SelfActions", "MIRA_Medical"], _action, false] call ace_interact_menu_fnc_addActionToClass;
	LOGF_1("Dynamically added interaction to %1", _type);
}] call CBA_fnc_addEventHandler;