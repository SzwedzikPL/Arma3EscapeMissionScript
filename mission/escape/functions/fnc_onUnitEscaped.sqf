/*
 * Escape script onUnitEscaped function
 * Triggered by unitEscaped CBA event
 * By SzwedzikPL (https://github.com/SzwedzikPL/Arma3EscapeMissionScript)
 */

params ["_unit", "_unitsLeftCount"];

if (!hasInterface) exitWith {};

if (player == _unit) then {
  hint parseText "<t size='1.5'>Gratulacje!<br/><br/>Udało Ci się bezpiecznie uciec.</t>";
};

// Exit if game already ended
if (missionNamespace getVariable ['ESCAPE_gameEnded', false]) exitWith {};

private _leftInfo = format ["Pozotało %1.", _unitsLeftCount];

if (_unitsLeftCount == 1) then {
  _leftInfo = "Pozostał ostatni.";
};

["ESCAPE_warning", [
  format ["Uciekinierowi udało się uciec. %1", _leftInfo]
]] call BIS_fnc_showNotification;
