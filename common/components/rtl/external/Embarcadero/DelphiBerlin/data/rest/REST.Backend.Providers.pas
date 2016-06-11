{*******************************************************}
{                                                       }
{             Delphi REST Client Framework              }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$HPPEMIT LINKUNIT}
unit REST.Backend.Providers;

{$SCOPEDENUMS ON}

interface

uses
  System.Classes, System.Generics.Collections, System.SysUtils, System.SyncObjs,
    REST.Backend.MetaTypes;

type

  IBackendProvider = interface;
  IBackendService = interface;


  IBackendProvider = interface
    ['{C563AC66-8AF4-45D8-906C-161B061B912F}']
    function GetProviderID: string;
    property ProviderID: string read GetProviderID;
  end;

  IBackendService = interface
    ['{E8BD0783-0E4D-459F-9EEC-11B5F29FE792}']
                           
  end;

  IBackendApi = interface
    ['{B2608078-946B-475D-B2DD-8523FDC1C773}']
  end;

  IBackendServiceComponent = interface
    ['{085164DF-FCA7-45CD-BAC3-42C6B0B08170}']
    function GetProvider: IBackendProvider;
    function GetServiceIID: TGuid;
    property Provider: IBackendProvider read GetProvider;
    property ServiceIID: TGuid read GetServiceIID;
  end;

  TBackendAPIThread = class(TPersistent)
  private
    FOnStarting: TNotifyEvent;
    FOnTerminated: TNotifyEvent;
  protected
    procedure DoThreadStarting; virtual;
    procedure OnThreadTerminate(Sender: TObject);
    procedure DoThreadTerminated; virtual;
  public
    property OnStarting: TNotifyEvent read FOnStarting write FOnStarting;
    property OnTerminated: TNotifyEvent read FOnTerminated write FOnTerminated;
  end;

  TBackendAPIThread<T: class> = class(TBackendAPIThread)
  public type
    TExecuteProc = TProc<T>;
    TExecuteEvent = procedure(Sender: TObject; AApi: T) of object;
  private type
    TInternalThread = class(TThread)
    private
      FProc: TProc;
      FAPI: T;
    protected
      procedure Execute; override;
    public
      constructor Create(const API: T; const AProc: TProc);
      destructor Destroy; override;
    end;
  protected type
    TOnCreateAPI = TFunc<T>;
  private
    FThread: TThread;
    FEvent: TEvent;
    FOnCreateAPI: TOnCreateAPI;
    function CreateAPI: T;
    function GetFatalException: TObject;
    function GetStarted: Boolean;
    function GetFinished: Boolean;
  protected
    function CreateThread(const ASender: TObject; const AEvent: TExecuteEvent; const AExecuteProc: TExecuteProc): TThread;
    procedure Start(const ASender: TObject; const AEvent: TExecuteEvent; const AExecuteProc: TExecuteProc); overload;
    property OnCreateAPI: TOnCreateAPI read FOnCreateAPI write FOnCreateAPI;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Start(const AExecuteProc: TExecuteProc); overload;
    procedure Start(const ASender: TObject; const AEvent: TExecuteEvent);  overload;
    procedure WaitFor;
    property FatalException: TObject read GetFatalException;
    property Started: Boolean read GetStarted;
    property Finished: Boolean read GetFinished;
  end;

  TBackendProviders = class
  public type
    TFactoryMethod = function(const AProvider: IBackendProvider; const IID: TGUID): IBackendService of object;

    TService = class
    private
      FIID: TGuid;
      FUnitNames: TArray<string>;
      FFactoryMethod: TFactoryMethod;
    public
      property IID: TGUID read FIID;
      property UnitNames: TArray<string> read FUnitNames;
      property FactoryProc: TFactoryMethod read FFactoryMethod;
    end;

    TProvider = class
    private
      FProviderID: string;
      FDisplayName: string;
      FServices: TList<TService>;
      function GetService(I: Integer): TService;
      function GetCount: Integer;
    public
      constructor Create;
      destructor Destroy; override;
      function FindService(const IID: TGUID): TService;
      property ProviderID: string read FProviderID;
      property DisplayName: string read FDisplayName;
      property Count: Integer read GetCount;
      property Services[I: Integer]: TService read GetService;
    end;
  private
    class var
      FInstance: TBackendProviders;
  private
    FProviders: TList<TProvider>;
    class function GetInstance: TBackendProviders; static;
    function GetCount: Integer;
    function GetProvider(I: Integer): TProvider;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Register(const AProviderID: string; const ADisplayName: string);
    procedure Unregister(const AProviderID: string);
    procedure RegisterService(const AProviderID: string; const AIID: TGuid; const AFactory: TFactoryMethod; const AUnitNames: TArray<string>);
    procedure UnregisterService(const AProviderID: string; const IID: TGuid);
    function FindProvider(const AProviderID: string): TProvider;
    function FindService(const AProviderID: string; const IID: TGUID): TService;
    property Count: Integer read GetCount;
    property Providers[I: Integer]: TProvider read GetProvider;
    class property Instance: TBackendProviders read GetInstance;
  end;

  TBackendAuthentication = (Default, Root, Application, User, Session, None);
  TBackendDefaultAuthentication = (Root, Application, User, Session, None);

  IAuthAccess = interface
    ['{E4F2AAC7-A81B-40E5-AF79-F60505B3C0A9}']
    procedure Login(const ALogin: TBackendEntityValue);
    procedure Logout;
    procedure SetAuthentication(const Value: TBackendAuthentication);
    procedure SetDefaultAuthentication(
      const Value: TBackendDefaultAuthentication);
    function GetProvider: IBackendProvider;
    property Provider: IBackendProvider read GetProvider;
  end;

  IBackendAuthReg = interface
    ['{6EB1DC55-C0C7-434D-8CE7-CD6F215A1B6F}']
    procedure RegisterForAuth(const AAuthAccess: IAuthAccess);
    procedure UnregisterForAuth(const AAuthAccess: IAuthAccess);
  end;

  // Base class for provider components (no livebindings support)
  TBackendServiceComponent = class(TComponent, IBackendServiceComponent)
  private
    FProvider: IBackendProvider;
    function GetProvider: IBackendProvider; // IBackendServiceComponent
    function IBackendServiceComponent.GetServiceIID = GetBackendServiceIID;
  protected
    procedure ProviderChanged; virtual;
    function CreateService(const AProvider: IBackendProvider): IBackendService;
    procedure SetProvider(const Value: IBackendProvider);
    function GetBackendServiceIID: TGUID; virtual; abstract;  // IBackendServiceComponent
    procedure UpdateProvider(const AProvider: IBackendProvider); virtual; abstract;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure ClearProvider; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    property ServiceIID: TGUID read GetBackendServiceIID;
    property Provider: IBackendProvider read GetProvider write SetProvider;
  end;

  TBackendServiceComponent<TI: IBackendService; T: Class> = class(TBackendServiceComponent)
  public type
    TExecuteProc = TProc<T>;
    TExecuteEvent = procedure(Sender: TObject; AAPI: T) of object;
    TAPIThread = TBackendAPIThread<T>;
  private
    FBackendService: TI;
    FBackendServiceAPI: T;
    FAPIThread: TAPIThread;
    function CreateService(const AProvider: IBackendProvider): TI;
    procedure SetAPIThread(
      const AValue: TAPIThread);
  protected
    function GetBackendServiceAPI: T;
    function GetBackendService: TI;
    procedure ClearProvider; override;
    function GetBackendServiceIID: TGUID; override;
    procedure UpdateProvider(const AValue: IBackendProvider); override;
    function InternalCreateBackendServiceAPI: T; virtual; abstract;
    function InternalCreateIndependentBackendServiceAPI: T; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property APIThread: TAPIThread read FAPIThread write SetAPIThread;

  end;

  TBackendServiceComponentAuth<TI: IBackendService; T: Class> = class(TBackendServiceComponent<TI, T>)
  private
    FAuth: IBackendAuthReg;
    FAuthAccess: IAuthAccess;
    procedure SetAuth(const Value: IBackendAuthReg);
  protected
    function CreateAuthAccess: IAuthAccess; virtual;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
  public
    destructor Destroy; override;
    property Auth: IBackendAuthReg read FAuth write SetAuth;
  end;

