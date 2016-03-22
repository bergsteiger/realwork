unit DbService;

{ $Id: DbService.pas,v 1.28 2015/11/26 09:46:09 lukyanets Exp $ }
// $Log: DbService.pas,v $
// Revision 1.28  2015/11/26 09:46:09  lukyanets
// КОнстанты переехали
//
// Revision 1.27  2015/07/02 11:41:01  lukyanets
// Описываем словари
//
// Revision 1.26  2015/04/17 11:21:00  lukyanets
// Подчищаем протухшие словари
//
// Revision 1.25  2014/12/25 15:43:51  voba
// - функции восстановления Priority и SortDate
//
// Revision 1.24  2013/04/12 12:48:36  voba
// -add procedure UpcaseDocNumber;
//
// Revision 1.23  2012/12/03 11:01:40  voba
// - tune
//
// Revision 1.22  2011/12/12 14:06:33  fireton
// - DbReformer и DbInfo переехали в DT
//
// Revision 1.21  2011/12/02 07:07:01  fireton
// - не собиралось
//
// Revision 1.20  2011/06/09 13:42:00  fireton
// - не собиралось (DbUtil)
//
// Revision 1.19  2010/12/29 12:17:01  voba
// [k:248195393]
//
// Revision 1.18  2009/06/02 09:37:22  narry
// - корректная работа с диапазонами номеров
//
// Revision 1.17  2009/05/13 13:56:10  voba
// - LNK#K001 не копировал
//
// Revision 1.16  2009/05/04 13:49:58  voba
// - не компилилось, не работало
//
// Revision 1.15  2009/03/05 09:03:47  narry
// - инициализация заданием папки с базой
//
// Revision 1.14  2008/03/25 14:20:12  narry
// - добавлена процедура замены ссылок на элемент словаря
//
// Revision 1.13  2007/06/26 09:14:06  narry
// - поддержка команды !SERVICEINFO
//
// Revision 1.12  2007/05/11 10:39:54  narry
// - процедура обновления FREE доступна из интерфейса
//
// Revision 1.11  2007/05/11 08:24:14  narry
// - исправление ряда ошибок
//
// Revision 1.10  2007/04/19 08:10:50  narry
// - не копировалась access
//
// Revision 1.9  2007/04/17 13:09:19  narry
// - процедура создания произвольной пустой базы
//
// Revision 1.8  2007/03/12 13:55:16  fireton
// - bug fix: не модифицировалось ACCESS.DOCUM_GR
//
// Revision 1.7  2005/09/20 14:40:35  step
// учтено изменение версии БД
//
// Revision 1.6  2005/04/07 18:47:04  step
// доработана TDbService.BuildCopy (учтены новые таблицы, добавлены проверки)
//
// Revision 1.5  2005/02/01 12:00:29  step
// добавлено копирование файла 'insert.lst'
//
// Revision 1.4  2004/10/07 12:14:41  step
// реализована переиндексация
//
// Revision 1.3  2004/09/22 09:11:46  step
// доделано восстановление таблицы
//
// Revision 1.2  2004/08/03 17:08:19  step
// добавлены операции для ремонта БД
//
// Revision 1.1  2004/07/21 16:58:59  step
// утилита по обслуживанию БД - занесена в CVS
//

interface

uses
 Classes,
 l3Types, l3Base,
 DT_DbInfo, DT_DbReformer,
 dt_AttrSchema,
 dt_Const, dt_Types;

