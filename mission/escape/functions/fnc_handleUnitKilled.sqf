/*
 * Escape script handleUnitKilled function
 * Triggered by MPKilled BIS MP event handler
 * By SzwedzikPL (https://github.com/SzwedzikPL/Arma3EscapeMissionScript)
 */

params ["_unit", "_killer", "_instigator"];

// Rest of code is server-side
if (!isServer) exitWith {};

// Ignore kills after game ended
if (missionNamespace getVariable ['ESCAPE_gameEnded', false]) exitWith {};

private _killedUnits = missionNamespace getVariable ['ESCAPE_killedUnits', []];
if (_unit in _killedUnits) exitWith {};

_killedUnits pushBack _unit;
missionNamespace setVariable ['ESCAPE_killedUnits', _killedUnits];

// Get game state
private _escapedUnits = missionNamespace getVariable ['ESCAPE_escapedUnits', []];
private _escapingUnitsLeft = count (ESCAPE_setting_escaping_units select {alive _x && !(_x in _escapedUnits)});
private _searchingUnitsLeft = count (ESCAPE_setting_searching_units select {alive _x});

// Check if game should be ended
if (_escapingUnitsLeft <= 0) exitWith {
  private _reason = '';

  if (count _escapedUnits > 0) then {
    private _reasonText = ['%1 uciekinierów uciekło.', 'Jeden uciekinier uciekł.'] select ((count _escapedUnits) == 1);
    _reason = format [_reasonText, count _escapedUnits];
  } else {
    _reason = "Wszyscy uciekinierzy zgineli.";
  };

  _reason call ESCAPE_fnc_endGame;
};

if (_searchingUnitsLeft <= 0) exitWith {
  "Wszyscy poszukiwacze zgineli." call ESCAPE_fnc_endGame;
};

// Trigger event for players
private _unitTeam = '';
private _unitTeammatesLeftCount = 0;

if (_unit in ESCAPE_setting_escaping_units) then {
 _unitTeam = 'escape';
 _unitTeammatesLeftCount = _escapingUnitsLeft;
};
if (_unit in ESCAPE_setting_searching_units) then {
  _unitTeam = 'search';
  _unitTeammatesLeftCount = _searchingUnitsLeft;
};

["ESCAPE_unitKilled", [_unitTeam, _unitTeammatesLeftCount]] call CBA_fnc_globalEvent;
