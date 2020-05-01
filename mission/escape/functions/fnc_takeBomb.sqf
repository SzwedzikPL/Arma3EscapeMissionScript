params ["_bombObject"];

// Check inventory
// Add item

// Delete bomb object
deleteVehicle _bombObject;

// Send event with bomb target
private _target = selectRandom ESCAPE_setting_bomb_targets;
["ESCAPE_bombTaken", _target] call CBA_fnc_globalEvent;