type
 TWriteToLogProc = procedure(const aStr: string) of object;

 TDbService = class(Tl3Base)
 private
  f_AdminDstDir: string;
  f_ArchiIniFile: string;
  f_BaseRoot: string;
  f_DbInfo: TDbInfo;
  f_DbReformer: TDbReformer;
  f_DocDstDir: string;
  f_HomesDstDir: string;
  f_ShareDstDir: string;
  f_WriteToLogProc: TWriteToLogProc;
  f_ProgressProc : Tl3ProgressProc;

  procedure CheckFolder(const aCopyDirName: string);
  procedure CopySimpleFile(const aFileName, aSrcDir, aDstDir: string);
  procedure CopyEmptyTable(const aTableName, aSrcDir, aDstDir: string);
  procedure CopyFullTable(const aTableName, aSrcDir, aDstDir: string);
 protected
  procedure Release; override;
  procedure Close;
 public
  constructor Create; reintroduce;
  //procedure Init(aArchiIniFile: string);
  procedure SetDocFamily(const aFamilyName: string);
  procedure GetFamilyNames(aList: TStrings);
  function Information: string; // строка с разделителями #13#10
  procedure Log(const aStr: string);
  procedure DoProgressProc(aState : Byte; aValue: Longint; const aMsg : String = '');
  procedure HeaderToLog(aStr: string);
  procedure LineToLog;
  function IsActive: Boolean;

  procedure ShowTableHolders(const aDirName: string);
  procedure ShowRecordsHolders(const aDirName: string);
  procedure ClearLocks(const aDirName: string);
  procedure CorrectTables(aDicts: TDLTypeSet; aWithUsers: Boolean);
  procedure InitFolder(aFolder: string);
  // основные действия
  procedure MakeCustomCopy(const aCopyDirName: string; aDicts: TDLTypeSet; aWithUsers: Boolean);
  procedure ReindexTable(const aTableName: string);
  procedure ReindexAllTables(const aDirName: string);
  procedure RepairTable(const aTableName: string);
  function  DeleteBadLinkToDict : Integer;
   {* - Удаление провисших линков}
  procedure ReplaceLinks(aTable: TFamTbls; aOldValue, aNewValue: Integer);
  procedure UpdateFreeTables;
  procedure JrnlUnpack(const aTblName: string);
  procedure CorrectForbiddenValue(const aTblName: string);
  procedure UpcaseDocNumber;
  procedure RecoverSortDate;
  procedure RecoverPriority;

  property WriteToLogProc: TWriteToLogProc read f_WriteToLogProc write f_WriteToLogProc;
  property DbInfo: TDbInfo read f_DbInfo;
  property ProgressProc : Tl3ProgressProc read f_ProgressProc write f_ProgressProc;
 end;


implementation

uses
 SysUtils,
 l3FileUtils,
 daTypes,
 daSchemeConsts;

const
 EOL = #13#10;
 c_FamilyName = 'garant';
 c_LogStrLen = 80;

constructor TDbService.Create;
begin
 // пока пусто
end;

procedure TDbService.CheckFolder(const aCopyDirName: string);
const
 c_TestFile = '~testfile.tmp';

var
 l_TmpFile: string;
 l_TmpFileHandle: Integer;
 l_BadCopyDir: Boolean;
begin
 f_BaseRoot  := aCopyDirname;
 f_DocDstDir := ConcatDirName(aCopyDirName, 'garant');
 f_AdminDstDir := ConcatDirName(aCopyDirName, 'main');
 f_ShareDstDir := ConcatDirName(aCopyDirName, 'share');
 f_HomesDstDir := ConcatDirName(aCopyDirName, 'homes');

 ForceDirectories(aCopyDirName);

 if DirectoryExists(aCopyDirName) then
 begin
  l_TmpFile := ConcatDirName(aCopyDirName, c_TestFile);
  l_TmpFileHandle := FileCreate(l_TmpFile);
  try
   l_BadCopyDir := FileExists(ConcatDirName(f_DbInfo.RootFolder, c_TestFile));
  finally
   FileClose(l_TmpFileHandle);
   DeleteFile(l_TmpFile);
  end;
  if l_BadCopyDir then
   raise Exception.Create(Format('Нельзя cкопировать БД в папку "%s".', [aCopyDirName]));
 end;
  // очистка
  if DirectoryExists(f_DocDstDir) then
   DelDir(f_DocDstDir);
  CreateDir(f_DocDstDir);

  if DirectoryExists(f_AdminDstDir) then
   DelDir(f_AdminDstDir);
  CreateDir(f_AdminDstDir);

  if DirectoryExists(f_ShareDstDir) then
   DelDir(f_ShareDstDir);
  CreateDir(f_ShareDstDir);

  if DirectoryExists(f_HomesDstDir) then
   DelDir(f_HomesDstDir);
  CreateDir(f_HomesDstDir);
end;

function TDbService.Information: string;
begin
 if f_DbInfo = nil then
  Result := 'Не задана БД.' + EOL + 'Укажите расположение базы данных.'
 else
  Result := f_DbInfo.Data;
end;

procedure TDbService.GetFamilyNames(aList: TStrings);
begin
 f_DbInfo.GetFamilyNames(aList);
end;

procedure TDbService.Release;
begin
 Close;
end;

