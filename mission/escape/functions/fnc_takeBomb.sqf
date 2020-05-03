/*
 * Escape script takeBomb function
 * Triggered by take bomb interaction
 * By SzwedzikPL (https://github.com/SzwedzikPL/Arma3EscapeMissionScript)
 */

params ["_bombObject"];

// Exit if game already ended;
if (missionNamespace getVariable ['ESCAPE_gameEnded', false]) exitWith {};

// Exit if player is not in escaping team
if (!(player in ESCAPE_setting_escaping_units)) exitWith {
  hint parseText "<t size='1.5'>Nie możesz podnieść bomby.<br/>Nie jesteś uciekinierem.</t>";
};

// Exit if player can't add item to inventory
if (!(player canAdd ESCAPE_setting_bomb_item)) exitWith {
  hint parseText "<t size='1.5'>Nie możesz podnieść bomby.<br/>Brak miejsca w ekwipunku.</t>";
};

// Give player bomb item
player addItem ESCAPE_setting_bomb_item;

// Delete bomb object
deleteVehicle _bombObject;

// Exit if bomb was taken before
if (missionNamespace getVariable ["ESCAPE_bombTaken", false]) exitWith {};
missionNamespace setVariable ["ESCAPE_bombTaken", true, true];

// Send bombTaken event with random bomb target
private _target = selectRandom ESCAPE_setting_bomb_targets;
["ESCAPE_bombTaken", _target] call CBA_fnc_globalEvent;
