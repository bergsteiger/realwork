unit nsDownloadManager;

interface

uses
 Windows,
 UrlMon,
 ActiveX,
 Classes,

 l3ProtoObject,

 nsDownloaderInterfaces;

type
 TnsDownloaderBaseClass = Tl3ProtoObject;

 TnsDownloadParams = class(TnsDownloaderBaseClass, InsDownloadParams)
 private
  FFileAction: TnsDownloadFileAction;
  FURL: string;
  FFileName: string;
  FFileTypeString: string;
  FObservers: TList;
  procedure MakeFileName;
  procedure MakeFileTypeString;
  procedure Changed;
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
  procedure Subscribe(const AObserver: InsDownloadParamsObserver);
  procedure Unsubscribe(const AObserver: InsDownloadParamsObserver);
  procedure CleanUp; override;
 public
  class function Make(const AURL: String;
   AFileAction: TnsDownloadFileAction): InsDownloadParams; overload;
  class function Make(const AURL: String; AFileAction: TnsDownloadFileAction;
   const AFileName: String): InsDownloadParams; overload;
 end;

 TnsAsyncDownloader = class;

 TnsBaseBindStatusCallback = class(TnsDownloaderBaseClass, IBindStatusCallback)
 private
  FDownloader: TnsAsyncDownloader;
  constructor Create(ADownloader: TnsAsyncDownloader);
  function GetDownloader: InsAsyncDownloader;
 protected
  function OnStartBinding(dwReserved: DWORD; pib: IBinding): HResult; stdcall;
  function GetPriority(out nPriority): HResult; stdcall;
  function OnLowResource(reserved: DWORD): HResult; stdcall;
  function OnProgress(ulProgress, ulProgressMax, ulStatusCode: ULONG; szStatusText: LPCWSTR): HResult; stdcall;
  function OnStopBinding(hresult: HResult; szError: LPCWSTR): HResult; stdcall;
  function GetBindInfo(out grfBINDF: DWORD; var bindinfo: TBindInfo): HResult; stdcall;
  function OnDataAvailable(grfBSCF: DWORD; dwSize: DWORD; formatetc: PFormatEtc; stgmed: PStgMedium): HResult; stdcall;
  function OnObjectAvailable(const iid: TGUID; punk: IUnknown): HResult; stdcall;
  property Downloader: InsAsyncDownloader read GetDownloader;
 public
  class function Make(ADownloader: TnsAsyncDownloader): IBindStatusCallback;
 end;

 TnsAsyncDownloader = class(TnsDownloaderBaseClass, InsAsyncDownloader)
 private
  FDownloadParams: InsDownloadParams;
  FCancelled: Boolean;
  FObservers: TList;
  FState: InsDownloaderState;
  constructor Create(const ADownloadParams: InsDownloadParams);
  procedure OnBeginDownloadData(var ACancel: Boolean);
  procedure OnEndDownloadData;
  procedure OnProgress(AProgressValue: Integer; ATotalValue: Integer;
   var ACancel: Boolean);
 protected
  function GetDownloadParams: InsDownloadParams;
  function GetIsDownloadingCancelled: Boolean;
  function GetState: InsDownloaderState;
  function IsSame(const ADownloader: InsAsyncDownloader): Boolean;
  procedure StartDownload;
  procedure CancelDownload;
  procedure Subscribe(const AObserver: InsDownloaderObserver);
  procedure Unsubscribe(const AObserver: InsDownloaderObserver);
  procedure Cleanup; override;
 public
  class function Make(const ADownloadParams: InsDownloadParams): InsAsyncDownloader;
 end;

 TnsDownloaderState = class(TnsDownloaderBaseClass, InsDownloaderState)
 private
  FTotal: Integer;
  FCurrent: Integer;
  FURL: string;
  FFileName: string;
  FFileTypeString: string;
  FCancelledByUser: Boolean;
  FObservers: TList;
  procedure Changed;
  constructor Create(const AURL: String; const AFileName: String; const AFileTypeString: string);
 protected
  function GetTotal: Integer;
  procedure SetTotal(ATotal: Integer);
  function GetCurrent: Integer;
  procedure SetCurrent(ACurrent: Integer);
  function GetURL: String;
  function GetFileName: String;
  function GetFileTypeString: String;
  function GetCancelledByUser: Boolean;
  procedure SetCancelledByUser(ACancelledByUser: Boolean);
  procedure Subscribe(const AObserver: InsDownloaderStateObserver);
  procedure Unsubscribe(const AObserver: InsDownloaderStateObserver);
  procedure Cleanup; override;
 public
  class function Make(const AURL: String; const AFileName: String; const AFileTypeString: string): InsDownloaderState;
 end;