(*procedure TDbService.Init(aArchiIniFile: string);
var
 l_LogProc: TShowToUserProc;
begin
 if not FileExists(aArchiIniFile) then
  raise Exception.Create(Format('Файл %s не найден', [aArchiIniFile]));
 f_ArchiIniFile := aArchiIniFile;

 Close;

 f_DbInfo := TDbInfo.Create(f_ArchiIniFile);

 l_LogProc := Log;
 f_DbReformer := MakeReformer(f_DbInfo, l_LogProc, DoProgressProc);
// f_DbReformer.InitLog;
 f_DbReformer.InitHt;
end;
*)

procedure TDbService.SetDocFamily(const aFamilyName: string);
begin
 f_DbInfo.ActiveFamily := aFamilyName;
end;

procedure TDbService.CopyEmptyTable(const aTableName,
                                          aSrcDir,
                                          aDstDir: string);
var
 l_FullSrcName: string;
 l_FullDstName: string;
begin
 l_FullSrcName := ConcatDirName(aSrcDir, ChangeFileExt(aTableName, '.HTB'));
 l_FullDstName := ConcatDirName(aDstDir, ChangeFileExt(aTableName, '.HTB'));
 if FileExists(l_FullSrcName) then
 begin
  CopyFile(l_FullSrcName, l_FullDstName);
  Log('Скопирована таблица ' + aTableName);
 end
 else
  Log(Format('Ошибка при копировании таблицы %s (не найден файл %s).',
             [aTableName, l_FullSrcName]));
end;

procedure TDbService.Log(const aStr: string);
begin
 if Assigned(f_WriteToLogProc) then
  f_WriteToLogProc(aStr);
end;

procedure TDbService.DoProgressProc(aState : Byte; aValue: Longint; const aMsg : String = '');
begin
 if Assigned(f_ProgressProc) then
  f_ProgressProc(aState, aValue, aMsg);
end;

procedure TDbService.CopyFullTable(const aTableName,
                                         aSrcDir,
                                         aDstDir: string);
var
 l_FullSrcName: string;
begin
 l_FullSrcName := ConcatDirName(aSrcDir, ChangeFileExt(aTableName, '.HTB'));
 if FileExists(l_FullSrcName) then
 begin
  CopyFilesByMask(aSrcDir, aDstDir, ChangeFileExt(aTableName, '.h*'));
  CopyFilesByMask(aSrcDir, aDstDir, ChangeFileExt(aTableName, '.tr*'));
  DeleteFile(ConcatDirName(aDstDir, ChangeFileExt(aTableName, '.HLK')));
  Log('Скопирована таблица ' + aTableName);
 end
 else
  Log(Format('Ошибка при копировании таблицы %s (не найден файл %s).',
             [aTableName, l_FullSrcName]));
end;

procedure TDbService.CopySimpleFile(const aFileName, aSrcDir, aDstDir: string);
var
 l_FullSrcName: string;
 l_FullDstName: string;
begin
 l_FullSrcName := ConcatDirName(aSrcDir, aFileName);
 l_FullDstName := ConcatDirName(aDstDir, aFileName);
 if FileExists(l_FullSrcName) then
 begin
  CopyFile(l_FullSrcName, l_FullDstName);
  Log('Скопирован файл ' + aFileName);
 end
 else
  Log(Format('Не удалось скопировать файл %s.', [aFileName]));
end;

procedure TDbService.Close;
begin
 if f_DbReformer <> nil then
 begin
  f_DbReformer.CloseHt;
//  f_DbReformer.CloseLog;
  FreeAndNil(f_DbReformer);
 end;

 if Assigned(f_DbInfo) then
  FreeAndNil(f_DbInfo);
end;

function TDbService.IsActive: Boolean;
begin
 Result := f_DbReformer <> nil;
end;

procedure TDbService.HeaderToLog(aStr: string);
const
 c_StrChar: Char = '=';
var
 l_Header: string;
 l_LineLen: Integer;
begin

 l_Header := ' ' + DateTimeToStr(Now) + ' - ' + aStr + ' ';
 l_LineLen := (c_LogStrLen - 2 - Length(l_Header)) div 2;
 Log(c_StrChar + StringOfChar(c_StrChar, l_LineLen) + l_Header + StringOfChar(c_StrChar, l_LineLen) + c_StrChar);

end;

procedure TDbService.LineToLog;
begin
// Log(StringOfChar('=', c_LogStrLen));
// Log(EOL);
end;

procedure TDbService.ShowTableHolders(const aDirName: string);
var
 l_List: TStringList;
 I: Integer;
