params ["_target"];

// Check inventory

// Start planting action
[ESCAPE_setting_bomb_planting_duration, [_target], {
  params ["_target"];

  // remove item
  // exec server event
  hint parseText "Bomba podłożona";

}, {}, "Podkładanie bomby"] call ace_common_fnc_progressBar;
