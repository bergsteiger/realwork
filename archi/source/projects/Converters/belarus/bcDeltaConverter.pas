unit bcDeltaConverter;

{ $Id: bcDeltaConverter.pas,v 1.2 2016/04/12 12:44:21 fireton Exp $ }

interface
uses
 l3ProtoObject,
 l3Types,
 bcInterfaces;

type
 TbcDeltaConverter = class(Tl3ProtoObject)
 private
  procedure ConvertProcessProc(aState: Byte; aValue: Long; const aMsg : AnsiString = '');
  procedure DoneDB;
  procedure InitDB;
  procedure Say(aMsg: AnsiString);
  procedure SayError(aMsg: AnsiString);
  procedure ErrorHandler(const aMsg: AnsiString; aLevel: Integer = 0);
 public
  function Process(const aSrcDir, aOutDir: AnsiString): Boolean;
 end;

implementation
uses
 Windows,
 SysUtils,
 DateUtils,
 l3Base,
 l3Chars,
 l3String,
 l3IniFile,
 l3FileUtils,
 l3ShellUtils,
 l3DateSt,
 ddFileIterator,
 bcTopicDispatcher,
 bcProcessor,
 HT_DLL,
 HT_Const,
 DT_Err;

const
 cLastDeltaParam = 'lastdelta';

function DS(const aStr: string): string;
begin
 Result := l3ChangeCodePage(aStr, CP_RussianWin, CP_RussianDOS);
end;

procedure DSWriteln(const aStr: AnsiString);
begin
 Writeln(DS(aStr));
end;

procedure DSWrite(const aStr: AnsiString);
begin
 Write(DS(aStr));
end;

procedure TbcDeltaConverter.ConvertProcessProc(aState: Byte; aValue: Long; const aMsg : AnsiString = '');
begin
 if (aState = 1) and (aMsg <> '') then
  Say(': '+ExtractFileName(aMsg));
end;

procedure TbcDeltaConverter.DoneDB;
begin
 htShut;
 htGlobalShut;
end;

procedure TbcDeltaConverter.ErrorHandler(const aMsg: AnsiString; aLevel: Integer = 0);
begin
 Say('   ' + aMsg);
end;

procedure TbcDeltaConverter.InitDB;
var
 l_DirTemp: AnsiString;
 l_DirLocks: AnsiString;
 l_Init :Init;
begin
 l_DirTemp  := l3GetTempDir;
 l_DirLocks := ExtractFilePath(ParamStr(0));
 l3FillChar(l_Init, SizeOf(l_Init));
 with l_Init do
 begin
  nTableCnt      := 50;
  nTaskCnt       := 20;
  nHtCnt         := 4 + 20 * 6 + 1;
  nLockTimeOut   := 40;
  nPollDelay     := 40;
  nTransTimeOut  := 40;
  nTrsMode       := TRS_HARD;
  fpTmpPath      := PChar(l_DirTemp);
  fpNetPath      := PChar(l_DirLocks);
  fpTrtPath      := PChar(l_DirLocks);
  fpNetName      := 'BelConv';
  fpfInfo        := Pointer(-1);
  fpfIoMess      := nil; //@fn_OnIOError;
  fpfErrMess     := nil; //@fn_OnHtError;
  fpfPiStart     := Pointer(-1);
  fpfPiDraw      := Pointer(-1);
  fpfPiStop      := Pointer(-1);
  fpfYield       := Pointer(-1);
  gHeapCtrl      := 10000000;
  gHeapTask      := 120000;
 end;
 htGlobalInit(HInstance);
 Ht(htInit(@l_Init, SizeOf(l_Init)));
end;

function TbcDeltaConverter.Process(const aSrcDir, aOutDir: AnsiString): Boolean;
var
 l_Date: TDateTime;
 l_Ini: Tl3IniFile;
 l_LastDeltaDate: TDateTime;
 l_FileMask: AnsiString;
 l_FI: TddFileIterator;
 l_ExeDir: AnsiString;
 l_TempSrcDir, l_TempResDir : AnsiString;
 l_NewDeltaDate: TDateTime;
 l_TD: IbcTopicDispatcher;
 l_TDPath, l_SettingsPath: AnsiString;
 l_Ph1Processor : TbcPhaseOneConverter;
 l_IterFunc: TddIterateProc;
 l_RarPath: AnsiString;

 function ExtractOne(const aFileName: AnsiString): Boolean;
 var
  l_CmdLine: AnsiString;
  l_ExeName: AnsiString;
  l_FileDate: Integer;
 begin
  Result := True;
  l_FileDate := FileAge(aFileName);
  if (l_FileDate <> -1) and (MonthsBetween(l_Date, FileDateToDateTime(l_FileDate)) < 6) then
  begin
   Say('  ' + aFileName);
   l_ExeName := ConcatDirName(l_ExeDir, 'rar.exe');
   l_CmdLine :=  'e -or ' + aFileName + ' ' + l_TempSrcDir;
   if FileExecuteWait(l_ExeName, l_CmdLine, l_ExeDir, esMinimized) <> 0 then
    SayError('не удалось распаковать ' + ExtractFileName(aFileName));
  end;
 end;

