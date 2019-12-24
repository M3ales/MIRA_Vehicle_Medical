#include "config_macros.hpp"

class CfgPatches {
	class ADDON
	{
		name = QUOTE(ADDON_NAME);
		author = "M3ales";
		url = "https://github.com/M3ales/MIRA_Vehicle_Medical";
		requiredAddons[] = {"ace_interact_menu", "ace_medical", "cba_settings"};
		units[] = {};
		weapons[] = {};
	};
};

class Extended_PreInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_preInit));
    };
};

#include "CfgVehicles.hpp"