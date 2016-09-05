unit nsDownloader;

interface
uses
  Classes,
  Windows,
  ActiveX,
  UrlMon,
  l3ProtoObject,
  nsDownloaderInterfaces,
  nsDownloaderThread,
  nsDownloaderThreadList,
  nscSystemProgressDialog;

type
  TnsDownloadParams = class(Tl3ProtoObject, InsDownloadParams)
  private
   FFileAction: TnsDownloadFileAction;                 
   FURL: string;
   FFileName: string;
   FFileTypeString: string;
   FFileIcon: HICON;
   procedure MakeFileName;
   procedure GetFileProperties;
   constructor Create(const AURL: String;
    AFileAction: TnsDownloadFileAction); overload;
   constructor Create(const AURL: String;
    AFileAction: TnsDownloadFileAction; const AFileName: String); overload;
  protected
   function GetFileAction: TnsDownloadFileAction;
   procedure SetFileAction(AFileAction: TnsDownloadFileAction);
   function GetURL: string;
   procedure SetURL(const AURL: String);
   function GetFileName: string;
   procedure SetFileName(const AFileName: String);
   function GetFileTypeString: string;
   procedure SetFileTypeString(const AFileTypeString: String);
   function GetFileIcon: HICON;
  public
   class function Make(const AURL: String;
    AFileAction: TnsDownloadFileAction): InsDownloadParams; overload;
   class function Make(const AURL: String; AFileAction: TnsDownloadFileAction;
    const AFileName: String): InsDownloadParams; overload;
  end;

  TnsDownloader = class(Tl3ProtoObject, IBindStatusCallback,
   InsDownloader)
  private
   FLockCS: TRTLCriticalSection;
   FBinding: IBinding;
   FParams: InsDownloadParams;
   FEventSink: Pointer;
   FDownloaderState: TnsDownloaderState;
   FCurrentProgress: Integer;
   FTotalProgress: Integer;
   FFinished: Boolean;
   FStartCalled: Boolean;
   constructor Create(const AParams: InsDownloadParams;
    ASink: InsDownloaderEventSink);
   procedure StartDownload;
   procedure Lock;
   procedure Unlock;
  protected
   procedure Cleanup; override;
   // IBindStatusCallBack
   function OnStartBinding(dwReserved: DWORD; pib: IBinding): HResult; stdcall;
   function GetPriority(out nPriority): HResult; stdcall;
   function OnLowResource(reserved: DWORD): HResult; stdcall;
   function OnProgress(ulProgress, ulProgressMax, ulStatusCode: ULONG;
    szStatusText: LPCWSTR): HResult; stdcall;
   function OnStopBinding(hresult: HResult; szError: LPCWSTR): HResult; stdcall;
   function GetBindInfo(out grfBINDF: DWORD; var bindinfo: TBindInfo): HResult; stdcall;
   function OnDataAvailable(grfBSCF: DWORD; dwSize: DWORD; formatetc: PFormatEtc;
    stgmed: PStgMedium): HResult; stdcall;
   function OnObjectAvailable(const iid: TGUID; punk: IUnknown): HResult; stdcall;
   // InsDownloader
   function GetParams: InsDownloadParams;
   procedure CancelDownload;
   function MakeState: TnsDownloaderState;
   function GetFinished: Boolean;
   procedure Start;
   procedure Cancel; 
  public
   class function Make(const AParams: InsDownloadParams;
    ASink: InsDownloaderEventSink): InsDownloader;
  end;

  TnsDownloadService = class(Tl3ProtoObject)
  private
   FThreads: TnsDownloaderThreadList;
   FActiveThreadNumber: Integer;
   procedure RegisterThread(AThread: TnsDownloaderThread);
   procedure UnregisterThread(AThread: TnsDownloaderThread);
   procedure TerminateThreads;
   procedure WaitForThreads;
   function MakeThread(const AParams: InsDownloadParams): TnsDownloaderThread;
   constructor Create;
  protected
   procedure DoOnThreadStarted(AThread: TnsDownloaderThread);
   procedure DoOnBeforeThreadDestroy(AThread: TnsDownloaderThread);
   procedure Cleanup; override;
  public
   class function Instance: TnsDownloadService;
   procedure DownloadFile(const AURL: String);
  end;