implementation

uses
 SysUtils,
 ShellApi,
 l3Base;

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

procedure TnsDownloadParams.MakeFileTypeString;
var
 l_SFI: TShFileInfo;
begin
 l3FillChar(l_SFI, SizeOf(l_SFI), 0);
 if (SHGetFileInfo(PChar(ExtractFileName(FFileName)), FILE_ATTRIBUTE_NORMAL, l_SFI,
  SizeOf(l_SFI), SHGFI_USEFILEATTRIBUTES or SHGFI_TYPENAME or SHGFI_DISPLAYNAME) <> 0) then
  FFileTypeString := l_SFI.szTypeName
 else
  FFileTypeString := Format('Τΰιλ %s', [ExtractFileExt(FFileName)]);
end;

procedure TnsDownloadParams.Changed;
var
 l_Index: Integer;
begin
 for l_Index := 0 to Pred(FObservers.Count) do
  InsDownloadParamsObserver(FObservers[l_Index]).NotifyParamsChanged(Self);
end;

constructor TnsDownloadParams.Create(const AURL: String;
 AFileAction: TnsDownloadFileAction);
begin
 inherited Create;
 FObservers := TList.Create;
 FURL := AURL;
 FFileAction := AFileAction;
 MakeFileName;
 MakeFileTypeString; 
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
  Changed;
 end;
end;

function TnsDownloadParams.GetURL: string;
begin
 Result := FURL;
end;

procedure TnsDownloadParams.SetURL(const AURL: String);
begin
 if (AURL <> FURL) then
 begin
  FURL := AURL;
  Changed;
 end;
end;

function TnsDownloadParams.GetFileName: String;
begin
 Result := FFileName;
end;

procedure TnsDownloadParams.SetFileName(const AFileName: String);
begin
 if (AFileName <> FFileName) then
 begin
  FFileName := AFileName;
  Changed;
 end;
end;

function TnsDownloadParams.GetFileTypeString: String;
begin
 Result := FFileTypeString
end;

procedure TnsDownloadParams.SetFileTypeString(const AFileTypeString: String);
begin
 if (AFileTypeString <> FFileTypeString) then
 begin
   FFileTypeString := AFileTypeString;
   Changed;
 end;
end;

procedure TnsDownloadParams.Subscribe(const AObserver: InsDownloadParamsObserver);
begin
 if (FObservers.IndexOf(Pointer(AObserver)) = -1) then
  FObservers.Add(Pointer(AObserver))
 else
  Assert(False);
end;

procedure TnsDownloadParams.Unsubscribe(const AObserver: InsDownloadParamsObserver);
begin
 if (FObservers.IndexOf(Pointer(AObserver)) <> -1) then
  FObservers.Remove(Pointer(AObserver))
 else
  Assert(False);
end;

procedure TnsDownloadParams.CleanUp;
begin
 FreeAndNil(FObservers);
 inherited;
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

class function TnsDownloadParams.Make(const AURL: String; AFileAction: TnsDownloadFileAction;
 const AFileName: String): InsDownloadParams;
var
 l_Inst: TnsDownloadParams;
begin
 l_Inst := Create(AURL, AFileAction, AFileName);
 Result := l_Inst;
 FreeAndNil(l_Inst);
end;

{ TnsBindStatusCallback }

function TnsBaseBindStatusCallback.OnStartBinding(dwReserved: DWORD; pib: IBinding): HResult;
begin
 Result := E_NOTIMPL;
end;

function TnsBaseBindStatusCallback.GetPriority(out nPriority): HResult;
begin
 Result := E_NOTIMPL;
end;

function TnsBaseBindStatusCallback.OnLowResource(reserved: DWORD): HResult;
begin
 Result := E_NOTIMPL;
end;

function TnsBaseBindStatusCallback.OnProgress(ulProgress, ulProgressMax, ulStatusCode: ULONG; szStatusText: LPCWSTR): HResult;
const
 cHResultArr: array[Boolean] of HResult = (S_OK, E_ABORT);
var
 l_Cancel: Boolean;
