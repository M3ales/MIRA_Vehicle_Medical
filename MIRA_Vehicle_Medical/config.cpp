class CfgPatches
{
	class MIRA_Vehicle_Medical
	{
		name = "ACE Vehicle Medical";
		author = "M3ales";
		url = "https://github.com/M3ales/MIRA_mods";
		requiredAddons[] = {};
		units[] = {};
		weapons[] = {};
	};
};

class CfgFunctions
{
	class MIRA{
        class VehicleMedical{
            tag = "MIRA";
            requiredAddons[]={};
            file="MIRA_Vehicle_Medical\functions";
            class buildPassengerActions{};
            class buildUnstableActions{};
        };
	};
};

class CfgVehicles
{
    class Air;
    class Helicopter: Air {
        class ACE_SelfActions {
            class MIRA_Medical {
                displayName = "Medical";
                condition = "alive _target";
                statement = "";
                insertChildren = "_this call MIRA_fnc_buildPassengerActions";
            };
        };
    };
};