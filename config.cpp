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
	class MIRA_Vehicle_Medical{
        class VehicleMedical{
            tag = "MIRA_Vehicle_Medical";
            requiredAddons[]={};
            file="MIRA_Vehicle_Medical\functions";
            class buildPassengerActions{};
            class buildUnstableActions{};
            class isBleeding{};
            class isCardiacArrest{};
            class isUnconscious{};
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
                insertChildren = "_this call MIRA_Vehicle_Medical_fnc_buildPassengerActions";
            };
        };
    };
};