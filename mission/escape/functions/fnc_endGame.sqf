/*
 * Escape script endGame function
 * Ends game
 * By SzwedzikPL (https://github.com/SzwedzikPL/Arma3EscapeMissionScript)
 */

params ["_reason"];

if (!isServer) exitWith {};

missionNamespace setVariable ['ESCAPE_gameEnded', true, true];

["ESCAPE_gameEnd", [_reason]] call CBA_fnc_globalEvent;
