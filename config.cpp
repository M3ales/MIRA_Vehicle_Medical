#include "config_macros.hpp"

class CfgPatches {
	class ADDON
	{
		name = QUOTE(ADDON_NAME);
		author = "M3ales";
		url = "https://github.com/M3ales/MIRA_Vehicle_Medical";
		requiredAddons[] = {"ace_interact_menu", "ace_medical"};
		units[] = {};
		weapons[] = {};
	};
};

class CfgMods {
    dir = QUOTE(CONCAT(@,ADDON));
	name = QUOTE(ADDON_NAME);
	picture = "";
	logo = "";
	logoOver = "";
	tooltip = "";
	action = "https://github.com/M3ales/MIRA_Vehicle_Medical";
	overview = "Adds a medical menu accessible from self interact, while inside a vehicle - displays only priority patients who are unstable.";
}

class Extended_PreInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_preInit));
    };
}; 

#include "CfgVehicles.hpp"