begin
 l_List := TStringList.Create;
 try
  f_DbReformer.LockedTables(aDirName, l_List);
  HeaderToLog('Папка: ' + aDirName);
  if l_List.Count = 0 then
   Log('Захваченных таблиц не найдено.')
  else
  begin
   l_List.Sort;
   for I := 0 to l_List.Count - 1 do
    Log(l_List[I]);
  end;
  LineToLog;
 finally
  FreeAndNil(l_List);
 end;
end;

procedure TDbService.ShowRecordsHolders(const aDirName: string);
var
 l_List: TStringList;
 I: Integer;
begin
 l_List := TStringList.Create;
 try
  f_DbReformer.LockedRecords(aDirName, l_List);
  HeaderToLog('Папка: ' + aDirName);
  if l_List.Count = 0 then
   Log('Захваченных записей не найдено.')
  else
  begin
   l_List.Sort;
   for I := 0 to l_List.Count - 1 do
    Log(l_List[I]);
  end;
  LineToLog;
 finally
  FreeAndNil(l_List);
 end;
end;

procedure TDbService.ClearLocks(const aDirName: string);
begin
 f_DbReformer.ClearAllBadLocks(aDirName);
end;

procedure TDbService.CorrectTables(aDicts: TDLTypeSet; aWithUsers: Boolean);
var
 l_DBInfo: TDBInfo;
 l_Reformer: TDBReformer;
 l_LogProc: TShowToUserProc;
begin
 HeaderToLog('Внесение изменений в таблицы...');
 l_DBInfo := TDBInfo.Make(f_BaseRoot, f_HomesDstDir, f_AdminDstDir, f_ShareDstDir);
 try
  Close;
  l_LogProc := Log;
  l_Reformer := MakeReformer(l_DBInfo, L_LogProc, DoProgressProc);
  try
   l_Reformer.InitHt;
   l_Reformer.AddDefaultValues(aDicts, aWithUsers);
   l_Reformer.CorrectFreeTables;
   l_Reformer.CloseHt;
  finally

   l3Free(l_Reformer);
  end;
  //Init(f_ArchiIniFile); //????
 finally
  l3Free(l_DBInfo);
 end;
 HeaderToLog('Внесение изменений в таблицы завершено');
end;

procedure TDbService.InitFolder(aFolder: string);
var
 l_LogProc: TShowToUserProc;
begin
 if not DirectoryExists(aFolder) then
  raise Exception.Create(Format('Папка %s не найдена', [aFolder]));
 f_ArchiIniFile := '';
 Close;
 f_DbInfo := TDbInfo.make(aFolder);

 l_LogProc := Log;
 f_DbReformer := MakeReformer(f_DbInfo, l_LogProc, DoProgressProc);
 f_DbReformer.InitHt;
end;

{ TDbService }

procedure TDbService.MakeCustomCopy(const aCopyDirName: string; aDicts: TDLTypeSet; aWithUsers: Boolean);
var
 l_TmpFile: string;
 l_TmpFileHandle: Integer;
 l_BadCopyDir: Boolean;
begin
 // а проверим-ка БД на "старость"
 f_DbInfo.CheckFolderVersions;
                     (*
                     da_dlSources, da_dlTypes, da_dlClasses, da_dlKeyWords, da_dlBases,
                     da_dlWarnings, da_dlCorSources, da_dlPublisheds,
                     da_dlPrefixes, da_dlTerritories, da_dlNorms, da_dlAccGroups,
                     da_dlAnnoClasses
                     *)
 // проверка на копирование в самого себя
 CheckFolder(aCopyDirName);

 // собственно копирование
 // папка GARANT
 Log('=== Копирование БД началось ===');

  CopyEmptyTable('ACTIV001',   DbInfo.FamilyFolder, f_DocDstDir);
  CopyEmptyTable('ALARM001',   DbInfo.FamilyFolder, f_DocDstDir);
  CopyEmptyTable('CTRL001',    DbInfo.FamilyFolder, f_DocDstDir);
  if da_dlSources in aDicts then
   CopyFullTable('DT#1001',   DbInfo.FamilyFolder, f_DocDstDir)
  else
   CopyEmptyTable('DT#1001',   DbInfo.FamilyFolder, f_DocDstDir);
  if da_dlTypes in aDicts then
   CopyFullTable('DT#2001',   DbInfo.FamilyFolder, f_DocDstDir)
  else
   CopyEmptyTable('DT#2001',   DbInfo.FamilyFolder, f_DocDstDir);
  if da_dlClasses in aDicts then
  begin
   CopyFullTable('DT#3001',   DbInfo.FamilyFolder, f_DocDstDir);
   CopyFullTable('DT#3E001',  DbInfo.FamilyFolder, f_DocDstDir);
  end
  else
  begin
   CopyEmptyTable('DT#3001',   DbInfo.FamilyFolder, f_DocDstDir);
   CopyEmptyTable('DT#3E001',  DbInfo.FamilyFolder, f_DocDstDir);
  end;
  if da_dlKeywords in aDicts then
  begin
   CopyFullTable('DT#5001',   DbInfo.FamilyFolder, f_DocDstDir);
