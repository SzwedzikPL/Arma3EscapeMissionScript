/*
 * Escape script onBombPlanted function
 * Triggered by bombPlanted CBA event
 * By SzwedzikPL (https://github.com/SzwedzikPL/Arma3EscapeMissionScript)
 */

params ["_target"];

// Rest of code is server-side
if (!isServer) exitWith {};

[{
  params ["_target"];

  private _mine = createMine ["ATMine", getPos _target, [], 0];
  _mine setPosATL (getPosATL _target);
  _mine setDamage 1;
  _target setDamage 1;

  private _escapeZone = selectRandom ESCAPE_setting_escaping_zones;

  private _circleSize = ESCAPE_setting_escaping_zone_searching_marker_size;
  private _minCircleDistance = ESCAPE_setting_escaping_zone_searching_marker_min_edge_distance;

  private _circlePos = _escapeZone getPos [random (_circleSize - _minCircleDistance), random 360];

  ["ESCAPE_bombExploded", [_escapeZone, _circlePos]] call CBA_fnc_globalEvent;
}, [_target], ESCAPE_setting_bomb_timer] call CBA_fnc_waitAndExecute;
