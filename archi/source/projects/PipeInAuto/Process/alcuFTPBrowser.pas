unit alcuFTPBrowser;

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

uses
  idFTP,

  alcuFTPBrowserParams
  ;

type
 TalcuFTPBrowser = class;
 TalcuEnumFilesCallBack = procedure (const Sender: TalcuFTPBrowser; const aFileName: String; var NeedStop: Boolean) of object;

 TalcuFTPBrowser = class(TalcuFTPBrowserParams)
 private
  f_FTP: TidFTP;
 private
  procedure Connect;
  procedure Disconnect;
  procedure ChangeFolder;
  function DoPutFile(const aFileName: String): Boolean;
  procedure DoEnumFiles(const aFileNameMask: String; const EnumProc: TalcuEnumFilesCallBack);
  function DoGetFile(const aFileName: String; const aTargetFolder: String): Boolean;
  function DoDeleteFile(const aFileName: String): Boolean;
  function pm_GetConnected: Boolean;
 protected
  procedure InitFields; override;
  procedure CleanUp; override;
 public
  function PutFile(const aFileName: String): Boolean;
  procedure EnumFiles(const aFileNameMask: String; const EnumProc: TalcuEnumFilesCallBack);
  function GetFile(const aFileName: String; const aTargetFolder: String): Boolean;
  function DeleteFile(const aFileName: String): Boolean;
  property Connected: Boolean read pm_GetConnected;
 end;//TalcuFTPBrowser

implementation

uses
 Classes,
 SysUtils,

 IdAssignedNumbers,

 l3Base,
 l3FileUtils
 ;

{ TalcuFTPBrowser }

procedure TalcuFTPBrowser.ChangeFolder;
begin
 { TODO : Неплохо было бы проверить наличие папки }
 f_FTP.ChangeDir(StringReplace(RemoteFolder, '\', '/', [rfReplaceAll]));
end;

procedure TalcuFTPBrowser.CleanUp;
begin
 FreeAndNil(f_FTP);
 inherited ClearFields;
end;

procedure TalcuFTPBrowser.Connect;
begin
 if ServerName <> '' then
 begin
  f_FTP.Host := ServerName;
  f_FTP.Port := Port;
  f_FTP.Username := Login;
  f_FTP.Password := Password;
  f_FTP.Passive:= PassiveMode;
  try
   f_FTP.Connect;
   ChangeFolder;
  except
   on E: Exception do
    l3System.Msg2Log('не удалось подключиться к FTP: %s', [E.Message]);
  end;
 end; // ServerName <> ''
end;

procedure TalcuFTPBrowser.Disconnect;
begin
 f_FTP.Disconnect;
end;

procedure TalcuFTPBrowser.DoEnumFiles(const aFileNameMask: String; const EnumProc: TalcuEnumFilesCallBack);
var
 l_List: TStringList;
 i: Integer;
 l_S: String;
 l_NeedStop: Boolean;
begin
 if Connected then
 try
  l_List:= TStringList.Create;
  try
   f_FTP.List(aFileNameMask, False);
   l_List.Assign(f_FTP.ListResult);
   l_List.Sort;
   if l_List.Count = 0 then
    l3System.Msg2Log('%s: файлы не найдены', [LogTitle]);
   l_NeedStop := False;
   for i:= 0 to Pred(l_List.Count) do
   begin
    l_S := Copy(l_List.Strings[i], 3, Length(l_List.Strings[i]));
    EnumProc(Self, l_S, l_NeedStop);
    if l_NeedStop then
     Break;
   end;
  finally
   l3Free(l_List);
  end;
 except
  on E:Exception do
   l3System.Msg2Log('Не удалось получить файлы с FTP: %s', [E.Message]);
 end;
end;

function TalcuFTPBrowser.DoPutFile(const aFileName: String): Boolean;
begin
 Result:= False;
 if Connected then
 try
  f_FTP.Put(aFileName);
  Result:= True;
 except
  on E: Exception do
   l3System.Msg2Log('не удалось поместить %s на FTP: %s', [aFileName, E.Message]);
 end;
end;

function TalcuFTPBrowser.GetFile(const aFileName: String; const aTargetFolder: String): Boolean;
var
 l_NeedConnect: Boolean;
begin
 l_NeedConnect := not Connected;
 if l_NeedConnect then
  Connect;
 try
  Result := DoGetFile(aFileName, aTargetFolder);
 finally
  if l_NeedConnect then
   Disconnect;
 end;
end;

procedure TalcuFTPBrowser.EnumFiles(const aFileNameMask: String; const EnumProc: TalcuEnumFilesCallBack);
var
 l_NeedConnect: Boolean;
begin
 try
  l_NeedConnect := not Connected;
  if l_NeedConnect then
   Connect;
  try
   DoEnumFiles(aFileNameMask, EnumProc);
  finally
   if l_NeedConnect then
    Disconnect;
  end;
 except
  on E: Exception do
   l3System.Msg2Log('Ошибка "%s" при %s', [E.Message, LogTitle])
 end;
end;

procedure TalcuFTPBrowser.InitFields;
begin
 inherited InitFields;
 f_FTP := TidFTP.Create(nil);
end;

function TalcuFTPBrowser.PutFile(const aFileName: String): Boolean;
var
 l_NeedConnect: Boolean;
begin
 l3System.Msg2Log('Копирование архива на FTP...');
 try
  l_NeedConnect := not Connected;
  if l_NeedConnect then
   Connect;
  try
   Result := DoPutFile(aFileName);
   if not Result then
    l3System.Msg2Log('Архив не скопирован. Неверные параметры подключения к FTP');
  finally
   if l_NeedConnect then
    Disconnect;
  end;
 except
  on E: Exception do
   l3System.Msg2Log('Ошибка "%s"  при %s', [E.Message, LogTitle])
 end;
 l3System.Msg2Log('Копирование завершено');
end;

function TalcuFTPBrowser.DoGetFile(const aFileName,
  aTargetFolder: String): Boolean;
begin
 Result := False;
 if Connected then
  try
   f_FTP.Get(aFileName, ConcatDirName(aTargetFolder, aFileName), True);
   Result := True;
  except
   on E: Exception do
    l3System.Msg2Log('Не удалось получить %s с FTP: %s', [aFileName, E.Message]);
  end;
 end;

function TalcuFTPBrowser.pm_GetConnected: Boolean;
begin
 Result := f_FTP.Connected;
end;

function TalcuFTPBrowser.DeleteFile(const aFileName: String): Boolean;
var
 l_NeedConnect: Boolean;
begin
 l_NeedConnect := not Connected;
 if l_NeedConnect then
  Connect;
 try
  Result := DoDeleteFile(aFileName);
 finally
  if l_NeedConnect then
   Disconnect;
 end;
end;

function TalcuFTPBrowser.DoDeleteFile(const aFileName: String): Boolean;
begin
 Result := False;
 if Connected then
  try
   f_FTP.Delete(aFileName);
   Result := True;
  except
   on E: Exception do
    l3System.Msg2Log('Не удалось удалить %s с FTP: %s', [aFileName, E.Message]);
  end;
end;

end.