unit alcuFTPUtils;
{ Сервисные функции для упрощения доступа к FTP }

{ $Id: alcuFTPUtils.pas,v 1.4 2015/10/16 08:49:34 fireton Exp $ }

// $Log: alcuFTPUtils.pas,v $
// Revision 1.4  2015/10/16 08:49:34  fireton
// - откатываем обратно. не всё так просто...
//
// Revision 1.3  2015/10/15 11:26:21  fireton
// - не сравниваем имена файлов с помощью AnsiEndsText
//
// Revision 1.2  2014/09/01 08:16:58  lukyanets
// Готовимся выделить FTPBrowser
//
// Revision 1.1  2014/08/04 13:12:39  lukyanets
// {Requestlink:558466572}. Отцепляем HavanskyExport
//
// Revision 1.7  2013/01/11 12:14:40  narry
// * автоматическая упаковка результатов экспорта Хаванского (ЭХ)
// * автоматическое копироване ЭХ на FTP
// * дельта экспорта МЦФР
//
// Revision 1.6  2012/10/18 07:37:18  narry
// Обновление
//
// Revision 1.5  2012/10/04 07:04:19  narry
// Поддержка экспортов Хаванского и МЦФР
//
// Revision 1.4  2011/08/10 11:05:50  narry
// - Не собиралось
//
// Revision 1.3  2011/08/09 12:14:03  narry
// Падает обновление автопростановщика (278833103)
//
// Revision 1.2  2011/06/02 13:21:05  narry
// Прикрутить обновление кэшей автопростановщика к Парню (266406580)
//
// Revision 1.1  2011/05/17 12:59:35  narry
// Прикрутить обновление кэшей автопростановщика к Парню (266410319)
//

interface

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

procedure PutFolderToFTP(const LocalFolder, FTPServer, FTPLogin, FTPPassword,
    FTPFolder: String; FTPPort: Integer; FTPPassive: Boolean);

procedure GetFolderFromFTP(const RemoteFolder, LocalFolder: String; FTPServer,
    FTPLogin, FTPPassword, FTPFolder: string; FTPPort: Integer; FTPPassive:
    Boolean);

procedure PutFileToFTP(const FileName, FTPServer, FTPLogin, FTPPassword,
    FTPFolder: String; FTPPort: Integer; FTPPassive: Boolean); overload;

procedure GetFileFromFTP(const FileName, LocalFolder, FTPServer, FTPLogin,
    FTPPassword, FTPFolder: String; FTPPort: Integer; FTPPassive: Boolean);

  {$If defined(AppServerSide)}
procedure PutFileToFTP(const FileName, FTPPrefix: String); overload;
  {$IfEnd defined(AppServerSide)}

implementation

uses
  idFTP, IdBaseComponent, SysUtils, l3FileUtils, IdAssignedNumbers, Classes,
  StrUtils, l3Base, ddAppConfig;

