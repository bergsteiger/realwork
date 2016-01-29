unit alcuRegionLoader;
{ Загрузка файлов, измененных в регионе }


{ $Id: alcuRegionLoader.pas,v 1.7 2015/06/16 12:30:50 lukyanets Exp $ }

// $Log: alcuRegionLoader.pas,v $
// Revision 1.7  2015/06/16 12:30:50  lukyanets
// Новый Indy 10
//
// Revision 1.6  2015/04/07 07:35:52  lukyanets
// Изолируем HT
//
// Revision 1.5  2014/09/05 12:38:58  lukyanets
// Рожаем RegionImportTask
//
// Revision 1.4  2014/09/02 10:29:04  lukyanets
// Учим экспорт в разные регионы работать одновременно
//
// Revision 1.3  2014/08/08 10:25:04  fireton
// - сортируем имена файлов, полученных с FTP
//
// Revision 1.2  2014/08/01 11:30:32  lukyanets
// {Requestlink:558466572}. Переопределяем Define
//
// Revision 1.1  2014/07/28 11:45:23  lukyanets
// {Requestlink:557844282}. Прикручиваем серверный ddAppConfig
//
// Revision 1.15  2014/02/14 15:33:23  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.14  2014/02/12 12:39:12  lulin
// - рефакторим списки заданий.
//
// Revision 1.13  2011/02/02 09:32:56  narry
// 250904861. Перейти на ZipForge
//
// Revision 1.12  2010/07/06 12:27:02  narry
// - К222759027
//
// Revision 1.11  2010/05/14 13:18:05  narry
// - K211878137
// - настройка для ААС
//
// Revision 1.10  2010/04/20 08:55:42  narry
// - информационные сообщения ошибок подключения к FTP
//
// Revision 1.9  2010/02/25 06:38:10  narry
// - удаление зависимости проектов от парня
// - выключение обработки очереди заданий на время еженедельного обновления
//
// Revision 1.8  2009/11/10 08:20:06  narry
// - обновление
// - экспорт произвольных аннотаций в Прайм
//
// Revision 1.7  2009/05/27 12:29:20  narry
// - Обновление
//
// Revision 1.6  2009/02/16 14:33:41  narry
// - поддержка пассивного режима FTP
//
// Revision 1.5  2008/10/13 12:38:41  narry
// - промежуточное обновление
//
// Revision 1.4  2008/02/06 09:27:11  narry
// - не компилировалось
// - новый параметр в конфигруации (файл архива кс)
//
// Revision 1.3  2008/02/04 12:25:24  narry
// - не компилировалось
//
// Revision 1.2  2007/11/12 09:11:10  narry
// - накопилось: чистка кода, окошко "О программе",  поддержка внешних словарей, исправление "метки 20005", "Английская база"
//
// Revision 1.1  2007/08/22 13:31:50  narry
// - механизм загрузки документов с FTP
//

interface

{$I alcuDefine.inc}

Uses
 l3Base, l3ObjectRefList,
 idFTP,
 ddServerTask,
 Classes, l3LongintList, alcuImport

{$If defined(AppServerSide)}
 ,
 alcuTaskListPrim
{$IfEnd defined(AppServerSide)}
 ;

