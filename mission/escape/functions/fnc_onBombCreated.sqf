params ["_bombObject"];

// Exit if player is not escaping unit
if (!(player in ESCAPE_setting_escaping_units)) exitWith {};

private _action = [
  "ESCAPE_takeBomb",
  "Weź bombę",
  "",
  ESCAPE_fnc_takeBomb,
  {true},
  {},
  _bombObject,
  [0,0,0],
  2
] call ace_interact_menu_fnc_createAction;
[_bombObject, 0, [], _action] call ace_interact_menu_fnc_addActionToObject;
