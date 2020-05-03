/*
 * Escape script handleUnitKilled function
 * Triggered by MPKilled BIS MP event handler
 * By SzwedzikPL (https://github.com/SzwedzikPL/Arma3EscapeMissionScript)
 */

params ["_unit"];

// Rest of code is server-side
if (!isServer) exitWith {};

// Ignore kills after game ended
if (missionNamespace getVariable ['ESCAPE_gameEnded', false]) exitWith {};

// Exit if unit was killed before (ignore second killed event from ACE3)
private _killedUnits = missionNamespace getVariable ['ESCAPE_killedUnits', []];
if (_unit in _killedUnits) exitWith {};

// Update killed units
_killedUnits pushBack _unit;
missionNamespace setVariable ['ESCAPE_killedUnits', _killedUnits];

// Check game state
call ESCAPE_fnc_checkGameState;

// Exit if game ended
if (missionNamespace getVariable ['ESCAPE_gameEnded', false]) exitWith {};

// Respawn bomb if unit had one
if (ESCAPE_setting_bomb_item in (itemsWithMagazines _unit)) then {
  _unit removeItem ESCAPE_setting_bomb_item;
  private _bombPos = _unit getPos [0.5, (getDir _unit) + 90];
  [_bombPos] call ESCAPE_fnc_createBomb;
};

// Determine unit team
private _unitTeam = "";
if (_unit in ESCAPE_setting_escaping_units) then {
 _unitTeam = "escape";
};
if (_unit in ESCAPE_setting_searching_units) then {
  _unitTeam = "search";
};

// Exit if unit is not on any team
if (_unitTeam == "") exitWith {};

// Send notification to all players
private _unitTeammatesLeftCount = _unitTeam call ESCAPE_fnc_getTeamUnitsLeftCount;
["ESCAPE_unitKilled", [_unitTeam, _unitTeammatesLeftCount]] call CBA_fnc_globalEvent;
