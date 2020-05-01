0 call ESCAPE_fnc_lockSearchingVehicles;

if (hasInterface) then {
  ["ESCAPE_warning", [ESCAPE_setting_searching_pursuit_notification_text]] call BIS_fnc_showNotification;
};

if (isServer) then {
  // Alarm sound
};
