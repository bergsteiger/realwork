{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{*******************************************************}
{               MTS Remote Data Module                  }
{*******************************************************}

unit Datasnap.Win.MtsRdm;

{$H+,X+}

interface

uses Winapi.Windows, System.Classes, Datasnap.DataBkr, Winapi.Mtx, Datasnap.Midas;

type
  { TMtsDataModule }

  TMtsDataModule = class(TRemoteDataModule, IAppServer, IObjectControl)
  private
    FAutoComplete: Boolean;
    FOnActivate: TNotifyEvent;
    FOnDeActivate: TNotifyEvent;
    FObjectContext: IObjectContext;
    FCanBePooled: Boolean;
  protected
    { IObjectControl }
    procedure Activate; safecall;
    procedure Deactivate; stdcall;
    function CanBePooled: Bool; virtual; stdcall;
    { IAppServer }
    function AS_GetProviderNames: OleVariant; safecall;
    function AS_ApplyUpdates(const ProviderName: WideString; Delta: OleVariant;
      MaxErrors: Integer; out ErrorCount: Integer;
      var OwnerData: OleVariant): OleVariant; safecall;
    function AS_GetRecords(const ProviderName: WideString; Count: Integer;
      out RecsOut: Integer; Options: Integer; const CommandText: WideString;
      var Params, OwnerData: OleVariant): OleVariant; safecall;
    function AS_DataRequest(const ProviderName: WideString;
      Data: OleVariant): OleVariant; safecall;
    function AS_GetParams(const ProviderName: WideString; var OwnerData: OleVariant): OleVariant; safecall;
    function AS_RowRequest(const ProviderName: WideString; Row: OleVariant;
      RequestType: Integer; var OwnerData: OleVariant): OleVariant; safecall;
    procedure AS_Execute(const ProviderName: WideString;
      const CommandText: WideString; var Params, OwnerData: OleVariant); safecall;

    procedure CallComplete(Complete: Boolean); virtual;
    property ObjectContext: IObjectContext read FObjectContext;
  public
    constructor Create(AOwner: TComponent); override;
    procedure SetComplete;
    procedure SetAbort;
    procedure EnableCommit;
    procedure DisableCommit;
    function IsInTransaction: Boolean;
    function IsSecurityEnabled: Boolean;
    function IsCallerInRole(const Role: WideString): Boolean;
  published
    [Default(True)]
    property AutoComplete: Boolean read FAutoComplete write FAutoComplete default True;
    property OnActivate: TNotifyEvent read FOnActivate write FOnActivate;
    property OnDeactivate: TNotifyEvent read FOnDeactivate write FOnDeactivate;
    property Pooled: Boolean read FCanBePooled write FCanBePooled;
  end;

implementation

constructor TMtsDataModule.Create(AOwner: TComponent);
begin
  FAutoComplete := True;
  inherited Create(AOwner);
end;

procedure TMtsDataModule.Activate;
begin
  FObjectContext := GetObjectContext;
  if Assigned(FOnActivate) then FOnActivate(Self);
end;

procedure TMtsDataModule.Deactivate;
begin
  if Assigned(FOnDeactivate) then FOnDeactivate(Self);
  FObjectContext := nil;
end;

function TMtsDataModule.CanBePooled: Bool;
begin
  Result := FCanBePooled;
end;

procedure TMtsDataModule.SetComplete;
begin
  if Assigned(FObjectContext) then FObjectContext.SetComplete;
end;

procedure TMtsDataModule.SetAbort;
begin
  if Assigned(FObjectContext) then FObjectContext.SetAbort;
end;

procedure TMtsDataModule.EnableCommit;
begin
  if Assigned(FObjectContext) then FObjectContext.EnableCommit;
end;

procedure TMtsDataModule.DisableCommit;
begin
  if Assigned(FObjectContext) then FObjectContext.DisableCommit;
end;

function TMtsDataModule.IsInTransaction: Boolean;
begin
  if Assigned(FObjectContext) then Result := FObjectContext.IsInTransaction
  else Result := False;
end;

function TMtsDataModule.IsSecurityEnabled: Boolean;
begin
  if Assigned(FObjectContext) then Result := FObjectContext.IsSecurityEnabled
  else Result := False;
end;

function TMtsDataModule.IsCallerInRole(const Role: WideString): Boolean;
begin
  if Assigned(FObjectContext) then Result := FObjectContext.IsCallerInRole(Role)
  else Result := False;
end;

{ IAppServer support }

procedure TMtsDataModule.CallComplete(Complete: Boolean);
begin
  if AutoComplete then
    if Complete then
      SetComplete else
      SetAbort;
end;

function TMtsDataModule.AS_GetProviderNames: OleVariant;
begin
  try
    Result := inherited AS_GetProviderNames;
  finally
    CallComplete(True);
  end;
end;

function TMtsDataModule.AS_ApplyUpdates(const ProviderName: WideString; Delta: OleVariant;
  MaxErrors: Integer; out ErrorCount: Integer;
  var OwnerData: OleVariant): OleVariant;
begin
  try
    Result := inherited AS_ApplyUpdates(ProviderName, Delta, MaxErrors, ErrorCount, OwnerData);
    if (ErrorCount <= MaxErrors) or (MaxErrors = -1) then
      CallComplete(True)
    else
      CallComplete(False);
  except
    CallComplete(False);
    raise;
  end;
end;

function TMtsDataModule.AS_GetRecords(const ProviderName: WideString; Count: Integer;
  out RecsOut: Integer; Options: Integer; const CommandText: WideString;
  var Params, OwnerData: OleVariant): OleVariant;
begin
  try
    Result := inherited AS_GetRecords(ProviderName, Count, RecsOut, Options,
      CommandText, Params, OwnerData);
  finally
    CallComplete(True);
  end;
end;

function TMtsDataModule.AS_DataRequest(const ProviderName: WideString;
  Data: OleVariant): OleVariant;
begin
  { No SetComplete call because I don't know what the developer is doing here.
    Developer needs to call SetComplete in the OnDataRequest event. }
  Result := inherited AS_DataRequest(ProviderName, Data);
end;

function TMtsDataModule.AS_GetParams(const ProviderName: WideString; var OwnerData: OleVariant): OleVariant;
begin
  try
    Result := inherited AS_GetParams(ProviderName, OwnerData);
  finally
    CallComplete(True);
  end;
end;

function TMtsDataModule.AS_RowRequest(const ProviderName: WideString; Row: OleVariant;
  RequestType: Integer; var OwnerData: OleVariant): OleVariant;
begin
  try
    Result := inherited AS_RowRequest(ProviderName, Row, RequestType, OwnerData);
  finally
    CallComplete(True);
  end;
end;

procedure TMtsDataModule.AS_Execute(const ProviderName: WideString;
  const CommandText: WideString; var Params, OwnerData: OleVariant);
begin
  try
    inherited AS_Execute(ProviderName, CommandText, Params, OwnerData);
  finally
    CallComplete(True);
  end;
end;

end.
