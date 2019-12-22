#define MEDICAL_BASE(addition) class MIRA_Medical {\
                displayName = "Medical";\
                condition = "alive _target";\
                statement = "if(true)exitWith{}";\
                ##addition##\
                class MIRA_Stable {\
                    displayName = "Stable";\
                    insertChildren = QUOTE(_this call FUNC(buildStablePassengerActions));\
                };\
                class MIRA_Unstable {\
                    displayName = "Unstable";\
                    insertChildren = QUOTE(_this call FUNC(buildUnstablePassengerActions));\
                };\
            };
class CfgVehicles {
    class Air;
    class Helicopter: Air {
        class ACE_SelfActions {
            MEDICAL_BASE( )
        };
    };
    class Plane: Air {
        class ACE_SelfActions {
            MEDICAL_BASE( )
        };
    };
    class LandVehicle;
    class Car: LandVehicle {
        class ACE_SelfActions {
            MEDICAL_BASE(exceptions[] = {"isNotSwimming"};)
        };
    };
    class Tank: LandVehicle {
            MEDICAL_BASE(exceptions[] = {"isNotSwimming"};)
    };
    class Ship;
    class Ship_F: Ship {
        class ACE_SelfActions {
            MEDICAL_BASE(exceptions[] = {"isNotSwimming"};)
        };
    };
};