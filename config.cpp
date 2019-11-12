class CfgPatches {
	class MIRA_Vehicle_Medical
	{
		name = "ACE Vehicle Medical";
		author = "M3ales";
		url = "https://github.com/M3ales/MIRA_Vehicle_Medical";
		requiredAddons[] = {"ace_interact_menu", "ace_medical", "ace_medical_gui"};
		units[] = {};
		weapons[] = {};
	};
};

class CfgMods {
    dir = "@MIRA_Vehicle_Medical";
	name = "ACE Vehicle Medical";
	picture = "";
	logo = "";
	logoOver = "";
	tooltip = "Arma 3 Typhon";
	action = "https://github.com/M3ales/MIRA_Vehicle_Medical";
	overview = "Adds a medical menu accessible from self interact, while inside a vehicle - displays only priority patients who are unstable.";
}

class CfgFunctions {
	class MIRA_Vehicle_Medical {
        class VehicleMedical {
            tag = "MIRA_Vehicle_Medical";
            requiredAddons[] = {"ace_interact_menu",  "ace_medical", "ace_medical_gui"};
            file = "MIRA_Vehicle_Medical\functions";
            class buildPassengerActions {};
            class buildUnstableActions {};
            class isBleeding {};
            class isCardiacArrest {};
            class isUnconscious {};
        };
	};
};

class CfgVehicles {
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