#define ADDON MIRA_Vehicle_Medical
#define ADDON_NAME Ace Vehicle Medical
#define FUNC(name) ADDON##_fnc_##name
#define ICON_PATH(name) ADDON##\ui\##name##.paa
#define QUOTE(target) #target
#define CONCAT(a,b) a##b
#define COMPILE_FILE(name) compile preprocessFileLineNumbers 'ADDON\##name##.sqf'
#define GVAR(name) ADDON##_##name
#define ARR_2(a,b) a, b
#define ARR_3(a,b,c) a, b, c
#define ARR_4(a,b,c,d) a, b, c, d
#define ARR_5(a,b,c,d,e) a, b, c, d, e