//   CopyFullTable('DT#5e001',   DbInfo.FamilyFolder, f_DocDstDir);
  end
  else
  begin
   CopyEmptyTable('DT#5001',   DbInfo.FamilyFolder, f_DocDstDir);
//   CopyEmptyTable('DT#5e001',  DbInfo.FamilyFolder, f_DocDstDir);
  end;
  if da_dlBases in aDicts then
   CopyFullTable('DT#6001',   DbInfo.FamilyFolder, f_DocDstDir)
  else
   CopyEmptyTable('DT#6001',   DbInfo.FamilyFolder, f_DocDstDir);
  CopyEmptyTable('DT#7001',   DbInfo.FamilyFolder, f_DocDstDir);
  if da_dlWarnings in aDicts then
   CopyFullTable('DT#8001',   DbInfo.FamilyFolder, f_DocDstDir)
  else
   CopyEmptyTable('DT#8001',   DbInfo.FamilyFolder, f_DocDstDir);
  CopyEmptyTable('DT#9001',   DbInfo.FamilyFolder, f_DocDstDir);
  if da_dlCorSources in aDicts then
  begin
   CopyFullTable('DT#A001',   DbInfo.FamilyFolder, f_DocDstDir);
   CopyFullTable('DT#B001',   DbInfo.FamilyFolder, f_DocDstDir);
  end
  else
  begin
   CopyEmptyTable('DT#A001',   DbInfo.FamilyFolder, f_DocDstDir);
   CopyEmptyTable('DT#B001',   DbInfo.FamilyFolder, f_DocDstDir);
  end;
  if da_dlPrefixes in aDicts then
   CopyFullTable('DT#C001',   DbInfo.FamilyFolder, f_DocDstDir)
  else
   CopyEmptyTable('DT#C001',   DbInfo.FamilyFolder, f_DocDstDir);
  if da_dlTerritories in aDicts then
   CopyFullTable('DT#D001',   DbInfo.FamilyFolder, f_DocDstDir)
  else
   CopyEmptyTable('DT#D001',   DbInfo.FamilyFolder, f_DocDstDir);
  if da_dlNorms in aDicts then
   CopyFullTable('DT#E001',   DbInfo.FamilyFolder, f_DocDstDir)
  else
   CopyEmptyTable('DT#E001',   DbInfo.FamilyFolder, f_DocDstDir);
  if da_dlTerritories in aDicts then
   CopyFullTable('DT#D001',   DbInfo.FamilyFolder, f_DocDstDir)
  else
   CopyEmptyTable('DT#D001',   DbInfo.FamilyFolder, f_DocDstDir);
  if da_dlNorms in aDicts then
   CopyFullTable('DT#E001',   DbInfo.FamilyFolder, f_DocDstDir)
  else
   CopyEmptyTable('DT#E001',   DbInfo.FamilyFolder, f_DocDstDir);
  if da_dlAccGroups in aDicts then
   CopyFullTable('DT#F001',   DbInfo.FamilyFolder, f_DocDstDir)
  else
   CopyEmptyTable('DT#F001',   DbInfo.FamilyFolder, f_DocDstDir);
  if da_dlNewClasses_Deprecated in aDicts then
  begin
   Assert(False, 'Deprecated dlNewClasses');
//   CopyFullTable('DT#G001',   DbInfo.FamilyFolder, f_DocDstDir);
//   CopyFullTable('DT#GE001',  DbInfo.FamilyFolder, f_DocDstDir);
  end
  else
  begin