implementation
uses
 SysUtils,

 Forms,

 ShellAPI,

 l3Base,
 l3Interlocked,
 l3String,

 nsDownloaderRes,
 nsDownloaderGUIService;

 
function HexToInt(const AHexStr: String): Int64;
var
 l_Len: Integer;
 l_Str: String;
 i: Byte;
begin
 l_Len := Length(AHexStr);
 l_Str := UpperCase(AHexStr);

 if l_Str[l_Len] = 'H' then
  Delete(l_Str, l_Len, 1);

 Result := 0;

 for i := 1 to l_Len do
 begin
  Result := Result shl 4;
  if l_Str[i] in ['0'..'9'] then
   Result := Result + (byte(l_Str[i]) - 48)
  else
  if l_Str[i] in ['A'..'F'] then
   Result := Result + (byte(l_Str[i]) - 55)
  else
  begin
   Result := 0;
   break;
  end;
 end;
end;

function UrlDecode(const AEncodedStr: String): String;
var
  i: Integer;
  l_Len: Integer;
begin
 Result := '';
 l_Len := Length(AEncodedStr);
 if l_Len > 0 then
 begin
  i := 1;
  while i <= l_Len do
  begin
   if AEncodedStr[i] = '%' then
   begin
    Result := Result + Chr(HexToInt(AEncodedStr[i + 1]
                                  + AEncodedStr[i + 2]));
    Inc(i, 2);
   end
   else
   if AEncodedStr[i] = '+' then
    Result := Result + ' '
   else
    Result := Result + AEncodedStr[i];
    Inc(i);
  end;
 end;
end;

function GetURLFilename(const AFilePath: String;
 const ADelimiter: String = '/'): string;
var
 l_DelimPos: Integer;
begin
 l_DelimPos := LastDelimiter(ADelimiter, AFilePath);
 Result := Copy(AFilePath, l_DelimPos + 1, MaxInt);
 Result := UrlDecode(Result);
end;

{ TnsDownloadParams }

procedure TnsDownloadParams.MakeFileName;
var
 l_FileName: String;
 l_Path: String;
 l_PathLen: Integer;
begin
 l_FileName := GetURLFilename(FURL);
 case FFileAction of
  dfaOpen:
   begin
    l_PathLen := MAX_PATH;
    SetLength(l_Path, l_PathLen);
    GetTempPath(l_PathLen, PChar(l_Path));
    FFileName := PChar(IncludeTrailingPathDelimiter(l_Path)) + l_FileName;
   end;
  dfaSave:
   FFileName := IncludeTrailingPathDelimiter(GetCurrentDir) + l_FileName;
  dfaSaveAs:
   FFileName := '';
 end;
end;

procedure TnsDownloadParams.GetFileProperties;
var
 l_SFI: TShFileInfo;
begin
 l3FillChar(l_SFI, SizeOf(l_SFI), 0);

 if (SHGetFileInfo(PChar(ExtractFileName(FFileName)),
                   FILE_ATTRIBUTE_NORMAL,
                   l_SFI,
                   SizeOf(l_SFI),
                   SHGFI_USEFILEATTRIBUTES or SHGFI_TYPENAME or
                    SHGFI_DISPLAYNAME or SHGFI_ICON or SHGFI_LARGEICON) <> 0) then
  FFileTypeString := l_SFI.szTypeName
 else
  FFileTypeString := l3Str(str_UnknownFile.AsCStr);

 FFileIcon := l_SFI.hIcon;
end;

constructor TnsDownloadParams.Create(const AURL: String;
 AFileAction: TnsDownloadFileAction);
begin
 inherited Create;
 FURL := AURL;
 FFileAction := AFileAction;
 MakeFileName;
 GetFileProperties;
end;

constructor TnsDownloadParams.Create(const AURL: String;
 AFileAction: TnsDownloadFileAction; const AFileName: String);
begin
 Create(AURL, AFileAction);
 FFileName := AFileName;
end;

function TnsDownloadParams.GetFileAction: TnsDownloadFileAction;
begin
 Result := FFileAction;
end;

procedure TnsDownloadParams.SetFileAction(AFileAction: TnsDownloadFileAction);
begin
 if (AFileAction <> FFileAction) then
 begin
  FFileAction := AFileAction;
  MakeFileName;
 end;
end;

function TnsDownloadParams.GetURL: string;
begin
 Result := FURL;
