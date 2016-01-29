{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Vcl.SvcMgr;

{$J+,H+,X+}

interface

uses
{$IF DEFINED(CLR)}
  System.Security.Permissions, System.ComponentModel.Design.Serialization,
{$ENDIF}
  Winapi.Windows, Winapi.Messages, Winapi.WinSvc, System.SysUtils, System.Classes;

type

  { TEventLogger }

  TEventLogger = class(TObject)
  private
    FName: String;
    FEventLog: Integer;
{$IF DEFINED(CLR)}
  strict protected
    procedure Finalize; override;
{$ENDIF}
  public
    constructor Create(Name: String);
    destructor Destroy; override;
    procedure LogMessage(Message: String; EventType: DWord = 1;
      Category: Word = 0; ID: DWord = 0);
  end;

  { TDependency }

  TDependency = class(TCollectionItem)
  private
    FName: String;
    FIsGroup: Boolean;
  protected
    function GetDisplayName: string; override;
  published
    property Name: String read FName write FName;
    property IsGroup: Boolean read FIsGroup write FIsGroup;
  end;

  { TDependencies }

  TDependencies = class(TCollection)
  private
    FOwner: TPersistent;
    function GetItem(Index: Integer): TDependency;
    procedure SetItem(Index: Integer; Value: TDependency);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(Owner: TPersistent);
    property Items[Index: Integer]: TDependency read GetItem write SetItem; default;
  end;

{ TServiceThread }

const

  CM_SERVICE_CONTROL_CODE = WM_USER + 1;

type

  TService = class;

{$IF DEFINED(CLR)}
  TServiceThread = class(TWin32Thread)
{$ELSE}
  TServiceThread = class(TThread)
{$ENDIF}
  private
    FService: TService;
  protected
    procedure Execute; override;
{$IF DEFINED(CLR)}
    property Terminated;
{$ENDIF}
  public
    constructor Create(Service: TService);
    procedure ProcessRequests(WaitForMessage: Boolean);
  end;

  { TService }

  TServiceController = THandlerFunction;

  TServiceType = (stWin32, stDevice, stFileSystem);

  TCurrentStatus = (csStopped, csStartPending, csStopPending, csRunning,
    csContinuePending, csPausePending, csPaused);

  TErrorSeverity = (esIgnore, esNormal, esSevere, esCritical);

  TStartType = (stBoot, stSystem, stAuto, stManual, stDisabled);

  TServiceEvent = procedure(Sender: TService) of object;
  TContinueEvent = procedure(Sender: TService; var Continued: Boolean) of object;
  TPauseEvent = procedure(Sender: TService; var Paused: Boolean) of object;
  TStartEvent = procedure(Sender: TService; var Started: Boolean) of object;
  TStopEvent = procedure(Sender: TService; var Stopped: Boolean) of object;

  [SecurityPermission(SecurityAction.Demand, Unrestricted=True)]
  TService = class(TDataModule)
  private
    FAllowStop: Boolean;
    FAllowPause: Boolean;
    FDependencies: TDependencies;
    FDisplayName: String;
    FErrCode: DWord;
    FErrorSeverity: TErrorSeverity;
    FEventLogger: TEventLogger;
    FInteractive: Boolean;
    FLoadGroup: String;
    FParams: TStringList;
    FPassword: String;
    FServiceStartName: String;
    FServiceThread: TServiceThread;
    FServiceType: TServiceType;
    FStartType: TStartType;
    FStatus: TCurrentStatus;
    FStatusHandle: THandle;
    FTagID: DWord;
    FWaitHint: Integer;
    FWin32ErrorCode: DWord;
    FBeforeInstall: TServiceEvent;
    FAfterInstall: TServiceEvent;
    FBeforeUninstall: TServiceEvent;
    FAfterUninstall: TServiceEvent;
    FOnContinue: TContinueEvent;
    FOnExecute: TServiceEvent;
    FOnPause: TPauseEvent;
    FOnShutdown: TServiceEvent;
    FOnStart: TStartEvent;
    FOnStop: TStopEvent;
    function GetDisplayName: String;
    function GetParamCount: Integer;
    function GetParam(Index: Integer): String;
    procedure SetStatus(Value: TCurrentStatus);
    procedure SetDependencies(Value: TDependencies);
    function GetNTDependencies: String;
    function GetNTServiceType: DWORD;
    function GetNTStartType: DWORD;
    function GetNTErrorSeverity: DWORD;
    function GetNTControlsAccepted: Integer;
    procedure SetOnContinue(Value: TContinueEvent);
    procedure SetOnPause(Value: TPauseEvent);
    procedure SetOnStop(Value: TStopEvent);
    function GetTerminated: Boolean;
    function AreDependenciesStored: Boolean;
    procedure SetInteractive(Value: Boolean);
    procedure SetPassword(const Value: string);
    procedure SetServiceStartName(const Value: string);
  protected
    procedure Controller(CtrlCode: DWord);
    procedure DoStart; virtual;
    function DoStop: Boolean; virtual;
    function DoPause: Boolean; virtual;
    function DoContinue: Boolean; virtual;
    procedure DoInterrogate; virtual;
    procedure DoShutdown; virtual;
    function DoCustomControl(CtrlCode: DWord): Boolean; virtual;
{$IF DEFINED(CLR)}
    procedure Main(Argc: DWord; Argv: IntPtr);
{$ELSE}
    procedure Main(Argc: DWord; Argv: PLPWSTR);
{$ENDIF}
  public
    constructor CreateNew(AOwner: TComponent; Dummy: Integer = 0); override;
    destructor Destroy; override;
    function GetServiceController: TServiceController; virtual; abstract;
    procedure ReportStatus;
    procedure LogMessage(Message: String; EventType: DWord = 1;
      Category: Integer = 0; ID: Integer = 0);
    property ErrCode: DWord read FErrCode write FErrCode;
    property ParamCount: Integer read GetParamCount;
    property Param[Index: Integer]: String read GetParam;
    property ServiceThread: TServiceThread read FServiceThread;
    property Status: TCurrentStatus read FStatus write SetStatus;
    property Terminated: Boolean read GetTerminated;
    property Win32ErrCode: DWord read FWin32ErrorCode write FWin32ErrorCode;
  published
    property AllowStop: Boolean read FAllowStop write FAllowStop default True;
    property AllowPause: Boolean read FAllowPause write FAllowPause default True;
    property Dependencies: TDependencies read FDependencies write SetDependencies stored AreDependenciesStored;
    property DisplayName: String read GetDisplayName write FDisplayName;
    property ErrorSeverity: TErrorSeverity read FErrorSeverity write FErrorSeverity default esNormal;
    property Interactive: Boolean read FInteractive write SetInteractive default False;
    property LoadGroup: String read FLoadGroup write FLoadGroup;
    property Password: String read FPassword write SetPassword;
    property ServiceStartName: String read FServiceStartName write SetServiceStartName;
    property ServiceType: TServiceType read FServiceType write FServiceType default stWin32;
    property StartType: TStartType read FStartType write FStartType default stAuto;
    property TagID: DWord read FTagID write FTagID default 0;
    property WaitHint: Integer read FWaitHint write FWaitHint default 5000;
    property BeforeInstall: TServiceEvent read FBeforeInstall write FBeforeInstall;
    property AfterInstall: TServiceEvent read FAfterInstall write FAfterInstall;
    property BeforeUninstall: TServiceEvent read FBeforeUninstall write FBeforeUninstall;
    property AfterUninstall: TServiceEvent read FAfterUninstall write FAfterUninstall;
    property OnContinue: TContinueEvent read FOnContinue write SetOnContinue;
    property OnExecute: TServiceEvent read FOnExecute write FOnExecute;
    property OnPause: TPauseEvent read FOnPause write SetOnPause;
    property OnShutdown: TServiceEvent read FOnShutdown write FOnShutdown;
    property OnStart: TStartEvent read FOnStart write FOnStart;
    property OnStop: TStopEvent read FOnStop write SetOnStop;
  end;

  { TServiceApplication }

  [RootDesignerSerializerAttribute('', '', False)]
  [SecurityPermission(SecurityAction.Demand, Unrestricted=True)]
  TServiceApplication = class(TComponent)
  private
    FDelayInitialize: Boolean;
    FEventLogger: TEventLogger;
    FInitialized: Boolean;
    FTitle: string;
    procedure OnExceptionHandler(Sender: TObject; E: Exception);
    function GetServiceCount: Integer;
  protected
    procedure DoHandleException(E: Exception); dynamic;
    procedure RegisterServices(Install, Silent: Boolean);
    function Hook(var Message: TMessage): Boolean;
{$IF DEFINED(CLR)}
    procedure DispatchServiceMain(Argc: DWord; Argv: IntPtr);
{$ELSE}
    procedure DispatchServiceMain(Argc: DWord; Argv: PLPWSTR);
{$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property DelayInitialize: Boolean read FDelayInitialize write FDelayInitialize;
    property ServiceCount: Integer read GetServiceCount;
    // The following uses the current behaviour of the IDE module manager
    procedure CreateForm(InstanceClass: TComponentClass; var Reference); virtual;
    procedure Initialize; virtual;
    function Installing: Boolean;
    procedure Run; virtual;
    property Title: string read FTitle write FTitle;
  end;

var
  Application: TServiceApplication = nil;

implementation

uses
{$IF DEFINED(CLR)}
  System.Runtime.InteropServices, System.IO,
{$ENDIF}
  System.UITypes, Vcl.Forms, Vcl.Dialogs, Vcl.Consts;

{ TEventLogger }

constructor TEventLogger.Create(Name: String);
begin
  inherited Create;
  FName := Name;
  FEventLog := 0;
end;

{$IF DEFINED(CLR)}
procedure TEventLogger.Finalize;
begin
  if FEventLog <> 0 then
    DeregisterEventSource(FEventLog);
  inherited;
end;
{$ENDIF}

destructor TEventLogger.Destroy;
begin
  if FEventLog <> 0 then
  begin
    DeregisterEventSource(FEventLog);
    FEventLog := 0;
  end;
{$IF DEFINED(CLR)}
  System.GC.SuppressFinalize(self);
{$ENDIF}
  inherited Destroy;
end;

procedure TEventLogger.LogMessage(Message: String; EventType: DWord;
  Category: Word; ID: DWord);
{$IF DEFINED(CLR)}
var
  P, PP: IntPtr;
begin
  if FEventLog = 0 then
    FEventLog := RegisterEventSource(nil, FName);
  P := Marshal.StringToHGlobalAuto(Message);
  try
    PP := Marshal.AllocHGlobal(SizeOf(IntPtr));
    try
      Marshal.WriteIntPtr(PP, P);
      ReportEvent(FEventLog, EventType, Category, ID, nil, 1, 0, PP, nil);
    finally
      Marshal.FreeHGlobal(PP);
    end;
  finally
    Marshal.FreeHGlobal(P);
  end;
end;
{$ELSE}
var
  P: Pointer;
begin
  P := PChar(Message);
  if FEventLog = 0 then
    FEventLog := RegisterEventSource(nil, PChar(FName));
  ReportEvent(FEventLog, EventType, Category, ID, nil, 1, 0, @P, nil);
end;
{$ENDIF}

{ TDependency }

function TDependency.GetDisplayName: string;
begin
  if Name <> '' then
    Result := Name else
    Result := inherited GetDisplayName;
end;

{ TDependencies }

constructor TDependencies.Create(Owner: TPersistent);
begin
  FOwner := Owner;
  inherited Create(TDependency);
end;

function TDependencies.GetItem(Index: Integer): TDependency;
begin
  Result := TDependency(inherited GetItem(Index));
end;

procedure TDependencies.SetItem(Index: Integer; Value: TDependency);
begin
  inherited SetItem(Index, TCollectionItem(Value));
end;

function TDependencies.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

{ TServiceThread }

constructor TServiceThread.Create(Service: TService);
begin
{$IF DEFINED(CLR)}
  inherited Create(True);
  FService := Service;
{$ELSE}
  FService := Service;
  inherited Create(True);
{$ENDIF}
end;

procedure TServiceThread.Execute;
var
  msg: TMsg;
  Started: Boolean;
begin
  PeekMessage(msg, 0, WM_USER, WM_USER, PM_NOREMOVE); { Create message queue }
  try
    // Allow initialization of the Application object after
    // StartServiceCtrlDispatcher to prevent conflicts under
    // Windows 2003 Server when registering a class object with OLE.
    if Application.DelayInitialize then
      Application.Initialize;
    FService.Status := csStartPending;
    Started := True;
    if Assigned(FService.OnStart) then FService.OnStart(FService, Started);
    if not Started then Exit;
    try
      FService.Status := csRunning;
      if Assigned(FService.OnExecute) then
        FService.OnExecute(FService)
      else
        ProcessRequests(True);
      ProcessRequests(False);
    except
      on E: Exception do
        FService.LogMessage(Format(SServiceFailed,[SExecute, E.Message]));
    end;
  except
    on E: Exception do
      FService.LogMessage(Format(SServiceFailed,[SStart, E.Message]));
  end;
end;

const
  ActionStr: array[1..5] of String = (SStop, SPause, SContinue, SInterrogate,
    SShutdown);

procedure TServiceThread.ProcessRequests(WaitForMessage: Boolean);
var
  msg: TMsg;
  OldStatus: TCurrentStatus;
  ErrorMsg: String;
  ActionOK, Rslt: Boolean;
begin
  while True do
  begin
    if Terminated and WaitForMessage then break;
    if WaitForMessage then
      Rslt := GetMessage(msg, 0, 0, 0)
    else
      Rslt := PeekMessage(msg, 0, 0, 0, PM_REMOVE);
    if not Rslt then break;
    if msg.hwnd = 0 then { Thread message }
    begin
      if msg.message = CM_SERVICE_CONTROL_CODE then
      begin
        OldStatus := FService.Status;
        try
          ActionOK := True;
          case NativeInt(msg.wParam) of
            SERVICE_CONTROL_STOP: ActionOK := FService.DoStop;
            SERVICE_CONTROL_PAUSE: ActionOK := FService.DoPause;
            SERVICE_CONTROL_CONTINUE: ActionOK := FService.DoContinue;
            SERVICE_CONTROL_SHUTDOWN: FService.DoShutDown;
            SERVICE_CONTROL_INTERROGATE: FService.DoInterrogate;
          else
            ActionOK := FService.DoCustomControl(msg.wParam);
          end;
          if not ActionOK then
            FService.Status := OldStatus;
        except
          on E: Exception do
          begin
            if msg.wParam <> SERVICE_CONTROL_SHUTDOWN then
              FService.Status := OldStatus;
            if NativeInt(msg.wParam) in [1..5] then
              ErrorMsg := Format(SServiceFailed, [ActionStr[NativeInt(msg.wParam)], E.Message])
            else
              ErrorMsg := Format(SCustomError,[msg.wParam, E.Message]);
            FService.LogMessage(ErrorMsg);
          end;
        end;
      end else
        DispatchMessage(msg);
    end else
      DispatchMessage(msg);
  end;
end;

{ TService }

constructor TService.CreateNew(AOwner: TComponent; Dummy: Integer = 0);
begin
  inherited CreateNew(AOwner, Dummy);
  FWaitHint := 5000;
  FInteractive := False;
  FServiceType := stWin32;
  FParams := TStringList.Create;
  FDependencies := TDependencies.Create(Self);
  FErrorSeverity := esNormal;
  FStartType := stAuto;
  FTagID := 0;
  FAllowStop := True;
  FAllowPause := True;
end;

destructor TService.Destroy;
begin
  FDependencies.Free;
  FParams.Free;
  FEventLogger.Free;
  inherited Destroy;
end;

function TService.GetDisplayName: String;
begin
  if FDisplayName <> '' then
    Result := FDisplayName
  else
    Result := Name;
end;

procedure TService.SetInteractive(Value: Boolean);
begin
  if Value = FInteractive then Exit;
  if Value then
  begin
    Password := '';
    ServiceStartName := '';
  end;
  FInteractive := Value;
end;

procedure TService.SetPassword(const Value: string);
begin
  if Value = FPassword then Exit;
  if Value <> '' then
    Interactive := False;
  FPassword := Value;
end;

procedure TService.SetServiceStartName(const Value: string);
begin
  if Value = FServiceStartName then Exit;
  if Value <> '' then
    Interactive := False;
  FServiceStartName := Value;
end;

procedure TService.SetDependencies(Value: TDependencies);
begin
  FDependencies.Assign(Value);
end;

function TService.AreDependenciesStored: Boolean;
begin
  Result := FDependencies.Count > 0;
end;

function TService.GetParamCount: Integer;
begin
  Result := FParams.Count;
end;

function TService.GetParam(Index: Integer): String;
begin
  Result := FParams[Index];
end;

procedure TService.SetOnContinue(Value: TContinueEvent);
begin
  FOnContinue := Value;
  AllowPause := True;
end;

procedure TService.SetOnPause(Value: TPauseEvent);
begin
  FOnPause := Value;
  AllowPause := True;
end;

procedure TService.SetOnStop(Value: TStopEvent);
begin
  FOnStop := Value;
  AllowStop := True;
end;

function TService.GetTerminated: Boolean;
begin
  Result := False;
  if Assigned(FServiceThread) then
    Result := FServiceThread.Terminated;
end;

function TService.GetNTDependencies: String;
var
{$IF DEFINED(CLR)}
  I, J, Len: Integer;
  Pos: Integer;
  Temp: string;
{$ELSE}
  I, Len: Integer;
  P: PChar;
{$ENDIF}
begin
  Result := '';
  Len := 0;
  for i := 0 to Dependencies.Count - 1 do
  begin
    Inc(Len, Length(Dependencies[i].Name) + 1); // For null-terminator
    if Dependencies[i].IsGroup then Inc(Len);
  end;
{$IF DEFINED(CLR)}
  if Len <> 0 then
  begin
    Inc(Len); // For final null-terminator;
    SetLength(Result, Len);
    Pos := 1;
    for i := 0 to Dependencies.Count - 1 do
    begin
      if Dependencies[i].IsGroup then
      begin
        Result[Pos] := SC_GROUP_IDENTIFIER;
        Inc(Pos);
      end;
      Temp := Dependencies[i].Name;
      Len := Length(Temp) + 1;
      SetLength(Temp, Len); // add one for null-terminator
      for j := 1 to Len do
      begin
        Result[Pos] := Temp[j];
        Inc(Pos);
      end;
    end;
    Result[Pos] := #0;
  end;
{$ELSE}
  if Len <> 0 then
  begin
    Inc(Len); // For final null-terminator;
    SetLength(Result, Len);
    P := @Result[1];
    for i := 0 to Dependencies.Count - 1 do
    begin
      if Dependencies[i].IsGroup then
      begin
        P^ := SC_GROUP_IDENTIFIER;
        Inc(P);
      end;
      P := StrECopy(P, PChar(Dependencies[i].Name));
      Inc(P);
    end;
    P^ := #0;
  end;
{$ENDIF}
end;

const
  NTServiceType: array[TServiceType] of DWORD = ( SERVICE_WIN32_OWN_PROCESS,
    SERVICE_KERNEL_DRIVER, SERVICE_FILE_SYSTEM_DRIVER);

function TService.GetNTServiceType: DWORD;
begin
  Result := NTServiceType[FServiceType];
  if (FServiceType = stWin32) and Interactive then
    Result := Result or SERVICE_INTERACTIVE_PROCESS;
  if (FServiceType = stWin32) and (Application.ServiceCount > 1) then
    Result := (Result xor SERVICE_WIN32_OWN_PROCESS) or SERVICE_WIN32_SHARE_PROCESS;
end;

const
  NTStartType: array[TStartType] of DWORD = (SERVICE_BOOT_START,
    SERVICE_SYSTEM_START, SERVICE_AUTO_START, SERVICE_DEMAND_START,
    SERVICE_DISABLED);

function TService.GetNTStartType: DWORD;
begin
  Result := NTStartType[FStartType];
  if (FStartType in [stBoot, stSystem]) and (FServiceType <> stDevice) then
    Result := SERVICE_AUTO_START;
end;

function TService.GetNTErrorSeverity: DWORD;
const
  NTErrorSeverity: array[TErrorSeverity] of DWORD = (SERVICE_ERROR_IGNORE,
    SERVICE_ERROR_NORMAL, SERVICE_ERROR_SEVERE, SERVICE_ERROR_CRITICAL);
begin
  Result := NTErrorSeverity[FErrorSeverity];
end;

function TService.GetNTControlsAccepted: Integer;
begin
  Result := SERVICE_ACCEPT_SHUTDOWN;
  if AllowStop then Result := Result or SERVICE_ACCEPT_STOP;
  if AllowPause then Result := Result or SERVICE_ACCEPT_PAUSE_CONTINUE;
end;

procedure TService.LogMessage(Message: String; EventType: DWord; Category, ID: Integer);
begin
  if FEventLogger = nil then
    FEventLogger := TEventLogger.Create(Name);
  FEventLogger.LogMessage(Message, EventType, Category, ID);
end;

const
  LastStatus: TCurrentStatus = csStartPending;
  NTServiceStatus: array[TCurrentStatus] of DWORD = (SERVICE_STOPPED,
    SERVICE_START_PENDING, SERVICE_STOP_PENDING, SERVICE_RUNNING,
    SERVICE_CONTINUE_PENDING, SERVICE_PAUSE_PENDING, SERVICE_PAUSED);
  PendingStatus: set of TCurrentStatus = [csStartPending, csStopPending,
    csContinuePending, csPausePending];

procedure TService.ReportStatus;
var
  ServiceStatus: TServiceStatus;
begin
  with ServiceStatus do
  begin
    dwWaitHint := FWaitHint;
    dwServiceType := GetNTServiceType;
    if FStatus = csStartPending then
      dwControlsAccepted := 0 else
      dwControlsAccepted := GetNTControlsAccepted;
    if (FStatus in PendingStatus) and (FStatus = LastStatus) then
      Inc(dwCheckPoint) else
      dwCheckPoint := 0;
    LastStatus := FStatus;
    dwCurrentState := NTServiceStatus[FStatus];
    dwWin32ExitCode := Win32ErrCode;
    dwServiceSpecificExitCode := ErrCode;
    if ErrCode <> 0 then
      dwWin32ExitCode := ERROR_SERVICE_SPECIFIC_ERROR;
    if not SetServiceStatus(FStatusHandle, ServiceStatus) then
      LogMessage(SysErrorMessage(GetLastError));
  end;
end;

procedure TService.SetStatus(Value: TCurrentStatus);
begin
  FStatus := Value;
  if not (csDesigning in ComponentState) then
    ReportStatus;
end;

{$IF DEFINED(CLR)}
procedure TService.Main(Argc: DWord; Argv: IntPtr);
var
  i: Integer;
  Controller: TServiceController;
  PStr: IntPtr;
begin
  for i := 0 to Argc - 1 do
  begin
    PStr := Marshal.ReadIntPtr(Argv, i * SizeOf(IntPtr));
    FParams.Add(Marshal.PtrToStringAuto(PStr));
  end;
  Controller := Self.GetServiceController();
  FStatusHandle := RegisterServiceCtrlHandler(Name, Controller);
  if (FStatusHandle = 0) then
    LogMessage(SysErrorMessage(GetLastError))
  else
    DoStart;
end;
{$ELSE}
procedure TService.Main(Argc: DWord; Argv: PLPWSTR);
type
  PPCharArray = ^TPCharArray;
  TPCharArray = array [0..1024] of PChar;
var
  i: Integer;
  Controller: THandlerFunction;
begin
  for i := 0 to Argc - 1 do
    FParams.Add(PPCharArray(Argv)[i]);
  Controller := GetServiceController();
  FStatusHandle := RegisterServiceCtrlHandler(PChar(Name), @Controller);
  if (FStatusHandle = 0) then
    LogMessage(SysErrorMessage(GetLastError))
  else
    DoStart;
end;
{$ENDIF}

procedure TService.Controller(CtrlCode: DWord);
begin
  PostThreadMessage(ServiceThread.ThreadID, CM_SERVICE_CONTROL_CODE, CtrlCode, 0);
  if ServiceThread.Suspended then ServiceThread.Resume;
end;

procedure TService.DoStart;
begin
  try
    Status := csStartPending;
    try
      FServiceThread := TServiceThread.Create(Self);
      FServiceThread.Resume;
      FServiceThread.WaitFor;
      FreeAndNil(FServiceThread);
    finally
      Status := csStopped;
    end;
  except
    on E: Exception do
      LogMessage(Format(SServiceFailed,[SExecute, E.Message]));
  end;
end;

function TService.DoStop: Boolean;
begin
  Result := True;
  Status := csStopPending;
  if Assigned(FOnStop) then FOnStop(Self, Result);
  if Result then ServiceThread.Terminate;
end;

function TService.DoPause: Boolean;
begin
  Result := True;
  Status := csPausePending;
  if Assigned(FOnPause) then FOnPause(Self, Result);
  if Result then
  begin
    Status := csPaused;
    ServiceThread.Suspend;
  end;
end;

function TService.DoContinue: Boolean;
begin
  Result := True;
  Status := csContinuePending;
  if Assigned(FOnContinue) then FOnContinue(Self, Result);
  if Result then
    Status := csRunning;
end;

procedure TService.DoInterrogate;
begin
  ReportStatus;
end;

procedure TService.DoShutdown;
begin
  Status := csStopPending;
  try
    if Assigned(FOnShutdown) then FOnShutdown(Self);
  finally
    { Shutdown cannot abort, it must stop regardless of any exception }
    ServiceThread.Terminate;
  end;
end;

function TService.DoCustomControl(CtrlCode: DWord): Boolean;
begin
  Result := True;
end;

{ TServiceApplication }

type
  TServiceClass = class of TService;

{$IF DEFINED(CLR)}
procedure ServiceMain(Argc: DWord; Argv: IntPtr);
{$ELSE}
procedure ServiceMain(Argc: DWord; Argv: PLPWSTR); stdcall;
{$ENDIF}
begin
  Application.DispatchServiceMain(Argc, Argv);
end;

{$IF DEFINED(CLR)}
const
  ServiceMainDelegate: TServiceMainFunction = @ServiceMain;
{$ENDIF}

procedure DoneServiceApplication;
begin
  with Vcl.Forms.Application do
  begin
    if Handle <> 0 then ShowOwnedPopups(Handle, False);
    ShowHint := False;
    Destroying;
    DestroyComponents;
  end;
  with Application do
  begin
    Destroying;
    DestroyComponents;
  end;
end;

constructor TServiceApplication.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDelayInitialize := False;
  FEventLogger := TEventLogger.Create(ExtractFileName(ParamStr(0)));
  FInitialized := False;
  Vcl.Forms.Application.HookMainWindow(Hook);
end;

destructor TServiceApplication.Destroy;
begin
  FreeAndNil(FEventLogger);
  Vcl.Forms.Application.OnException := nil;
  Vcl.Forms.Application.UnhookMainWindow(Hook);
  inherited Destroy;
end;

{$IF DEFINED(CLR)}
procedure TServiceApplication.DispatchServiceMain(Argc: DWord; Argv: IntPtr);
var
  i: Integer;
  PSTR: IntPtr;
begin
  for i := 0 to ComponentCount - 1 do
    if (Components[i] is TService) then
    begin
      PStr := Marshal.ReadIntPtr(Argv, 0);
      if SameText(Marshal.PtrToStringAuto(PStr), Components[i].Name) then
      begin
        TService(Components[i]).Main(Argc, Argv);
        break;
      end;
    end;
end;
{$ELSE}
procedure TServiceApplication.DispatchServiceMain(Argc: DWord; Argv: PLPWSTR);
var
  i: Integer;
begin
  for i := 0 to ComponentCount - 1 do
    if (Components[i] is TService) and
       (AnsiCompareText(Argv^, Components[i].Name) = 0) then
    begin
      TService(Components[i]).Main(Argc, Argv);
      break;
    end;
end;
{$ENDIF}

function TServiceApplication.GetServiceCount: Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to ComponentCount - 1 do
    if Components[i] is TService then
      Inc(Result);
end;

procedure TServiceApplication.RegisterServices(Install, Silent: Boolean);

  procedure InstallService(Service: TService; SvcMgr: SC_HANDLE);
  var
{$IF DEFINED(CLR)}
    TmpTagID: DWORD;
{$ELSE}
    TmpTagID: DWORD;
    PTag: PDWORD;
    PSSN: PChar;
{$ENDIF}
    Svc: SC_HANDLE;
    Path: string;
  begin
    Path := ParamStr(0);
    with Service do
    begin
     if Assigned(BeforeInstall) then BeforeInstall(Service);
     TmpTagID := TagID;
{$IF DEFINED(CLR)}
     if (TagID <> 0) and (ServiceStartName <> '') then
        Svc := CreateService(SvcMgr, Name, DisplayName, SERVICE_ALL_ACCESS,
          GetNTServiceType, GetNTStartType, GetNTErrorSeverity,
          Path, LoadGroup, TmpTagID, GetNTDependencies, ServiceStartName, Password)
      else if TagID <> 0 then
        Svc := CreateService(SvcMgr, Name, DisplayName, SERVICE_ALL_ACCESS,
          GetNTServiceType, GetNTStartType, GetNTErrorSeverity,
          Path, LoadGroup, TmpTagID, GetNTDependencies, nil, Password)
      else if ServiceStartName <> '' then
        Svc := CreateService(SvcMgr, Name, DisplayName, SERVICE_ALL_ACCESS,
          GetNTServiceType, GetNTStartType, GetNTErrorSeverity,
          Path, LoadGroup, nil, GetNTDependencies, ServiceStartName, Password)
      else
        Svc := CreateService(SvcMgr, Name, DisplayName, SERVICE_ALL_ACCESS,
          GetNTServiceType, GetNTStartType, GetNTErrorSeverity,
          Path, LoadGroup, nil, GetNTDependencies, nil, Password);
{$ELSE}
      if TmpTagID > 0 then PTag := @TmpTagID else PTag := nil;
      if ServiceStartName = '' then
        PSSN := nil else
        PSSN := PChar(ServiceStartName);
      Svc := CreateService(SvcMgr, PChar(Name), PChar(DisplayName),
        SERVICE_ALL_ACCESS, GetNTServiceType, GetNTStartType, GetNTErrorSeverity,
        PChar(Path), PChar(LoadGroup), PTag, PChar(GetNTDependencies),
        PSSN, PChar(Password));
{$ENDIF}
      TagID := TmpTagID;
      if Svc = 0 then
        RaiseLastOSError;
      try
        try
          if Assigned(AfterInstall) then AfterInstall(Service);
        except
          on E: Exception do
          begin
            DeleteService(Svc);
            raise;
          end;
        end;
      finally
        CloseServiceHandle(Svc);
      end;
    end;
  end;

  procedure UninstallService(Service: TService; SvcMgr: SC_HANDLE);
  var
    Svc: SC_HANDLE;
  begin
    with Service do
    begin
      if Assigned(BeforeUninstall) then BeforeUninstall(Service);
{$IF DEFINED(CLR)}
      Svc := OpenService(SvcMgr, Name, SERVICE_ALL_ACCESS);
{$ELSE}
      Svc := OpenService(SvcMgr, PChar(Name), SERVICE_ALL_ACCESS);
{$ENDIF}
      if Svc = 0 then RaiseLastOSError;
      try
        if not DeleteService(Svc) then RaiseLastOSError;
      finally
        CloseServiceHandle(Svc);
      end;
      if Assigned(AfterUninstall) then AfterUninstall(Service);
    end;
  end;

  procedure DisplayMessage(const Msg: string; const MsgType: TMsgDlgType);
  begin
    if IsConsole then
      WriteLn(Msg)
    else
      MessageDlg(Msg, MsgType, [mbOk], 0);
  end;

var
  SvcMgr: SC_HANDLE;
  i: Integer;
  Success: Boolean;
  Msg: string;
begin
  Success := True;
{$IF DEFINED(CLR)}
  SvcMgr := OpenSCManager('', nil, SC_MANAGER_ALL_ACCESS);
{$ELSE}
  SvcMgr := OpenSCManager(nil, nil, SC_MANAGER_ALL_ACCESS);
{$ENDIF}
  if SvcMgr = 0 then RaiseLastOSError;
  try
    for i := 0 to ComponentCount - 1 do
      if Components[i] is TService then
      try
        if Install then
          InstallService(TService(Components[i]), SvcMgr)
        else
          UninstallService(TService(Components[i]), SvcMgr)
      except
        on E: Exception do
        begin
          Success := False;
          if Install then
            Msg := SServiceInstallFailed
          else
            Msg := SServiceUninstallFailed;
          with TService(Components[i]) do
            DisplayMessage(Format(Msg, [DisplayName, E.Message]), mtError);
        end;
      end;
    if Success and not Silent then
      if Install then
        DisplayMessage(SServiceInstallOK, mtInformation)
      else
        DisplayMessage(SServiceUninstallOK, mtInformation);
  finally
    CloseServiceHandle(SvcMgr);
  end;
end;

function TServiceApplication.Hook(var Message: TMessage): Boolean;
begin
  Result := Message.Msg = WM_ENDSESSION;
end;

procedure TServiceApplication.CreateForm(InstanceClass: TComponentClass;
  var Reference);
begin
  if InstanceClass.InheritsFrom(TService) then
  begin
{$IF DEFINED(CLR)}
    try
      Reference := TServiceClass(InstanceClass).Create(Self);
    except
      Reference := nil;
      raise;
    end;
{$ELSE}
    try
      TComponent(Reference) := InstanceClass.Create(Self);
    except
      TComponent(Reference) := nil;
      raise;
    end;
{$ENDIF}
  end else
    Vcl.Forms.Application.CreateForm(InstanceClass, Reference);
end;

procedure TServiceApplication.DoHandleException(E: Exception);
begin
  FEventLogger.LogMessage(E.Message);
end;

procedure TServiceApplication.Initialize;
begin
  if not FInitialized then
  begin
    FInitialized := True;
    Vcl.Forms.Application.ShowMainForm :=False;
    Vcl.Forms.Application.Initialize;
  end;
end;

function FindSwitch(const Switch: string): Boolean;
begin
  Result := FindCmdLineSwitch(Switch, ['-', '/'], True);
end;

function TServiceApplication.Installing: Boolean;
begin
  Result := FindSwitch('INSTALL') or FindSwitch('UNINSTALL');
end;

procedure TServiceApplication.OnExceptionHandler(Sender: TObject; E: Exception);
begin
  DoHandleException(E);
end;

type
  TServiceTableEntryArray = array of TServiceTableEntry;

  TServiceStartThread = class(TThread)
  private
    FServiceStartTable: TServiceTableEntryArray;
  protected
    procedure DoTerminate; override;
    procedure Execute; override;
{$IF DEFINED(CLR)}
    property ReturnValue;
{$ENDIF}
  public
    constructor Create(Services: TServiceTableEntryArray);
  end;

constructor TServiceStartThread.Create(Services: TServiceTableEntryArray);
begin
{$IF DEFINED(CLR)}
  inherited Create(True);
  FreeOnTerminate := False;
  ReturnValue := 0;
  FServiceStartTable := Services;
  Resume;
{$ELSE}
  FreeOnTerminate := False;
  ReturnValue := 0;
  FServiceStartTable := Services;
  inherited Create(False);
{$ENDIF}
end;

procedure TServiceStartThread.DoTerminate;
begin
  inherited DoTerminate;
  PostMessage(Vcl.Forms.Application.Handle, WM_QUIT, 0, 0);
end;

procedure TServiceStartThread.Execute;
begin
  if StartServiceCtrlDispatcher(FServiceStartTable[0]) then
    ReturnValue := 0
  else
    ReturnValue := GetLastError;
end;

procedure TServiceApplication.Run;
var
  ServiceStartTable: TServiceTableEntryArray;
  ServiceCount, i, J: Integer;
  StartThread: TServiceStartThread;
begin
{$IF NOT DEFINED(CLR)}
  AddExitProc(DoneServiceApplication);
{$ENDIF}
  if FindSwitch('INSTALL') then
    RegisterServices(True, FindSwitch('SILENT'))
  else if FindSwitch('UNINSTALL') then
    RegisterServices(False, FindSwitch('SILENT'))
  else
  begin
    Vcl.Forms.Application.OnException := OnExceptionHandler;
    ServiceCount := 0;
    for i := 0 to ComponentCount - 1 do
      if Components[i] is TService then Inc(ServiceCount);
    SetLength(ServiceStartTable, ServiceCount + 1);
{$IF NOT DEFINED(CLR)}
    FillChar(ServiceStartTable[0], SizeOf(TServiceTableEntry) * (ServiceCount + 1), 0);
{$ENDIF}
    J := 0;
    for i := 0 to ComponentCount - 1 do
      if Components[i] is TService then
      begin
{$IF DEFINED(CLR)}
        ServiceStartTable[J].lpServiceName := Components[i].Name;
        ServiceStartTable[J].lpServiceProc := ServiceMainDelegate;
{$ELSE}
        ServiceStartTable[J].lpServiceName := PChar(Components[i].Name);
        ServiceStartTable[J].lpServiceProc := @ServiceMain;
{$ENDIF}
        Inc(J);
      end;
    StartThread := TServiceStartThread.Create(ServiceStartTable);
    try
      while not Vcl.Forms.Application.Terminated do
      try
        Vcl.Forms.Application.HandleMessage;
      except
        on E: Exception do
          DoHandleException(E);
      end;
      Vcl.Forms.Application.Terminate;
{$IF DEFINED(CLR)}
      DoneServiceApplication;
{$ENDIF}
      if StartThread.ReturnValue <> 0 then
        FEventLogger.LogMessage(SysErrorMessage(StartThread.ReturnValue));
    finally
      StartThread.Free;
    end;
  end;
end;

procedure InitApplication;
begin
  Application := TServiceApplication.Create(nil);
end;

procedure DoneApplication;
begin
  Application.Free;
  Application := nil;
end;

initialization
  InitApplication;
finalization
  DoneApplication;
end.
