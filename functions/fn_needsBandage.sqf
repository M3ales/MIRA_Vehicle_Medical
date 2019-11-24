params["_unit"];

private _needsBandage = false;

{
    _x params ["", "_bodyPartN", "_amountOf", "_bleeding"];
    if ({_amountOf * _bleeding > 0}) exitWith {
        _needsBandage = true;
    };
} forEach _unit call FUNC(getOpenWounds);

_needsBandage