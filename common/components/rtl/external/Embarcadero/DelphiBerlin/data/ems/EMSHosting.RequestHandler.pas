{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit EMSHosting.RequestHandler;

interface

uses System.SysUtils, System.Classes, System.Generics.Collections,
  EMSHosting.RequestTypes, EMS.ResourceAPI, EMSHosting.Endpoints;

type
  TEMSHostRequestProps = record
  public type
    THeaderNames = record
    public const
      ApiVersion = 'X-Embarcadero-Api-Version';
      ApplicationId = 'X-Embarcadero-Application-Id';
      SessionToken = 'X-Embarcadero-Session-Token';
      MasterSecret = 'X-Embarcadero-Master-Secret';
      AppSecret = 'X-Embarcadero-App-Secret';
   end;
  private
    FApplicationId: string;
    FApiVersion: string;
    FApiMajorVersion: string;
    FApiMinorVersion: string;
    FSessionToken: string;
    FResourceURL: string;
    FAppSecret: string;
    FMasterSecret: string;
  public
    property ApiVersion: string read FApiVersion;
    property ApiMajorVersion: string read FApiMajorVersion;
    property ApiMinorVersion: string read FApiMinorVersion;
    property ApplicationID: string read FApplicationID;
    property ResourceURL: string read FResourceURL;
    property SessionToken: string read FSessionToken;
    property AppSecret: string read FAppSecret;
    property MasterSecret: string read FMasterSecret;
  end;

  TEMSHostRequestHandler = class abstract
  private
    function GetRequestProps(
      const Request: IEMSHostRequest): TEMSHostRequestProps;
    function GetGroups(const AContext: IEMSHostContext; const AUserID: string;
      var AGroups: TEndpointContext.TGroups): TEndpointContext.TGroups;
    function GetUserID(const AContext: IEMSHostContext; const ASessionToken: string;
      var AUserID: string): string;
    function GetUserName(const AContext: IEMSHostContext; const AUserID: string; var AUserName: string): string;
  protected
    function UserIDOfSession(const AContext: IEMSHostContext; const ASessionToken: string;
      out AUserID: string): Boolean; virtual; abstract;
    function UserNameOfID(const AContext: IEMSHostContext; const AUserID: string;
      out AUserName: string): Boolean; virtual; abstract;
    function GetGroupsByUser(const AContext: IEMSHostContext; const AUserID: string): TArray<string>; virtual;
    procedure CheckForbiddenRequest(const AResourceName, AOriginalResourceName: string); virtual; abstract;
    procedure AuthenticateRequest(const AResources: TArray<TEMSResource>; const AResourceRequest: TEMSHostRequestProps;
      var AAuthenticated: TEndpointContext.TAuthenticated); virtual; abstract;
    procedure LogEndpoint(const AResource, AEndpointName, AMethod, AUserID,
      ACustom: string); virtual; abstract;
    procedure RedirectResource(const AContext: TEndpointContext; var AResource: TEMSResource; var AEndpointName: string); virtual; abstract;
  public
    { Public declarations }
    procedure HandleRequest(const Context: IEMSHostContext; const Request: IEMSHostRequest;
      const Response: IEMSHostResponse; var Handled: Boolean);
    procedure HandleException(const E: Exception;
      const Response: IEMSHostResponse;
      var Handled: Boolean);
  end;


implementation

uses System.JSON, EMSHosting.Utility,
  EMSHosting.Helpers,
  EMSHosting.ResourceManager, EMSHosting.Consts;

function TEMSHostRequestHandler.GetRequestProps(const Request: IEMSHostRequest): TEMSHostRequestProps;

  function GetField(const AName: string; const ADefault: string = ''): string;
  begin
    Result := Request.Headers[AName];
    if Result = '' then
      Result := ADefault;
  end;
var
  LPathInfo: string;
  LStrings: TStrings;
  I: Integer;
begin
  LPathInfo := String(Request.PathInfo);                                 
  LStrings := ParseURLPath(LPathInfo);
  try
    if LStrings.Count > 0 then                                                      
    begin
      if LStrings[0] = '/' then
        if LStrings.Count > 1 then
          Result.FResourceURL := '/' + LStrings[1]
        else
          Result.FResourceURL := LStrings[0]
      else
        Result.FResourceURL := LStrings[0];
    end;
    Result.FApplicationId := GetField(TEMSHostRequestProps.THeaderNames.ApplicationId);

    Result.FApiVersion := GetField(TEMSHostRequestProps.THeaderNames.ApiVersion);
    I := Result.FApiVersion.IndexOf('.');
    if I > 0 then
    begin
      Result.FApiMinorVersion := Result.FApiVersion.Substring(I+1);
      Result.FApiMajorVersion := Result.FApiVersion.Substring(0, I);
    end
    else
      Result.FApiMajorVersion := Result.FApiVersion;

    Result.FMasterSecret := GetField(TEMSHostRequestProps.THeaderNames.MasterSecret);

    Result.FAppSecret := GetField(TEMSHostRequestProps.THeaderNames.AppSecret);

    Result.FSessionToken := GetField(TEMSHostRequestProps.THeaderNames.SessionToken);

    if Result.FResourceURL = '' then
      Result.FResourceURL := '/';
  finally
    LStrings.Free;
  end;
end;

type
  TUser = class(TEndpointContextImpl.TUser)
  private type
    TGroups = TEndpointContext.TGroups;
  private
    FGetGroups: TFunc<TGroups>;
    FGetUserName: TFunc<string>;
    FGetUserID: TFunc<string>;
  protected
                    
    function GetUserName: string; override;
    function GetUserID: string;  override;
    function GetGroups: TEndpointContext.TGroups; override;
  end;

  TEdgemodule = class(TEndpointContextImpl.TEdgemodule)
  private
    FGetModuleName: TFunc<string>;
    FGetModuleVersion: TFunc<string>;
  protected
    function GetModuleName: string; override;
    function GetModuleVersion: string; override;
  end;

  TGroups = class(TEndpointContextImpl.TGroups)
  private
    FRequestHandler: TEMSHostRequestHandler;
    FUserID: string;
    FGroups: TList<string>;
    FContext: IEMSHostContext;
    procedure CheckGroups;
  protected
    function GetCount: Integer; override;
  public
    constructor Create(const AContext: IEMSHostContext; const ARequestHandler: TEMSHostRequestHandler; const AUserID: string);
    destructor Destroy; override;
    function Contains(const AGroup: string): Boolean; override;
  end;

{ TUser }

function TUser.GetUserName: string;
begin
  Assert(Assigned(FGetUserName));
  Result := FGetUserName;
end;

function TUser.GetUserID: string;
begin
  Assert(Assigned(FGetUserID));
  Result := FGetUserID;
end;

function TUser.GetGroups: TEndpointContext.TGroups;
begin
  Assert(Assigned(FGetGroups));
  Result := FGetGroups;
end;

{ TEdgemodule }

function TEdgemodule.GetModuleName: string;
begin
  Assert(Assigned(FGetModuleName));
  Result := FGetModuleName;
end;

function TEdgemodule.GetModuleVersion: string;
begin
  Assert(Assigned(FGetModuleVersion));
  Result := FGetModuleVersion;
end;


function TEMSHostRequestHandler.GetUserID(const AContext: IEMSHostContext; const ASessionToken: string; var AUserID: string): string;
begin
  Result := AUserID;
  if Result = '' then
  begin
    if not Self.UserIDOfSession(AContext, ASessionToken, Result) then
      EEMSHTTPError.RaiseUnauthorized; // No user
  end;
  AUserID := Result;
end;

function TEMSHostRequestHandler.GetGroups(const AContext: IEMSHostContext; const AUserID: string; var AGroups: TEndpointContext.TGroups): TEndpointContext.TGroups;
begin
  Result := AGroups;
  if Result = nil then
    Result := TGroups.Create(AContext, Self, AUserID);
  AGroups := Result;
end;

function TEMSHostRequestHandler.GetUserName(const AContext: IEMSHostContext; const AUserID: string; var AUserName: string): string;
begin
  Result := AUserName;
  if Result = '' then
  begin
    if not Self.UserNameOfID(AContext, AUserID, Result) then
      EEMSHTTPError.RaiseNotFound;
  end;
  AUserName := Result;
end;

function TEMSHostRequestHandler.GetGroupsByUser(const AContext: IEMSHostContext; const AUserID: string): TArray<string>;
begin
  Result := nil;
end;

procedure TEMSHostRequestHandler.HandleRequest(const Context: IEMSHostContext;
  const Request: IEMSHostRequest; const Response: IEMSHostResponse; var Handled: Boolean);
var
  LResources: TArray<TEMSResource>;

  function IsVersionResource: Boolean;
  begin
    Result := (Length(LResources) = 1) and
      SameText(LResources[0].Name, 'version');
  end;

type
  TUserGroups = TUser.TGroups;                                                
var
  LPathInfo: string;
  LResource: TEMSResource;
  R: TEMSResource;
  LContext: TEndpointContextImpl;
  LRequest: TEndpointRequest;
  LResponse: TEndpointResponseImpl;
  LAuthenticated: TEndpointContext.TAuthenticated;
  LEndpointName: string;
  LCustom: string;
  LResourceRequest: TEMSHostRequestProps;
  LUserID: string;
  LUserName: string;
  LGroups: TEndpointContext.TGroups;
  LGetGroups: TFunc<TUserGroups>;
  LGetUserName: TFunc<string>;
  LGetUserID: TFunc<string>;
  LOriginalResourceName: string;
  LOriginalEndpointName: string;
begin
  LGroups := nil;
  LAuthenticated := [];
  LRequest := nil;
  LResponse := nil;
  try
    LPathInfo := String(Request.PathInfo);                                 
    LResourceRequest := GetRequestProps(Request);
    LResources := TEMSEndpointManagerImpl.Instance.FindByBaseURL(LResourceRequest.ResourceURL);

    Self.AuthenticateRequest(LResources, LResourceRequest, LAuthenticated);

    LResource := nil;
    if LResources = nil then
    begin
      if LResourceRequest.ResourceURL = '/'  then
      begin
        // Blank page
        Response.StatusCode := 200;
        Exit; // EXIT
      end
      else if SameText(LResourceRequest.ResourceURL, '/favicon.ico')  then
      begin
        // Silent failure
        Response.StatusCode := EEMSHTTPError.TCodes.NotFound;
        Exit; // EXIT
      end;
      EEMSHTTPError.RaiseNotFound(Format(sResourceNotFound, [LResourceRequest.ResourceURL]));
    end;

    LRequest := TEndpointRequestImpl.Create(Request);
    LContext := TEndpointContextImpl.Create;
    LContext.OnGetAuthenticated :=
      function: TEndpointContext.TAuthenticated
      begin
        Result := LAuthenticated;
        if LContext.User <> nil then
          Include(Result, TEndpointContext.TAuthenticate.User);
      end;
    LContext.OnGetEndpointName :=
      function: string
      begin
        Result := LEndpointName;
      end;
    LContext.OnGetRequest :=
      function: TEndpointRequest
      begin
        Result := LRequest;
      end;
    LContext.OnGetResponse :=
      function: TEndpointResponse
      begin
        Result := LResponse;
      end;
    LGetGroups :=
      function: TUserGroups
      begin
        Result := Self.GetGroups(Context, Self.GetUserID(Context, LResourceRequest.SessionToken, LUserID), LGroups);
      end;
    LGetUserName :=
      function: string
      begin
        Result := Self.GetUserName(Context, Self.GetUserID(Context, LResourceRequest.SessionToken, LUserID), LUserName);
      end;
    LGetUserID :=
      function: string
      begin
        Result := Self.GetUserID(Context, LResourceRequest.SessionToken, LUserID);
      end;
    LContext.OnCreateUser :=
      procedure(const AContext: TEndpointContextImpl; out AUser: TEndpointContextImpl.TUser)
      begin
        AUser := nil;
        if LResourceRequest.SessionToken <> '' then
        begin
          AUser := TUser.Create;
          TUser(AUser).FGetGroups := LGetGroups;
          TUser(AUser).FGetUserName := LGetUserName;
          TUser(AUser).FGetUserID := LGetUserID;
        end;
      end;
    LContext.OnCreateEdgemodule :=
      procedure(const AContext: TEndpointContextImpl; out AEdgemodule: TEndpointContextImpl.TEdgemodule)
      var
        LIntf: IEMSEdgeHostContext;
      begin
        AEdgemodule := nil;
        if Supports(Context, IEMSEdgeHostContext, LIntf) then
        begin
          AEdgemodule := TEdgemodule.Create;
          TEdgemodule(AEdgemodule).FGetModuleName := function: string begin Result := LIntf.ModuleName end;
          TEdgemodule(AEdgemodule).FGetModuleVersion := function: string begin Result := LIntf.ModuleVersion end;
        end;
      end;
    for R in LResources do
      if R.CanHandleRequest(LContext, LEndpointName) then
      begin
        if LResource = nil then
          LResource := R
        else
          EEMSHTTPError.RaiseError(500, sResourceErrorMessage, Format(sResourceMultipleEndpoints, [LEndpointName]));
      end;
    if LResource <> nil then
    begin
      LOriginalResourceName := LResource.Name;
      LOriginalEndpointName := LEndpointName;
      RedirectResource(LContext, LResource, LEndpointName);
    end;
    if LResource <> nil then
    begin
      CheckForbiddenRequest(LResource.Name, LOriginalResourceName);
      if LContext.User <> nil then
        LUserID := LContext.User.UserID
      else
        LUserID := '';
      if TLogHelpers.LoggingEnabled then
        TLogHelpers.LogRequest(LResource.Name, LEndpointName, LRequest.MethodString, LUserID);
      LResponse := TEndpointResponseImpl.Create(Response);
      Handled := True;
      LResource.HandleRequest(LContext);
      LResponse.Write;
      case LContext.EndpointDataType of
        // In the case of AddUser/DeleteUser, the userid being added or deleted should be passed to ACustom
        TEndpointContextImpl.TEndpointDataType.AddUser,
        TEndpointContextImpl.TEndpointDataType.DeletedUser:
          LCustom := LContext.EndpointDataValue;
      end;
      case LContext.EndpointDataType of
        // In the case of AddUser/Login, log the userid
        TEndpointContextImpl.TEndpointDataType.AddUser,
        TEndpointContextImpl.TEndpointDataType.LoginUser:
          if LUserID = '' then
            LUserID := LContext.EndpointDataValue;
      end;
      // Analytics log
      Self.LogEndpoint(LResource.Name, LEndpointName, LRequest.MethodString, LUserID, LCustom);
    end
    else
      EEMSHTTPError.RaiseNotFound('', Format(sResourceNotFound, [LResourceRequest.ResourceURL]));
  finally
    LRequest.Free;
    LResponse.Free;
    LContext.Free;
  end;

end;



procedure TEMSHostRequestHandler.HandleException(const E: Exception;
  const Response: IEMSHostResponse;
  var Handled: Boolean);
var
  LHTTPError: EEMSHTTPError;
  LJSONObject: TJSONObject;
  LBody: TEndpointResponseBodyImpl;
  LError: string;
  LDescription: string;
begin
  Handled := True;
  if E is EEMSHTTPError then
  begin
    LHTTPError := EEMSHTTPError(E);
    Response.StatusCode := LHTTPError.Code;
    if LHTTPError.Error <> '' then
      LError := LHTTPError.Error;
    if LHTTPError.Description <> '' then
      LDescription := LHTTPError.Description;
  end
  else
  begin
    Response.StatusCode := 500;
    LDescription := E.Message;
  end;
  // Write JSONObject with error description
  LJSONObject := TErrorHelpers.CreateJSONError(string(Response.ReasonString), LError, LDescription);
  try
    if TLogHelpers.LoggingEnabled then
      TLogHelpers.LogHTTPError(REsponse.StatusCode, String(Response.ReasonString),
        LError, LDescription);
    LBody :=  TEndpointResponseBodyImpl.Create(
      Response);
    try
      // Write to response
      LBody.SetValue(LJSONObject, False);
    finally
      LBody.Free;
    end;
  finally
    LJSONObject.Free;
  end;
end;

{ TGroups }

procedure TGroups.CheckGroups;
begin
  if FGroups = nil then
  begin
    FGroups := TList<string>.Create;
    FGroups.AddRange(FRequestHandler.GetGroupsByUser(FContext, FUserID));
  end;
end;

function TGroups.Contains(const AGroup: string): Boolean;
begin
  CheckGroups;
  Result := FGroups.Contains(AGroup);
end;

constructor TGroups.Create(const AContext: IEMSHostContext; const ARequestHandler: TEMSHostRequestHandler; const AUserID: string);
begin
  FContext := AContext;
  FRequestHandler := ARequestHandler;
  FUserID := AUserID;
end;

destructor TGroups.Destroy;
begin
  FGroups.Free;
  inherited;
end;

function TGroups.GetCount: Integer;
begin
  CheckGroups;
  Result := FGroups.Count;
end;

end.
