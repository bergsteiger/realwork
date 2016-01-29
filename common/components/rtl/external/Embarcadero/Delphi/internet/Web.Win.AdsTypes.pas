{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Web.Win.AdsTypes;

interface

uses Winapi.Windows, Winapi.ActiveX, System.Classes, System.SysUtils, System.Variants, System.Win.ComObj, Web.Win.AdsConst;

type

{ TWebDirStruct }

  TAdsOpenStyle = (asOpenWithGet, asOpenWithOpen);

  EAdsException = class(Exception);

  IAdsContainer = Interface;

  TWebDirStruct = class(TPersistent)
  private
    FName: string;
    FPath: string;
    FAdsPath: string;
    FParent: string;
    FSchema: string;
    FAppRoot: string;
    FAccessRead: Boolean;
    FAccessWrite: Boolean;
    FDontLog: Boolean;
    FGrantByDefault: Boolean;
    FAccessFlags: Integer;
    FUNCUserName: string;
    FUNCPassword: string;
    FAccessExecute: Boolean;
    FAccessSource: Boolean;
    FAccessScript: Boolean;
    FAccessNoRemoteRead: Boolean;
    FAccessNoRemoteWrite: Boolean;
    FAccessNoRemoteExecute: Boolean;
    FAccessNoRemoteScript: Boolean;
    FAccessNoRemoteSource: Boolean;
    FEnableDirBrowsing: Boolean;
    FScriptMaps: TStrings;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property Name: string read FName write FName;
    property Path: string read FPath write FPath;
    property AdsPath: string read FAdsPath write FAdsPath;
    property AppRoot: string read FAppRoot write FAppRoot;
    property Parent: string read FParent write FParent;
    property Schema: string read FSchema write FSchema;
    property AccessRead: Boolean read FAccessRead write FAccessRead;
    property AccessWrite: Boolean read FAccessWrite write FAccessWrite;
    property DontLog: Boolean read FDontLog write FDontLog;
    property GrantByDefault: Boolean read FGrantByDefault write FGrantByDefault;
    property AccessFlags: Integer read FAccessFlags write FAccessFlags;
    property UNCUserName: string read FUNCUserName write FUNCUserName;
    property UNCPassword: string read FUNCPassword write FUNCPassword;
    property AccessExecute: Boolean read FAccessExecute write FAccessExecute;
    property AccessSource: Boolean read FAccessSource write FAccessSource;
    property AccessScript: Boolean read FAccessScript write FAccessScript;
    property AccessNoRemoteRead: Boolean read FAccessNoRemoteRead write FAccessNoRemoteRead;
    property AccessNoRemoteWrite: Boolean read FAccessNoRemoteWrite write FAccessNoRemoteWrite;
    property AccessNoRemoteExecute: Boolean read FAccessNoRemoteExecute write FAccessNoRemoteExecute;
    property AccessNoRemoteScript: Boolean read FAccessNoRemoteScript write FAccessNoRemoteScript;
    property AccessNoRemoteSource: Boolean read FAccessNoRemoteSource write FAccessNoRemoteSource;
    property EnableDirBrowsing: Boolean read FEnableDirBrowsing write FEnableDirBrowsing;
    property ScriptMaps: TStrings read FScriptMaps;
  end;

{ TWebDirList }

  TWebDirList = class(TList)
  private
    function GetWebDirStruct(const Index: Integer): TWebDirStruct;
  public
    destructor Destroy; override;
    property WebDirStruct[const Index: Integer]: TWebDirStruct read GetWebDirStruct;
  end;

  IVirtualWebDir = Interface(IInvokable)
    ['{76C77D2D-D22C-11D6-BFD0-00C04F79AB6E}']
    function GetWebDirInfo: TWebDirList;
    function GetWebDirChildInfo(const VRootName: string): TWebDirList;
    function GetRemoteWebDirInfo: TWebDirList;
    procedure CreateVRoot(const WebDir: TWebDirStruct);
    procedure DeleteVRoot(const VRootName: WideString);
    procedure SetIISPath(const Domain: WideString; const Root: WideString = '1';
                         const Username: string = ''; const Password: string = '');
    procedure SetFilter(const WebDir: TWebDirStruct);
  end;

{ TVirtualWebDir }

  TVirtualWebDir = Class(TObject, IVirtualWebDir)
    private
      FOpenStyle: TAdsOpenStyle;
      FRefCount: Integer;
      FContainerLoaded: Boolean;
      FVirtualDirsLoaded: Boolean;
      FVRootParent: string;
      FDomain: string;
      FIISPathNum: string;
      FUserName: string;
      FPassword: string;
      FWebDirList: TWebDirList;
      FContainer: IAdsContainer;
      FFilter: TWebDirStruct;
      procedure SetOpenStyle(Value: TADsOpenStyle);
    protected
      function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
      function _AddRef: Integer; stdcall;
      function _Release: Integer; stdcall;
      procedure LoadContainer;
      procedure LoadWebDirList;
      procedure LoadWebDirChildList(const VRootName: string);
      property Container: IAdsContainer read FContainer write FContainer;
      function MatchFilter(Match: TWebDirStruct): Boolean;
      procedure LoadWebDirArray(const Container: IAdsContainer; WebDirList: TWebDirList;
          const MatchParent: string = ''; ChildrenOnly: Boolean = False; Recursive: Boolean = False; const Path: string = '');
      property OpenStyle: TAdsOpenStyle read FOpenStyle write SetOpenStyle;
    public
      constructor Create;
      destructor Destroy; override;
      function GetWebDirInfo: TWebDirList;
      function GetWebDirChildInfo(const VRootName: string): TWebDirList;
      function GetRemoteWebDirInfo: TWebDirList;
      procedure CreateVRoot(const WebDir: TWebDirStruct);
      procedure DeleteVRoot(const VRootName: WideString);
      procedure SetIISPath(const Domain: WideString; const Root: WideString = '1';
                         const Username: string = ''; const Password: string = '');
      procedure SetFilter(const WebDir: TWebDirStruct);
  end;

  IADsObject = interface(IDispatch)
    ['{FD8256D0-FD15-11CE-ABC4-02608C9E7553}']
    function  Get_Name: WideString; safecall;
    function  Get_Class_: WideString; safecall;
    function  Get_GUID: WideString; safecall;
    function  Get_ADsPath: WideString; safecall;
    function  Get_Parent: WideString; safecall;
    function  Get_Schema: WideString; safecall;
    procedure GetInfo; safecall;
    procedure SetInfo; safecall;
    function  Get(const bstrName: WideString): OleVariant; safecall;
    procedure Put(const bstrName: WideString; vProp: OleVariant); safecall;
    function  GetEx(const bstrName: WideString): OleVariant; safecall;
    procedure PutEx(lnControlCode: Integer; const bstrName: WideString; vProp: OleVariant); safecall;
    procedure GetInfoEx(vProperties: OleVariant; lnReserved: Integer); safecall;
    property Name: WideString read Get_Name;
    property Class_: WideString read Get_Class_;
    property GUID: WideString read Get_GUID;
    property ADsPath: WideString read Get_ADsPath;
    property Parent: WideString read Get_Parent;
    property Schema: WideString read Get_Schema;
  end;

  IADsContainer = interface(IDispatch)
    ['{001677D0-FD16-11CE-ABC4-02608C9E7553}']
    function  Get_Count: Integer; safecall;
    function  Get__NewEnum: IUnknown; safecall;
    function  Get_Filter: OleVariant; safecall;
    procedure Set_Filter(pVar: OleVariant); safecall;
    function  Get_Hints: OleVariant; safecall;
    procedure Set_Hints(pvFilter: OleVariant); safecall;
    function  GetObject(const ClassName: WideString; const RelativeName: WideString): IDispatch; safecall;
    function  Create(const ClassName: WideString; const RelativeName: WideString): IDispatch; safecall;
    procedure Delete(const bstrClassName: WideString; const bstrRelativeName: WideString); safecall;
    function  CopyHere(const SourceName: WideString; const NewName: WideString): IDispatch; safecall;
    function  MoveHere(const SourceName: WideString; const NewName: WideString): IDispatch; safecall;
    property Count: Integer read Get_Count;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Filter: OleVariant read Get_Filter write Set_Filter;
    property Hints: OleVariant read Get_Hints write Set_Hints;
  end;

const

  sPath               =  'Path';               { do not localize }
  sAccessRead         =  'AccessRead';         { do not localize }
  sAccessWrite        =  'AccessWrite';        { do not localize }
  sAccessExecute      =  'AccessExecute';      { do not localize }
  sAccessSource       =  'AccessSource';       { do not localize }
  sAccessScript       =  'AccessScript';       { do not localize }
  sEnableDirBrowsing  =  'EnableDirBrowsing';  { do not localize }
  sAppRoot            =  'AppRoot';            { do not localize }
  sAppFriendlyName    =  'AppFriendlyName';    { do not localize }
  sScriptMaps         =  'ScriptMaps';         { do not localize }

  {
   Other interesting properties:
    'EnableDefaultDoc',
    'AuthNTLM',
    'DefaultDoc' = 'default.htm,default.aspx,default.asp',
    'AspEnableParentPaths',
  }

  sDontLog            =  'DontLog';            { do not localize }
  sIPSecurity         =  'IPSecurity';         { do not localize }
  sUNCUSERNAME        =  'UNCUSERNAME';        { do not localize }
  sUNCPASSWORD        =  'UNCPASSWORD';        { do not localize }
  sAccessFlags        =  'AccessFlags';        { do not localize }

  ActiveDSDll         =   'activeds.dll';      { do not localize }

  IID_IADsContainer: TGUID    =   '{001677D0-FD16-11CE-ABC4-02608C9E7553}';
  MD_ACCESS_READ              =   $00000001; // Allow read access.
  MD_ACCESS_WRITE             =   $00000002; // Allow write access.
  MD_ACCESS_EXECUTE           =   $00000004; // Allow file execution (includes script permission).
  MD_ACCESS_SOURCE            =   $00000010; // Allow source access.
  MD_ACCESS_SCRIPT            =   $00000200; // Allow script execution.
  MD_ACCESS_NO_REMOTE_WRITE   =   $00000400; // Local write access only.
  MD_ACCESS_NO_REMOTE_READ    =   $00001000; // Local read access only.
  MD_ACCESS_NO_REMOTE_EXECUTE =   $00002000; // Local execution only.
  MD_ACCESS_NO_REMOTE_SCRIPT  =   $00004000; // Local host access only.

  sLocalHost                  =   'localhost';              { do not localize }
  sIISRoot                    =   'IIS://';                 { do not localize }
  sW3Svc                      =   '/w3svc';                 { do not localize }
  IISPath                     =   'IIS://localhost/w3svc';  { do not localize }
  sIISPathNum                 =   '1';                      { do not localize }
  sRoot                       =   'Root';                   { do not localize }
  IISWebServer                =   'IISWebServer';           { do not localize }
  IISWebVirtualDir            =   'IISWebVirtualDir';       { do not localize }
  IISAppRoot                  =   '/LM/W3SVC/1/ROOT/';      { do not localize }

{ ONLY A SMALL % OF THE IIS WEB VIRTUAL DIRECTORY PROPERTIES
ARE SURFACED IN TWebDirStruct: * INDICATES THOSE THAT ARE SURFACED:

AccessExecute               *
AccessFlags                 *
AccessNoRemoteExecute       *
AccessNoRemoteRead          *
AccessNoRemoteScript        *
AccessNoRemoteWrite         *
AccessRead                  *
AccessScript                *
AccessSource                *
AccessSSL
AccessSSL128
AccessSSLFlags
AccessSSLMapCert
AccessSSLNegotiateCert
AccessSSLRequireCert
AccessWrite                 *
AnonymousPasswordSync
AppAllowClientDebug
AppAllowDebugging
AppFriendlyName             *
AppIsolated
AppOopRecoverLimit
AppPackageID
AppPackageName
AppRoot                     *
AppWamClsid
AspAllowOutOfProcComponents
AspAllowSessionState
AspBufferingOn
AspCodepage
AspEnableApplicationRestart
AspEnableAspHtmlFallback
AspEnableChunkedEncoding
AspEnableParentPaths
AspEnableTypelibCache
AspErrorsToNTLog
AspExceptionCatchEnable
AspLogErrorRequests
AspProcessorThreadMax
AspQueueConnectionTestTime
AspQueueTimeout
AspRequestQueueMax
AspScriptEngineCacheMax
AspScriptErrorSentToBrowser
AspScriptFileCacheSize
AspScriptLanguage
AspScriptTimeout
AspSessionMax
AspSessionTimeout
AspThreadGateEnabled
AspThreadGateLoadHigh
AspThreadGateLoadLow
AspThreadGateSleepDelay
AspThreadGateSleepMax
AspThreadGateTimeSlice
AspTrackThreadingModel
AuthAnonymous
AuthBasic
AuthFlags
AuthNTLM
AuthPersistence
CacheControlCustom
CacheControlMaxAge
CacheControlNoCache
CacheISAPI
CGITimeout
ConnectionTimeout
CpuAppEnabled
CpuCgiEnabled
CpuEnableActiveProcs
CpuEnableAllProcLogging
CpuEnableApplicationLogging
CpuEnableCgiLogging
CpuEnableEvent
CpuEnableKernelTime
CpuEnableLogging
CpuEnablePageFaults
CpuEnableProcType
CpuEnableTerminatedProcs
CpuEnableTotalProcs
CpuEnableUserTime
CpuLimitLogEvent
CpuLimitPause
CpuLimitPriority
CpuLimitProcStop
CpuLimitsEnabled
CpuLoggingInterval
CpuLoggingMask
CpuLoggingOptions
CpuResetInterval
CreateCGIWithNewConsole
CreateProcessAsUser
DefaultDoc
DefaultDocFooter
DirBrowseFlags
DirBrowseShowDate
DirBrowseShowExtension
DirBrowseShowLongDate
DirBrowseShowSize
DirBrowseShowTime
DontLog
EnableDefaultDoc
EnableDirBrowsing           *
EnableDocFooter
EnableReverseDns
FrontPageWeb
HttpCustomHeaders
HttpErrors
HttpExpires
HttpPics
IPSecurity
LogonMethod
MimeMap
PoolIDCTimeout
PutReadSize
Realm
ScriptMaps
SSIExecDisable
UNCAuthenticationPassthrough
UNCPassword                 *
UNCUserName                 *
UploadReadAheadSize }

function ADsGetObject(lpszPathName:WideString; const riid:TGUID;
                      out ppObject): HRESULT; stdcall;

function ADsOpenObject(lpszPathName:WideString;
                       lpszUserName:WideString;
                       lpszPassword:WideString;
                       dwReserved:DWORD;
                       const riid:TGUID;
                       out ppObject): HRESULT; stdcall;

function ADsBuildEnumerator(const pADsContainer: IADsContainer;
                            out ppEnumVariant: IEnumVARIANT): HRESULT; stdcall;

function ADsFreeEnumerator(pEnumVariant: IEnumVARIANT): HRESULT; stdcall;

function ADsEnumerateNext(pEnumVariant: IEnumVARIANT;
                          cElements: ULONG;
                          var pvar: OleVARIANT;
                          var pcElementsFetched: ULONG): HRESULT; stdcall;

function GetVirtualWebDirObject: IVirtualWebDir;
procedure CheckForIIS;

implementation

procedure AdsError(const AMessage: string);
begin
  raise EAdsException.Create(AMessage);
end;

function IsVistaPlus: boolean;
begin
  Result := (Win32MajorVersion >= 6);
end;

procedure CheckForIIS;
var
  Path: WideString;
  hr : HResult;
  FContainer: IAdsContainer;
begin
  Path := sIISRoot + sLocalHost + sW3Svc;
  hr := ADsGetObject(Path, IID_IADsContainer, FContainer);
  if not Succeeded(hr) then
  begin
    if IsVistaPlus and (hr = E_FAIL) then
      raise EOleSysError.Create(sADSAccessFailureVista, hr, 0)
    else
      OleError(hr);
  end;
  if not Assigned(FContainer) then
    AdsError(sIISNotRunning);
  // testinge.  Uncomment the next line to test as if IIS is not installed
  // raise Exception.Create('test syntax error');
end;

function GetVirtualWebDirObject: IVirtualWebDir;
begin
  Result := TVirtualWebDir.Create;
end;

{ TWebDirList }

destructor TWebDirList.Destroy;
var
  I: Integer;
begin
  for I := 0 to Count -1 do
    TWebDirStruct(Items[I]).Free;
  inherited;
end;

function TWebDirList.GetWebDirStruct(const Index: Integer): TWebDirStruct;
begin
  Result := TWebDirStruct(Items[Index]);
end;

{ TVirtualWebDir }

constructor TVirtualWebDir.Create;
begin
  inherited;
  FRefCount := 0;
  FDomain := sLocalHost;
  FIISPathNum := sIISPathNum;
  FContainerLoaded := False;
  FVirtualDirsLoaded := False;
  FFilter := Nil;
end;

destructor TVirtualWebDir.Destroy;
begin
  if Assigned(FFilter) then
    FFilter.Free;
  if Assigned(FWebDirList) then
    FWebDirList.Free;
  inherited;
end;

procedure TVirtualWebDir.SetOpenStyle(Value: TADsOpenStyle);
begin
  if FOpenStyle <> Value then
  begin
    FOpenStyle := Value;
    FWebDirList.Clear;
    FContainerLoaded := False;
    FVirtualDirsLoaded := False;
  end;
end;

procedure TVirtualWebDir.SetIISPath(const Domain: WideString; const Root: WideString = '1';
                         const Username: string = ''; const Password: string = '');
begin
  if (Domain <> FDomain) or (Root <> FIISPathNum) then
  begin
    FDomain := Domain;
    FIISPathNum := Root;
    FWebDirList.Clear;
    FContainerLoaded := False;
    FVirtualDirsLoaded := False;
  end;
  FUserName := UserName;
  FPassword := Password;
end;

function MatchBoolean(const b1, b2: Boolean): Boolean;
begin
  if not b1 then
    Result := True
  else
    Result := b2;
end;

{ Filter works only on True values: if a value is set in the
  filter, then it must also be set in Virtual Root to be included }
function TVirtualWebDir.MatchFilter(Match: TWebDirStruct): Boolean;
begin
  Result := True;
  if Assigned(FFilter) then
  begin
    Result := (MatchBoolean(FFilter.AccessExecute, Match.AccessExecute)) and
              (MatchBoolean(FFilter.AccessRead, Match.AccessRead)) and
              (MatchBoolean(FFilter.AccessWrite, Match.AccessWrite)) and
              (MatchBoolean(FFilter.AccessScript, Match.AccessScript)) and
              (MatchBoolean(FFilter.AccessSource, Match.AccessSource)) and
              (MatchBoolean(FFilter.AccessNoRemoteExecute, Match.AccessNoRemoteExecute)) and
              (MatchBoolean(FFilter.AccessNoRemoteRead, Match.AccessNoRemoteRead)) and
              (MatchBoolean(FFilter.AccessNoRemoteScript, Match.AccessNoRemoteScript)) and
              (MatchBoolean(FFilter.AccessNoRemoteSource, Match.AccessNoRemoteSource)) and
              (MatchBoolean(FFilter.AccessNoRemoteWrite, Match.AccessNoRemoteWrite));
  end;
end;

procedure TVirtualWebDir.SetFilter(const WebDir: TWebDirStruct);
begin
  FFilter := WebDir;
end;

procedure TVirtualWebDir.LoadWebDirArray(const Container: IAdsContainer; WebDirList: TWebDirList;
  const MatchParent: string; ChildrenOnly: Boolean; Recursive: Boolean; const Path: string);

  function AddPath(const Path, Name: string): string;
  begin
    if Path = '' then
      Result := Name
    else
      Result := Path + '/' + Name;
  end;

var
  e: IEnumVARIANT;
  varArr: OleVariant;
  lNumElements: ULong;
  obj: IADsObject;
  ChildContainer: IADsContainer;
  hr: HResult;
  vTest: OleVariant;
  WebDir: TWebDirStruct;
  I: Integer;
begin
  // testing.  Uncomment the next line to test unexpected IIS errors
  // raise Exception.Create('test loadwebdirarray exception');
  hr := ADsBuildEnumerator(Container, e);
  if not Succeeded(hr) then
    OleError(hr);
  //WebDirList := TWebDirList.Create;
  while(Succeeded(Hr)) do
  begin
    hr := ADsEnumerateNext(e, 1, varArr ,lNumElements);
    if not Succeeded(hr) then
      OleError(hr);
    if (lNumElements=0) then
      break;
    hr := IDispatch(varArr).QueryInterface(IADsObject, obj);
    if not Succeeded(hr) then
      OleError(hr);
    if obj <> nil then
    begin
      if AnsiCompareText(obj.Class_, IISWebVirtualDir) = 0 then
      begin
        if (MatchParent <> '') and (AnsiCompareText(obj.Name, MatchParent) <> 0) then
          continue;
        WebDir := TWebDirStruct.Create;
        WebDir.Name := AddPath(Path, obj.Name);
        vTest := obj.Get(sPath);
        WebDir.Path := vTest;
        vTest := obj.Get(sAppRoot);
        WebDir.AppRoot := vTest;
        vTest := obj.Get(sDontLog);
        WebDir.DontLog := vTest;
        vTest := obj.Get(sAccessRead);
        WebDir.AccessRead := vTest;
        vTest := obj.Get(sAccessWrite);
        WebDir.AccessWrite := vTest;
        vTest := obj.Get(sEnableDirBrowsing);
        WebDir.EnableDirBrowsing := vTest;
        { to do: access other members of IPSecurity }
        vTest := obj.Get(sIPSecurity);
        WebDir.GrantByDefault := vTest.GrantByDefault;
        vTest := obj.Get(sUNCUSERNAME);
        WebDir.UNCUserName := vTest;
        vTest := obj.Get(sUNCPASSWORD);
        WebDir.UNCPassword := vTest;
        vTest := obj.Get(sAccessFlags);
        WebDir.AccessFlags := vTest;
        WebDir.AccessNoRemoteRead := (vTest and MD_ACCESS_NO_REMOTE_READ) = MD_ACCESS_NO_REMOTE_READ;
        WebDir.AccessNoRemoteWrite := (vTest and MD_ACCESS_NO_REMOTE_WRITE) = MD_ACCESS_NO_REMOTE_WRITE;
        WebDir.AccessNoRemoteScript := (vTest and MD_ACCESS_NO_REMOTE_SCRIPT) = MD_ACCESS_NO_REMOTE_SCRIPT;
        WebDir.AccessNoRemoteExecute := (vTest and MD_ACCESS_NO_REMOTE_EXECUTE) = MD_ACCESS_NO_REMOTE_EXECUTE;
        WebDir.AccessScript := (vTest and MD_ACCESS_SCRIPT) = MD_ACCESS_SCRIPT;
        WebDir.AccessExecute := (vTest and MD_ACCESS_EXECUTE) = MD_ACCESS_EXECUTE;
        WebDir.AccessSource := (vTest and MD_ACCESS_SOURCE) = MD_ACCESS_SOURCE;
        vTest := obj.Get(sScriptMaps);
        for I := VarArrayLowBound(vTest , 1) to VarArrayHighBound(vTest , 1) do
          WebDir.ScriptMaps.Add(vTest[I]);
        if MatchFilter(WebDir) then
        begin
          if not ChildrenOnly then
            WebDirList.Add(WebDir);
          if Recursive and Supports(obj, IADsContainer, ChildContainer) then
            LoadWebDirArray(ChildContainer, WebDirList,
             '' {MatchParent}, False {ChildrenOnly}, True {Recursive}, WebDir.FName {Path});
        end
        else
          WebDir.Free;
    end;
    end;
    varArr := NULL;
  end;
end;

procedure TVirtualWebDir.LoadContainer;
var
  ADs: IAdsObject;
  Path: WideString;
  hr : HResult;
  dw: Word;
begin
  Path := sIISRoot + FDomain + sW3Svc;
  if not FContainerLoaded then
  begin
    if FOpenStyle = asOpenWithGet then
      hr := ADsGetObject(Path, IID_IADsContainer, FContainer)
    else begin
      dw := 0;
      hr := ADsOpenObject(Path, FUsername, FPassword, dw,
                  IID_IADsContainer, FContainer);
    end;
    if not Succeeded(hr) then
      OleError(hr);
    if not Assigned(FContainer) then
      AdsError(sIISNotRunning);
    ADs := IAdsObject(FContainer.GetObject(IISWebServer, FIISPathNum));
    if not Assigned(ADs) then
      AdsError(sLoadError);
    if ADs.QueryInterface(IID_IADsContainer, FContainer) = S_OK then
    begin
      ADs := IADsObject(FContainer.GetObject(IIsWebVirtualDir, sRoot));
      if ADs.QueryInterface(IID_IADsContainer, FContainer) = S_OK then
        FContainerLoaded := True;
    end;
  end;
end;

procedure TVirtualWebDir.LoadWebDirList;
begin
  if FContainerLoaded and not FVirtualDirsLoaded then
  begin
    FWebDirList.Free;
    FWebDirList := TWebDirList.Create;
    LoadWebDirArray(FContainer, FWebDirList);
    FVirtualDirsLoaded := True;
    FVRootParent := '';
  end;
end;

procedure TVirtualWebDir.LoadWebDirChildList(const VRootName: string);
begin
  if FContainerLoaded and not (FVirtualDirsLoaded and (FVRootParent = VRootName)) then
  begin
    FWebDirList.Free;
    FWebDirList := TWebDirList.Create;
    LoadWebDirArray(FContainer, FWebDirList,
      VRootName { MatchParent }, True { ChildrenOnly }, True { Recursive });
    FVirtualDirsLoaded := True;
    FVRootParent := VRootName;
  end;
end;

function TVirtualWebDir.GetWebDirInfo: TWebDirList;
begin
  OpenStyle := asOpenWithGet;
  if (not FContainerLoaded) or (not FVirtualDirsLoaded) then
  begin
    LoadContainer;
    LoadWebDirList;
  end;
  Result := Self.FWebDirList;
end;

function TVirtualWebDir.GetWebDirChildInfo(const VRootName: string): TWebDirList;
begin
  OpenStyle := asOpenWithGet;
  if (not FContainerLoaded) or (not FVirtualDirsLoaded) or (VRootName <> FVRootParent) then
  begin
    LoadContainer;
    LoadWebDirChildList(VRootName);
  end;
  Result := Self.FWebDirList;
end;

function TVirtualWebDir.GetRemoteWebDirInfo: TWebDirList;
begin
  OpenStyle := asOpenWithOpen;
  if (not FContainerLoaded) or (not FVirtualDirsLoaded) then
  begin
    LoadContainer;
    LoadWebDirList;
  end;
  Result := Self.FWebDirList;
end;

procedure TVirtualWebDir.DeleteVRoot(const VRootName: WideString);
begin
  if not FContainerLoaded then
    LoadContainer;
  FContainer.Delete(IISWebVirtualDir, VRootName);
end;

procedure TVirtualWebDir.CreateVRoot(const WebDir: TWebDirStruct);
var
  ADs: IAdsObject;
begin
  if not FContainerLoaded then
    LoadContainer;
  if FContainerLoaded then
  begin
    ADs := IADsObject(FContainer.Create(IIsWebVirtualDir, WebDir.Name));
    ADs.Put(sPath, WebDir.Path);                     { do not localize }
    ADs.Put(sAccessRead, WebDir.AccessRead);         { do not localize }
    ADs.Put(sAccessWrite, WebDir.AccessWrite);       { do not localize }
    ADs.Put(sAccessExecute, WebDir.AccessExecute);   { do not localize }
    ADs.Put(sAccessSource, WebDir.AccessSource);     { do not localize }
    ADs.Put(sAccessScript, WebDir.AccessScript);     { do not localize }
    ADs.Put(sEnableDirBrowsing, WebDir.EnableDirBrowsing);  { do not localize }
    Ads.Put(sAppRoot, IIsAppRoot + WebDir.Name);     { do not localize }
    Ads.Put(sAppFriendlyName, WebDir.Name);          { do not localize }
    ADs.SetInfo;
  end;
end;

function TVirtualWebDir.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;

function TVirtualWebDir._AddRef: Integer;
begin
  Result := InterlockedIncrement(FRefCount);
end;

function TVirtualWebDir._Release: Integer;
begin
  Result := InterlockedDecrement(FRefCount);
  if Result = 0 then
    Destroy;
end;

{$DEFINE LOAD_ACTIVEDS_DLL}
{$IFNDEF LOAD_ACTIVEDS_DLL}

function ADsGetObject;       external ActiveDsDll;  { do not localize }
function ADsOpenObject;      external ActiveDSDll;  { do not localize }
function ADsBuildEnumerator; external ActiveDsDll;  { do not localize }
function ADsEnumerateNext;   external ActiveDsDll;  { do not localize }
function ADsFreeEnumerator;  external ActiveDsDll;  { do not localize }

{$ELSE}

function ADsGetObject(lpszPathName:WideString; const riid:TGUID;
                      out ppObject): HRESULT; stdcall;
var
  hMod : THandle;  
  FuncProc : function(lpszPathName : WideString; const riid : TIID; out obj) : HRESULT; stdcall;
begin
  Result := ERROR_GEN_FAILURE;
  hMod := LoadLibrary(ActiveDsDll);
  if hMod > 0 then
  begin
    try
      @FuncProc := GetProcAddress(hMod, 'ADsGetObject');
      if (@FuncProc <> nil) then
      begin
        Result := FuncProc(lpszPathName, riid, ppObject);
      end;
    finally
      FreeLibrary(hMod);
    end;
  end;
end;

function ADsOpenObject(lpszPathName:WideString;
                       lpszUserName:WideString;
                       lpszPassword:WideString;
                       dwReserved:DWORD;
                       const riid:TGUID;
                       out ppObject): HRESULT; stdcall;
var
  hMod : THandle;  
  FuncProc : function(lpszPathName: WideString; lpszUserName: WideString;
                       lpszPassword: WideString; dwReserved: DWORD;
                       const riid : TIID; out obj) : HRESULT; stdcall;
begin
  Result := ERROR_GEN_FAILURE;
  hMod := LoadLibrary(ActiveDsDll);
  if hMod > 0 then
  begin
    try
      @FuncProc := GetProcAddress(hMod, 'ADsOpenObject');
      if (@FuncProc <> nil) then
      begin
        Result := FuncProc(lpszPathName, lpszUserName, lpszPassword, dwReserved, riid, ppObject);
      end;
    finally
      FreeLibrary(hMod);
    end;
  end;
end;

function ADsBuildEnumerator(const pADsContainer: IADsContainer;
                            out ppEnumVariant: IEnumVARIANT): HRESULT; stdcall;
var
  hMod : THandle;  
  FuncProc : function(const pADsContainer: IADsContainer;
                       out ppEnumVariant: IEnumVARIANT): HRESULT; stdcall;
begin
  Result := ERROR_GEN_FAILURE;
  hMod := LoadLibrary(ActiveDsDll);
  if hMod > 0 then
  begin
    try
      @FuncProc := GetProcAddress(hMod, 'ADsBuildEnumerator');
      if (@FuncProc <> nil) then
      begin
        Result := FuncProc(pADsContainer, ppENumVariant);
      end;
    finally
      FreeLibrary(hMod);
    end;
  end;
end;

function ADsFreeEnumerator(pEnumVariant: IEnumVARIANT): HRESULT; stdcall;
var
  hMod : THandle;  
  FuncProc : function(pEnumVariant: IEnumVARIANT): HRESULT; stdcall;
begin
  Result := ERROR_GEN_FAILURE;
  hMod := LoadLibrary(ActiveDsDll);
  if hMod > 0 then
  begin
    try
      @FuncProc := GetProcAddress(hMod, 'ADsFreeEnumerator');
      if (@FuncProc <> nil) then
      begin
        Result := FuncProc(pENumVariant);
      end;
    finally
      FreeLibrary(hMod);
    end;
  end;
end;

function ADsEnumerateNext(pEnumVariant: IEnumVARIANT;
                          cElements: ULONG;
                          var pvar: OleVARIANT;
                          var pcElementsFetched: ULONG): HRESULT; stdcall;
var
  hMod : THandle;  
  FuncProc : function(pEnumVariant: IEnumVARIANT;
                       cElements: ULONG;
                       var pvar: OleVARIANT;
                       var pcElementsFetched: ULONG): HRESULT; stdcall;
begin
  Result := ERROR_GEN_FAILURE;
  hMod := LoadLibrary(ActiveDsDll);
  if hMod > 0 then
  begin
    try
      @FuncProc := GetProcAddress(hMod, 'ADsEnumerateNext');
      if (@FuncProc <> nil) then
      begin
        Result := FuncProc(pENumVariant, cElements, pVar, pcElementsFetched);
      end;
    finally
      FreeLibrary(hMod);
    end;
  end;
end;

{$ENDIF}

{ TWebDirStruct }

constructor TWebDirStruct.Create;
begin
  inherited;
  FScriptMaps := TStringList.Create;
end;

destructor TWebDirStruct.Destroy; 
begin
  inherited;
  FScriptMaps.Free;
end;

procedure TWebDirStruct.Assign(Source: TPersistent);
begin
  if Source.InheritsFrom(TWebDirStruct) then
  begin
    with TWebDirStruct(Source) do
    begin
      Self.FName := FName;
      Self.FPath := FPath;
      Self.FAdsPath := FAdsPath;
      Self.FParent := FParent;
      Self.FSchema := FSchema;
      Self.FAppRoot := FAppRoot;
      Self.FAccessRead := FAccessRead;
      Self.FAccessWrite := FAccessWrite;
      Self.FDontLog := FDontLog;
      Self.FGrantByDefault := FGrantByDefault;
      Self.FAccessFlags := FAccessFlags;
      Self.FUNCUserName := FUNCUserName;
      Self.FUNCPassword := FUNCPassword;
      Self.FAccessExecute := FAccessExecute;
      Self.FAccessSource := FAccessSource;
      Self.FAccessScript := FAccessScript;
      Self.FAccessNoRemoteRead := FAccessNoRemoteRead;
      Self.FAccessNoRemoteWrite := FAccessNoRemoteWrite;
      Self.FAccessNoRemoteExecute := FAccessNoRemoteExecute;
      Self.FAccessNoRemoteScript := FAccessNoRemoteScript;
      Self.FAccessNoRemoteSource := FAccessNoRemoteSource;
      Self.FEnableDirBrowsing := FEnableDirBrowsing;
      Self.FScriptMaps.Clear;
      Self.FScriptMaps.Assign(FScriptMaps);
    end;
  end
  else
    inherited;
end;

end.
