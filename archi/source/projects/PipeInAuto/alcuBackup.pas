unit alcuBackup;

interface

uses ddServerBaseEngine;

function DoMakeFamilyBackup: Boolean;

function DoMakeFullBackup(aBaseEngine: TServerbaseEngine; const aDestination: String): Boolean;

procedure ClearYesterdayBases;

function CheckBackup(aFrom, aTo: ShortString): Boolean;

function GetYesterdayPath(const aLast: Boolean = False): string;

implementation

uses l3base, alcuStrings, SysUtils, StrUtils, ddAppConfig, DateUtils, Types, Math, l3FileUtils,
 ddUtils, StdAteSt, l3Date, DT_Serv, DT_Const, StStrS, StFileOp, alcuMsgDlg, Controls, Classes,
 ddFileIterator;

function DoMakeFamilyBackup: Boolean;
var
 S, l_Msg, l_YesterdayPath: string;
 l_suffix: Integer;
 l_Handle: Integer;
begin
   l3System.Msg2Log(SalcuAutoPipeServer_Naalokopirovaniyabazy);
   ClearYesterdayBases;
   l_YesterdayPath:= ExpandFileName(GetYesterdayPath);
   PureDir(l_YesterdayPath); // Очистка предыдущей копии
   CopyFolder(ExcludeTrailingBackslash(GlobalHtServer.FamilyTbl.FamilyPath(CurrentFamily)), l_YesterdayPath, False);
   l3System.Msg2Log(SalcuAutoPipeServer_Proverkatonostikopii);
   Result:= CheckBackup(ExcludeTrailingBackslash(GlobalHtServer.FamilyTbl.FamilyPath(CurrentFamily)),
                          ConcatDirName(l_YesterdayPath,
                                        GlobalHtServer.FamilyTbl.GetFamilyName(1)));
   if Result then
   begin
    // Создание файла даты базы
    S:= StDateToDateString(SalcuAutoPipeServer_DdNnnnnnnnnnnnYyyy, CurrentDate, True);
    l_Handle:= FileCreate(ConcatDirName(l_YesterdayPath, SalcuAutoPipeServer_DateOfBaseTxt));
    try
     FileWrite(l_Handle, S[1], Length(S));
    finally
     FileClose(l_Handle);
    end;
    l_Msg:= SalcuAutoPipeServer_Kopirovaniebazyzaversheno;
   end; // result
end;

function DoMakeFullBackup(aBaseEngine: TServerbaseEngine; const aDestination: String): Boolean;
var
  S, l_Msg,
  l_SourFolder, l_DestFolder: string;
  i: Integer;
begin
  l3System.Msg2Log(SalcuAutoPipeServer_Naalopolnogokopirovaniyabazy);
  try
   l_DestFolder:= ExpandFileName(JustPathNameS(AddBackSlashS(aDestination)));
   l_SourFolder := IfThen(ddAppConfiguration.AsString['LocalBasePath'] = '',
                          ddAppConfiguration.AsString['UNCBasePath'], ddAppConfiguration.AsString['LocalBasePath']);
   PureDir(l_DestFolder); // Очистка предыдущей копии
   if l_SourFolder <> '' then
   begin
    try
     aBaseEngine.Stop;
     CopyFolder(l_SourFolder, l_DestFolder);
     l3System.Msg2Log(SalcuAutoPipeServer_Proverkatonostikopii);
     Result:= CheckBackup(l_SourFolder, l_DestFolder);
    except
      on E: Exception do
      begin
       l_Msg:= SysUtils.Format(SalcuAutoPipeServer_Oshibkasozdaniyapolnoykopiibazy, [l_DestFolder]);
       l3System.Msg2Log(l_Msg);
       Result:= False;
       exit;
      end;
    end; // try except
    aBaseEngine.Start;
    l_Msg:= SalcuAutoPipeServer_Sozdaniepolnoykopiibazyzavershen;
    l3System.Msg2Log(l_Msg);
   end; // l_SourFolder <> ''
  except
   on E: Exception do
   begin
    l_Msg:= SalcuAutoPipeServer_Oshibkakopirovaniyabazy;
    l3System.Msg2Log(l_Msg);
    Result:= False;
   end;
  end;
