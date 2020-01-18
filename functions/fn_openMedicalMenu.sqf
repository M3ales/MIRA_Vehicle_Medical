params[["_unit", player, [player]]];
if(isNil("ace_medical_gui_fnc_openMenu")) then {
	//open for old ace
	[_unit] call ace_medical_menu_fnc_openMenu;
}else {
	//open for new ace (wtf ace why change this name smh)
	[_unit] call ace_medical_gui_fnc_openMenu;
};