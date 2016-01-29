unit a2Security;

interface

function GlobalInit: Boolean;

Procedure GlobalDone; far;

implementation
uses
 SysUtils,
 Forms,
 Dialogs,

 l3Base,
 l3IniFile,

 Dt_Types,

 ddHTInit,
 ddClientBaseEngine,
 ddTypes
 ;



function GlobalInit: Boolean;
begin
 Result := False;
 AddExitProc(GlobalDone);
 Result := InitBaseEngine(nil, False, True); // разрешаем Supervisor
end;

Procedure GlobalDone;
begin
 DoneClientBaseEngine;
end;

end.
