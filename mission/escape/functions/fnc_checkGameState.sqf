/*
 * Escape script checkGameState function
 * Checks game state and ends it if conditions are met
 * By SzwedzikPL (https://github.com/SzwedzikPL/Arma3EscapeMissionScript)
 */

if (!isServer || missionNamespace getVariable ['ESCAPE_gameEnded', false]) exitWith {};

// Get game state
private _escapedUnits = missionNamespace getVariable ['ESCAPE_escapedUnits', []];
private _escapingUnitsLeft = "escape" call ESCAPE_fnc_getTeamUnitsLeftCount;
private _searchingUnitsLeft = "search" call ESCAPE_fnc_getTeamUnitsLeftCount;

// Check if there are no escaping units left
if (_escapingUnitsLeft <= 0) exitWith {
  private _reason = '';

  if ((count _escapedUnits) > 0) then {
    if ((count _escapedUnits) == (count ESCAPE_setting_escaping_units)) exitWith {
      _reason = 'Wszyscy uciekinierzy uciekli.';
    };

    private _reasonText = ['%1 uciekinierów uciekło.', 'Jeden uciekinier uciekł.'] select ((count _escapedUnits) == 1);
    _reason = format [_reasonText, count _escapedUnits];
  } else {
    _reason = "Wszyscy uciekinierzy zgineli.";
  };

  _reason call ESCAPE_fnc_endGame;
};

// Check if there are no searching units left
if (_searchingUnitsLeft <= 0) exitWith {
  "Wszyscy poszukiwacze zgineli." call ESCAPE_fnc_endGame;
};