implementation

uses System.TypInfo, REST.Utils, REST.Backend.Consts, REST.Backend.Exception,
  REST.Backend.ServiceTypes;

{ TBackendProviders }

constructor TBackendProviders.Create;
begin
  FProviders := TObjectList<TProvider>.Create;
end;

destructor TBackendProviders.Destroy;
begin
  FProviders.Free;
  inherited;
end;

function TBackendProviders.FindProvider(const AProviderID: string): TProvider;
var
  LProvider: TProvider;
begin
  Result := nil;
  for LProvider in FProviders do
    if SameText(LProvider.ProviderID, AProviderID) then
    begin
      Result := LProvider;
      break;
    end;
end;

function TBackendProviders.FindService(const AProviderID: string;
  const IID: TGUID): TService;
var
  LProvider: TProvider;
begin
  Result := nil;
  LProvider := FindProvider(AProviderID);
  if LProvider <> nil then
    Result := LProvider.FindService(IID);
end;

{ TBackendProviders.TService }

function TBackendProviders.GetCount: Integer;
begin
  Result := FProviders.Count;
end;

class function TBackendProviders.GetInstance: TBackendProviders;
begin
  if FInstance = nil then
    FInstance := TBackendProviders.Create;
  Result := FInstance;
end;

function TBackendProviders.GetProvider(I: Integer): TProvider;
begin
  Result := FProviders[I];
