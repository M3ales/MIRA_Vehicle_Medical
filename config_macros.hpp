#define ADDON MIRA_Vehicle_Medical
#define ADDON_NAME Ace Vehicle Medical
#define FUNC(name) ADDON##_fnc_##name
#define ICON_PATH(name) ADDON##\ui\##name##.paa
#define QUOTE(target) #target
#define CONCAT(a,b) a##b
#define COMPILE_FILE(name) compile preprocessFileLineNumbers 'ADDON\##name##.sqf'