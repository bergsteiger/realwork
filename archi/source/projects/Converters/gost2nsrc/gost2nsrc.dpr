program gost2nsrc;

{$APPTYPE CONSOLE}

{$I evDefine.inc}
{$I ProjectDefine.inc}

uses
  SysUtils,

  l3Interfaces,
  l3ProtoObject,
  l3Types,
  l3Base,
  l3Chars,
  l3String,

  g2nGrinder;

type
 Tg2nProgress = class(Tl3ProtoObject)
 private
  f_MaxValue: Long;
 public
  procedure DoProgress(aState: Byte; aValue: Long; const aMsg: AnsiString = '');
 end;

function DS(const aStr: string): string;
begin
 Result := l3ChangeCodePage(aStr, CP_RussianWin, CP_RussianDOS);
end;

procedure Tg2nProgress.DoProgress(aState: Byte; aValue: Long; const aMsg: AnsiString = '');
begin
 case aState of
  piStart   : f_MaxValue := aValue;
  piCurrent :
   begin
    Write(DS(Format(' Обработка %d из %d (%d%%)    '#13, [aValue+1, f_MaxValue, (aValue+1) * 100 div f_MaxValue])));
   end;{piCurrent}
  piEnd     : f_MaxValue := 0;
 end;
end;

procedure BadParams(const aMsg: string);
begin
 Writeln(DS(aMsg));
 Writeln;
 Writeln(DS('Использование: gost2nsrc <директория с исходными файлами RTF> [<директория для результата>]'));
 ExitCode := 1;
end;

var
 l_InDir, l_OutDir: string;
 l_Indicator: Tg2nProgress;
 l_Grinder: Tg2nGrinder;
begin
 Writeln(DS('Конвертер ГОСТ-ов из RTF в NSRC (c) 2015 Гарант-Сервис-Университет'));
 l_InDir := ParamStr(1);
 l_OutDir := ParamStr(2);
 if l_InDir = '' then
 begin
  BadParams(DS('Не указана входная директория'));
  Exit;
 end;
 if not DirectoryExists(l_InDir) then
 begin
  BadParams(DS(Format('Директория %s не найдена', [l_InDir])));
  Exit;
 end;
 if l_OutDir = '' then
  l_OutDir := GetCurrentDir;
 if not ForceDirectories(l_OutDir) then
 begin
  BadParams(DS(Format('Неверно указана выходная директория: %s', [l_OutDir])));
  Exit;
 end;
 l_Indicator := Tg2nProgress.Create;
 try
  l_Grinder := Tg2nGrinder.Create(l_InDir, l_OutDir, l_Indicator.DoProgress);
  try
   l_Grinder.Execute;
  finally
   FreeAndNil(l_Grinder);
  end;
 finally
  FreeAndNil(l_Indicator);
 end;
 //Readln;
end.