end;

procedure TnsDownloadParams.SetURL(const AURL: String);
begin
 if (AURL <> FURL) then
  FURL := AURL;
end;

function TnsDownloadParams.GetFileName: String;
begin
 Result := FFileName;
end;

procedure TnsDownloadParams.SetFileName(const AFileName: String);
begin
 if (AFileName <> FFileName) then
  FFileName := AFileName;
end;

function TnsDownloadParams.GetFileTypeString: String;
begin
 Result := FFileTypeString
end;

procedure TnsDownloadParams.SetFileTypeString(const AFileTypeString: String);
begin
 if (AFileTypeString <> FFileTypeString) then
   FFileTypeString := AFileTypeString;
end;

function TnsDownloadParams.GetFileIcon: HICON;
begin
 Result := FFileIcon;
end;

class function TnsDownloadParams.Make(const AURL: String;
 AFileAction: TnsDownloadFileAction): InsDownloadParams;
var
 l_Inst: TnsDownloadParams;
begin
 l_Inst := Create(AURL, AFileAction);
 Result := l_Inst;
 FreeAndNil(l_Inst);
end;

class function TnsDownloadParams.Make(const AURL: String;
 AFileAction: TnsDownloadFileAction;
 const AFileName: String): InsDownloadParams;
var
 l_Inst: TnsDownloadParams;
begin
 l_Inst := Create(AURL, AFileAction, AFileName);
 Result := l_Inst;
 FreeAndNil(l_Inst);
end;

{ TnsDownloader }

constructor TnsDownloader.Create(const AParams: InsDownloadParams;
 ASink: InsDownloaderEventSink);
begin
 inherited Create;
 InitializeCriticalSection(FLockCS);
 FParams := AParams;
 FEventSink := Pointer(ASink);
end;

procedure TnsDownloader.StartDownload;
begin
 URLDownloadToFile(nil, PChar(FParams.URL), PChar(FParams.FileName),
  0, Self);
end;

procedure TnsDownloader.Lock;
begin
 EnterCriticalSection(FLockCS);
end;

procedure TnsDownloader.Unlock;
begin
 LeaveCriticalSection(FLockCS);
end;

procedure TnsDownloader.Cleanup;
begin
 DeleteCriticalSection(FLockCS);
 FBinding := nil;
 FParams := nil;
 FEventSink := nil;
 inherited;
end;

function TnsDownloader.OnStartBinding(dwReserved: DWORD; pib: IBinding): HResult;
begin
 Result := E_NOTIMPL;
 FBinding := pib;
end;

function TnsDownloader.GetPriority(out nPriority): HResult;
begin
 Result := E_NOTIMPL;
end;

function TnsDownloader.OnLowResource(reserved: DWORD): HResult;
begin
 Result := E_NOTIMPL;
end;

function TnsDownloader.OnProgress(ulProgress, ulProgressMax, ulStatusCode: ULONG;
 szStatusText: LPCWSTR): HResult;
var
 l_State: TnsDownloaderState;
begin
 Lock;
 try
  FCurrentProgress := ulProgress;
  FTotalProgress := ulProgressMax;
  l_State := MakeState;

  if not FStartCalled then
  begin
   if (FEventSink <> nil) then
    InsDownloaderEventSink(FEventSink).OnStartDownload(FParams, l_State);
   FStartCalled := True;
  end;

  case ulStatusCode of
   BINDSTATUS_ENDDOWNLOADDATA:
    begin
     if (FEventSink <> nil) then
      InsDownloaderEventSink(FEventSink).OnDownloadFinished(FParams, l_State);
     FFinished := True;
    end;
   BINDSTATUS_DOWNLOADINGDATA:
    if (FEventSink <> nil) then
     InsDownloaderEventSink(FEventSink).OnProgress(FParams, l_State);
   end;
  Result := S_OK;
 finally
  Unlock;
 end;
end;

function TnsDownloader.OnStopBinding(hresult: HResult; szError: LPCWSTR): HResult;
begin
 FBinding := nil;
 Result := E_NOTIMPL;
end;

function TnsDownloader.GetBindInfo(out grfBINDF: DWORD; var bindinfo: TBindInfo): HResult;
begin
 Result := E_NOTIMPL;
end;

