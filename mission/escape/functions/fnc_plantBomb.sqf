/*
 * Escape script plantBomb function
 * Triggered by plant bomb interaction
 * By SzwedzikPL (https://github.com/SzwedzikPL/Arma3EscapeMissionScript)
 */

params ["_target"];

private _noBombItemError = parseText "<t size='1.5'>Nie możesz podłożyć bomby.<br/>Nie masz jej w ekwipunku.</t>";

// Exit if player don't have bomb in inventory
if (!(ESCAPE_setting_bomb_item in (itemsWithMagazines player))) exitWith {
  hint _noBombItemError;
};

// Start planting action
[ESCAPE_setting_bomb_planting_duration, [_target, _noBombItemError], {
  params ["_params"];
  _params params ["_target", "_noBombItemError"];

  // Once again make sure bomb is in player inventory
  // It's possible to take item from unit backpack during action
  if (!(ESCAPE_setting_bomb_item in (itemsWithMagazines player))) exitWith {
    hint _noBombItemError;
  };

  player removeItem ESCAPE_setting_bomb_item;
  _target setVariable ["ESCAPE_bombPlanted", true, true];
  ["ESCAPE_bombPlanted", _target] call CBA_fnc_globalEvent;
  hint parseText format ["<t size='1.5'>Bomba podłożona<br/>Wybuchnie za około <t color='#FF0000'>%1</t> sekund</t>", ESCAPE_setting_bomb_timer];
  // Hide hint after explosion
  0 spawn {
    sleep ESCAPE_setting_bomb_timer;
    hintSilent "";
  };
}, {}, "Podkładanie bomby"] call ace_common_fnc_progressBar;
