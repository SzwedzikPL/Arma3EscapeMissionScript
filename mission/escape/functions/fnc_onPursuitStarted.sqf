/*
 * Escape script onPursuitStarted function
 * Triggered by pursuitStarted CBA event
 * By SzwedzikPL (https://github.com/SzwedzikPL/Arma3EscapeMissionScript)
 */

0 call ESCAPE_fnc_lockSearchingVehicles;

if (hasInterface) then {
  ["ESCAPE_warning", [ESCAPE_setting_searching_pursuit_notification_text]] call BIS_fnc_showNotification;
};

if (isServer && ESCAPE_setting_searching_pursuit_alarm_sound != "") then {
  playSound3D [
    ESCAPE_setting_searching_pursuit_alarm_sound,
    ESCAPE_setting_searching_pursuit_alarm_source,
    false,
    getPosASL ESCAPE_setting_searching_pursuit_alarm_source,
    4
  ];
};
