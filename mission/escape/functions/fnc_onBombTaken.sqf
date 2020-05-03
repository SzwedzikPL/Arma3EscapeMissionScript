/*
 * Escape script onBombTaken function
 * Triggered by bombTaken CBA event
 * By SzwedzikPL (https://github.com/SzwedzikPL/Arma3EscapeMissionScript)
 */

params ["_target", "_markerText"];

if (isServer) then {
  // Update end time
  private _endtime = CBA_missionTime + (ESCAPE_setting_time_to_plant_bomb * 60);
  missionNamespace setVariable ['ESCAPE_endTime', _endtime + 1, true];
};

if (!hasInterface) exitWith {};

// Show notification
private _minutesForm = ESCAPE_setting_time_to_plant_bomb call ESCAPE_fnc_getMinutesForm;
["ESCAPE_warning", [
  format ["Uciekinierzy znaleźli bombę! Mają %1 %2 żeby ją podłożyć.", ESCAPE_setting_time_to_plant_bomb, _minutesForm]
]] call BIS_fnc_showNotification;

// Exit if player is not escaping unit
if (!(player in ESCAPE_setting_escaping_units)) exitWith {};

private _marker = createMarkerLocal ["ESCAPE_bomb_target_marker", getPos _target];
_marker setMarkerShapeLocal "ICON";
_marker setMarkerTypeLocal ESCAPE_setting_bomb_target_marker_type;
_marker setMarkerColorLocal ESCAPE_setting_bomb_target_marker_color;
_marker setMarkerTextLocal _markerText;

private _action = [
  "ESCAPE_plantBomb",
  "Podłóż bombę",
  "",
  ESCAPE_fnc_plantBomb,
  {
    params ["_target"];
    !(_target getVariable ["ESCAPE_bombPlanted", false]) && (ESCAPE_setting_bomb_item in (itemsWithMagazines player))
  },
  {},
  [],
  [0,0,0],
  ESCAPE_setting_bomb_plant_actionable_distance
] call ace_interact_menu_fnc_createAction;
[_target, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
