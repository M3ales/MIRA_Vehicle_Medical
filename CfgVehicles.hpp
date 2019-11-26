class CfgVehicles {
    class Air;
    class Helicopter: Air {
        class ACE_SelfActions {
            class MIRA_Medical {
                displayName = "Medical";
                condition = "alive _target";
                statement = "";
                class MIRA_Stable {
                    displayName = "Stable";
                    insertChildren = QUOTE(_this call FUNC(buildStablePassengerActions));
                };
                class MIRA_Unstable {
                    displayName = "Unstable";
                    insertChildren = QUOTE(_this call FUNC(buildUnstablePassengerActions));
                };
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
                class MIRA_Stable {
                    displayName = "Stable";
                    insertChildren = QUOTE(_this call FUNC(buildStablePassengerActions));
                };
                class MIRA_Unstable {
                    displayName = "Unstable";
                    insertChildren = QUOTE(_this call FUNC(buildUnstablePassengerActions));
                };
            };
        };
    };
};