#include "function_macros.hpp"
params["_unit"];
_needBandage = false;
_wounds = _unit call MIRA_Vehicle_medical_fnc_getOpenWounds;
{ 
    _x params ["", "_bodyPartN", "_amountOf", "_bleeding"]; 
    if ((_amountOf * _bleeding) > 0) exitWith { 
        _needBandage = true;
    }; 
    false     
}forEach _wounds;
_needBandage