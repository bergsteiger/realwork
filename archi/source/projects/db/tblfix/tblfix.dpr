program tblfix;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  tfProcess,
  l3Base;

var
 l_Processor: TtfProcessor;
 l_TName: AnsiString;
begin
 Writeln('HyTech Table Fixer 1.0   (c) Garant');
 l3System.Str2Log(' ');
 if ParamCount > 0 then
 begin
  l_TName := ParamStr(1);
  if FileExists(l_TName) then
  begin
   l_Processor := TtfProcessor.Create;
   try
    Msg('Обработка таблицы '+l_TName);
    l_Processor.SetTable(l_TName);
    l_Processor.FixTable;
   finally
    FreeAndNil(l_Processor);
   end;
  end
  else
   Msg('Неверно указана таблица для обработки');
 end
 else
  Msg('ИСПОЛЬЗОВАНИЕ: tblfix <путь к .HTB>');
end.
