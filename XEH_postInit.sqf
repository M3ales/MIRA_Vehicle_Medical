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
			[LSTRING(Interaction,Medical)] call FUNC(cachedLocalisationCall),
			"",
			{ if(true) exitWith{} },
			{ GVAR(EnableAVM) }
		] call ace_interact_menu_fnc_createAction;
    [_type, 1, ["ACE_SelfActions"], _action, false] call ace_interact_menu_fnc_addActionToClass;
	_action = 
		[
			"MIRA_Stable",
			[LSTRING(Interaction,Stable)] call FUNC(cachedLocalisationCall),
			"",
			{ },
			{ GVAR(EnableStable) },
			{ [QUOTE(GVAR(StableCache)),_this, FUNC(buildStablePassengerActions)] call FUNC(cachedResult) }
		] call ace_interact_menu_fnc_createAction;
    [_type, 1, ["ACE_SelfActions", "MIRA_Medical"], _action, false] call ace_interact_menu_fnc_addActionToClass;
	_action = 
		[
			"MIRA_Unstable",
			[LSTRING(Interaction,Unstable)] call FUNC(cachedLocalisationCall),
			"",
			{ }, 
			{ GVAR(EnableUnstable) },
			{ [QUOTE(GVAR(UnstableCache)), _this, FUNC(buildUnstablePassengerActions)] call FUNC(cachedResult) }
		] call ace_interact_menu_fnc_createAction;
    [_type, 1, ["ACE_SelfActions", "MIRA_Medical"], _action, false] call ace_interact_menu_fnc_addActionToClass;
	_action = 
		[
			"MIRA_Incapacitated",
			[LSTRING(Interaction,Incapacitated)] call FUNC(cachedLocalisationCall),
			"",
			{ }, 
			{ GVAR(EnableIncapacitated) },
			{ [QUOTE(GVAR(IncapacitatedCache)), _this, FUNC(buildIncapacitatedPassengerActions)] call FUNC(cachedResult) }
		] call ace_interact_menu_fnc_createAction;
    [_type, 1, ["ACE_SelfActions", "MIRA_Medical"], _action, false] call ace_interact_menu_fnc_addActionToClass;
	LOGF_1("Dynamically added interaction to %1", _type);
}] call CBA_fnc_addEventHandler;