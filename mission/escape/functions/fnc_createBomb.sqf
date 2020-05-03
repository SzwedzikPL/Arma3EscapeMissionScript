/*
 * Escape script createBomb function
 * Creates bomb and triggers global event for it
 * By SzwedzikPL (https://github.com/SzwedzikPL/Arma3EscapeMissionScript)
 */

params ["_bombPosition"];

private _bombObject = ESCAPE_setting_bomb_class createVehicle _bombPosition;
_bombObject setPos _bombPosition;

["ESCAPE_bombCreated", _bombObject] call CBA_fnc_globalEvent;
