/*
 * Escape script getTeamUnitsLeftCount function
 * Returns count of units from given team that not died or escaped yet
 * By SzwedzikPL (https://github.com/SzwedzikPL/Arma3EscapeMissionScript)
 */

params ["_team"];

private _killedUnits = missionNamespace getVariable ['ESCAPE_killedUnits', []];

if (_team == "escape") exitWith {
  private _escapedUnits = missionNamespace getVariable ['ESCAPE_escapedUnits', []];
  {
    !(isNil "_x") && (alive _x) && !(_x in _killedUnits) && !(_x in _escapedUnits)
  } count ESCAPE_setting_escaping_units
};

if (_team == "search") exitWith {
  {
    !(isNil "_x") && (alive _x) && !(_x in _killedUnits)
  } count ESCAPE_setting_searching_units
};

0
