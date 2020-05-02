/*
 * Escape script onUnitKilled function
 * Triggered by unitKilled CBA event
 * By SzwedzikPL (https://github.com/SzwedzikPL/Arma3EscapeMissionScript)
 */

if (!hasInterface) exitWith {};

_this spawn {
  params ["_unitTeam", "_unitTeammatesLeftCount"];
  sleep 1;
  if (missionNamespace getVariable ['ESCAPE_gameEnded', false]) exitWith {};
  private _leftInfo = format ["Pozotało %1.", _unitTeammatesLeftCount];

  if (_unitTeammatesLeftCount == 1) then {
    _leftInfo = "Pozostał ostatni.";
  };

  if (_unitTeam == 'escape') exitWith {
    ["ESCAPE_warning", [
      format ["Uciekinier został zabity. %1", _leftInfo]
    ]] call BIS_fnc_showNotification;
  };

  if (_unitTeam == 'search') exitWith {
    ["ESCAPE_warning", [
      format ["Poszukiwacz został zabity. %1", _leftInfo]
    ]] call BIS_fnc_showNotification;
  };
};
