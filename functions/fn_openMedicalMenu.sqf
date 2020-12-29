#include "function_macros.hpp"
params[["_unit", player, [player]], ["_legacyAce",false,[false]]];
/*if(!GVAR(medical_rewrite)) exitWith {
	//open for old ace
	[_unit] call ace_medical_menu_fnc_openMenu;
};*/
//open for new ace

if(_legacyAce) exitWith {
	
}
[_unit] call ace_medical_gui_fnc_openMenu;