type
 TalcuRegionLoader = class(Tl3Base)
 private
  f_Description: string;
  f_FileNameMask: string;
  f_FTPFolder: string;
  f_FTPPort: Integer;
  f_FTPServer: string;
  f_FTPLogin: string;
  f_FTPPassive: Boolean;
  f_FTPPassword: string;
  f_NotifyAddress: string;
{$If defined(AppServerSide)}
  f_TaskList: TalcuTaskListPrim;
{$IfEnd defined(AppServerSide)}
  f_TempFolder: string;
  function GetFile(aFileName: String): Boolean;
  function pm_GetConnected: Boolean;
  function pm_GetFTPFolder: string;
  procedure pm_SetFTPFolder(const Value: string);
  function PrepareFile(afileName: String; aTask: TalcuImport): Boolean;
  function TrueFileNameMask: string;
  function UnZipFile(afileName: String; aTask: TalcuImport): Boolean;
 protected
  f_FTP: TidFTP;
  procedure Cleanup; override;
  function CompareWithMask(aMask, aText: String): Boolean;
  procedure Connect;
  procedure Disconnect;
{$If defined(AppServerSide)}
  procedure GetFiles;
  procedure MakeImportTask(afileName: String);
{$IfEnd defined(AppServerSide)}
 public
  constructor Create;
  procedure ChangeFolder;
{$If defined(AppServerSide)}
  procedure FillTaskList;
{$IfEnd defined(AppServerSide)}
  property Connected: Boolean read pm_GetConnected;
  property Description: string read f_Description write f_Description;
  property FileNameMask: string read f_FileNameMask write f_FileNameMask;
  property FTPFolder: string read pm_GetFTPFolder write pm_SetFTPFolder;
  property FTPPort: Integer read f_FTPPort write f_FTPPort;
  property FTPServer: string read f_FTPServer write f_FTPServer;
  property FTPLogin: string read f_FTPLogin write f_FTPLogin;
  property FTPPassive: Boolean read f_FTPPassive write f_FTPPassive;
  property FTPPassword: string read f_FTPPassword write f_FTPPassword;
  property NotifyAddress: string read f_NotifyAddress write f_NotifyAddress;
{$If defined(AppServerSide)}
  property TaskList: TalcuTaskListPrim read f_TaskList;
{$IfEnd defined(AppServerSide)}
  property TempFolder: string read f_TempFolder write f_TempFolder;
 end;

 TalcuRegionManager = class(Tl3ObjectRefList)
 end;

//var
// alcuRegions: TalcuRegionManager;
 
implementation

Uses
 daInterfaces,
 SysUtils,
 alcuZipUtils,
 ddFileIterator,
 l3FileUtils,
 IdAssignedNumbers;

constructor TalcuRegionLoader.Create;
begin
 inherited;
 f_FTP := TIdFTP.Create(nil);
{$If defined(AppServerSide)}
 f_TaskList := TalcuTaskListPrim.Create;
{$IfEnd defined(AppServerSide)}
 f_FTPPort := IDPORT_FTP;
 f_FTPPassive:= False;
end;

procedure TalcuRegionLoader.ChangeFolder;
begin
 { TODO : Неплохо было бы проверить наличие папки }
 f_FTP.ChangeDir(f_FTPFolder);
end;

procedure TalcuRegionLoader.Cleanup;
begin
{$If defined(AppServerSide)}
 l3Free(f_TaskList);
{$IfEnd defined(AppServerSide)}
 l3Free(f_FTP);
 inherited;
end;

function TalcuRegionLoader.CompareWithMask(aMask, aText: String): Boolean;
var
 i: Integer;
 l_Mask: String;
begin
 Result := False;
 l_Mask:= TrueFileNameMask;
 if Length(l_Mask) = Length(aText) then
 begin
  for i:= 1 to Length(l_Mask) do
   if l_Mask[i] = '?' then
    l_Mask[i]:= aText[i];
  Result:= AnsiCompareText(l_Mask, aText) = 0;
 end; // Length(aMask) = Length(aText)
end;

procedure TalcuRegionLoader.Connect;
begin
 if FTPServer <> '' then
 begin
  f_FTP.Host := FTPServer;
  f_FTP.Port := FTPPort;
  f_FTP.Username := FTPLogin;
  f_FTP.Password := FTPPassword;
  f_FTP.Passive:= FTPPassive;
  try
   f_FTP.Connect;
  except
   on E: Exception do
    l3System.Msg2Log('не удалось подключиться к FTP: %s', [E.Message]);
  end;
 end; // FTPHost <> ''
end;

procedure TalcuRegionLoader.Disconnect;
begin
 f_FTP.Disconnect;
end;

