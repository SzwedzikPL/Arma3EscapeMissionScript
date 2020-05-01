call compile preprocessFileLineNumbers "escape\settings.sqf";

// Declare events
["ESCAPE_bombCreated", ESCAPE_fnc_onBombCreated] call CBA_fnc_addEventHandler;
["ESCAPE_pursuitStarted", ESCAPE_fnc_onPursuitStarted] call CBA_fnc_addEventHandler;
["ESCAPE_bombTaken", ESCAPE_fnc_onBombTaken] call CBA_fnc_addEventHandler;
["ESCAPE_bombPlanted", ESCAPE_fnc_onBombPlanted] call CBA_fnc_addEventHandler;
["ESCAPE_bombExplosion", ESCAPE_fnc_onBombExplosion] call CBA_fnc_addEventHandler;
["ESCAPE_unitKilled", ESCAPE_fnc_onUnitKilled] call CBA_fnc_addEventHandler;
["ESCAPE_unitEscaped", ESCAPE_fnc_onUnitEscaped] call CBA_fnc_addEventHandler;
["ESCAPE_missionEnd", ESCAPE_fnc_onMissionEnd] call CBA_fnc_addEventHandler;

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

if (hasInterface) then {
  player addEventHandler ["killed", {
    ["ESCAPE_unitKilled", _this] call CBA_fnc_globalEvent;
  }];
};

// Rest of code is server-side only
if (!isServer) exitWith {};

// Setup escaping units
private _spawnCenterPos = getMarkerPos selectRandom ESCAPE_setting_escaping_spawns;
private _dirDiff = floor (360 / (count ESCAPE_setting_escaping_units));
private _dir = 0;
{
  private _unit = _x;
  private _unitPos = _spawnCenterPos getPos [ESCAPE_setting_escaping_spawn_radius, _dir];
  _unitPos set [2, 0];

  _unit setPosATL _unitPos;
  _unit setDir (_unit getDir _spawnCenterPos);

  _dir = _dir + _dirDiff;
} forEach ESCAPE_setting_escaping_units;

// Setup escaping units supply box
if (!isNull ESCAPE_setting_escaping_supply_box) then {
  ESCAPE_setting_escaping_supply_box setPosATL [_spawnCenterPos # 0, _spawnCenterPos # 1, 0];
};

_spawnCenterPos spawn {
  private _spawnCenterPos = _this;
  private _unitCount = count ESCAPE_setting_escaping_units;
  private _area = [
    _spawnCenterPos,
    ESCAPE_setting_escaping_spawn_distance_limit,
    ESCAPE_setting_escaping_spawn_distance_limit
  ];

  // Wait for mission start
  sleep 0.5;

  // Create bomb
  private _bombPosition = getMarkerPos selectRandom ESCAPE_setting_bomb_spawns;
  _bombPosition set [2, 0.05];
  private _bombObject = ESCAPE_setting_bomb_class createVehicle _bombPosition;
  _bombObject setPosATL _bombPosition;

  ["ESCAPE_bombCreated", _bombObject] call CBA_fnc_globalEvent;

  // Wait until pursuit should start
  waitUntil {sleep 1; count (ESCAPE_setting_escaping_units inAreaArray _area) != _unitCount};

  ["ESCAPE_pursuitStarted"] call CBA_fnc_globalEvent;
};
