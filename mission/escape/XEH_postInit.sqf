/*
 * Escape script postInit
 * By SzwedzikPL (https://github.com/SzwedzikPL/Arma3EscapeMissionScript)
 */

call compile preprocessFileLineNumbers "escape\settings.sqf";

// Remove not spawned units from units array
[{
  ESCAPE_setting_searching_units = ESCAPE_setting_searching_units select {!(isNil "_x") && alive _x};
  ESCAPE_setting_escaping_units = ESCAPE_setting_escaping_units select {!(isNil "_x") && alive _x};
}, [], 0.001] call CBA_fnc_waitAndExecute;

// Declare events
["ESCAPE_bombCreated", ESCAPE_fnc_onBombCreated] call CBA_fnc_addEventHandler;
["ESCAPE_pursuitStarted", ESCAPE_fnc_onPursuitStarted] call CBA_fnc_addEventHandler;
["ESCAPE_bombTaken", ESCAPE_fnc_onBombTaken] call CBA_fnc_addEventHandler;
["ESCAPE_bombPlanted", ESCAPE_fnc_onBombPlanted] call CBA_fnc_addEventHandler;
["ESCAPE_bombExploded", ESCAPE_fnc_onBombExploded] call CBA_fnc_addEventHandler;
["ESCAPE_unitKilled", ESCAPE_fnc_onUnitKilled] call CBA_fnc_addEventHandler;
["ESCAPE_unitEscaped", ESCAPE_fnc_onUnitEscaped] call CBA_fnc_addEventHandler;
["ESCAPE_gameEnd", ESCAPE_fnc_onGameEnd] call CBA_fnc_addEventHandler;

// Lock searching vehicles
2 call ESCAPE_fnc_lockSearchingVehicles;

// Create bomb position markers
if (player in ESCAPE_setting_escaping_units) then {
  private _markerNumber = 1;

  {
    private _marker = createMarkerLocal [format ["ESCAPE_bomb_pos_marker_%1", _markerNumber], getMarkerPos _x];
    _marker setMarkerShapeLocal "ICON";
    _marker setMarkerTypeLocal ESCAPE_setting_bomb_spawn_marker_type;
    _marker setMarkerColorLocal ESCAPE_setting_bomb_spawn_marker_color;
    _marker setMarkerTextLocal ESCAPE_setting_bomb_spawn_marker_text;
    _markerNumber = _markerNumber + 1;
  } forEach ESCAPE_setting_bomb_spawns;
};

[{
  systemChat "ESCAPE script by SzwedzikPL v1.1.0";
}, [], 0.5] call CBA_fnc_waitAndExecute;

// Rest of code is server-side only
if (!isServer) exitWith {};

{
  _x addMPEventHandler ["MPKilled", ESCAPE_fnc_handleUnitKilled];
} forEach allUnits;

0 spawn {
  // Wait for mission start
  sleep 0.1;

  // End game if escape team is empty
  if (("escape" call ESCAPE_fnc_getTeamUnitsLeftCount) == 0) exitWith {
    "Brak uciekinierów." call ESCAPE_fnc_endGame;
  };

  // End game if search team is empty
  if (("search" call ESCAPE_fnc_getTeamUnitsLeftCount) == 0) exitWith {
    "Brak poszukiwaczy." call ESCAPE_fnc_endGame;
  };

  // Setup escaping units
  private _spawnCenterPos = getMarkerPos (selectRandom ESCAPE_setting_escaping_spawns);
  private _dirDiff = floor (360 / (count ESCAPE_setting_escaping_units));
  private _dir = 0;
  {
    if (!(isNil "_x") && alive _x) then {
      private _unit = _x;
      private _unitPos = _spawnCenterPos getPos [ESCAPE_setting_escaping_spawn_radius, _dir];

      _unit setPosATL [_unitPos # 0, _unitPos # 1, 0];
      _unit setDir (_unit getDir _spawnCenterPos);

      _dir = _dir + _dirDiff;
    };
  } forEach ESCAPE_setting_escaping_units;

  // Setup escaping units supply box
  if (!isNull ESCAPE_setting_escaping_supply_box) then {
    ESCAPE_setting_escaping_supply_box setPosATL [_spawnCenterPos # 0, _spawnCenterPos # 1, 0];

    if (count ESCAPE_setting_escaping_supply_box_content_sets > 0) then {
      private _box = ESCAPE_setting_escaping_supply_box;
      private _set = selectRandom ESCAPE_setting_escaping_supply_box_content_sets;

      clearWeaponCargoGlobal _box;
      clearMagazineCargoGlobal _box;
      clearItemCargoGlobal _box;
      clearBackpackCargoGlobal _box;

      {
        _box addItemCargoGlobal [_x # 0, _x # 1];
      } forEach _set;
    }
  };

  // Create bomb
  private _bombPosition = getMarkerPos (selectRandom ESCAPE_setting_bomb_spawns);
  _bombPosition set [2, 0.05];
  [_bombPosition] call ESCAPE_fnc_createBomb;

  sleep 1;

  // Wait until pursuit should start
  waitUntil {
    sleep 0.5;
    ({(_x distance2D _spawnCenterPos) > ESCAPE_setting_escaping_spawn_distance_limit} count ESCAPE_setting_escaping_units) > 0
  };

  // Set game end time
  private _endtime = CBA_missionTime + (ESCAPE_setting_time_to_find_bomb * 60);
  missionNamespace setVariable ['ESCAPE_endTime', _endtime + 1, true];

  ["ESCAPE_pursuitStarted", [
    "escape" call ESCAPE_fnc_getTeamUnitsLeftCount,
    "search" call ESCAPE_fnc_getTeamUnitsLeftCount
  ]] call CBA_fnc_globalEvent;
};
