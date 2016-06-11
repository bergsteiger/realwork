{*******************************************************}
{                                                       }
{             Delphi REST Client Framework              }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit REST.Backend.BindSource;

interface

uses
  System.Classes, System.SysUtils, System.JSON,
  System.Generics.Collections,
  REST.JSON,
  REST.Backend.Providers,
  Data.Bind.ObjectScope, REST.BindSource, Data.Bind.Components;

type

  // Base class for provider components (with livebindings support)
  TBackendBindSourceComponent = class(TBaseObjectBindSourceDelegate, IBackendServiceComponent)
   private
    FProvider: IBackendProvider;
    procedure SetProvider(const Value: IBackendProvider);
    function GetProvider: IBackendProvider; // IBackendServiceComponent
  protected
    procedure ProviderChanged; virtual;
    function GetServiceIID: TGUID; virtual; abstract; // IBackendServiceComponent
    function CreateService(const AProvider: IBackendProvider): IBackendService;
    procedure ClearProvider; virtual;
    procedure UpdateProvider(const AProvider: IBackendProvider); virtual; abstract;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    property ServiceIID: TGUID read GetServiceIID;
    property Provider: IBackendProvider read FProvider write SetProvider;
  end;

  TBackendBindSourceComponent<TI: IBackendService; T: Class> = class(TBackendBindSourceComponent)
  public type
    TExecuteProc = TProc<T>;
    TExecuteEvent = procedure(Sender: TObject; AApi: T) of object;
    TAPIThread = TBackendAPIThread<T>;
  private
    FBackendService: TI;
    FBackendServiceAPI: T;
    FAPIThread: TAPIThread;
    function CreateBackendService(const AProvider: IBackendProvider): TI;
    procedure SetAPIThread(const Value: TAPIThread);
  protected
    function GetBackendServiceAPI: T;
    procedure ClearProvider; override;
    function GetBackendService: TI;
    function GetServiceIID: TGUID; override;
    procedure UpdateProvider(const AValue: IBackendProvider); override;
    function InternalCreateBackendServiceAPI: T; virtual; abstract;
    function InternalCreateIndependentBackendServiceAPI: T; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property APIThread: TAPIThread read FAPIThread write SetAPIThread;
  end;

  TBackendBindSourceComponentAuth<TI: IBackendService; T: Class> = class(TBackendBindSourceComponent<TI, T>)
  private
    FAuth: IBackendAuthReg;
    FAuthAccess: IAuthAccess;
    procedure SetAuth(const Value: IBackendAuthReg);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function CreateAuthAccess: IAuthAccess; virtual;
  public
    destructor Destroy; override;
    property Auth: IBackendAuthReg read FAuth write SetAuth;
  end;

implementation

uses
  System.TypInfo, REST.Utils, REST.Backend.Consts, REST.Backend.Exception;

{ TBackendBindSourceComponent<TService, TApi> }

destructor TBackendBindSourceComponent<TI, T>.Destroy;
begin
  FAPIThread.Free;
  ClearProvider;
  inherited;
end;

constructor TBackendBindSourceComponent<TI, T>.Create(AOwner: TComponent);
begin
  inherited;
  FAPIThread := TAPIThread.Create;
  FAPIThread.OnCreateAPI :=
    function: T
    begin
      Result := InternalCreateIndependentBackendServiceAPI;
    end;
end;

function TBackendBindSourceComponent<TI, T>.CreateBackendService(
  const AProvider: IBackendProvider): TI;
begin
  Result := TI(inherited CreateService(AProvider));
  Assert(Supports(Result, ServiceIID));
end;

function TBackendBindSourceComponent<TI, T>.GetBackendServiceAPI: T;
begin
  if FBackendServiceAPI = nil then
  begin
    if FBackendService <> nil then
      FBackendServiceAPI := InternalCreateBackendServiceAPI // TBackendQueryApi.Create(FService.CreateQueryApi)
    else
      raise Exception.CreateFmt(sNoBackendService, [Self.ClassName]);
  end;
  Result := FBackendServiceAPI;
end;

function TBackendBindSourceComponent<TI, T>.GetBackendService: TI;
begin
  Result := FBackendService;
end;

function TBackendBindSourceComponent<TI, T>.GetServiceIID: TGUID;
begin
  Result := GetTypeData(TypeInfo(TI)).Guid;
end;

function TBackendBindSourceComponent<TI, T>.InternalCreateIndependentBackendServiceAPI: T;
begin
  raise ENotSupportedException.Create('InternalCreateIndependentBackendServiceAPI'); // Do not localize
end;

procedure TBackendBindSourceComponent<TI, T>.SetAPIThread(
  const Value: TAPIThread);
begin
  FAPIThread.Assign(Value);
end;

procedure TBackendBindSourceComponent<TI, T>.ClearProvider;
begin
  inherited;
  FBackendService := nil;
  FreeAndNil(FBackendServiceAPI);
end;

procedure TBackendBindSourceComponent<TI, T>.UpdateProvider(const AValue: IBackendProvider);
begin
  ClearProvider;
  if AValue <> nil then
    FBackendService := CreateBackendService(AValue);  // May raise an exception
end;

procedure TBackendBindSourceComponent.SetProvider(
  const Value: IBackendProvider);
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
    end;
    ProviderChanged;
  end;
end;

procedure TBackendBindSourceComponent.ClearProvider;
begin
  FProvider := nil;
end;

constructor TBackendBindSourceComponent.Create(AOwner: TComponent);
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

function TBackendBindSourceComponent.CreateService(
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

function TBackendBindSourceComponent.GetProvider: IBackendProvider;
begin
  Result := FProvider;
end;
procedure TBackendBindSourceComponent.Notification(AComponent: TComponent;
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


procedure TBackendBindSourceComponent.ProviderChanged;
begin
//
end;

{ TBackendBindSourceComponentAuth<TI, T> }

function TBackendBindSourceComponentAuth<TI, T>.CreateAuthAccess: IAuthAccess;
begin
  Result := nil;
end;

destructor TBackendBindSourceComponentAuth<TI, T>.Destroy;
begin
  Auth := nil; // Unregister for auth
  inherited;
end;

procedure TBackendBindSourceComponentAuth<TI, T>.Notification(
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

procedure TBackendBindSourceComponentAuth<TI, T>.SetAuth(
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

end.
