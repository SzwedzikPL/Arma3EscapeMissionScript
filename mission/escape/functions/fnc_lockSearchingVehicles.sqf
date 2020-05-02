/*
 * Escape script loclSearchingVehicles function
 * Locks or unlocks searching team vehicles
 * By SzwedzikPL (https://github.com/SzwedzikPL/Arma3EscapeMissionScript)
 */

params ["_mode"];

{_x lock _mode} forEach ESCAPE_setting_searching_vehicles;
