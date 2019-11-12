class CfgVehicles {
    class Air;
    class Helicopter: Air {
        class ACE_SelfActions {
            class MIRA_Medical {
                displayName = "Medical";
                condition = "alive _target";
                statement = "";
                insertChildren = QUOTE(_this call FUNC(buildPassengerActions));
            };
        };
    };
    class Car_F;
    class Wheeled_APC_F : Car_F {
        class ACE_SelfActions {
            class MIRA_Medical {
                displayName = "Medical";
                condition = "alive _target";
                statement = "";
                insertChildren = QUOTE(_this call FUNC(buildPassengerActions));
            };
        };
    };
};