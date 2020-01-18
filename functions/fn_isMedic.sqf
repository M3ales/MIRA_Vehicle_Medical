params[["_unit", player, [player]]];
if(GVAR(medical_rewrite)) exitWith {
	//new ace
	_unit call ace_medical_treatment_fnc_isMedic;
};
//old ace
_unit call ace_medical_fnc_isMedic;