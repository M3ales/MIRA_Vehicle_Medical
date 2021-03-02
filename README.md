# ACE Vehicle Medical 2.0.0

## Features
- Dynamically adds itself to anything inheriting from: `Car, Tank, Helicopter, Ship, Plane`, using `ace_interact_menu_newControllableObject` for performance.
- Provides a main interact while inside vehicle, which splits into two subcategories.
   - Stable
   - Unstable
- Filters by severity, with rapidly degrading status effects being listed in Unstable, and more minor afflictions placing the unit under Stable.
- Tracks deceased members inside a vehicle to easily see if you're working on someone who has passed on.
- Icons to more easily identify a situation and triage patients quickly - get to those who need it most.
- Easily access the Ace Medical Menu by selecting either the patient's name, or one of their afflictions.

### Stable
This category is for most non varying conditions such as: 
- Bandaging required on a tourinquetted limb.
- Stitching of bandaged wounds.
- Low Blood Pressure or Heart Rate (Although not yet in cardiac arrest).
- Arm Fractures.

### Unstable
This is for conditions which may quickly lead to the patient dying, or significantly reduce their effectiveness.
- Cardiac Arrest
- Unconscious
- Bleeding
- Leg Fractures

### Configurability
CBA Settings are provided and can be accessed under Configure Addons -> ACE Vehicle Medical.
- Enable/Disable tracking of most states.
- Apply your own thresholds for 'low' heartrate/blood pressure. (Medics only)
- Enable/Disable dead people being listed as unstable.
- Enable/Disable warning popups for viewing dead members.

## Translations
- English | [m3ales](https://github.com/M3ales)

I am accepting translation PRs.
