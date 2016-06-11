{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit REST.Backend.EMSFireDAC;
{$SCOPEDENUMS ON}

interface

uses
  System.Classes, System.SysUtils, System.Generics.Collections, System.JSON,
  REST.Backend.EMSProvider, FireDAC.Comp.Client, REST.Backend.Endpoint,
  REST.Client, REST.Backend.Providers, REST.Backend.ServiceComponents,
  REST.Backend.ServiceTypes;

type

  /// <summary>
  /// <para>
  /// TEMSFireDACClient implements REST requests to the EMS server
  /// </para>
  /// </summary>
  TCustomEMSFireDACClient = class(TComponent)
  private
    FProvider: TEMSProvider;
    FSchemaAdapter: TFDSchemaAdapter;
    FGetEndpoint: TCustomBackendEndpoint;
    FGetResponse: TCustomRESTResponse;
    FApplyEndpoint: TCustomBackendEndpoint;
    FApplyResponse: TCustomRESTResponse;
    FResource: string;
    FAuth: IBackendAuthReg;
    procedure SetProvider(const Value: TEMSProvider);
    procedure SetSchemaAdapter(const Value: TFDSchemaAdapter);
    procedure CheckProvider;
    procedure CheckSchemaAdapter;
    procedure UpdateEndpoints;
    procedure CheckResource;
    function GetCanPostUpdates: Boolean;
    procedure SetAuth(const Value: IBackendAuthReg);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Resource: string read FResource write FResource;
    property Provider: TEMSProvider read FProvider write SetProvider;
    property SchemaAdapter: TFDSchemaAdapter read FSchemaAdapter write SetSchemaAdapter;
    procedure GetData;
    procedure PostUpdates;
    property CanPostUpdates: Boolean read GetCanPostUpdates;
    property Auth: IBackendAuthReg read FAuth write SetAuth;
    property GetEndpoint: TCustomBackendEndpoint read FGetEndpoint;
    property ApplyEndpoint: TCustomBackendEndpoint read FApplyEndpoint;
  end;

  TEMSFireDACClient = class(TCustomEMSFireDACClient)
  published
    property Resource;
    property Provider;
    property SchemaAdapter;
    property Auth;
  end;

  TEEMSFireDACClientError = class(Exception);

implementation

uses FireDAC.Stan.Intf, REST.Types, Data.DB, REST.Backend.EMSFireDACConsts,
  FireDAC.Stan.StorageJSON; // Support JSON format

{ TCustomEMSFireDACClient }

constructor TCustomEMSFireDACClient.Create(AOwner: TComponent);
begin
  inherited;
  FGetEndpoint := TCustomBackendEndpoint.Create(nil);
  FGetEndpoint.Method := TRESTRequestMethod.rmGET;
  FGetResponse := TCustomRESTResponse.Create(nil);
  FGetEndPoint.Response := FGetResponse;
  FApplyEndpoint := TCustomBackendEndpoint.Create(nil);
  FApplyEndpoint.Method := TRESTRequestMethod.rmPOST;
  FApplyResponse := TCustomRESTResponse.Create(nil);
  FApplyEndpoint.Response := FApplyResponse;
end;

destructor TCustomEMSFireDACClient.Destroy;
begin
  FGetEndpoint.Free;
  FApplyEndPoint.Free;
  FGetResponse.Free;
  FApplyResponse.Free;
  inherited;
end;

procedure TCustomEMSFireDACClient.CheckResource;
begin
  if FResource = '' then
    raise TEEMSFireDACClientError.Create(sResourceMustNotBeBlank);
end;

procedure TCustomEMSFireDACClient.UpdateEndpoints;
begin
  CheckResource;
  FGetEndpoint.Resource := FResource;
  FApplyEndpoint.Resource := FResource;
  FGetEndpoint.Provider := FProvider;
  FApplyEndpoint.Provider := FProvider;
  FGetEndpoint.Auth := Auth;
  FApplyEndpoint.Auth := Auth;
end;

procedure TCustomEMSFireDACClient.CheckSchemaAdapter;
begin
  if FSchemaAdapter = nil then
    raise TEEMSFireDACClientError.Create(sSchemaAdapterIsRequired );
  if FSchemaAdapter.Count = 0 then
    raise TEEMSFireDACClientError.CreateFmt(sSchemaAdapterHasNoData, [FSchemaAdapter.Name]);
end;

procedure TCustomEMSFireDACClient.CheckProvider;
begin
  if FProvider = nil then
    raise TEEMSFireDACClientError.CreateFmt(sProviderIsRequired, [Self.Name]);
end;

function TCustomEMSFireDACClient.GetCanPostUpdates: Boolean;
var
  I: Integer;
  LDataSet: TFDAdaptedDataSet;
begin
  Result := (FSchemaAdapter <> nil) and (FProvider <> nil);
  if Result then
  begin
    Result := False;
    for I := 0 to FSchemaAdapter.Count - 1 do
    begin
      LDataSet := FSchemaAdapter.DataSets[I];
      if (LDataSet.ChangeCount > 0) or (LDataSet.State in dsEditModes) then
      begin
        Result := True;
        break;
      end;
    end;
  end;
end;

procedure TCustomEMSFireDACClient.GetData;
var
  LStream: TStream;
begin
  CheckSchemaAdapter;
  CheckProvider;
  UpdateEndpoints;
  FGetEndpoint.Execute;
  if not SameText(FGetEndpoint.Response.ContentType, 'application/json') then  // Do not localize
    raise EEMSProviderError.CreateFmt(sUnexpectedContentType , [FGetEndpoint.Response.ContentType]);
  if Length(FGetResponse.RawBytes) = 0 then
    raise EEMSProviderError.Create(sResponseHasNoContent);
  LStream := TMemoryStream.Create;
  try
    LStream.Write(FGetResponse.RawBytes, Length(FGetResponse.RawBytes));
    if not SameText(FGetEndpoint.Response.ContentType, 'application/json') then // Do not localize
      raise EEMSProviderError.CreateFmt(sUnexpectedContentType , [FGetEndpoint.Response.ContentType]);
    LStream.Position := 0;
    FSchemaAdapter.LoadFromStream(LStream, TFDStorageFormat.sfJSON);
  finally
    LStream.Free;
  end;
end;

procedure TCustomEMSFireDACClient.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;

  if (Operation = opRemove) then
  begin
    if AComponent = FSchemaAdapter then
      FSchemaAdapter := nil
    else if AComponent = FProvider then
      FProvider := nil
    else if (FAuth is TComponent) and (TComponent(FAuth) = AComponent) then
      Auth := nil;
  end;
end;

procedure TCustomEMSFireDACClient.PostUpdates;
var
  LStream: TStream;
  I: Integer;
  LDataSet: TDataSet;
begin
  CheckSchemaAdapter;
  CheckProvider;
  UpdateEndpoints;

  for I := 0 to FSchemaAdapter.Count - 1 do
  begin
    LDataSet := FSchemaAdapter.DataSets[I];
    if LDataSet <> nil then
      if LDataSet.State in dsEditModes then
        LDataSet.Post;
  end;

  LStream := TMemoryStream.Create;
  try
    FSchemaAdapter.ResourceOptions.StoreItems := [siDelta, siMeta];
    FSchemaAdapter.SaveToStream(LStream, TFDStorageFormat.sfJSON);

    LStream.Position := 0;
    FApplyEndpoint.Params.Clear;
    FApplyEndpoint.AddBody(LStream, TRESTContentType.ctAPPLICATION_JSON);
    FApplyEndpoint.Execute;
                                 
    // FSchemaAdapter.Reconcile;
    if Length(FApplyResponse.RawBytes) <> 0 then
    begin
      if not SameText(FApplyEndpoint.Response.ContentType, 'application/json') then  // Do not localize
        raise EEMSProviderError.CreateFmt(sUnexpectedContentType , [FApplyEndpoint.Response.ContentType])
      else
         raise EEMSProviderError.CreateFmt(sErrorsOnApplyUpdates , [FApplyEndpoint.Response.Content]);
    end
    else
      FSchemaAdapter.CommitUpdates;
  finally
    LStream.Free;
  end;

end;

procedure TCustomEMSFireDACClient.SetAuth(
  const Value: IBackendAuthReg);
begin
  if FAuth <> Value then
  begin
    if FAuth <> nil then
    begin
      if FAuth is TComponent then
        TComponent(FAuth).RemoveFreeNotification(Self);
    end;
    FAuth := Value;
    if FAuth <> nil then
    begin
      if FAuth is TComponent then
        TComponent(FAuth).FreeNotification(Self);
    end;
  end;
end;

procedure TCustomEMSFireDACClient.SetProvider(const Value: TEMSProvider);
begin
  if Value <> FProvider then
  begin
    if FProvider <> nil then
      FProvider.RemoveFreeNotification(Self);

    FProvider := Value;

    if FProvider <> nil then
      FProvider.FreeNotification(self);
  end;
end;

procedure TCustomEMSFireDACClient.SetSchemaAdapter(
  const Value: TFDSchemaAdapter);
begin
  if Value <> FSchemaAdapter then
  begin
    if FSchemaAdapter <> nil then
      FSchemaAdapter.RemoveFreeNotification(Self);

    FSchemaAdapter := Value;

    if FSchemaAdapter <> nil then
      FSchemaAdapter.FreeNotification(self);
  end;
end;

end.