end;

procedure TBackendProviders.Register(const AProviderID,
  ADisplayName: string);
var
  LProvider: TProvider;
begin
  if FindProvider(AProviderID) <> nil then
    raise EBackendProviderError.CreateFmt(sDuplicateProviderID, [AProviderID]);
  LProvider := TProvider.Create;
  LProvider.FProviderID := AProviderID;
  LProvider.FDisplayName := ADisplayName;
  FProviders.Add(LProvider);
end;


procedure TBackendProviders.RegisterService(const AProviderID: string; const AIID: TGuid; const AFactory: TFactoryMethod; const AUnitNames: TArray<string>);
var
  LProvider: TProvider;
  LService: TService;
begin
  LProvider := FindProvider(AProviderID);
  if LProvider = nil then
    raise EBackendProviderError.CreateFmt(sProviderNotFound, [AProviderID]);
  LService := LProvider.FindService(AIID);
  if LService <> nil then
    raise EBackendProviderError.CreateFmt(sDuplicateService, [AProviderID]);
  LService := TService.Create;
  LService.FIID := AIID;
  LService.FUnitNames := AUnitNames;
  LService.FFactoryMethod := AFactory;
  LProvider.FServices.Add(LService);
end;

procedure TBackendProviders.Unregister(const AProviderID: string);
var
  LProvider: TProvider;
begin
  LProvider := FindProvider(AProviderID);
  if LProvider = nil then
    raise EBackendProviderError.CreateFmt(sUnregisterProviderNotFound, [AProviderID]);
  FProviders.Remove(LProvider);
end;

procedure TBackendProviders.UnregisterService(const AProviderID: string;
  const IID: TGuid);
var
  LProvider: TProvider;
  LService: TService;
begin
  LProvider := FindProvider(AProviderID);
  if LProvider = nil then
    raise EBackendProviderError.CreateFmt(sProviderNotFound, [AProviderID]);
  LService := LProvider.FindService(IID);
  if LService <> nil then
    LProvider.FServices.Remove(LService)
  else
    raise EBackendProviderError.CreateFmt(sUnregisterServiceNotFound, [AProviderID]);
end;

{ TBackendProviders.TProvider }

constructor TBackendProviders.TProvider.Create;
begin
  FServices := TObjectList<TService>.Create;
end;

destructor TBackendProviders.TProvider.Destroy;
begin
  FServices.Free;
  inherited;
end;

function TBackendProviders.TProvider.FindService(const IID: TGUID): TService;
var
  LService: TService;
begin
  Result := nil;
  for LService in  FServices do
    if IID = LService.IID then
    begin
      Result := LService;
      break;
    end
end;

function TBackendProviders.TProvider.GetCount: Integer;
begin
  Result := FServices.Count;
end;

function TBackendProviders.TProvider.GetService(I: Integer): TService;
begin
  Result := FServices[I];
end;

{ TBackendServiceComponent }

procedure TBackendServiceComponent.SetProvider(const Value: IBackendProvider);
begin
  if FProvider <> Value then
  begin
    if FProvider <> nil then
    begin
      if FProvider is TComponent then
        TComponent(FProvider).RemoveFreeNotification(Self);
    end;
    UpdateProvider(Value);
    FProvider := Value;
    if FProvider <> nil then
    begin
      if FProvider is TComponent then
        TComponent(FProvider).FreeNotification(Self);
    end
    else
    begin
    end;
    ProviderChanged;
  end;
end;

procedure TBackendServiceComponent.ProviderChanged;
begin
end;

procedure TBackendServiceComponent.ClearProvider;
begin
  FProvider := nil;