begin
 l_Cancel := False;
 if (not Downloader.IsDownloadingCancelled) then 
 begin
  case ulStatusCode of
   BINDSTATUS_BEGINDOWNLOADDATA:
    FDownloader.OnBeginDownloadData(l_Cancel);
   BINDSTATUS_ENDDOWNLOADDATA:
    FDownloader.OnEndDownloadData;
   BINDSTATUS_DOWNLOADINGDATA:
    FDownloader.OnProgress(ulProgress, ulProgressMax, l_Cancel);
  end;
  if l_Cancel then
   Downloader.CancelDownload;
 end
 else                       
  l_Cancel := True;
 Result := cHResultArr[l_Cancel];
end;

function TnsBaseBindStatusCallback.OnStopBinding(hresult: HResult; szError: LPCWSTR): HResult;
begin
 Result := E_NOTIMPL;
end;

function TnsBaseBindStatusCallback.GetBindInfo(out grfBINDF: DWORD;
 var bindinfo: TBindInfo): HResult;
begin
 Result := E_NOTIMPL;
end;

function TnsBaseBindStatusCallback.OnDataAvailable(grfBSCF: DWORD; dwSize: DWORD;
 formatetc: PFormatEtc; stgmed: PStgMedium): HResult;
begin
 Result := E_NOTIMPL;
end;

function TnsBaseBindStatusCallback.OnObjectAvailable(const iid: TGUID; punk: IUnknown): HResult;
begin
 Result := E_NOTIMPL;
end;

constructor TnsBaseBindStatusCallback.Create(ADownloader: TnsAsyncDownloader);
begin
 inherited Create;
 FDownloader := ADownloader;
end;

function TnsBaseBindStatusCallback.GetDownloader: InsAsyncDownloader;
begin
 Result := InsAsyncDownloader(FDownloader);
end;

class function TnsBaseBindStatusCallback.Make(ADownloader: TnsAsyncDownloader): IBindStatusCallback;
var
 l_Inst: TnsBaseBindStatusCallback;
begin
 Assert(ADownloader <> nil);
 l_Inst := Create(ADownloader);
 Result := l_Inst;
 FreeAndNil(l_Inst);
end;

{ TnsAsyncDownloader }

procedure TnsAsyncDownloader.OnBeginDownloadData(var ACancel: Boolean);
var
 l_Index: Integer;
begin
 for l_Index := Pred(FObservers.Count) downto 0 do
  InsDownloaderObserver(FObservers[l_Index]).OnBeginDownloadData(Self, ACancel);
end;

procedure TnsAsyncDownloader.OnEndDownloadData;
var
 l_Index: Integer;
begin
 for l_Index := Pred(FObservers.Count) downto 0 do
  InsDownloaderObserver(FObservers[l_Index]).OnEndDownloadData(Self);
end;

procedure TnsAsyncDownloader.OnProgress(AProgressValue: Integer; ATotalValue: Integer;
 var ACancel: Boolean);
var
 l_Index: Integer;
begin
 GetState.Total := ATotalValue;
 GetState.Current := AProgressValue;
 for l_Index := Pred(FObservers.Count) downto 0 do
  InsDownloaderObserver(FObservers[l_Index]).OnProgress(Self, AProgressValue, ATotalValue, ACancel);
end;

constructor TnsAsyncDownloader.Create(const ADownloadParams: InsDownloadParams);
begin
 inherited Create;
 FObservers := TList.Create;
 FDownloadParams := ADownloadParams;
 FCancelled := False;
end;

function TnsAsyncDownloader.GetDownloadParams: InsDownloadParams;
begin
 Result := FDownloadParams;
end;

function TnsAsyncDownloader.GetIsDownloadingCancelled: Boolean;
begin
 Result := FCancelled;
end;

function TnsAsyncDownloader.GetState: InsDownloaderState;
begin
 if (FState = nil) then
  FState := TnsDownloaderState.Make(FDownloadParams.URL,
   FDownloadParams.FileName, FDownloadParams.FileTypeString);
 Result := FState;
 Assert(Result <> nil);
end;

function TnsAsyncDownloader.IsSame(const ADownloader: InsAsyncDownloader): Boolean;
begin
 Result := Pointer(ADownloader) = Pointer(Self as InsAsyncDownloader);
 Assert(Result);
end;

procedure TnsAsyncDownloader.CancelDownload;
begin
 FCancelled := True;
end;

