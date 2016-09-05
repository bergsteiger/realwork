unit nsProgressDialog;

interface
uses
 Windows,
 SysUtils,
 nsDownloaderInterfaces,
 nscSystemProgressDialog;


type
 TnsDownloadProgressDialog = class(TInterfacedObject, InsDownloadProgressDialog, InsDownloaderStateObserver)
 private
  FDialog: IProgressDialog;
  FDownloader: Pointer;
  procedure InitDialog;
  constructor Create(const ADownloader: InsAsyncDownloader);
 protected
  function GetDownloader: InsAsyncDownloader;
  procedure NotifyDownloaderStateChanged(const ADownloaderState: InsDownloaderState);
  procedure StopProgressDialog;
  property Downloader: InsAsyncDownloader read GetDownloader;
 public
  class function Make(const ADownloader: InsAsyncDownloader): InsDownloadProgressDialog;
  destructor Destroy; override;
 end;

implementation
uses
 ActiveX,
 ShlObj,
 Classes,
 Forms;

function AnsiToWide(aText: AnsiString): WideString;
var
 l_wText: PWideChar;
 l_ansiSize: integer;
 l_wideSize: integer;
begin
 l_wText := nil;
 Result := '';
 if (aText = '') then
  Exit;
 try
  l_ansiSize := Length(aText) + 1;
  l_wideSize := l_ansiSize * SizeOf(WideChar);
  l_wText := AllocMem(l_wideSize);
  try
   MultiByteToWideChar(CP_ACP, 0, PChar(aText), l_ansiSize, l_wText, l_wideSize);
   Result := l_wText;
  finally
   FreeMem(l_wText);
  end;
 except
 end;
end;

{ TnsDownloadProgressDialog }

procedure TnsDownloadProgressDialog.InitDialog;
var
 l_Title: WideString;
 l_nilPointer: Pointer;
 l_S1: WideString;
 l_S2: WideString;
 l_S3: WideString;
begin
 FDialog := GetProgressDialog;
 Assert(FDialog <> nil);
 l_Title := Application.Title;

 l_nilPointer := nil;

 l_S1 := 'Загрузка файла';
 l_S2 := Downloader.DownloadParams.URL;
 l_S3 := Downloader.DownloadParams.FileName;

 FDialog.SetTitle(PWideChar(l_Title));
 FDialog.SetLine(1, PWideChar(l_S1), True, l_nilPointer);
 FDialog.SetLine(2, PWideChar(l_S2), True, l_nilPointer);
 FDialog.SetLine(3, PWideChar(l_S3), True, l_nilPointer);

 FDialog.StartProgressDialog(0, nil, PROGDLG_NORMAL, l_nilPointer);
 Sleep(2000);
end;

constructor TnsDownloadProgressDialog.Create(const ADownloader: InsAsyncDownloader);
var
 l_Downloader: InsAsyncDownloader;
 l_State: InsDownloaderState;
begin
 inherited Create;
 Assert(ADownloader <> nil);
 FDownloader := Pointer(ADownloader);
 l_Downloader := Downloader;
 Assert(l_Downloader <> nil);
 l_State := l_Downloader.State;
 Assert(l_State <> nil);
 l_State.Subscribe(Self);
 InitDialog;
end;

function TnsDownloadProgressDialog.GetDownloader: InsAsyncDownloader;
begin
 Result := InsAsyncDownloader(FDownloader);
end;

procedure TnsDownloadProgressDialog.NotifyDownloaderStateChanged(const ADownloaderState: InsDownloaderState);
begin
 FDialog.SetProgress(ADownloaderState.Current, ADownloaderState.Total);
 ADownloaderState.CancelledByUser := FDialog.HasUserCancelled;
end;

procedure TnsDownloadProgressDialog.StopProgressDialog;
var
 l_DlgHWND: HWND;
 l_OleWindow: IOleWindow;
 l_hr: HRESULT;
begin
 if (FDialog <> nil) then
 begin
  if Supports(FDialog, IOleWindow, l_OleWindow) then
  try
   if (not Succeeded(l_OleWindow.GetWindow(l_DlgHWND))) then
    l_DlgHWND := 0;
  finally
   l_OleWindow := nil;
  end;
  FDialog.StopProgressDialog;
  if (l_DlgHWND <> 0) then
   ShowWindow(l_DlgHWND, SW_HIDE);
  Application.ProcessMessages;
  FDialog := nil;
 end;
end;

class function TnsDownloadProgressDialog.Make(const ADownloader: InsAsyncDownloader): InsDownloadProgressDialog;
var
 l_Inst: InsDownloadProgressDialog;
begin
 l_Inst := Create(ADownloader);
 Result := l_Inst;
end;

destructor TnsDownloadProgressDialog.Destroy;
begin
 if (FDialog <> nil) then
  FDialog.StopProgressDialog;
 FDialog := nil;

 if (Downloader <> nil) then
  Downloader.State.Unsubscribe(Self);
  
 FDownloader := nil;

 inherited;
end;


end.
