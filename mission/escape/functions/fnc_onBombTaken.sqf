params ["_target"];

if (!hasInterface) exitWith {};
["ESCAPE_warning", [ESCAPE_setting_bomb_taken_notification_text]] call BIS_fnc_showNotification;

// Exit if player is not escaping unit
if (!(player in ESCAPE_setting_escaping_units)) exitWith {};

private _marker = createMarkerLocal ["ESCAPE_bomb_target_marker", getPos _target];
_marker setMarkerShapeLocal "ICON";
_marker setMarkerTypeLocal ESCAPE_setting_bomb_target_marker_type;
_marker setMarkerColorLocal ESCAPE_setting_bomb_target_marker_color;
_marker setMarkerTextLocal ESCAPE_setting_bomb_target_marker_text;

private _action = [
  "ESCAPE_plantBomb",
  "Podłóż bombę",
  "",
  ESCAPE_fnc_plantBomb,
  {true},
  {},
  _target,
  [0,0,0],
  3
] call ace_interact_menu_fnc_createAction;
[_target, 0, [], _action] call ace_interact_menu_fnc_addActionToObject;
