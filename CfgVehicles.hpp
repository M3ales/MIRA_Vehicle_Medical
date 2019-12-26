#define STABLE_UNSTABLE_BASE \
                class MIRA_Stable {\
                    displayName = "Stable";\
                    condition = QUOTE(GVAR(EnableStable));\
                    insertChildren = QUOTE(_this call FUNC(buildStablePassengerActions));\
                };\
                class MIRA_Unstable {\
                    displayName = "Unstable";\
                    condition = QUOTE(GVAR(EnableUnstable));\
                    insertChildren = QUOTE(_this call FUNC(buildUnstablePassengerActions));\
                };
class CfgVehicles {
    class Air;
    class Helicopter: Air {
        class ACE_SelfActions {
            class MIRA_Medical {
                displayName = "Medical";
                condition = QUOTE(alive _target && GVAR(EnableAVM) && GVAR(Vehicles_EnableHelicopter));
                statement = "if(true)exitWith{}";
                STABLE_UNSTABLE_BASE
            };
        };
    };
    class Plane: Air {
        class ACE_SelfActions {
            class MIRA_Medical {
                displayName = "Medical";
                condition = QUOTE(alive _target && GVAR(EnableAVM)&& GVAR(Vehicles_EnablePlane));
                statement = "if(true)exitWith{}";
                STABLE_UNSTABLE_BASE
            };
        };
    };
    class LandVehicle;
    class Car: LandVehicle {
        class ACE_SelfActions {
                class MIRA_Medical {
                displayName = "Medical";
                condition = QUOTE(alive _target && GVAR(EnableAVM) && GVAR(Vehicles_EnableCar));
                statement = "if(true)exitWith{}";
                exceptions[] = {"isNotSwimming"};
                STABLE_UNSTABLE_BASE
            };
        };
    };
    class Tank: LandVehicle {
            class MIRA_Medical {
                displayName = "Medical";
                condition = QUOTE(alive _target && GVAR(EnableAVM)&& GVAR(Vehicles_EnableTank));
                statement = "if(true)exitWith{}";
                exceptions[] = {"isNotSwimming"};
                STABLE_UNSTABLE_BASE
            };
    };
    class Ship;
    class Ship_F: Ship {
        class ACE_SelfActions {
            class MIRA_Medical {
                displayName = "Medical";
                condition = QUOTE(alive _target && GVAR(EnableAVM) && GVAR(Vehicles_EnableShip));
                statement = "if(true)exitWith{}";
                exceptions[] = {"isNotSwimming"};
                STABLE_UNSTABLE_BASE
            };
        };
    };
};