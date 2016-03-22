unit alcuAutoLinkUpdater;

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

uses
  ddProgressObj;

procedure ExportAutoLinkCache;

procedure ImportAutoLinkCache(aProgressor: TddProgressObject);

procedure UpdateAutoLinkCache(aProgressor: TddProgressObject);

implementation

uses
  alcuFTPUtils, ddAutolinkCache, l3FileUtils, ddUtils, alcuZipUtils,
  ddAppConfig, dt_Serv, SysUtils;


function CacheTempFolder: String;
begin
 Result:= ConcatDirName(GetWindowsTempFolder, 'AutoLinkCache');
end;

function CacheZipFile(isLocal: Boolean): String;
begin
 Result:= 'AutoLinkCache.zip';
 if isLocal then
  Result:= ConcatDirName(CacheTempFolder, Result);
end;

procedure ExportAutoLinkCache;
var
 l_Folder,
 l_File: String;
begin
 // Создать кеш, поместить на ftp
 l_Folder:= CacheTempFolder;
 PureDir(l_Folder);
 ForceDirectories(l_Folder);
 l_File:= CacheZipFile(True);
 MakeRemoteAutolinkCache(l_Folder);
 ZipFiles(l_File, l_Folder);
 with ddAppConfiguration do
  PutFileToFTP(l_File, AsString['alcFTPHost'], AsString['alcFTPUser'], AsString['alcFTPPassword'],
                       AsString['alcFTPFolder'], AsInteger['alcFTPport'], AsBoolean['alcFTPPassive']);
 PureDir(l_Folder);
end;

procedure ImportAutoLinkCache(aProgressor: TddProgressObject);
var
 l_Folder,
 l_File: String;
begin
 // Забрать кеш с ftp
 l_Folder:= ConcatDirName(GetWindowsTempFolder, 'AutoLinkCache');;
 PureDir(l_Folder);
 ForceDirectories(l_Folder);
 with ddAppConfiguration do
  GetFileFromFTP(CacheZipFile(False), l_Folder, AsString['alcFTPHost'], AsString['alcFTPUser'], AsString['alcFTPPassword'],
                       AsString['alcFTPFolder'], AsInteger['alcFTPport'], AsBoolean['alcFTPPassive']);
 l_File:= CacheZipFile(True);
 if FileExists(l_File) then
 begin
  UnZipFiles(l_File, l_Folder, '*.*', aProgressor);
  DeleteFile(l_File);
  CopyFilesByMask(l_Folder, GlobalHtServer.Family[1].Path, '*.*');
  PureDir(l_Folder);
 end; // FileExists(l_File)
end;

procedure UpdateAutoLinkCache(aProgressor: TddProgressObject);
begin
 CreateOrUpdateAutolinkCache(aProgressor.ProcessUpdate{$IFDEF UseCommandFile}, False{$ENDIF});
end;

end.