function TnsDownloader.OnDataAvailable(grfBSCF: DWORD; dwSize: DWORD; formatetc: PFormatEtc;
 stgmed: PStgMedium): HResult;
begin
 Result := E_NOTIMPL;
end;

function TnsDownloader.OnObjectAvailable(const iid: TGUID; punk: IUnknown): HResult;
begin
 Result := E_NOTIMPL;
end;

function TnsDownloader.GetParams: InsDownloadParams;
begin
 Result := FParams;
end;

procedure TnsDownloader.CancelDownload;
begin
 FBinding.Abort;
end;

function TnsDownloader.MakeState: TnsDownloaderState;
begin
 Finalize(Result);
 Result := TnsDownloaderState_C(FTotalProgress, FCurrentProgress, FParams);
end;

function TnsDownloader.GetFinished: Boolean;
begin
 Lock;
 Result := FFinished;
 Unlock;
end;

procedure TnsDownloader.Start;
begin
 StartDownload;
end;

procedure TnsDownloader.Cancel;
begin
 if (FBinding <> nil) then
  FBinding.Abort;
 // А если FBinding = nil - значит, уже и так никакой загрузки не происходит,
 // нечего и отменять.
end;

class function TnsDownloader.Make(const AParams: InsDownloadParams;
 ASink: InsDownloaderEventSink): InsDownloader;
var
 l_Inst: TnsDownloader;
begin
 l_Inst := TnsDownloader.Create(AParams, ASink);
 Result := l_Inst;
 FreeAndNil(l_Inst);
end;


{ TnsDownloadService }

procedure TnsDownloadService.RegisterThread(AThread: TnsDownloaderThread);
begin
 FThreads.Add(AThread);
end;

procedure TnsDownloadService.UnregisterThread(AThread: TnsDownloaderThread);
begin
 FThreads.Remove(AThread);
end;

procedure TnsDownloadService.TerminateThreads;
var
 l_Index: Integer;
begin
 for l_Index := 0 to Pred(FThreads.Count) do
  FThreads[l_Index].Terminate;
end;

procedure TnsDownloadService.WaitForThreads;
var
 l_Handles: TWOHandleArray;
 l_Index: Integer;
begin
 l3FillChar(l_Handles, SizeOf(l_Handles), 0);
 for l_Index := 0 to Pred(FThreads.Count) do
  l_Handles[l_Index] := FThreads[l_Index].Handle;
 WaitForMultipleObjects(FThreads.Count, @l_Handles, True, INFINITE);
end;

function TnsDownloadService.MakeThread(const AParams: InsDownloadParams): TnsDownloaderThread;
begin
 Result := TnsDownloaderThread.Create(AParams);
 Result.OnStarted := DoOnThreadStarted;
 Result.OnBeforeDestroy := DoOnBeforeThreadDestroy;
end;

constructor TnsDownloadService.Create;
begin
 inherited;
 FThreads := TnsDownloaderThreadList.Create;
end;

procedure TnsDownloadService.DoOnThreadStarted(AThread: TnsDownloaderThread);
begin
 RegisterThread(AThread);
end;

procedure TnsDownloadService.DoOnBeforeThreadDestroy(AThread: TnsDownloaderThread);
begin
 UnregisterThread(AThread);
end;

procedure TnsDownloadService.Cleanup;
begin
 TerminateThreads;
 WaitForThreads;
 FreeAndNil(FThreads);
 inherited;
end;

var
 g_TnsDownloadService: TnsDownloadService = nil;

procedure TnsDownloadService_Free;
begin
 FreeAndNil(g_TnsDownloadService);
end;

class function TnsDownloadService.Instance: TnsDownloadService;
begin
 if (g_TnsDownloadService = nil) then
 begin
  g_TnsDownloadService := TnsDownloadService.Create;
  l3System.AddExitProc(TnsDownloadService_Free);
 end;
 Result := g_TnsDownloadService;
end;

procedure TnsDownloadService.DownloadFile(const AURL: String);
var
 l_Params: InsDownloadParams;
 l_Thread: TnsDownloaderThread;
begin
 l_Params := TnsDownloadParams.Make(AURL, dfaSave);
 if (not TnsDownloaderGUIService.Instance.EditParams(l_Params)) then
  Exit;
 l_Thread := MakeThread(l_Params);
 l_Thread.Resume;
end;

end.
