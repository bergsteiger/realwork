program beladelta;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  l3Base,
  l3Chars,
  l3String,
  l3FileUtils,
  l3DateSt,
  bcDeltaConverter;

function DS(const aStr: string): string;
begin
 Result := l3ChangeCodePage(aStr, CP_RussianWin, CP_RussianDOS);
end;

procedure DSWriteln(const aStr: AnsiString);
begin
 Writeln(DS(aStr));
end;

procedure PrintError(const aMsg: AnsiString);
var
 l_Str: AnsiString;
begin
 l_Str := 'ОШИБКА: '+aMsg;
 DSWriteln(l_Str);
 l3System.Msg2Log(l_Str);
end;

procedure DoJob;
var
 l_SrcDir, l_OutDir: AnsiString;
 l_DC: TbcDeltaConverter;
 l_DeltaDir: AnsiString;
begin
 if ParamCount < 2 then
 begin
  DSWriteln('Использование:');
  DSWriteln('  beladelta <папка с дельтами> <папка для результата>');
  Halt(1);
 end;
 l_SrcDir := ParamStr(1);
 l_OutDir := ParamStr(2);
 if not DirectoryExists(l_SrcDir) then
 begin
  PrintError('неверно указана папка с исходными данными!');
  Halt(1);
 end;
 ForceDirectories(l_OutDir);
 if not DirectoryExists(l_OutDir) then
 begin
  PrintError('неверно указана папка для результата!');
  Halt(1);
 end;
 l_DeltaDir := 'delta-' + l3DateTimeToStr(Now, 'yyyy-mm-dd');
 l_OutDir := ConcatDirName(l_OutDir, l_DeltaDir);
 ForceDirectories(l_OutDir);
 if not DirectoryExists(l_OutDir) then
 begin
  PrintError('не удалось создать папку ' + l_OutDir);
  Halt(1);
 end;
 l_DC := TbcDeltaConverter.Create;
 try
  l_DC.Process(l_SrcDir, l_OutDir);
 finally
  FreeAndNil(l_DC);
 end;
end;

begin
 DSWriteln('Архивариус: Утилита конвертации белорусских дельт v.1.0');
 DoJob;
end.