begin
 Result := False;
 l_ExeDir := ExtractFilePath(ParamStr(0));
 l_TempSrcDir := ConcatDirName(l_ExeDir, '$BCDTEMP_S');
 l_TempResDir := ConcatDirName(l_ExeDir, '$BCDTEMP_R');
 l_RarPath := ConcatDirName(l_ExeDir, 'Rar.exe');
 l_TDPath := ConcatDirName(l_ExeDir, cTDTableName);
 l_SettingsPath := ConcatDirName(l_ExeDir, cConfigFileName);
 if not FileExists(l_RarPath) then
 begin
  SayError('Rar.exe не найден рядом с исполняемым файлом');
  Exit;
 end;
 if not FileExists(l_TDPath+'.htb') then
 begin
  SayError('таблицы перекодировки не найдены рядом с исполняемым файлом');
  Exit;
 end;
 if not FileExists(l_SettingsPath) then
 begin
  SayError('файл настроек ('+cConfigFileName+') не найден рядом с исполняемым файлом');
  Exit;
 end;
 ForceDirectories(l_TempSrcDir);
 ForceDirectories(l_TempResDir);
 PureDir(l_TempResDir);
 PureDir(aOutDir);
 l_NewDeltaDate := 0;
 // получим дату последней дельты
 l_Ini := Tl3IniFile.Create({ConcatDirName(aSrcDir, 'bcdelta.ini')});
 try
  l_Ini.Section := 'main';
  l_LastDeltaDate := l_Ini.ReadParamDateDef(cLastDeltaParam, EncodeDate(2015, 12, 1)); // раньше 1 января 2015 г. дельт не бывает
  l3System.Str2Log('');
  Say('Конвертация дельт с '+ l3DateToStr(l_LastDeltaDate, 'dd.mm.yyyy'));
  l_Date := SysUtils.Date;
  InitDB;
  try
   l_TD := TbcTopicDispatcher.Make(l_TDPath);
   l_Ph1Processor := TbcPhaseOneConverter.Create(l_TD, l_SettingsPath);
   try
    l_Ph1Processor.ErrorFolder := ConcatDirName(aOutDir, '_errors');
    l_Ph1Processor.TotalProgressProc := ConvertProcessProc;
    l_Ph1Processor.OnError := ErrorHandler;
    while l_Date > l_LastDeltaDate do
    begin
     l_FileMask := '*_' + l3DateToStr(l_Date, 'ddmm') + '*.exe';
     l_FI := TddFileIterator.Make(aSrcDir, l_FileMask, nil, True);
     try
      if l_FI.Count > 0 then
      begin
       Say('Найдены дельты за '+l3DateToStr(l_Date, 'dd.mm.yyyy:'));
       PureDir(l_TempSrcDir);
       l_IterFunc := L2IterateFilesProc(@ExtractOne);
       try
        l_FI.IterateFiles(l_IterFunc);
       finally
        FreeIterateFilesProc(l_IterFunc);
       end;
       l_Ph1Processor.Process(l_TempSrcDir, l_TempResDir, l_NewDeltaDate <> 0);
       if l_NewDeltaDate = 0 then
        l_NewDeltaDate := l_Date;
      end;
     finally
      FreeAndNil(l_FI);
     end;
     l_Date := IncDay(l_Date, -1);
    end; // while
   finally
    FreeAndNil(l_Ph1Processor);
   end;
   Say('Простановка ссылок и финализация процесса...');
   BCPhaseTwoProcess(l_TempResDir, aOutDir, bcoNSRC, l_TD, ErrorHandler, ConvertProcessProc, nil);
   CopyFile(ConcatDirName(l_TempResDir, 'doclist.txt'), ConcatDirName(aOutDir, 'doclist.txt'));
   DelDir(l_TempSrcDir);
   DelDir(l_TempResDir);
   if l_NewDeltaDate <> 0 then
    l_Ini.WriteParamDate(cLastDeltaParam, l_NewDeltaDate)
  finally
   l_TD := nil;
   DoneDB;
  end;
 finally
  FreeAndNil(l_Ini);
 end;
 Result := True;
end;

procedure TbcDeltaConverter.Say(aMsg: AnsiString);
begin
 DSWriteln(aMsg);
 l3System.Msg2Log(aMsg);
end;

procedure TbcDeltaConverter.SayError(aMsg: AnsiString);
begin
 Say('ОШИБКА: '+aMsg);
end;

end.
