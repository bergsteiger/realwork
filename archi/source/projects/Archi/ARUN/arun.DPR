program aRun;

uses
  Windows, SysUtils, Classes,
  shellapi,
  Controls, Dialogs, vtDialogs,
  l3FileUtils, l3IniFile, l3String, l3ShellUtils,
  l3Base;

{$R *.RES}

ResourceString
 sidDoNotCopy = 'Не удалось обновить %s.'^M'Возможно модуль используется другим приложением.'^M'Повторить попытку?';

function NeedUpdateFile(aMyFile, aDistFile : TFileName) : Boolean;
 begin
  if Not FileExists(aMyFile)
   then Result := True
   else
    if Not FileExists(aDistFile)
     then Result := False
     else
      Result := (GetFileSize(aMyFile) <> GetFileSize(aDistFile)) or
                (FileDateTime(aMyFile) <> FileDateTime(aDistFile));
 end;

procedure INIPatch(aLocalDir  : TFileName);
 var
  UserCfg : TCfgList;
  I       : Integer;
  lIniName    : ShortString;
  lIniSection : ShortString;
  lIniParam   : ShortString;
  lIniValue   : ShortString;

  function GetUserCfg : TCfgList;
   begin
    If UserCfg = nil then UserCfg := TCfgList.Create('');
    Result := UserCfg;
   end;
 begin
  UserCfg := nil;
  try
   StationConfig.Section := 'INIPATCH';
   I := 1;
   while StationConfig.ReadParamStr(Format('ININAME%d',[I]), lIniName) do
    begin
     if StationConfig.ReadParamStr(Format('IniSection%d',[I]), lIniSection) and
        StationConfig.ReadParamStr(Format('IniParam%d',[I]),  lIniParam) and
        StationConfig.ReadParamStr(Format('IniValue%d',[I]),  lIniValue)

     then
      with GetUserCfg do
      begin
       CfgFileName := ConcatDirName(aLocalDir, lIniName);
       Section := lIniSection;
       WriteParamStr(lIniParam, lIniValue);
      end;
     Inc(I);
    end;

  finally
   UserCfg.Free;
  end;
 end;

procedure DoIt;
 var
  lRunCmdLine : String;
  lRunParam   : String;
  lCommonIni  : String;
  lRemoteFile : TFileName;
  lLocalFile  : TFileName;
  lForCopy    : TStringList;
  lLocalDir,
  lRemoteDir  : TFileName;
  I           : Integer;
  lPos        : Integer;
  lTime       : TDateTime;
 begin
  If ParamCount = 0
   then InitStationConfig
   else InitStationConfig(ParamStr(1));

  lForCopy := TStringList.Create;
  try

   with StationConfig do
    begin
     Section := 'MAIN';
     lLocalDir  := ReadParamStrDef ('LocalDir', '');
     lRemoteDir := ReadParamStrDef ('RemoteDir', '');
     lCommonIni := ReadParamStrDef ('CommonIni', '');
     lRunParam  := ReadParamStrDef ('RunParam', '');
    end;

  If Length(lCommonIni) > 0 then
   begin
    DoneConfigs;
    lCommonIni := ConcatDirName(lRemoteDir, lCommonIni);
    InitStationConfig(lCommonIni);
   end;

   with StationConfig do
    begin
     Section := 'COPY';
     ReadParamList('File', lForCopy);
    end;

   if lLocalDir = '' then
    lLocalDir := ExtractFilePath(ParamStr(0));

   with lForCopy do
    begin
     I := 0;
     while I < Count do
      begin
       lRemoteFile := ConcatDirName(lRemoteDir, Strings[I]);
       lLocalFile := ConcatDirName(lLocalDir, Strings[I]);
       if NeedUpdateFile(lLocalFile,lRemoteFile) then
       lTime := GetTime;
       repeat
        try
         CopyFile(lRemoteFile, lLocalFile, cmWriteOver + cmNoBakCopy);
         Break;
        except
         on E : Exception do
         begin
          if (GetTime - lTime) * 24*60*60 < 10 {second} then
           Continue
          else
           raise Exception.Create(Format('Ошибка копирования %s : %s', [Strings[I], E.Message]));
          //Application.ShowException(E);
         end;
        end;
       until False;
       Inc(I);
      end;
    end;

  { If lForCopy.Count <> 0 then
    with TFMain.Create(Application) do
     try
      Application.ProcessMessages;
      Execute(lLocalDir, lRemoteDir, lForCopy);
     finally
      Free;
     end;
  }
  finally
   lForCopy.Free;
  end;

  INIPatch(lLocalDir);
  with StationConfig do
   begin
    Section := 'RUN';
    lRunCmdLine := ReadParamStrDef ('RUN', '');
   end;
  if lRunCmdLine = '' then Exit;

  lPos:= Pos(' ', lRunCmdLine);
  if lPos > 0 then
  begin
   lRunParam:= Copy(lRunCmdLine, Succ(lPos), MaxInt);
   lRunCmdLine:= Copy(lRunCmdLine, 1, Pred(lPos));
  end
  else
   lRunParam:= '';
  //lRunCmdLine := ConcatDirName(ExtractFilePath(Application.ExeName), lRunCmdLine);
  //lRunCmdLine := lRunCmdLine +' '+ lRunParam;
  //WinExec(PChar(lRunCmdLine), SW_NORMAL);
  FileExecute(ConcatDirName(ExtractFilePath(ParamStr(0)), lRunCmdLine), lRunParam, ExtractFilePath(ParamStr(0)), esNormal);
 end;


begin
 try
  DoIt;
 except
  on E: Exception do
  begin
   l3System.Msg2Log('ОШИБКА: ' + E.Message);
   Halt(1);
  end;
 end;
end.
