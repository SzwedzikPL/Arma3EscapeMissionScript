/*
 * Escape script onBombExploded function
 * Triggered by bombExploded CBA event
 * By SzwedzikPL (https://github.com/SzwedzikPL/Arma3EscapeMissionScript)
 */

params ["_escapeZone", "_escapeZoneCirclePos"];

private _minutesForm = ESCAPE_setting_time_to_escape call ESCAPE_fnc_getMinutesForm;

// Create escape zone marker & show proper notification for escaping units
if (player in ESCAPE_setting_escaping_units) then {
  private _marker = createMarkerLocal ["ESCAPE_escape_zone_marker", getPos _escapeZone];
  _marker setMarkerShapeLocal "ICON";
  _marker setMarkerTypeLocal ESCAPE_setting_escaping_zone_marker_type;
  _marker setMarkerColorLocal ESCAPE_setting_escaping_zone_marker_color;
  _marker setMarkerTextLocal ESCAPE_setting_escaping_zone_marker_text;

  ["ESCAPE_warning", [
    format [
      "Cel został zniszczony. Oznaczono miejsce ewakuacji. Macie %1 %2.",
      ESCAPE_setting_time_to_escape,
      _minutesForm
    ]
  ]] call BIS_fnc_showNotification;
};

// Create escape zone marker & show proper notification for searching units
if (player in ESCAPE_setting_searching_units) then {
  private _markerSize = ESCAPE_setting_escaping_zone_searching_marker_size;
  private _marker = createMarkerLocal ["ESCAPE_escape_zone_searching_marker", _escapeZoneCirclePos];
  _marker setMarkerShapeLocal "ELLIPSE";
  _marker setMarkerSizeLocal [_markerSize, _markerSize];
  _marker setMarkerBrushLocal ESCAPE_setting_escaping_zone_searching_marker_brush;
  _marker setMarkerColorLocal ESCAPE_setting_escaping_zone_searching_marker_color;
  _marker setMarkerAlphaLocal ESCAPE_setting_escaping_zone_searching_marker_alpha;

  ["ESCAPE_warning", [
    format [
      "Cel uciekinierów zniszczony. Mają %1 %2 na ewakuację.",
      ESCAPE_setting_time_to_escape,
      _minutesForm
    ]
  ]] call BIS_fnc_showNotification;

  hintSilent parseText "<t size='1.2'>Uwaga<br/>Na mapie oznaczono strefę w której znajduje się punkt ewakuacji uciekinierów.</t>";
};

// Rest of code is server side
if (!isServer) exitWith {};

// Handle escaping units and game ending
_escapeZone spawn {
  params ["_escapeZone"];

  private _escapedUnits = [];
  private _escapingUnitsInZone = [];
  private _escapingUnitsLeft = 0;

  while {!(missionNamespace getVariable ['ESCAPE_gameEnded', false])} do {
    waitUntil {
      sleep 0.5;
      _escapingUnitsInZone = ESCAPE_setting_escaping_units inAreaArray _escapeZone;
      (count _escapingUnitsInZone) > 0 || (missionNamespace getVariable ['ESCAPE_gameEnded', false])
    };

    // Exit if game already ended
    if (missionNamespace getVariable ['ESCAPE_gameEnded', false]) exitWith {};

    {
      private _unit = _x;
      // Parse only units that not escaped yet
      if (!(_unit in _escapedUnits)) then {
        // Update escaped units array
        _escapedUnits pushback _unit;
        missionNamespace setVariable ['ESCAPE_escapedUnits', _escapedUnits];

        // Move unit to safe zone
        _unit setPos (getMarkerPos ESCAPE_setting_escaping_safe_zone);

        // Check game state
        call ESCAPE_fnc_checkGameState;

        // Exit if game already ended
        if (missionNamespace getVariable ['ESCAPE_gameEnded', false]) exitWith {};

        // Show notification to all players
        _escapingUnitsLeft = "escape" call ESCAPE_fnc_getTeamUnitsLeftCount;
        ['ESCAPE_unitEscaped', [_unit, _escapingUnitsLeft]] call CBA_fnc_globalEvent;
      };
    } forEach _escapingUnitsInZone;
  };
};
