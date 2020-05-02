/*
 * Escape script onBombTaken function
 * Triggered by bombTaken CBA event
 * By SzwedzikPL (https://github.com/SzwedzikPL/Arma3EscapeMissionScript)
 */

params ["_target", "_markerText"];

if (!hasInterface) exitWith {};
["ESCAPE_warning", [ESCAPE_setting_bomb_taken_notification_text]] call BIS_fnc_showNotification;

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
