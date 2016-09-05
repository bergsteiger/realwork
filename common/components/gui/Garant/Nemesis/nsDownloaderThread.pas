unit nsDownloaderThread;

interface
uses
  Classes,
  nscSystemProgressDialog,
  nsDownloaderInterfaces;

type
  TnsDownloaderThread = class;

  TnsDownloaderThreadEvent = procedure(AThread: TnsDownloaderThread) of object;

  _l3Unknown_Parent_ = TThread;
  {$Define _UnknownNeedsQI}
  {$Include w:\Common\Components\rtl\Garant\l3\l3Unknown.imp.pas}
  TnsDownloaderThread = class(_l3Unknown_, InsDownloaderEventSink)
  private
   FParams: InsDownloadParams;
   FDownloader: InsDownloader;
   FProgressDialog: IProgressDialog;
   FOnStarted: TnsDownloaderThreadEvent;
   FOnBeforeDestroy: TnsDownloaderThreadEvent;
   procedure UpdateProgressState(const AState: TnsDownloaderState);
   procedure CallOnStarted;
  protected
   procedure Execute; override;
   procedure Cleanup; override;
   procedure OnStartDownload(const AParams: InsDownloadParams;
    const ADownloaderState: TnsDownloaderState);
   procedure OnDownloadFinished(const AParams: InsDownloadParams;
    const ADownloaderState: TnsDownloaderState);
   procedure OnProgress(const AParams: InsDownloadParams;
    const ADownloaderState: TnsDownloaderState);
  public
   constructor Create(const AParams: InsDownloadParams);
   property OnStarted: TnsDownloaderThreadEvent read FOnStarted write FOnStarted;
   property OnBeforeDestroy: TnsDownloaderThreadEvent read FOnBeforeDestroy write FOnBeforeDestroy;
  end;


implementation
uses
  SysUtils,
  Windows,
  ShellAPI,
  Forms,
  l3Base,
  l3Interlocked,
  l3String,
  nsDownloader,
  nsDownloaderRes,
  ActiveX;

{ TnsDownloaderThread }

{$Include w:\Common\Components\rtl\Garant\l3\l3Unknown.imp.pas}

procedure TnsDownloaderThread.UpdateProgressState(const AState: TnsDownloaderState);
begin
 FProgressDialog.SetProgress(AState.rCurrent, AState.rTotal);
end;

procedure TnsDownloaderThread.CallOnStarted;
begin
 if Assigned(FOnStarted) then
  FOnStarted(Self);
end;

procedure TnsDownloaderThread.Execute;
begin
 CoInitialize(nil);
 Synchronize(CallOnStarted);
 FDownloader := TnsDownloader.Make(FParams, Self);
 try
  FDownloader.Start;
  while (not Terminated) and (not FDownloader.Finished) and (not FProgressDialog.HasUserCancelled) do
   Sleep(1);
  if FProgressDialog.HasUserCancelled then
   FDownloader.Cancel;
 finally
  if (FProgressDialog <> nil) then
   StopProgressDialog(FProgressDialog);
  FDownloader := nil;
  CoUninitialize;
 end;
end;

procedure TnsDownloaderThread.Cleanup;
begin
 if Assigned(FOnBeforeDestroy) then
  FOnBeforeDestroy(Self);
 FDownloader := nil;
 FProgressDialog := nil;
 inherited;
end;

procedure TnsDownloaderThread.OnStartDownload(const AParams: InsDownloadParams;
 const ADownloaderState: TnsDownloaderState);
var
 l_Title: WideString;
 l_S1, l_S2, l_S3: WideString;
 l_nilPointer: Pointer;
begin
 FProgressDialog := GetProgressDialog;

 l_nilPointer := nil;

 l_Title := Application.Title;
 l_S1 := l3Str(str_FileDownload.AsCStr);
 l_S2 := AParams.URL;
 l_S3 := AParams.FileName;

 Assert(FProgressDialog <> nil);

 FProgressDialog.SetTitle(PWideChar(l_Title));
 FProgressDialog.SetLine(1, PWideChar(l_S1), True, l_nilPointer);
 FProgressDialog.SetLine(2, PWideChar(l_S2), True, l_nilPointer);
 FProgressDialog.SetLine(3, PWideChar(l_S3), True, l_nilPointer);

 FProgressDialog.StartProgressDialog(0, nil, PROGDLG_NORMAL, l_nilPointer);
 Sleep(800);
end;

procedure TnsDownloaderThread.OnDownloadFinished(const AParams: InsDownloadParams;
 const ADownloaderState: TnsDownloaderState);

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

begin
 FProgressDialog.StopProgressDialog;
 if (AParams.FileAction = dfaOpen) then
  if FileExists(AParams.FileName) then
   lp_ShellExecute(AParams.FileName);
end;

procedure TnsDownloaderThread.OnProgress(const AParams: InsDownloadParams;
 const ADownloaderState: TnsDownloaderState);
begin
 UpdateProgressState(FDownloader.MakeState);
end;

constructor TnsDownloaderThread.Create(const AParams: InsDownloadParams);
begin
 inherited Create(True);
 FParams := AParams;
 FreeOnTerminate := True;
end;

end.
