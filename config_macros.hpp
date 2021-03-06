#define ADDON MIRA_Vehicle_Medical
#define ADDON_NAME Ace Vehicle Medical
#define FUNC(name) ADDON##_fnc_##name
#define ICON_PATH(name) ADDON##\ui\##name##.paa
#define QUOTE(target) #target
#define CONCAT(a,b) a##b
#define COMPILE_FILE(name) compileFinal preprocessFileLineNumbers 'ADDON\##name##.sqf'
#define GVAR(name) ADDON##_##name
#define ARR_2(a,b) a, b
#define ARR_3(a,b,c) a, b, c
#define ARR_4(a,b,c,d) a, b, c, d
#define ARR_5(a,b,c,d,e) a, b, c, d, e
#define LSTR(module,name) CONCAT(STR_MIRA_AVM_,CONCAT(module,CONCAT(_,name)))
#define LSTRING(module,name) QUOTE(LSTR(module,name))
#define CSTRING(module,name) QUOTE(CONCAT($,LSTR(module,name)))