#include "function_macros.hpp"
params[["_unit", player, [player]]];
if(GVAR(medical_rewrite)) exitWith {
	//open for new ace
	[_unit] call ace_medical_gui_fnc_openMenu;
};
//open for old ace
[_unit] call ace_medical_menu_fnc_openMenu;