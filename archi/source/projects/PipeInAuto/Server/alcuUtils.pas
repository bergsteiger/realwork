unit alcuUtils;

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

Uses
 Classes, SysUtils,
 l3Base, l3LongintList,
 alcuTypes,
 dt_Types, dt_doc,
 CsCommon,
 ddServerTask, csProcessTask, dtIntf, DT_Sab,
 csCourtDecisionSabCheckerParams;


// Возвращает имя пользователя по идентификатору
function UserHostByID(aID: TcsClientID): String;

// Возвращает приоритет задачи для указанного пользователя
procedure Exception2Log(E: EXception; aStatus: TalcuStatus = dd_apsRevert);

// Возвращает информацию о пользователе по идентификатору
function UserNameByID(aID: TcsClientID; const InkognitoSuffix: AnsiString = ''): String;

procedure ResetLogFile(const aFileName: String; aMaxSize: Integer; aCompress: Boolean = False);

procedure ResetSelfLog(aMaxSize: Integer; aCompress: Boolean = False);

{$If not defined(ServerAssistantSide)}
procedure ResetArchiLog(aCompress: Boolean);
{$IfEnd not defined(ServerAssistantSide)}

procedure AddReportLog(aMessage: String; const Args: array of const; aReport:
    TStrings); overload;

procedure AddReportLog(aMessage: String; aReport: TStrings); overload;

function GetAppFolderFileName(const aFileName: String; aUnique: Boolean = False): String;

function GetFolderSize(const aFolderName: string; aWithSubFolders: Boolean =
    True): Int64;

function GetTaskImageIndex(aTask: TddProcessTask): Integer;

function FileIsFree(const aFileName: String): Boolean;

function LoadDocNumbers(const aFileName: String): ISab;

 {$If defined(AppServerSide)}
function MakeCourtDecisionSabCheckerParams: TcsCourtDecisionSabCheckerParams;
 {$IfEnd defined(AppServerSide)}

 {$If defined(AppServerSide)}
function CorrectArchiveWarehousePath(const aPath, aDefaultSuffix: String): String;
 {$IfEnd defined(AppServerSide)}

function IsDayOfWeekByMask(const aDate: TDateTime; const aMask: Integer): Boolean;
// проверяет, попадает ли день недели в маску. Маска - битовая, понедельник - 0-й бит, вторник - 1-й и т.д.


const
 GetUserNameLock: Boolean = False;
 NewStorage = False;
 OldStorage = True;

implementation
Uses
 alcuMailServer,
 dt_User, dt_Const,
 l3String,
 l3Bits, DateUtils,
 JclDebug,
 dt_UserTypes,
 l3ExceptionsLog, l3FileUtils,
 {$If not defined(ServerAssistantSide)}
 ddAppConfig,
 ddAppConfigDataAdapters,
 {$IfEnd not defined(ServerAssistantSide)}
 alcuStrings, ddUtils, ddFileIterator, csExport, csImport, csTaskTypes, alcuZipUtils,
 dt_ListUtils,
 csCourtDescription;

resourcestring
  rsUnknown = 'неизвестно';
  rsErrorGetInfo = 'Ошибка получения информации о пользователе %d';

function UserHostByID(aID: TcsClientID): String;
var
 l_User: TArchiUser;
begin
 if aID > High(TUserID) then
  Result := ''
 else
 begin
  l_User := UserManager.UserByID(aID);
  if l_User = nil then
   Result := ''
  else
   Result := l_User.IP;
 end;                                                 
end;

procedure Exception2Log(E: EXception; aStatus: TalcuStatus = dd_apsRevert);
var
 I: Integer;
 l_StackList: TJclStackInfoList;
 l_List: TStrings;