end;

constructor TBackendServiceComponent.Create(AOwner: TComponent);
var
  LProvider: IBackendProvider;
begin
  inherited;
  // Find a default provider
  if not Supports(AOwner, IBackendProvider, LProvider) then
    if csDesigning in ComponentState then
      LProvider := TRESTFindDefaultComponent.FindDefaultIntfT<IBackendProvider>(Self);
  if LProvider <> nil then
    if TBackendProviders.Instance.FindService(LProvider.ProviderID, ServiceIID) <> nil then
      // Valid provider
      Provider := LProvider;
end;

function TBackendServiceComponent.CreateService(
  const AProvider: IBackendProvider): IBackendService;
var
  LService: TBackendProviders.TService;
begin
  LService := TBackendProviders.Instance.FindService(AProvider.ProviderID, ServiceIID);
  if LService <> nil then
  begin
    Result := LService.FactoryProc(AProvider, ServiceIID) as IBackendService;
  end
  else
    raise EBackendServiceError.CreateFmt(sServiceNotSupportedByProvider, [AProvider.ProviderID]);

end;

function TBackendServiceComponent.GetProvider: IBackendProvider;
begin
  Result := FProvider;
end;

procedure TBackendServiceComponent.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  /// clean up component-references
  if (Operation = opRemove) then
  begin
    if (FProvider is TComponent) and (TComponent(FProvider) = AComponent) then
      ClearProvider;
  end;
end;

{ TBackendServiceComponent<TService: IBackendService; TApi: Class> }

destructor TBackendServiceComponent<TI, T>.Destroy;
begin
  FAPIThread.Free;
  ClearProvider;
  inherited;
end;

constructor TBackendServiceComponent<TI, T>.Create(AOwner: TComponent);
begin
  inherited;
  FAPIThread := TAPIThread.Create;
  FAPIThread.OnCreateAPI :=
    function: T
    begin
      Result := InternalCreateIndependentBackendServiceAPI;
    end;
end;

function TBackendServiceComponent<TI, T>.CreateService(
  const AProvider: IBackendProvider): TI;
begin
  Result := TI(inherited CreateService(AProvider));
  Assert(Supports(Result, ServiceIID));
end;

function TBackendServiceComponent<TI, T>.GetBackendServiceAPI: T;
begin
  if FBackendServiceAPI = nil then
  begin
    if FBackendService <> nil then
      FBackendServiceAPI := InternalCreateBackendServiceAPI // TBackendQueryApi.Create(FService.CreateQueryApi)
    else
      raise EBackendServiceError.CreateFmt(sNoBackendService, [Self.ClassName]);
  end;
  Result := FBackendServiceAPI;
end;

function TBackendServiceComponent<TI, T>.GetBackendService: TI;
begin
  Result := FBackendService;
end;

function TBackendServiceComponent<TI, T>.GetBackendServiceIID: TGUID;
begin
  Result := GetTypeData(TypeInfo(TI)).Guid;
end;

function TBackendServiceComponent<TI, T>.InternalCreateIndependentBackendServiceAPI: T;
begin
  raise ENotImplemented.Create('InternalCreateIndependentBackendServiceAPI'); // do not localize
end;

procedure TBackendServiceComponent<TI, T>.SetAPIThread(const AValue: TAPIThread);
begin
  FAPIThread.Assign(AValue);
end;

procedure TBackendServiceComponent<TI, T>.ClearProvider;
begin
  inherited;
  FBackendService := nil;
  FreeAndNil(FBackendServiceAPI);
end;

procedure TBackendServiceComponent<TI, T>.UpdateProvider(const AValue: IBackendProvider);
begin
  ClearProvider;
  if AValue <> nil then
    FBackendService := CreateService(AValue);  // May raise an exception
end;

{ TBackendThread }

constructor TBackendAPIThread<T>.TInternalThread.Create(const API: T; const AProc: TProc);
begin
  inherited Create(True);
  FAPI := API;
  FProc := AProc;
end;

destructor TBackendAPIThread<T>.TInternalThread.Destroy;
begin
  FAPI.Free;
  inherited;
end;

procedure TBackendAPIThread<T>.TInternalThread.Execute;
begin
  FProc();
end;

{ TBackendThreadProperties<T> }

constructor TBackendAPIThread<T>.Create;
begin
  inherited Create;
  FEvent := TEvent.Create;
end;

