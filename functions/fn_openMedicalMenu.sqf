#include "function_macros.hpp"

params[
	"_patient"
];


if(GVAR(legacyAce)) exitWith {
	[_patient] call ace_medical_menu_fnc_openMenu;
};

[_patient] call ace_medical_gui_fnc_openMenu;