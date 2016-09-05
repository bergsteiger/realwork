unit nsDownloadService;

interface
uses
 Classes,

 l3ProtoObject,

 nsDownloaderInterfaces,
 nsAsyncDownloaderList,
 nsDownloadProgressDialogList;

type
 TnsDownloadService = class(Tl3ProtoObject, InsDownloaderObserver)
 private
  FDownloaders: TnsAsyncDownloaderList;
  FProgressDialogs: TnsDownloadProgressDialogList;
  function GetProgressDialog(const ADownloader: InsAsyncDownloader): InsDownloadProgressDialog;
  procedure StartProgressDialog(const ADownloader: InsAsyncDownloader);
  procedure StopProgressDialog(const ADownloader: InsAsyncDownloader);
  procedure OpenFileIfNeeded(const ADownloader: InsAsyncDownloader);
  procedure DeleteFileIfNeeded(const ADownloader: InsAsyncDownloader);
  procedure DeleteDownloader(const ADownloader: InsAsyncDownloader);
  constructor Create;
 protected
  // InsDownloaderObserver
  procedure OnBeginDownloadData(const ADownloader: InsAsyncDownloader;
   var ACancel: Boolean);
  procedure OnProgress(const ADownloader: InsAsyncDownloader;
   AProgressValue: Integer; ATotalValue: Integer; var ACancel: Boolean);
  procedure OnEndDownloadData(const ADownloader: InsAsyncDownloader);
  procedure OnDownloadingCancelled(const ADownloader: InsAsyncDownloader);
  procedure Cleanup; override;
 public
  procedure DownloadFile(const AURL: String);
  class function Instance: TnsDownloadService;
 end;

implementation
uses
 SysUtils,
 Windows,
 ShellAPI,

 l3Base,

 nsDownloadManager,
 nsDownloaderGUIService,
 nsProgressDialog;

var
 g_TnsDownloadServiceInstance: TnsDownloadService = nil;

procedure TnsDownloadService_Free;
begin
 FreeAndNil(g_TnsDownloadServiceInstance);
end;

function TnsDownloadService.GetProgressDialog(const ADownloader: InsAsyncDownloader): InsDownloadProgressDialog;
var
 l_Index: Integer;
 l_Dlg: InsDownloadProgressDialog;
begin
 Result := nil;
 for l_Index := Pred(FProgressDialogs.Count) downto 0 do
 begin
  l_Dlg := FProgressDialogs[l_Index] as InsDownloadProgressDialog;
  if (Pointer(l_Dlg.Downloader) = Pointer(ADownloader)) then
  begin
   Result := l_Dlg;
   Exit; 
  end;
 end;
end;

procedure TnsDownloadService.StartProgressDialog(const ADownloader: InsAsyncDownloader);
var
 l_Dlg: InsDownloadProgressDialog;
begin
 l_Dlg := GetProgressDialog(ADownloader);
end;

procedure TnsDownloadService.StopProgressDialog(const ADownloader: InsAsyncDownloader);
var
 l_Dlg: InsDownloadProgressDialog;
begin
 l_Dlg := GetProgressDialog(ADownloader);
 Assert(l_Dlg <> nil);
 l_Dlg.StopProgressDialog;
 FProgressDialogs.Remove(l_Dlg);
end;

procedure TnsDownloadService.OpenFileIfNeeded(const ADownloader: InsAsyncDownloader);

 procedure lp_ShellExecute(const AFileName: string);
 var
  l_ShellExecuteInfo: {$IfDef XE}TShellExecuteInfoA{$Else}TShellExecuteInfo{$EndIf};
  l_Handle: THandle;
  l_FindData: {$IfDef XE}TWin32FindDataA{$Else}TWin32FindData{$EndIf};
 begin
  l3FillChar(l_ShellExecuteInfo, SizeOf(l_ShellExecuteInfo), 0);
  //http://mdp.garant.ru/pages/viewpage.action?pageId=431371899
  with l_ShellExecuteInfo do
  begin
   cbSize := SizeOf(l_ShellExecuteInfo);
   lpFile := PAnsiChar(AFileName);
   nShow := SW_SHOWNORMAL;
  end;//with l_ShellExecuteInfo
  ShellExecuteExA(@l_ShellExecuteInfo);
 end;

var
 l_FileName: String;
begin
 if (ADownloader.DownloadParams.FileAction = dfaOpen) then
 begin
  l_FileName := ADownloader.DownloadParams.FileName;
  if FileExists(l_FileName) then
   lp_ShellExecute(l_FileName);
 end;
end;

procedure TnsDownloadService.DeleteFileIfNeeded(const ADownloader: InsAsyncDownloader);
begin
 DeleteFile(PChar(ADownloader.DownloadParams.FileName));
end;

procedure TnsDownloadService.DeleteDownloader(const ADownloader: InsAsyncDownloader);
begin
 FDownloaders.Remove(ADownloader);
end;

constructor TnsDownloadService.Create;
begin
 inherited;
 FDownloaders := TnsAsyncDownloaderList.Create;
 FProgressDialogs := TnsDownloadProgressDialogList.Create;
end;

procedure TnsDownloadService.OnBeginDownloadData(const ADownloader: InsAsyncDownloader;
 var ACancel: Boolean);
begin
 StartProgressDialog(ADownloader);
end;

procedure TnsDownloadService.OnProgress(const ADownloader: InsAsyncDownloader;
 AProgressValue: Integer; ATotalValue: Integer; var ACancel: Boolean);
begin
 with ADownloader.State do
 begin
  Total := ATotalValue;
  Current := AProgressValue;
  if CancelledByUser then
   ACancel := True;
 end;
end;

procedure TnsDownloadService.OnEndDownloadData(const ADownloader: InsAsyncDownloader);
begin
 StopProgressDialog(ADownloader);
 OpenFileIfNeeded(ADownloader);
 ADownloader.Unsubscribe(Self);
 DeleteDownloader(ADownloader);
end;

procedure TnsDownloadService.OnDownloadingCancelled(const ADownloader: InsAsyncDownloader);
begin
 StopProgressDialog(ADownloader);
 DeleteFileIfNeeded(ADownloader);
 ADownloader.Unsubscribe(Self);
 DeleteDownloader(ADownloader);
end;

procedure TnsDownloadService.Cleanup;
begin
 FreeAndNil(FDownloaders);
 FreeAndNil(FProgressDialogs);
 inherited;
end;

procedure TnsDownloadService.DownloadFile(const AURL: String);
var
 l_Params: InsDownloadParams;
 l_Downloader: InsAsyncDownloader;
 l_ProgressDialog: InsDownloadProgressDialog;
begin
 Assert(FDownloaders <> nil);
 l_Params := TnsDownloadParams.Make(AURL, dfaOpen);
 if TnsDownloaderGUIService.Instance.EditParams(l_Params) then
 begin
  if (l_Params.FileAction = dfaSaveAs) then
   Exit;
  l_Downloader := TnsAsyncDownloader.Make(l_Params);
  Assert(l_Downloader <> nil);
  FDownloaders.Add(l_Downloader);
  l_Downloader.Subscribe(Self);
  l_ProgressDialog := TnsDownloadProgressDialog.Make(l_Downloader);
  FProgressDialogs.Add(l_ProgressDialog);
  l_Downloader.StartDownload;
 end;
end;

class function TnsDownloadService.Instance: TnsDownloadService;
begin
 if (g_TnsDownloadServiceInstance = nil) then
 begin
  g_TnsDownloadServiceInstance := Create;
  l3System.AddExitProc(TnsDownloadService_Free);
 end;
 Result := g_TnsDownloadServiceInstance;
end;

end.