function TBackendAPIThread<T>.CreateAPI: T;
begin
  if Assigned(FOnCreateAPI) then
    Result := FOnCreateAPI
  else
  begin
    Assert(False); // unexpected
    Result := nil;
  end;
end;

function TBackendAPIThread<T>.CreateThread(const ASender: TObject;
  const AEvent: TExecuteEvent; const AExecuteProc: TExecuteProc): TThread;
var
  LBackendServiceAPI: T;
begin
  FEvent.ResetEvent;
  LBackendServiceAPI := CreateAPI;
  Result := TInternalThread.Create(LBackendServiceAPI,
    procedure
    begin
      FEvent.SetEvent; // Thread started
      if Assigned(AExecuteProc) then
        AExecuteProc(LBackendServiceAPI)
      else
        AEvent(ASender, LBackendServiceAPI)
    end);
end;

destructor TBackendAPIThread<T>.Destroy;
begin
  FEvent.Free;
  FThread.Free; // Blocking
  inherited;
end;

function TBackendAPIThread<T>.GetFatalException: TObject;
begin
  if FThread <> nil then
    Result := FThread.FatalException
  else
    Result := nil;
end;

function TBackendAPIThread<T>.GetFinished: Boolean;
begin
  Result := (FThread <> nil) and FThread.Finished;
end;

function TBackendAPIThread<T>.GetStarted: Boolean;
begin
 Result := (FThread <> nil) and FThread.Started;
end;

procedure TBackendAPIThread<T>.Start(const ASender: TObject;
  const AEvent: TExecuteEvent);
begin
  Start(ASender, AEvent, nil);
end;

procedure TBackendAPIThread<T>.Start(
  const AExecuteProc: TExecuteProc);
begin
  Start(TObject(nil), TExecuteEvent(nil), AExecuteProc);
end;

procedure TBackendAPIThread<T>.Start(const ASender: TObject;
  const AEvent: TExecuteEvent; const AExecuteProc: TExecuteProc);
begin
  if Assigned(FThread) and (not FThread.Finished) then
    raise  EBackendServiceError.Create(sBackendThreadRunning);
  FThread.Free;
  FThread := CreateThread(ASender, AEvent, AExecuteProc);
  DoThreadStarting;
  FThread.OnTerminate := OnThreadTerminate;
  FThread.Start;
end;

procedure TBackendAPIThread<T>.WaitFor;
begin
  if FThread <> nil then
  begin
    // Wait until thread is started
    FEvent.WaitFor;
    FThread.WaitFor;
  end;
end;

{ TBackendAPIThread }

procedure TBackendAPIThread.DoThreadStarting;
begin
  if Assigned(FOnStarting) then
    FOnStarting(Self);
end;

procedure TBackendAPIThread.DoThreadTerminated;
begin
  if Assigned(FOnTerminated) then
    FOnTerminated(Self);
end;

procedure TBackendAPIThread.OnThreadTerminate(Sender: TObject);
begin
  DoThreadTerminated;
end;

{ TBackendServiceComponentAuth<TI, T> }

function TBackendServiceComponentAuth<TI, T>.CreateAuthAccess: IAuthAccess;
begin
  Result := nil;
end;

destructor TBackendServiceComponentAuth<TI, T>.Destroy;
begin
  Auth := nil; // Unregister for auth
  inherited;
end;

procedure TBackendServiceComponentAuth<TI, T>.Notification(
  AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  /// clean up component-references
  if (Operation = opRemove) then
  begin
    if (FAuth is TComponent) and (TComponent(FAuth) = AComponent) then
      Auth := nil;
  end;
end;

procedure TBackendServiceComponentAuth<TI, T>.SetAuth(
  const Value: IBackendAuthReg);
begin
  if FAuth <> Value then
  begin
    if FAuth <> nil then
    begin
      if FAuth is TComponent then
        TComponent(FAuth).RemoveFreeNotification(Self);
      if FAuthAccess <> nil then
        try
          FAuth.UnregisterForAuth(FAuthAccess);
        finally
          FAuthAccess := nil;
        end;
    end;
    FAuth := Value;
    if FAuth <> nil then
    begin
      if FAuth is TComponent then
        TComponent(FAuth).FreeNotification(Self);
      FAuthAccess := CreateAuthAccess;
      if FAuthAccess <> nil then
        FAuth.RegisterForAuth(FAuthAccess);
    end;
  end;
end;

initialization
finalization
  TBackendProviders.FInstance.Free;
end.