//   CopyEmptyTable('DT#G001',   DbInfo.FamilyFolder, f_DocDstDir);
//   CopyEmptyTable('DT#GE001',  DbInfo.FamilyFolder, f_DocDstDir);
  end;
  if da_dlAnnoClasses in aDicts then
   CopyFullTable('DT#I001',   DbInfo.FamilyFolder, f_DocDstDir)
  else
   CopyEmptyTable('DT#I001',   DbInfo.FamilyFolder, f_DocDstDir);
  if da_dlServiceInfo in aDicts then
   CopyFullTable('DT#J001',   DbInfo.FamilyFolder, f_DocDstDir)
  else
   CopyEmptyTable('DT#J001',   DbInfo.FamilyFolder, f_DocDstDir);

  CopyEmptyTable('FILE001',    DbInfo.FamilyFolder, f_DocDstDir);
  CopyEmptyTable('FREE001',   DbInfo.FamilyFolder, f_DocDstDir);
  CopyEmptyTable('HLINK001',   DbInfo.FamilyFolder, f_DocDstDir);
  CopyEmptyTable('LNK#1001',   DbInfo.FamilyFolder, f_DocDstDir);
  CopyEmptyTable('LNK#2001',   DbInfo.FamilyFolder, f_DocDstDir);
  CopyEmptyTable('LNK#3001',   DbInfo.FamilyFolder, f_DocDstDir);
//  CopyEmptyTable('LNK#4001',   DbInfo.FamilyFolder, f_DocDstDir);
  CopyEmptyTable('LNK#5001',   DbInfo.FamilyFolder, f_DocDstDir);
  CopyEmptyTable('LNK#6001',   DbInfo.FamilyFolder, f_DocDstDir);
  CopyEmptyTable('LNK#7001',   DbInfo.FamilyFolder, f_DocDstDir);
  CopyEmptyTable('LNK#8001',   DbInfo.FamilyFolder, f_DocDstDir);
  CopyEmptyTable('LNK#9001',   DbInfo.FamilyFolder, f_DocDstDir);
//  CopyEmptyTable('LNK#A001',   DbInfo.FamilyFolder, f_DocDstDir);
  CopyEmptyTable('LNK#B001',   DbInfo.FamilyFolder, f_DocDstDir);
  CopyEmptyTable('LNK#C001',   DbInfo.FamilyFolder, f_DocDstDir);
  CopyEmptyTable('LNK#D001',   DbInfo.FamilyFolder, f_DocDstDir);
  CopyEmptyTable('LNK#E001',   DbInfo.FamilyFolder, f_DocDstDir);
  CopyEmptyTable('LNK#F001',   DbInfo.FamilyFolder, f_DocDstDir);
//  CopyEmptyTable('LNK#G001',   DbInfo.FamilyFolder, f_DocDstDir);
  CopyEmptyTable('LNK#I001',   DbInfo.FamilyFolder, f_DocDstDir);
  CopyEmptyTable('LNK#H001',   DbInfo.FamilyFolder, f_DocDstDir);
  CopyEmptyTable('LNK#J001',   DbInfo.FamilyFolder, f_DocDstDir);
  CopyEmptyTable('LNK#K001',   DbInfo.FamilyFolder, f_DocDstDir);
  CopyEmptyTable('LOG001',     DbInfo.FamilyFolder, f_DocDstDir);
  if (da_dlSources in aDicts) and (da_dlTypes in aDicts) then
   CopyFullTable('PRIOR001',  DbInfo.FamilyFolder, f_DocDstDir)
  else
   CopyEmptyTable('PRIOR001',  DbInfo.FamilyFolder, f_DocDstDir);
  CopyEmptyTable('RENUM001',  DbInfo.FamilyFolder, f_DocDstDir);
  CopyEmptyTable('STAGE001',   DbInfo.FamilyFolder, f_DocDstDir);
  CopyEmptyTable('SUB001',     DbInfo.FamilyFolder, f_DocDstDir);


  CopySimpleFile('base.ini',   DbInfo.FamilyFolder, f_DocDstDir);

 // папка MAIN

  CopyEmptyTable('BB_LOG',     DbInfo.MainFolder, f_AdminDstDir);
  CopyEmptyTable('CTRL',      DbInfo.MainFolder, f_AdminDstDir);
    CopyFullTable('DICTSRC',  DbInfo.MainFolder, f_AdminDstDir);
    CopyFullTable('FAMILY',    DbInfo.MainFolder, f_AdminDstDir);
  CopyEmptyTable('FREE',      DbInfo.MainFolder, f_AdminDstDir);
  CopyFullTable('REGIONS', DbInfo.MainFolder, f_AdminDstDir);
  if aWithUsers then
  begin
   CopyFullTable('GUDT',      DbInfo.MainFolder, f_AdminDstDir);
   CopyFullTable('GULNK',     DbInfo.MainFolder, f_AdminDstDir);
   CopyFullTable('PASS',      DbInfo.MainFolder, f_AdminDstDir);
   CopyFullTable('USERS',     DbInfo.MainFolder, f_AdminDstDir);
   CopyFullTable('ACCESS',    DbInfo.MainFolder, f_AdminDstDir);
  end
  else
  begin
   CopyEmptyTable('GUDT',      DbInfo.MainFolder, f_AdminDstDir);
   CopyEmptyTable('GULNK',     DbInfo.MainFolder, f_AdminDstDir);
   CopyEmptyTable('PASS',      DbInfo.MainFolder, f_AdminDstDir);
   CopyEmptyTable('USERS',     DbInfo.MainFolder, f_AdminDstDir);
   CopyEmptyTable('ACCESS',    DbInfo.MainFolder, f_AdminDstDir);
  end;
  CopySimpleFile('base.ini',   DbInfo.MainFolder, f_AdminDstDir);
  CopySimpleFile('insert.evd', DbInfo.MainFolder, f_AdminDstDir);

  Log('=== Копирование БД завершено ===');