{$If defined(AppServerSide)}
procedure TalcuRegionLoader.FillTaskList;
begin
 try
  Connect;
  try
   GetFiles;
  finally
   Disconnect;
  end;
 except
  on E: Exception do
   l3System.Msg2Log('Ошибка "%s" обработки источника дельты', [E.Message])
 end;
end;
{$IfEnd defined(AppServerSide)}

function TalcuRegionLoader.GetFile(aFileName: String): Boolean;
begin
 Result := False;
 if Connected then
  try
   f_FTP.Get(aFileName, ConcatDirName(TempFolder, aFileName), True);
   Result := True;
  except
   on E: Exception do
    l3System.Msg2Log('Не удалось получить %s с FTP: %s', [aFileName, E.Message]);
  end;
  if Result then
  try
   f_FTP.Delete(aFileName);
  except
   on E: Exception do
    l3System.Msg2Log('Не удалось удалить %s с FTP', [aFileName, E.Message]);
  end;
end;

{$If defined(AppServerSide)}
procedure TalcuRegionLoader.GetFiles;
var
 l_List: TStringList;
 i: Integer;
 l_S: String;
begin
 if Connected then
 try
  l_List:= TStringList.Create;
  try
   ChangeFolder;
   f_FTP.List(TrueFileNameMask, False);
   l_List.Assign(f_FTP.ListResult);
   l_List.Sort;
   for i:= 0 to Pred(l_List.Count) do
   begin
    l_S := Copy(l_List.Strings[i], 3, Length(l_List.Strings[i]));
    makeImportTask(l_S);
   end;
  finally
   l3Free(l_List);
  end;
 except
  on E:Exception do
   l3System.Msg2Log('Не удалось получить файлы с FTP: %s', [E.Message]);
 end;
end;
{$IfEnd defined(AppServerSide)}

{$If defined(AppServerSide)}
procedure TalcuRegionLoader.MakeImportTask(afileName: String);
var
 l_Task: TalcuImport;
begin
 l3System.Msg2Log('Обработка файла %s', [ExtractFileName(aFileName)]);
 l_Task := TalcuImport.Create({nil, }usServerService);
 try
  l_Task.Description:= Description;
  with l_Task do
  begin
   NeedSendMailReport := True;
   TaskFolder := TempFolder;
   ReplyAddress:= NotifyAddress;
   DeleteIncluded := True;
   if PrepareFile(aFilename, l_Task) then
    f_taskList.Add(l_Task);
  end; // with l_Task
 finally
  l3Free(l_task);
 end;
end;
{$IfEnd defined(AppServerSide)}

function TalcuRegionLoader.pm_GetConnected: Boolean;
begin
 Result := f_FTP.Connected;
end;

function TalcuRegionLoader.pm_GetFTPFolder: string;
begin
 Result := StringReplace(f_FTPFolder, '/', '\', [rfReplaceAll]);
end;

procedure TalcuRegionLoader.pm_SetFTPFolder(const Value: string);
begin
 f_FTPFolder := StringReplace(Value, '\', '/', [rfReplaceAll]);
end;

function TalcuRegionLoader.PrepareFile(afileName: String; aTask: TalcuImport): Boolean;
begin
 Result := GetFile(aFileName) and UnZipFile(aFileName, aTask);
 DeleteFile(ConcatDirName(TempFolder, aFileName));
end;

function TalcuRegionLoader.TrueFileNameMask: string;
var
 i: Integer;
begin
 Result:= FileNameMask;
 for i:= 1 to Length(Result) do
  if Result[i] in ['D', 'M', 'Y'] then
   Result[i]:= '?';
end;

function TalcuRegionLoader.UnZipFile(afileName: String; aTask: TalcuImport): Boolean;
var
 i: Integer;
 l_Stream: TStream;
 l_FileName, l_Folder: String;
begin
 Result := False;
 l_Folder:= aTask.TaskFolder; 
 ForceDirectories(l_Folder);
 Result:= UnzipFiles(ConcatDirName(TempFolder, aFileName), l_Folder);
end;

end.
