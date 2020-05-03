/*
 * Escape script onBombCreated function
 * Triggered by bombCreated CBA event
 * By SzwedzikPL (https://github.com/SzwedzikPL/Arma3EscapeMissionScript)
 */

params ["_bombObject"];

// Hide bomb for searching units
if (player in ESCAPE_setting_searching_units) then {
  _bombObject hideObject true;
};

// Create action for escaping units
if (player in ESCAPE_setting_escaping_units) then {
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
  [_bombObject, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
};