begin
 l3System.Str2Log(TalcuStatusNames[aStatus]);
 l3System.Exception2Log(E);

 l_List:= TStringList.Create;
 try
  l_List.Add(E.Message);
  try
   l_StackList:= JclLastExceptStackList{(E)};
   If (l_StackList <> nil) and (l_StackList.Count > 0) then
   begin
    With l_StackList do
     for I := 0 to Count - 1 do
      l_List.Add(SysUtils.Format('  [Stack #%3d] %s',
                       [I,
                       GetLocationInfoStr(Pointer(Items[I].StackInfo.CallerAddr))]));
   end; // (l_StackList <> nil) and (l_StackList.Count > 0)
   l_List.Add(#13#10#13#10'ВНИМАНИЕ! Данная ошибка может быть вторичной, обязательно просмотрите лог-файл.');
  except
   on E2: Exception do l3System.Exception2Log(E2);
  end; // try..except

  l3System.Str2Log(l_List.Text);
  alcuMail.SendEmailNotify(eventException, True, l_List, aStatus);
  l3System.Stack2Log('Exception Stack');
  //alcuMail.WaitCommands := True;
 finally
  l_List.Free;
 end;
end;

function UserNameByID(aID: TcsClientID; const InkognitoSuffix: AnsiString = ''): String;
var
 l_User: TArchiUser;
begin
 if aID > High(TUserID) then
  Result := rsInkognito
 else
 begin
  l_User := UserManager.UserByID(aID);
  if l_User = nil then
  begin
   if InkognitoSuffix <> '' then
    Result := Format('%s (%d) - %s', [rsInkognito, aID, InkognitoSuffix])
   else
    Result := Format('%s (%d)', [rsInkognito, aID]);
  end
  else
   Result := l_User.UserName;
 end;
end;

function GetLogBackupFileName(const aBaseName: AnsiString; aNeedCompress: Boolean): AnsiString;
var
 l_Idx: Integer;
 l_Suffix: AnsiString;
begin
 l_Idx := 1;
 l_Suffix := '';
 while (aNeedCompress and FileExists(aBaseName + l_Suffix + '.zip')) or (not aNeedCompress and FileExists(aBaseName + l_Suffix)) do
 begin
  Inc(l_Idx);
  l_Suffix := Format('-%d', [l_Idx]);
 end;
 Result := aBaseName + l_Suffix;
 if aNeedCompress then
  Result := Result + '.zip';
end;

procedure ResetLogFile(const aFileName: String; aMaxSize: Integer; aCompress: Boolean = False);
var
 l_LogFileName, l_OldLogFileName, l_Folder: ShortString;
begin
 l_LogFileName:= GetAppFolderFileName(aFileName);
 l3System.Msg2Log('Сброс %s', [aFileName]);
 if FileExists(l_LogFileName) and (SizeOfFile(l_LogFileName) > aMaxSize) then
 begin
  if FileIsFree(l_LogFileName) then
  begin
   l_Folder:= ConcatDirName(ExtractFilePath(l_LogFileName), 'Log Files');
   if ForceDirectories(l_Folder) then
   begin
    l_OldLogFileName:= ConcatDirName(l_Folder, ExtractFileName(l_LogFileName)+'.'+SysUtils.FormatDateTime(SalcuAutoPipeServer_YyyyMmDd, Now));
    l_OldLogFileName := GetLogBackupFileName(l_OldLogFileName, aCompress);
    if aCompress then
    try
     ZipFiles(l_OldLogFileName, ExtractFileDir(l_LogFileName), ExtractFilename(l_LogFileName));
     if not DeleteFile(l_LogFileName) then
      l3System.Msg2Log('Не удалось удалить лог-файл');
    except
     l3System.Msg2Log('Не удалось сжать лог-файл');
    end
    else
    try
     CopyFile(l_LogFileName, l_OldLogFileName, cmDeleteSource);
    except
     l3System.Msg2Log('Не удалось скопировать лог-файл');
    end;
   end; // ForceDirectories(l_Folder)
  end
  else // FileIsFree(l_LogFileName)
  // if not FileIsFree(l_OldLogFileName) then -- ЗАЧЕМ ЭТА ПРОВЕРКА (особенно учитывая, что l_OldLogFileName не инициализирован)?!!
   l3System.Msg2Log('Ошибка совместного доступа к %s', [l_LogFileName]);
 end; // FileExists(l_LogFileName) and (SizeOfFile(l_LogFileName) > aMaxSize)
end;

procedure ResetSelfLog(aMaxSize: Integer; aCompress: Boolean = False);
var
 l_LogFileName, l_OldLogFileName, l_Folder: ShortString;
begin
 l_LogFileName:= Gm0EXCLibDefSrv.LogFileName;
 l3System.Msg2Log('Сброс %s', [l_LogFileName]);
 if FileExists(l_LogFileName) and (SizeOfFile(l_LogFileName) > aMaxSize) then
 begin
  FreeAndNil(Gm0EXCLibDefSrv);
  try
   if FileIsFree(l_LogFileName) then
   begin
    l_Folder:= ConcatDirName(ExtractFilePath(ParamStr(0)), 'Log Files');
    if ForceDirectories(l_Folder) then
    begin
     l_OldLogFileName:= ConcatDirName(l_Folder, ExtractFileName(l_LogFileName)+'.'+SysUtils.FormatDateTime(SalcuAutoPipeServer_YyyyMmDd, Now));
     l_OldLogFileName := GetLogBackupFileName(l_OldLogFileName, aCompress);
     if aCompress then
     try
      ZipFiles(l_OldLogFileName, ExtractFileDir(l_LogFileName), ExtractFilename(l_LogFileName));
      if not DeleteFile(l_LogFileName) then
       l3System.Msg2Log('Не удалось удалить лог-файл');
     except
      alcuMail.SendEmailNotify(eventResetSelfLog, True, 'Не удалось сжать лог-файл', dd_apsEverydayUpdate);
     end
     else
     try
      CopyFile(l_LogFileName, l_OldLogFileName, cmDeleteSource);
     except
      alcuMail.SendEmailNotify(eventResetSelfLog, True, 'Не удалось скопировать лог-файл', dd_apsEverydayUpdate);
     end;
    end; // ForceDirectories(l_Folder)
   end
   else // FileIsFree(l_LogFileName)
   // if not FileIsFree(l_OldLogFileName) then -- ЗАЧЕМ ЭТА ПРОВЕРКА (особенно учитывая, что l_OldLogFileName не инициализирован)?!!
    l3System.Msg2Log('Ошибка совместного доступа к %s', [l_LogFileName]);
  finally
   Gm0EXCLibDefSrv:= Tl3ExceptionsLog.Create(l_LogFileName);
  end;
 end; // FileExists(l_LogFileName) and (SizeOfFile(l_LogFileName) > aMaxSize)
end;

{$If not defined(ServerAssistantSide)}
procedure ResetArchiLog(aCompress: Boolean);
var
 l_LogFileName,
 l_OldLogFileName: AnsiString;
begin
 with ddAppConfiguration do
 begin
  l_LogFileName:= AsString[SalcuAutoPipeServer_ArchiLogFileName];
  if FileExists(l_LogFileName) and
     (SizeOfFile(l_LogFileName) > AsInteger[SalcuAutoPipeServer_MaxArchiLogFileSize]*dd_SizeMulti[dd_stMega]) then
  begin
   l_OldLogFileName:= l_LogFileName+'.'+SysUtils.FormatDateTime(SalcuAutoPipeServer_YyyyMmDd, Now);
   l_OldLogFileName := GetLogBackupFileName(l_OldLogFileName, aCompress);
   if aCompress then
   try
    ZipFiles(l_OldLogFileName, ExtractFileDir(l_LogFileName), ExtractFilename(l_LogFileName));
    DeleteFile(l_LogFileName);
   except
    l3System.Msg2Log('Не удалось сжать лог-файл');
   end
   else
   begin
    if not RenameFile(l_LogFileName, l_OldLogFileName) then
     l3System.Msg2Log(rsResetArchiLogError);
   end;
  end;
 end;
end;
{$IfEnd not defined(ServerAssistantSide)}

procedure AddReportLog(aMessage: String; const Args: array of const; aReport:
    TStrings);
begin
 AddReportLog(Format(aMessage, Args), aReport);
end;

procedure AddReportLog(aMessage: String; aReport: TStrings);
begin
 aReport.Add(aMessage);
 l3System.Msg2Log(aMessage);
end;

function GetAppFolderFileName(const aFileName: String; aUnique: Boolean = False): String;
var
 l_Folder: String;
begin
 l_Folder:= ExtractFileDir(ParamStr(0));
 Result:= ConcatDirName(l_Folder, aFileName);
 if aUnique then
  Result:= MakeUniqueFileName(Result);
end;

function GetFolderSize(const aFolderName: string; aWithSubFolders: Boolean =
    True): Int64;
begin
 with TddFileIterator.Make(aFolderName, '*.*', nil, aWithSubFolders) do
 try
  Result := TotalSize;
 finally
  Free;
 end;
end;

function GetTaskImageIndex(aTask: TddProcessTask): Integer;
begin
 if aTask is TcsExport then
  Result:= 12
 else
 if aTask is TcsImportTaskItem then
  Result:= 11
 else
 if aTask.TaskType = cs_ttAutoClass then
  Result:= 13
 else
  Result:= -1;
end;

function FileIsFree(const aFileName: String): Boolean;
var
 l_Handle: Integer;
begin
 Result := False;
 l_Handle:= FileOpen(aFileName, fmShareExclusive);
 if l_Handle <> -1 then
 begin
  FileClose(l_Handle);
  Result:= True;
 end;
end;

function LoadDocNumbers(const aFileName: String): ISab;
begin
 Result:= dt_ListUtils.LoadDocNumbers(aFileName);
end;

 {$If defined(AppServerSide)}
function MakeCourtDecisionSabCheckerParams: TcsCourtDecisionSabCheckerParams;
var
  l_CourtList: TddSimpleListDataAdapter;
  l_CourtDescription: TcsCourtDescription;
  l_CourtIDX: Integer;
begin
  Result := TcsCourtDecisionSabCheckerParams.Create;
  Result.IsParamsValid := not ddAppConfiguration.IsEmpty['DocType'] and not Tl3LongintList(ddAppConfiguration.AsObject['DocType']).Empty;
  if Result.IsParamsValid then
  begin
    Result.DocTypeID := Tl3LongintList(ddAppConfiguration.AsObject['DocType'])[0];
   {$IFNDEF Region}
    Result.LastUpdateDate := ddAppConfiguration.AsDateTime['CD_FromDate'];
   {$ENDIF Region}
    Result.NotifyList := ddAppConfiguration.AsString['CD_Email'];
    l_CourtList := ddAppConfiguration.AsObject['CourtList'] as TddSimpleListDataAdapter;
    for l_CourtIDX := 0 to l_CourtList.Count - 1 do
    begin
      l_CourtDescription := TcsCourtDescription.Create;
      try
        l_CourtDescription.Name :=  l_CourtList.Strings[l_CourtIDX];
        l_CourtDescription.NeedProcess := l_CourtList.Values[l_CourtIDX, 'Court_Work'].AsBoolean;
        if Tl3LongintList(l_CourtList.Values[l_CourtIDX, 'Court_Source'].AsObject).Count > 0 then
          l_CourtDescription.SourceID := Tl3LongintList(l_CourtList.Values[l_CourtIDX, 'Court_Source'].AsObject)[0]
        else
        begin
          l_CourtDescription.NeedProcess := False;
          l3System.Msg2Log('Не до конца определены параметры Судебных решений для "%s". Автопроставление сабов для него отключено.',[l_CourtDescription.Name]);
        end;
        l_CourtDescription.DecisionPhrases.CopyFrom((l_CourtList.Values[l_CourtIDX, 'Court_Before'].asObject as TddStringDataAdapter).GetStrings);
        Result.CourtsList.Add(l_CourtDescription.TaggedData);
      finally
        FreeAndNil(l_CourtDescription);
      end;
    end;
  end;
end;
 {$IfEnd defined(AppServerSide)}

 {$If defined(AppServerSide)}
function CorrectArchiveWarehousePath(const aPath, aDefaultSuffix: String): String;
begin
 if aPath = '' then
  Result := ConcatDirName(ExtractFileDir(ParamStr(0)), aDefaultSuffix)
 else
  Result := aPath;
end;
 {$IfEnd defined(AppServerSide)}

function IsDayOfWeekByMask(const aDate: TDateTime; const aMask: Integer): Boolean;
var
 l_DOW : Integer;
begin
 l_DOW := DayOfTheWeek(aDate);
 Result := l3TestBit(aMask, l_DOW - 1);
end;


end.


