unit alcuCommands;

// Команды для управления Парнем через почту

interface

type
 TalcuCommands = (alcuRestart, alcuStopQuery, alcuStopExport, alcuStopImport);

function DecodeCommands(aText: String; out Command: TalcuCommands): Boolean;

implementation

Uses
 StrUtils;

const
 alcuCommandNames : array[TalcuCommands] of String =
                    ('*restart', '*stop', '*export', '*import');

function DecodeCommands(aText: String; out Command: TalcuCommands): Boolean;
var
 i: TalcuCommands;
begin
 Result := False;
 for i:= Low(TalcuCommands) to High(TalcuCommands) do
  if AnsiStartsText(alcuCommandNames[i], aText) then
  begin
   Command := i;
   Result := True;
   break;
  end; // AnsiTextStarts(aText, alcuCommandNames[i])
end;

end.
