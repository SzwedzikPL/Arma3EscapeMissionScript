/*
 * Escape script onPursuitStarted function
 * Triggered by pursuitStarted CBA event
 * By SzwedzikPL (https://github.com/SzwedzikPL/Arma3EscapeMissionScript)
 */

params ["_escapingUnitsCount", "_searchingUnitsCount"];

// Unlock search team vehicles
0 call ESCAPE_fnc_lockSearchingVehicles;

if (hasInterface) then {
  // Show notification
  private _escapeUnitForm = "uciekinierów";
  if (_escapingUnitsCount == 1) then {
    _escapeUnitForm = "uciekinier";
  };

  private _searchUnitForm = "poszukiwaczy";
  if (_searchingUnitsCount == 1) then {
    _searchUnitForm = "poszukiwacz";
  };

  ["ESCAPE_warning", [
    format [
      "Pościg rozpoczęty. Jest %1 %2 i %3 %4.",
      _escapingUnitsCount,
      _escapeUnitForm,
      _searchingUnitsCount,
      _searchUnitForm
    ]
  ]] call BIS_fnc_showNotification;

  0 spawn {
    // Wait for end time to setup
    waitUntil {
      sleep 0.01;
      (missionNamespace getVariable ['ESCAPE_endTime', 0]) > 0
    };

    // Add clock perFrameHandler
    private _handler = [{
      private _timeLeft = ((missionNamespace getVariable ['ESCAPE_endTime', 0]) - CBA_missionTime) max 0;
      private _minutesLeft = floor (_timeLeft / 60);
      private _secondsLeft = floor (_timeLeft - (_minutesLeft * 60));
      private _fadeInTime = 0.01;
      private _fadeOutTime = 999;

      if (_minutesLeft == 0 && _secondsLeft < 30) then {
        _fadeInTime = 1;
        _fadeOutTime = 0.5;
      };

      if (_minutesLeft < 10) then {
        _minutesLeft = format ["0%1", _minutesLeft];
      };

      if (_secondsLeft < 10) then {
        _secondsLeft = format ["0%1", _secondsLeft];
      };

      "ESCAPE_endTimeClock" cutText [
        format [
          "<br/><br/><br/><br/><br /><t font='EtelkaMonospaceProBold' size='2' align='left' shadow='2'>%1:%2&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</t>",
          _minutesLeft, _secondsLeft
        ],
        "PLAIN DOWN",
        _fadeInTime, false, true
      ];
      "ESCAPE_endTimeClock" cutFadeOut _fadeOutTime;
    }, 1] call CBA_fnc_addPerFrameHandler;

    // Wait until player dies or game ends
    waitUntil {
      sleep 0.5;
      !(alive player) || (missionNamespace getVariable ['ESCAPE_gameEnded', false])
    };

    // Kill clock perFrameHandler
    [_handler] call CBA_fnc_removePerFrameHandler;
  };
};

// Rest of code is server-side
if (!isServer) exitWith {};

// Remove objects
{
  deleteVehicle _x;
} forEach ESCAPE_settings_objects_to_delete_after_pursuit_start;

// Sound alarm
private _alarm = createSoundSource ["Sound_Alarm", position ESCAPE_setting_searching_pursuit_alarm_source, [], 0];
[{deleteVehicle _this;}, _alarm, 7.5] call CBA_fnc_waitAndExecute;

0 spawn {
  // Wait for end time to setup
  waitUntil {
    sleep 0.01;
    (missionNamespace getVariable ['ESCAPE_endTime', 0]) > 0
  };

  // Check time left
  while {!(missionNamespace getVariable ['ESCAPE_gameEnded', false])} do {
    private _timeLeft = (missionNamespace getVariable ['ESCAPE_endTime', 0]) - CBA_missionTime;
    if (_timeLeft <= 0) exitWith {
      "Skończył się czas." call ESCAPE_fnc_endGame;
    };
    sleep 0.5;
  };
};
