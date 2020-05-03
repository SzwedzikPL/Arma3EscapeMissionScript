/*
 * Escape script onBombPlanted function
 * Triggered by bombPlanted CBA event
 * By SzwedzikPL (https://github.com/SzwedzikPL/Arma3EscapeMissionScript)
 */

// Rest of code is server-side
if (!isServer) exitWith {};

// Update server endTime to not end game after bomb is planted but before explosion
missionNamespace setVariable ['ESCAPE_endTime', (CBA_missionTime + ESCAPE_setting_bomb_timer + 5)];

[{
  params ["_target"];

  // Detonate bomb
  private _mine = createMine ["ATMine", getPos _target, [], 0];
  _mine setPosATL (getPosATL _target);
  _mine setDamage 1;
  _target setDamage 1;

  // Exit if mission already ended
  if (missionNamespace getVariable ['ESCAPE_gameEnded', false]) exitWith {};

  // Update end time
  private _endtime = CBA_missionTime + (ESCAPE_setting_time_to_escape * 60);
  missionNamespace setVariable ['ESCAPE_endTime', _endtime + 1, true];

  // Determine escape zone and search marker position
  private _escapeZone = selectRandom ESCAPE_setting_escaping_zones;
  private _circleSize = ESCAPE_setting_escaping_zone_searching_marker_size;
  private _minCircleDistance = ESCAPE_setting_escaping_zone_searching_marker_min_edge_distance;
  private _circlePos = _escapeZone getPos [random (_circleSize - _minCircleDistance), random 360];

  // Send data to all players
  ["ESCAPE_bombExploded", [_escapeZone, _circlePos]] call CBA_fnc_globalEvent;
}, _this, ESCAPE_setting_bomb_timer] call CBA_fnc_waitAndExecute;
