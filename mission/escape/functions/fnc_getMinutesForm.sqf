/*
 * Escape script getMinutesForm function
 * Returns minutes word form
 * By SzwedzikPL (https://github.com/SzwedzikPL/Arma3EscapeMissionScript)
 */

params ["_minutes"];

private _minutesForm = "minut";
if (_minutes < 5) then {
  if (_minutes == 1) then {
    _minutesForm = "minutę";
  } else {
    _minutesForm = "minuty";
  };
};

_minutesForm
