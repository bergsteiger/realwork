program StgIndex;

{$APPTYPE CONSOLE}

uses
  Windows,
  SysUtils,
  l3Base,
  l3FileUtils,
  m3StorageInterfaces,
  m3DBInterfaces,
  m3DB,
  m4DB,
  l3Interfaces,
  m4DBInterfaces,
  l3CRT,
  l3Chars,
  l3String,
  m3Endings,
  m0LNGLib,
  m3StorageIndexAdapter in '..\..\..\..\..\common\components\rtl\Garant\TestsSupport\m3StorageIndexAdapter.pas';

const
 cFileName = 'bserv001';
 cPhaseSample = 'Phase %d : %s';

var
 lPhaseCnt : Byte = 1;

type
 TProgressor = class(Tl3Base)
 private
  lMaxCount : Longint;
 public
  procedure FilesProcessedExProc(aCurrentID : Longint; aMaxID : Longint; aTime : TDateTime);
  procedure ProgressProc(aState: Byte; aValue: Longint; const aMsg: String);
 end;

procedure TProgressor.ProgressProc(aState: Byte; aValue: Longint; const aMsg: String);
begin
 case aState of
  piStart : lMaxCount := aValue;
  piEnd : begin
           CRT.ReWrite(Format(cPhaseSample, [lPhaseCnt, 'done']));
           Writeln;
          end;
  piCurrent : CRT.ReWrite(Format(Tm3StorageIndexAdapter.Instance.PhaseStr, [aValue, lMaxCount]));
 end;
end;

procedure TProgressor.FilesProcessedExProc(aCurrentID : Longint; aMaxID : Longint; aTime : TDateTime);
begin
 CRT.ReWrite(Format(Tm3StorageIndexAdapter.Instance.PhaseStr, [aCurrentID, aMaxID]));
end;

function DS(S: String): String;
begin
 Result := l3ChangeCodePage(S, CP_RussianWin, CP_RussianDOS);
end;

var
 l_Progressor : TProgressor;
begin
 try
  l_Progressor := TProgressor.Create;
  try
   with Tm3StorageIndexAdapter.Instance do
   begin
    BaseName := ParamStr(1);
    if BaseName = '' then BaseName := cFileName;
    DirName := ExtractDirName(ExpandFileName(BaseName));
    InitEndings(DirName);
    BaseName := ExtractOnlyFileName(BaseName);
    if BaseName = '' then BaseName := cFileName;
    Writeln('Storage : ', ConcatDirName(DirName, BaseName));
    m0ExplicitEndingsListLoad; // принудительно загружаем список окончаний
    DoBuildIndex(l_Progressor.ProgressProc);
   end; // with g_Tm3StorageIndexAdapter.Instance do
  finally
   l3Free(l_Progressor);
  end;
  Writeln('All done. Press <Enter>');
 except
  on E: Exception do
  begin
   Writeln(DS(Format('ERROR: %s', [E.Message])));
   Writeln(DS('Нажмите <Enter>'));
  end;
 end;
 Readln;
end.
