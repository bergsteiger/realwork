{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit EMSHosting.Helpers;

{$SCOPEDENUMS ON}

interface

uses System.SysUtils, System.JSON, EMS.ResourceAPI, EMS.Services, EMS.ResourceTypes;

type

  TEndpointHelpers = class
  private type
    TCreatorIDs = record
    const
      Master = '00000000-0000-0000-0000-000000000001';
      Null =   '00000000-0000-0000-0000-000000000000';
    end;
  public
    class function IdentityFromContext(const AContext: TEndpointContext): string;
    class function CreatorRequired(const AContext: TEndpointContext): Boolean;
    class procedure SetCreatorRequired(const AContext: TEndpointContext);
    class procedure CheckCreator(const AContext: TEndpointContext; const AGetCreator: TFunc<string>); overload;
    class procedure CheckCreator(const AContext: TEndpointContext; const ACreator: string); overload;
  end;

  TLogHelpers = class
  protected
    type
      TLogCallback = reference to procedure(const AJSON: TJSONObject);
  private
    class function GetLoggingEnabled: Boolean; static;
    class function GetService: IEMSLoggingService; static;
  protected
    class procedure DoLog(const ACategory: string; const ACallback: TLogCallback);
  public
    class procedure LogRequest(const AResourceName, AEndpointName, AMethod, AUserID: string); static;
    class procedure LogRedirect(const AResourceName, AEndpointName, ADestinationResourceName, ADestinationEndpointName: string); static;
    class procedure LogHTTPError(ACode: Integer; const AReason: string; const AError, ADescription: string);
    class procedure LogException(const AException: Exception);
    class procedure LogPackageException(const AFileName: string; const AException: Exception);
    class procedure LogPackageLoading(const AFileName: string); static;
    class procedure LogPackageLoaded(const AFileName: string); static;
    class procedure LogRegisterResource(const AResource: TEMSResource);
    class procedure LogRegisterACL(const AName, AValue: string); static;
    class procedure LogRegisterRedirect(const AName, AValue: string); static;
    class procedure LogConfigurationLoaded(const AFileName: string); static;
    class property LoggingEnabled: Boolean read GetLoggingEnabled;
  end;

  TErrorHelpers = class
  public
    class function CreateJSONError(const AReasonString, AError, ADescription: string): TJSONObject; static;
  end;

  TJSONHelpers = class
  public
    class function JsonEncode(AJsonValue: TJsonValue): string; static;
  end;

  TLogCategoryNames = record
  public const
    Request = 'Request';
    Redirect = 'Redirect';
    Error = 'Error';
    Loading = 'Loading';
    Loaded = 'Loaded';
    Push = 'Push';
    RegisterUnit = 'RegUnit';
    RegisterResource = 'RegResource';
    RegisterACL = 'RegACL';
    RegisterRedirect = 'RegRedirect';
    ConfigLoaded = 'ConfigLoaded';
    DBConnection = 'DBConnection';
    Licensing = 'Licensing';
    TraceMessage = 'Trace';
  end;

  TLogErrorTypes = record
  public const
    HTTP = 'HTTP';
    Other = 'Other';
    Package = 'Package';
  end;

  TLogObjectNames = record
  public const
    Resource = 'Resource';
    Endpoint = 'Endpoint';
    DestinationResource = 'DestinationResource';
    DestinationEndpoint = 'DestinationEndpoint';
    Endpoints = 'Endpoints';
    Method = 'Method';
    UserID = 'User';
    Time = 'Time';
    Thread = 'Thread';
    Redirect = 'Redirect';
    Push = 'Push';

    Code = 'Code';
    Reason = 'Reason';
    Error = 'Error';
    Description = 'Description';

    FileName = 'Filename';
    UnitName = 'Unitname';
    ExceptionClass = 'Exception';
    ExceptionMessage = 'Message';
    TraceMessage = 'Message';
    ErrorType = 'Type';

    DBInstanceName = 'InstanceName';
    DBFileName = 'Filename';

    Licensed = 'Licensed';
    LicensedMaxUsers = 'LicensedMaxUsers';
    DefaultMaxUsers = 'DefaultMaxUsers';

  end;


implementation

uses EMSHosting.Endpoints, EMSHosting.Consts;

const
  sBlank = '(blank)';
{ TEndpointHelpers }


class procedure TEndpointHelpers.CheckCreator(
  const AContext: TEndpointContext; const ACreator: string);
begin
  CheckCreator(AContext,
    function: string begin Result := ACreator end);
end;

class function TEndpointHelpers.CreatorRequired(
  const AContext: TEndpointContext): Boolean;
begin
  if AContext is TEndpointContextImpl then
    Result := TEndpointContextImpl(AContext).CreatorRequired
  else
    Result := False;
end;

class procedure TEndpointHelpers.SetCreatorRequired(
  const AContext: TEndpointContext);
begin
  if AContext is TEndpointContextImpl then
    TEndpointContextImpl(AContext).SetCreatorRequired;
end;

class procedure TEndpointHelpers.CheckCreator(
  const AContext: TEndpointContext; const AGetCreator: TFunc<string>);
var
  LContextIdentity: string;
  LCreator: string;
begin
  if CreatorRequired(AContext) then
  begin
    LCreator := AGetCreator;
    if LCreator = TCreatorIDs.Null then   // No creator
      EEMSHTTPError.RaiseUnauthorized
    else
    begin
      LContextIdentity := IdentityFromContext(AContext);
      Assert(LContextIdentity <> TCreatorIDs.Master); // Shouldn't be here if master auth
      if LContextIdentity <> AGetCreator then
        EEMSHTTPError.RaiseUnauthorized;
    end
  end;
end;

class function TEndpointHelpers.IdentityFromContext(
  const AContext: TEndpointContext): string;
begin
  if AContext.User <> nil then
    Result := AContext.User.UserID
  else if TEndpointContext.TAuthenticate.MasterSecret in AContext.Authenticated then
    Result := TCreatorIDs.Master
  else
    Result := TCreatorIDs.Null
end;

{ TLogHelpers }

class procedure TLogHelpers.DoLog(const ACategory: string; const ACallback: TLogCallback);
var
  LService: IEMSLoggingService;
  LJSON: TJSONObject;
begin
  if LoggingEnabled then
  begin
    LService := GetService;
    LJSON := TJSONObject.Create;
    try
      ACallback(LJSON);
      Assert(ACategory <> '');
      Assert(LJSON.Count > 0);
      LService.Log(ACategory, LJSON);
    finally
      LJSON.Free;
    end;
  end;
end;

class function TLogHelpers.GetLoggingEnabled: Boolean;
var
  LService: IEMSLoggingService;
begin
  LService := GetService;
  if LService <> nil then
    Result := LService.LoggingEnabled
  else
    Result := False;
end;

class function TLogHelpers.GetService: IEMSLoggingService;
begin
  if not EMS.Services.EMSServices.TryGetService(IEMSLoggingService, Result) then
    Result := nil;
end;

class procedure TLogHelpers.LogHTTPError(ACode: Integer; const AReason, AError,
  ADescription: string);
begin
  DoLog(TLogCategoryNames.Error,
    procedure(const LJSON: TJSONObject)
    begin
      LJSON.AddPair(TLogObjectNames.ErrorType, TLogErrorTypes.HTTP);
      LJSON.AddPair(TLogObjectNames.Code, IntToStr(ACode));
      LJSON.AddPair(TLogObjectNames.Reason, AReason);
      LJSON.AddPair(TLogObjectNames.Error, AError);
      LJSON.AddPair(TLogObjectNames.Description, ADescription);
    end);
end;

class procedure TLogHelpers.LogPackageException(const AFileName: string;
  const AException: Exception);
begin
  DoLog(TLogCategoryNames.Error,
    procedure(const LJSON: TJSONObject)
    begin
      LJSON.AddPair(TLogObjectNames.ErrorType, TLogErrorTypes.Package);
      LJSON.AddPair(TLogObjectNames.FileName, AFileName);
      LJSON.AddPair(TLogObjectNames.ExceptionClass, AException.ClassName);
      LJSON.AddPair(TLogObjectNames.ExceptionMessage, AException.Message);
    end);
end;

class procedure TLogHelpers.LogPackageLoading(const AFileName: string);
begin
  DoLog(TLogCategoryNames.Loading,
    procedure(const LJSON: TJSONObject)
    begin
      LJSON.AddPair(TLogObjectNames.FileName, AFileName);
    end);
end;

class procedure TLogHelpers.LogPackageLoaded(const AFileName: string);
begin
  DoLog(TLogCategoryNames.Loaded,
    procedure(const LJSON: TJSONObject)
    begin
      LJSON.AddPair(TLogObjectNames.FileName, AFileName);
    end);
end;


class procedure TLogHelpers.LogRegisterACL(const AName, AValue: string);
begin
  DoLog(TLogCategoryNames.RegisterACL,
    procedure(const LJSON: TJSONObject)
    var
      LJSONACL: TJSONValue;
    begin
      LJSON.AddPair(TLogObjectNames.Resource, AName);
      LJSONACL := TJSONObject.ParseJSONValue(AValue);
      if (LJSONACL = nil) or not (LJSONACL is TJSONObject) then
      begin
        LJSONACL.Free;
        LJSONACL := TJSONObject.Create;
        TJSONObject(LJSONACL).AddPair('InvalidJSON', AValue);
      end;
      LJSON.AddPair('ACL', LJSONACL);
    end);
end;

class procedure TLogHelpers.LogRegisterRedirect(const AName, AValue: string);
begin
  DoLog(TLogCategoryNames.RegisterRedirect,
    procedure(const LJSON: TJSONObject)
    var
      LJSONRedirect: TJSONValue;
    begin
      LJSON.AddPair(TLogObjectNames.Resource, AName);
      LJSONRedirect := TJSONObject.ParseJSONValue(AValue);
      if (LJSONRedirect = nil) or not (LJSONRedirect is TJSONObject) then
      begin
        LJSONRedirect.Free;
        LJSONRedirect := TJSONObject.Create;
        TJSONObject(LJSONRedirect).AddPair('InvalidJSON', AValue);
      end;
      LJSON.AddPair('Redirect', LJSONRedirect);
    end);
end;

class procedure TLogHelpers.LogRegisterResource(const AResource: TEMSResource);
begin
  DoLog(TLogCategoryNames.RegisterResource,
    procedure(const LJSON: TJSONObject)
    var
      LEndpoints: TJSONArray;
      S: string;
    begin
      LJSON.AddPair(TLogObjectNames.Resource, AResource.Name);
      LEndpoints := TJSONArray.Create;
      for S in AResource.EndpointNames do
        LEndpoints.Add(S);
      LJSON.AddPair(TLogObjectNames.Endpoints, LEndpoints);
    end);
end;

class procedure TLogHelpers.LogConfigurationLoaded(const AFileName: string);
begin
  DoLog(TLogCategoryNames.ConfigLoaded,
    procedure(const LJSON: TJSONObject)
    begin
      LJSON.AddPair(TLogObjectNames.FileName, AFileName);
    end);
end;

class procedure TLogHelpers.LogException(
  const AException: Exception);
begin
  DoLog(TLogCategoryNames.Error,
    procedure(const LJSON: TJSONObject)
    begin
      LJSON.AddPair(TLogObjectNames.ErrorType, TLogErrorTypes.Other);
      LJSON.AddPair(TLogObjectNames.ExceptionClass, AException.ClassName);
      LJSON.AddPair(TLogObjectNames.ExceptionMessage, AException.Message);
    end);
end;

class procedure TLogHelpers.LogRequest(const AResourceName, AEndpointName,
  AMethod, AUserID: string);
begin
  DoLog(TLogCategoryNames.Request,
    procedure(const LJSON: TJSONObject)
    begin
      LJSON.AddPair(TLogObjectNames.Resource, AResourceName);
      LJSON.AddPair(TLogObjectNames.Endpoint, AEndpointName);
      LJSON.AddPair(TLogObjectNames.Method, AMethod);
      if AUserID <> '' then
        LJSON.AddPair(TLogObjectNames.UserID, AUserID)
      else
        LJSON.AddPair(TLogObjectNames.UserID, TJSONString.Create(sBlank));
      LJSON.AddPair(TLogObjectNames.Time, DateTimeToStr(Now));
    end);
end;

class procedure TLogHelpers.LogRedirect(const AResourceName, AEndpointName,
  ADestinationResourceName, ADestinationEndpointName: string);
begin
  DoLog(TLogCategoryNames.Redirect,
    procedure(const LJSON: TJSONObject)
    begin
      LJSON.AddPair(TLogObjectNames.Resource, AResourceName);
      LJSON.AddPair(TLogObjectNames.Endpoint, AEndpointName);
      LJSON.AddPair(TLogObjectNames.DestinationResource, ADestinationResourceName);
      LJSON.AddPair(TLogObjectNames.DestinationEndpoint, ADestinationEndpointName);
      LJSON.AddPair(TLogObjectNames.Time, DateTimeToStr(Now));
    end);
end;

{ TErrorHelpers }

class function TErrorHelpers.CreateJSONError(const AReasonString, AError,
  ADescription: string): TJSONObject;
const
  sError = 'error';
  sDescription = 'description';
begin
  Result := TJSONObject.Create;
  if AError <> '' then
    Result.AddPair(sError, AError)  // Do not localize
  else
    Result.AddPair(sError, AReasonString);
  if ADescription <> '' then
    Result.AddPair(sDescription, ADescription);
end;

{ TJSONHelpers }

class function TJSONHelpers.JsonEncode(AJsonValue: TJsonValue): string;
var
  LBytes: TBytes;
begin
  // Use AJsonValue.ToJson;
  SetLength(LBytes,AJsonValue.ToString.Length*6); //Length can not be predicted. Worst case: every single char gets escaped
  SetLength(LBytes, AJsonValue.ToBytes(LBytes, 0)); //adjust Array to actual length
  result := TEncoding.Default.GetString(LBytes);
end;

end.
