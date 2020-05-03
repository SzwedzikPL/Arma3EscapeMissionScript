/*
 * Escape script onGameEnd function
 * Triggered by gameEnd CBA event
 * By SzwedzikPL (https://github.com/SzwedzikPL/Arma3EscapeMissionScript)
 */

_this spawn {
  params ["_reason"];

  ["ESCAPE_warning", [format ["Rozgrywka zakończona. %1", _reason]]] call BIS_fnc_showNotification;

  private _hint = parseText format [
    "<t align='center'><t size='1.5'>Rozgrywka zakończona</t><br/><br/><br/><t size='1.2'>%1</t></t>",
    _reason
  ];

  while {alive player} do {
    hintSilent _hint;
    sleep 5;
  };
};