end;

procedure TDbService.ReindexTable(const aTableName: string);
begin
 HeaderToLog('Индексация таблицы ' + aTableName);
 f_DbReformer.ReindexTable(aTableName);
 LineToLog;
end;

procedure TDbService.ReindexAllTables(const aDirName: string);
begin
 HeaderToLog('Индексация всех таблиц в папке ' + aDirName);
 f_DbReformer.ReindexAllTables(aDirName);
 LineToLog;
end;

procedure TDbService.RepairTable(const aTableName: string);
begin
 HeaderToLog('Проверка таблицы ' + aTableName);
 if f_DbReformer.IsTableCorrect(aTableName) then
  Log('Ошибок не найдено.')
 else
 begin
  Log('Обнаружены ошибки.');
  f_DbReformer.RepairTable(aTableName);
  Log('Ошибки исправлены.');
 end;
 LineToLog;
end;

function TDbService.DeleteBadLinkToDict : Integer;
begin
 HeaderToLog('Восстановление соответствия Link-Dict');
 f_DBReformer.DeleteBadLinkRec(CurrentFamily);
end;

procedure TDbService.ReplaceLinks(aTable: TFamTbls; aOldValue, aNewValue: Integer);
begin
 HeaderToLog('Замена ссылок на элементы словаря');
 f_DBReformer.ReplaceLinks(aTable, aOldValue, aNewValue);
 Log('Исправление завершено');
 LineToLog;
end;

procedure TDbService.UpdateFreeTables;
begin
 HeaderToLog('Исправление таблиц FREE');
 f_DBReformer.CorrectFreeTables;
 Log('Исправление завершено');
 LineToLog;
end;

procedure TDbService.JrnlUnpack(const aTblName: string);
begin
 HeaderToLog('Распаковка '+aTblName);
 f_DBReformer.JournalUnpack(aTblName);
 Log('Распаковка завершена');
 LineToLog;
end;

procedure TDbService.CorrectForbiddenValue(const aTblName: string);
begin
 //HeaderToLog('Исправление запрещенных значений' + aTblName);
 f_DBReformer.CorrectForbiddenValue(aTblName);
 //Log('Исправление завершено');
 LineToLog;
end;

procedure TDbService.UpcaseDocNumber;
var
 lTblName : string;

begin
 lTblName := ConcatDirName(DbInfo.FamilyFolder, 'dt#7001');
 HeaderToLog('Поднимаем регистр номерам документов');
 f_DBReformer.UpcaseFieldValue(lTblName, 3 {номер поля});
 Log('Исправление завершено');
 LineToLog;
end;

procedure TDbService.RecoverSortDate;
begin
 HeaderToLog('Восстанавливаем дату сортировки');
 f_DBReformer.RecoverSortDate;
 Log('Исправление завершено');
 LineToLog;
end;


procedure TDbService.RecoverPriority;
begin
 HeaderToLog('Восстанавливаем важность');
 f_DBReformer.RecoverPriority;
 Log('Исправление завершено');
 LineToLog;
end;

end.