function FTPFolderToLocalFolder(const aFTPFolder: String): string;
begin
 Result := StringReplace(aFTPFolder, '/', '\', [rfReplaceAll]);
end;

function LocalFolderToFTPFolder(const aLocalFolder: string): string;
begin
 Result:= StringReplace(aLocalFolder, '\', '/', [rfReplaceAll]);
end;


procedure lp_PutFileToFTP(aFTP: TIdFTP; const aFileName: string);
begin
 if aFTP.Connected then
  aFTP.Put(aFileName);
end;

procedure lp_GetFileFromFTP(aFTP: TIdFTP; const aSrcFileName, aDestFileName: string);
var
 l_List: TStrings;
 i: Integer;
begin
 if aFTP.Connected then
 begin
  // Нужно проверить есть ли такой файл на FTP
  l_List:= TStringList.Create;
  try
   aFTP.List(l_List, '*.*', False);
   for i:= 0 to Pred(l_List.Count) do
   if AnsiEndsText(aSrcFileName, l_List[i]) then
   begin
    aFTP.get(aSrcFileName, aDestFileName, True);
    break;
   end;
  finally
   FreeAndNil(l_List);
  end;
 end;
end;

function lp_MakeFTP(const FTPServer, FTPLogin, FTPPassword, FTPFolder: string;
    FTPPassive: Boolean; FTPPort: Integer = IdPORT_FTP): TidFTP;
begin
 Result:= TidFTP.Create;
 try
  Result.Host := FTPServer;
  Result.Port := FTPPort;
  Result.Username := FTPLogin;
  Result.Password := FTPPassword;
  Result.Passive:= FTPPassive;
  Result.Connect;
 except
  on E: Exception do
   l3System.Msg2Log('Не удалось подключиться к FTP. Причина: %s', [E.Message]);
 end;
end;

procedure lp_DestroyFTP(var aFTP: TidFTP);
begin
 try
  aFTP.Disconnect;
 finally
  FreeAndNil(aFTP);
 end;
end;


procedure PutFolderToFTP(const LocalFolder, FTPServer, FTPLogin, FTPPassword,
    FTPFolder: String; FTPPort: Integer; FTPPassive: Boolean);
var
 l_FTP: TidFTP;
 l_SR: TSearchRec;
begin
 l_FTP:= lp_MakeFTP(FTPServer, FTPLogin, FTPPassword, FTPFolder, FTPPassive, FTPPort);
 try
  if l_FTP.Connected then
  begin
   l_FTP.ChangeDir(LocalFolderToFTPFolder(FTPFolder));
   l_FTP.MakeDir(ExtractFileName(LocalFolder));
   l_FTP.ChangeDir(ExtractFileName(LocalFolder));
   if FindFirst(ConcatDirName(LocalFolder,  '*.*'), faAnyFile, l_sr) = 0 then
   begin
    repeat
     if (l_sr.Attr <> faDirectory) and (l_sr.Name[1] <> '.') then
      lp_PutFileToFTP(l_FTP, ConcatDirName(LocalFolder, l_sr.Name));
    until FindNext(l_sr) <> 0;
    FindClose(l_sr);
   end; // FindFirst
  end; // l_FTP.Connected
 finally
  lp_DestroyFTP(l_Ftp);
 end;
end;

procedure GetFolderFromFTP(const RemoteFolder, LocalFolder: String; FTPServer,
    FTPLogin, FTPPassword, FTPFolder: string; FTPPort: Integer; FTPPassive:
    Boolean);
begin
  Assert(False, 'Не написан метод');
end;

procedure PutFileToFTP(const FileName, FTPServer, FTPLogin, FTPPassword,
    FTPFolder: String; FTPPort: Integer; FTPPassive: Boolean);
var
 l_FTP: TidFTP;
begin
 l_FTP:= lp_MakeFTP(FTPServer, FTPLogin, FTPPassword, FTPFolder, FTPPassive, FTPPort);
 try
  if l_FTP.Connected then
  begin
   if FTPFolder <> '' then
    l_FTP.ChangeDir(LocalFolderToFTPFolder(FTPFolder));
   lp_PutFileToFTP(l_FTP, Filename);
  end; // l_FTP.Connected
 finally
  lp_DestroyFTP(l_FTP);
 end;
end;

procedure GetFileFromFTP(const FileName, LocalFolder, FTPServer, FTPLogin,
    FTPPassword, FTPFolder: String; FTPPort: Integer; FTPPassive: Boolean);
var
 l_FTP: TidFTP;
begin
 l_FTP:= lp_MakeFTP(FTPServer, FTPLogin, FTPPassword, FTPFolder, FTPPassive, FTPPort);
 try
  if l_FTP.Connected then
  begin
   l_FTP.ChangeDir(LocalFolderToFTPFolder(FTPFolder));
   lp_GetFileFromFTP(l_FTP, Filename, ConcatDirName(LocalFolder, FileName));
  end; // l_FTP.Connected
 finally
  lp_DestroyFTP(l_FTP);
 end;
end;

  {$If defined(AppServerSide)}
procedure PutFileToFTP(const FileName, FTPPrefix: String);
var
 l_Host, l_User, l_Password, l_Folder: String;
 l_Port: Integer;
 l_Passive: Boolean;
begin
 with ddAppConfiguration do
 begin
  if HasValue(FTPPrefix+'FTPport') then
   l_Port:= AsInteger[FTPPrefix+'FTPport']
  else
   l_Port:= IdPORT_FTP;
  PutFileToFTP(FileName, AsString[FTPPrefix+'FTPServer'], AsString[FTPPrefix+'FTPUser'],
                         AsString[FTPPrefix+'FTPPassword'], AsString[FTPPrefix+'FTPFolder'],
                         l_Port, AsBoolean[FTPPrefix+'FTPPassive']);
 end;
end;
  {$IfEnd defined(AppServerSide)}

end.
