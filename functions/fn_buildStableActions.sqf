#include "function_macros.hpp"
params["_player", "_target", "_params"];
_params params["_unit"];

_actions = [];

_stitchWounds = _unit call FUNC(getStitchableWounds);
if (count _stitchWounds > 0) then {
	diag_log format["'%1' is has stitchable wounds", _unit];
	_action = ["MIRA_Stitch", format["Stitch (%1)", count _stitchWounds] , "\MIRA_Vehicle_Medical\ui\cardiac_arrest_red.paa", {
			params ["_player", "_target", "_parameters"];
			_parameters params ["_unit"];
			LOG(format["Unit is: %1 -- %2", _unit, _target]);
			[_unit] call ace_medical_menu_fnc_openMenu;
		}, {true}, {}, [_unit]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _unit];
};

if(_unit call FUNC(needsBandage)) then {
	_requiredBandages = 0;
	{
		_x params ["", "_bodyPartN", "_amountOf", "_bleeding"];
		if ({_amountOf * _bleeding > 0}) then {
			_requiredBandages += 1;
		};
	} forEach _unit call FUNC(getOpenWounds);
	diag_log format["'%1' is has stitchable wounds", _unit];
	_action = ["MIRA_Bandage", format["Open Wounds (%1)", _requiredBandages] , "\MIRA_Vehicle_Medical\ui\bleeding_red.paa", {
			params ["_player", "_target", "_parameters"];
			_parameters params ["_unit"];
			LOG(format["Unit is: %1 -- %2", _unit, _target]);
			[_unit] call ace_medical_menu_fnc_openMenu;
		}, {true}, {}, [_unit]] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _unit];
};

_actions