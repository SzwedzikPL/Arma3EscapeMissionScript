/*
 * Escape script preInit
 * By SzwedzikPL (https://github.com/SzwedzikPL/Arma3EscapeMissionScript)
 */

ESCAPE_fnc_takeBomb = compile preprocessFileLineNumbers "escape\functions\fnc_takeBomb.sqf";
ESCAPE_fnc_plantBomb = compile preprocessFileLineNumbers "escape\functions\fnc_plantBomb.sqf";
ESCAPE_fnc_lockSearchingVehicles = compile preprocessFileLineNumbers "escape\functions\fnc_lockSearchingVehicles.sqf";
ESCAPE_fnc_endGame = compile preprocessFileLineNumbers "escape\functions\fnc_endGame.sqf";
ESCAPE_fnc_handleUnitKilled = compile preprocessFileLineNumbers "escape\functions\fnc_handleUnitKilled.sqf";

ESCAPE_fnc_onBombCreated = compile preprocessFileLineNumbers "escape\functions\fnc_onBombCreated.sqf";
ESCAPE_fnc_onPursuitStarted = compile preprocessFileLineNumbers "escape\functions\fnc_onPursuitStarted.sqf";
ESCAPE_fnc_onBombTaken = compile preprocessFileLineNumbers "escape\functions\fnc_onBombTaken.sqf";
ESCAPE_fnc_onBombPlanted = compile preprocessFileLineNumbers "escape\functions\fnc_onBombPlanted.sqf";
ESCAPE_fnc_onBombExploded = compile preprocessFileLineNumbers "escape\functions\fnc_onBombExploded.sqf";
ESCAPE_fnc_onUnitKilled = compile preprocessFileLineNumbers "escape\functions\fnc_onUnitKilled.sqf";
ESCAPE_fnc_onUnitEscaped = compile preprocessFileLineNumbers "escape\functions\fnc_onUnitEscaped.sqf";
ESCAPE_fnc_onGameEnd = compile preprocessFileLineNumbers "escape\functions\fnc_onGameEnd.sqf";