end;

procedure ClearYesterdayBases;
var
 l_S, l_Folder: string;
 l_Folders: TddFileIterator;
 i: Integer;
begin
 l3System.Msg2Log(SalcuAutoPipeServer_Udaleniestaryhverashnihkopiy);
 //Должно остаться N-1 копий базы
 with ddAppConfiguration do
 begin
  l_Folder:= AsString[SalcuAutoPipeServer_FamilyBackup];
  l_Folders:= TddFileIterator.MakeFolders(l_Folder, '????-??-??*');
  try
   if l_Folders.Count > AsInteger[SalcuAutoPipeServer_EverydayBackupCount] then
    for i:= 0  to l_Folders.Count-AsInteger[SalcuAutoPipeServer_EverydayBackupCount] do
    begin
     l_S:= l_Folders.FileList[i];
     l3System.Msg2Log(SalcuAutoPipeServer_Udalenie + l_S);
     DelDir(l_S);
    end; // for i
  finally
   FreeAndNil(l_Folders);
  end;
 end; // with

 l3System.Msg2Log(SalcuAutoPipeServer_Udaleniestaryhindeksov);
 DeleteFilesByMaskRecur(l_Folder, SalcuAutoPipeServer_Idx);
end; // TddAutoPipeServer.CheckYesterdayBases

function CheckBackup(aFrom, aTo: ShortString): Boolean;
var
  SR_From, SR_TO: TSearchRec;
  l_Msg: String;
  l_Break : Boolean;
begin
  l_Break := False;
  Result:= True;
  try
   if FindFirst(ConcatDirName(aFrom, '*.*'), faAnyFile, SR_From) = 0 then
   begin
    repeat
     if SR_From.Name[1] <> '.' then
     begin
      if faDirectory and SR_From.Attr <> 0 then
       Result:= CheckBackup(ConcatDirName(aFrom, SR_From.Name), ConcatDirName(aTo, SR_From.Name))
      else
      try
       if FindFirst(ConcatDirName(aTo, SR_From.Name), SR_From.Attr, SR_To) = 0 then
       begin
        if (SR_From.Size <> SR_To.Size) and (SR_From.Time <> SR_To.Time) then
        begin
         Result:= False;
         l_msg:= SalcuAutoPipeServer_Kopiyafayla+ConcatDirName(aTo, SR_From.Name)+SalcuAutoPipeServer_Otliaetsyaotoriginala;
        end
        else
         Result := True;
       end
       else
       begin
        l_msg:= SalcuAutoPipeServer_Vkopiiotsutstvuetfayl+ConcatDirName(aTo, SR_From.Name);
        Result:= False;
       end;
      finally
       SysUtils.FindClose(SR_To);
      end; // try..finally

      if not Result then
      begin
       if l_Msg <> '' then
       begin
        l3System.Msg2Log(SalcuAutoPipeServer_Kopiyaotliaetsyaotoriginala, [aTo, aFrom]);
        l3System.Msg2Log(l_Msg);
       end; // l_Msg <> ''
       l_break := True;
      end; // not Result

     end; // SR_From.Name[1] <> '.'
    until (FindNext(sr_from) <> 0) or l_Break;
   end; // FindFirst(ConcatDirName(aFrom, '*.*'), faAnyFile, SR_From) = 0
  finally
   SysUtils.FindClose(SR_FRom);
  end; // try..finally
end;

function GetYesterdayPath(const aLast: Boolean = False): string;
var
 l_Delta: Integer;
begin
 l_Delta:= ifThen(CompareTime(ddAppConfiguration.AsDateTime['WorkDayStart'], Time) = GreaterThanValue, -1, 0);
 Result:= MakeUniqueFolderName(ConcatDirName(ddAppConfiguration.AsString[SalcuAutoPipeServer_FamilyBackup],
                                     StDateToDateString(SalcuAutoPipeServer_YyyyMmDd,
                                            IncDate(CurrentDate, l_Delta, 0, 0),
                                            True)), aLast);
end;

end.