procedure TnsAsyncDownloader.Subscribe(const AObserver: InsDownloaderObserver);
begin
 if (FObservers.IndexOf(Pointer(AObserver)) = -1) then
  FObservers.Add(Pointer(AObserver))
 else
  Assert(False);
end;

procedure TnsAsyncDownloader.Unsubscribe(const AObserver: InsDownloaderObserver);
begin
 if (FObservers.IndexOf(Pointer(AObserver)) <> -1) then
  FObservers.Remove(Pointer(AObserver))
 else
  Assert(False);
end;

procedure TnsAsyncDownloader.Cleanup;
begin
 FreeAndNil(FObservers);
 FDownloadParams := nil;
 FState := nil;
 inherited;
end;

procedure TnsAsyncDownloader.StartDownload;
var
 l_CallBack: IBindStatusCallback;
begin
 l_CallBack := TnsBaseBindStatusCallback.Make(Self);
 try
  URLDownloadToFile(nil,
   PChar(FDownloadParams.URL),
   PChar(FDownloadParams.FileName),
   0,
   l_CallBack);
 finally
  l_CallBack := nil;
 end;
end;

class function TnsAsyncDownloader.Make(const ADownloadParams: InsDownloadParams): InsAsyncDownloader;
var
 l_Inst: TnsAsyncDownloader;
begin
 Assert(ADownloadParams <> nil);
 l_Inst := Create(ADownloadParams);
 Result := l_Inst;
 FreeAndNil(l_Inst);
end;

{ TnsDownloaderState }

procedure TnsDownloaderState.Changed;
var
 l_Index: Integer;
begin
 for l_Index := 0 to Pred(FObservers.Count) do
  InsDownloaderStateObserver(FObservers[l_Index]).NotifyDownloaderStateChanged(Self);
end;


constructor TnsDownloaderState.Create(const AURL: String; const AFileName: String;
 const AFileTypeString: string);
begin
 inherited Create;
 FObservers := TList.Create;
 FURL := AURL;
 FFileName := AFileName;
 FFileTypeString := AFileTypeString;
 FTotal := 0;
 FCurrent := 0;
end;

function TnsDownloaderState.GetTotal: Integer;
begin
 Result := FTotal;
end;

procedure TnsDownloaderState.SetTotal(ATotal: Integer);
begin
 if (ATotal <> FTotal) then
 begin
  FTotal := ATotal;
  Changed;
 end;
end;

function TnsDownloaderState.GetCurrent: Integer;
begin
 Result := FCurrent;
end;

procedure TnsDownloaderState.SetCurrent(ACurrent: Integer);
begin
 if (ACurrent <> FCurrent) then
 begin
  FCurrent := ACurrent;
  Changed;
 end;
end;

function TnsDownloaderState.GetURL: String;
begin
 Result := FURL;
end;

function TnsDownloaderState.GetFileName: String;
begin
 Result := FFileName;
end;

function TnsDownloaderState.GetFileTypeString: String;
begin
 Result := FFileTypeString;
end;

function TnsDownloaderState.GetCancelledByUser: Boolean;
begin
 Result := FCancelledByUser;
end;

procedure TnsDownloaderState.SetCancelledByUser(ACancelledByUser: Boolean);
begin
 if (ACancelledByUser <> FCancelledByUser) then
 begin
  FCancelledByUser := ACancelledByUser;
  Changed;
 end;
end;

procedure TnsDownloaderState.Subscribe(const AObserver: InsDownloaderStateObserver);
begin
 if (FObservers.IndexOf(Pointer(AObserver)) = -1) then
  FObservers.Add(Pointer(AObserver))
 else
  Assert(False);
end;

procedure TnsDownloaderState.Unsubscribe(const AObserver: InsDownloaderStateObserver);
begin
 if (FObservers.IndexOf(Pointer(AObserver)) <> -1) then
  FObservers.Remove(Pointer(AObserver))
 else
  Assert(False);
end;

procedure TnsDownloaderState.Cleanup;
begin
 FreeAndNil(FObservers);
 inherited;
end;

class function TnsDownloaderState.Make(const AURL: String; const AFileName: String;
 const AFileTypeString: string): InsDownloaderState;
var
 l_Inst: TnsDownloaderState;
begin
 l_Inst := Create(AURL, AFileName, AFileTypeString);
 Result := l_Inst;
 FreeAndNil(l_Inst);
end; 

end.

