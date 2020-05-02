/*
 * Escape script onBombExploded function
 * Triggered by bombExploded CBA event
 * By SzwedzikPL (https://github.com/SzwedzikPL/Arma3EscapeMissionScript)
 */

params ["_escapeZone", "_escapeZoneCirclePos"];

// Create escape zone marker & show proper notification for escaping units
if (player in ESCAPE_setting_escaping_units) then {
  private _marker = createMarkerLocal ["ESCAPE_escape_zone_marker", getPos _escapeZone];
  _marker setMarkerShapeLocal "ICON";
  _marker setMarkerTypeLocal ESCAPE_setting_escaping_zone_marker_type;
  _marker setMarkerColorLocal ESCAPE_setting_escaping_zone_marker_color;
  _marker setMarkerTextLocal ESCAPE_setting_escaping_zone_marker_text;

  ["ESCAPE_warning", [
    "Cel został zniszczony. Oznaczono miejsce ewakuacji."
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
    "Uciekinierzy zniszczyli swój cel."
  ]] call BIS_fnc_showNotification;

  hintSilent parseText "<t size='1.5'>Na mapie oznaczono strefę w której znajduje się punkt ewakuacji uciekinierów.</t>";
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

    private _aliveEscapingUnitsCount = count (ESCAPE_setting_escaping_units select {alive _x});

    {
      private _unit = _x;
      // Parse only units that not escaped yet
      if (!(_unit in _escapedUnits)) then {
        _escapedUnits pushback _unit;
        _unit setPos (getMarkerPos ESCAPE_setting_escaping_safe_zone);
        _escapingUnitsLeft = _aliveEscapingUnitsCount - (count _escapedUnits);
        ['ESCAPE_unitEscaped', [_unit, _escapingUnitsLeft]] call CBA_fnc_globalEvent;
      };
    } forEach _escapingUnitsInZone;

    missionNamespace setVariable ['ESCAPE_escapedUnits', _escapedUnits];

    // Exit if no more escaping units left
    if (_escapingUnitsLeft <= 0) exitWith {
      private _reasonText = ['%1 uciekinierów uciekło.', 'Wszyscy uciekinierzy uciekli.'] select (count _escapedUnits == count ESCAPE_setting_escaping_units);
      if (count _escapedUnits == 1) then {
        _reasonText = "Jeden uciekinier uciekł."
      };

      _reason = format [_reasonText, count _escapedUnits];
      _reason call ESCAPE_fnc_endGame;
    };
  };
};
