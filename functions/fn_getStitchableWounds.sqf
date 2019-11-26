//adapted from https://github.com/acemod/ACE3/blob/master/addons/medical_treatment/functions/fnc_getStitchableWounds.sqf
params ["_unit"]; 
_openWounds = [_unit] call mira_vehicle_medical_fnc_getOpenWounds;   
_bleedingWounds = [];  
{  
    _x params["", "_bodyPartN", "_amountOf", "_bleedingRate"];  
    if(_amountOf > 0 && _bleedingRate > 0) then {  
        _bleedingWounds pushBack _x;  
    };  
} forEach _openWounds;  
diag_log format["%1", _bleedingWounds];  
_bandagedWounds = _unit getVariable ["ace_medical_bandagedWounds",[]];  
_result = [];  
{  
    if(!(_x in _bleedingWounds)) then {  
        _result pushBack _x;  
    };  
} forEach _bandagedWounds; 
_result