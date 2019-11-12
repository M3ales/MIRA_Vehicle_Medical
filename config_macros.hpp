#define ADDON MIRA_Vehicle_Medical
#define ADDON_NAME Ace Vehicle Medical
#define FUNC(name) ADDON##_fnc_##name
#define FUNC_ACE(module,name) ace_##module##_fnc_##name
#define QUOTE(target) #target
#define CONCAT(a,b) a##b