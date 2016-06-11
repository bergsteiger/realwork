{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Datasnap.DSAuth;

interface

uses System.Classes, Data.DBXCommon, Datasnap.DSCommonServer;

type

  /// <summary>Attribute that you can use in a server class or in a server
  /// method to specify the roles that are authorized or not authorized to use
  /// the methods of the target class or the target method.</summary>
  TRoleAuth = class(TCustomAttribute)
  private
    FIsDesignTime: Boolean;
    FCreateTime: TDateTime;
    FAuthorizedRoles : TStringList;
    FDeniedRoles: TStringList;
  public
    ///  <summary> Constructor which takes in three comma-separated value string lists.
    ///  </summary>
    ///  <remarks> Each CSV String contains a list of zero or more role names associated
    ///    with the language construct being annotated.
    ///    DeniedRoles and IgnoredRoles are both optional and default to empty.
    ///  </remarks>
    constructor Create(AuthorizedRoles: string; DeniedRoles: string = ''); overload; virtual;
    ///  <summary> Constructor with roles as TStrings</summary>
    ///  <remarks> Created instance will not take ownership of the arguments below</remarks>
    ///  <param name="AllowRoles">list of allowed roles, can be empty but not nil</param>
    ///  <param name="DenyRoles">list of rejected roles, can be empty but not nil</param>
    ///  <param name="DesignTime">true if this TRoleAuth was created at design time. defaults to false</param>
    constructor Create(AllowRoles: TStrings; DenyRoles: TStrings;
                       DesignTime: Boolean = False); overload; virtual;
    destructor Destroy; override;
    ///  <summary> List of roles which are authorized to access the construct annotated with this attribute
    ///  </summary>
    property AuthorizedRoles : TStringList read FAuthorizedRoles;
    ///  <summary> List of roles which are NOT authorized to access the construct annotated with this attribute.
    ///  </summary>
    ///  <remarks> Unauthorized access with one of these roles will result in an exception being thrown.
    ///  </remarks>
    property DeniedRoles : TStringList read FDeniedRoles;
    ///  <summary> Boolean value which specifies if this TRoleAuth was created at design time instead
    ///     of being annotation stripped from the code at runtime. This can be useful, for example, when
    ///     deciding if the instance should be created at the end of method invocation or not.
    ///  </summary>
    property IsDesignTime: Boolean read FIsDesignTime;
    ///  <summary> The date/time the TRoeAuth was created, useful when IsDesignTime = True, to determine
    ///     if the TRoeAuth has become outdated.
    ///  </summary>
    property CreateTime: TDateTime read FCreateTime;
  end;

  /// <summary>Role item that belongs to a collection of roles and contains a
  /// list of authorized roles, a list of denied roles, a set of entities where
  /// the role applies, and a set of entities to exclude from the set of
  /// entities where the role applies.</summary>
  TDSCustomRoleItem = class(TCollectionItem)
  private
    FDeniedRoles: TStrings;
    FAuthorizedRoles: TStrings;
    FApplyTo: TStrings;
    FExclude: TStrings;
    procedure SetAuthorizedRoles(const Value: TStrings);
    procedure SetDeniedRoles(const Value: TStrings);
    procedure SetApplyTo(const Value: TStrings);
    procedure SetExclude(const Value: TStrings);
    procedure Changed;
  protected
    function GetDisplayName: string; override;
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create(Collection: TCollection); overload; override;
    destructor Destroy; override;
    ///  <summary> List of roles which are authorized to access the construct annotated with this attribute
    ///  </summary>
    property AuthorizedRoles : TStrings read FAuthorizedRoles write SetAuthorizedRoles;
    ///  <summary> List of roles which are NOT authorized to access the construct annotated with this attribute.
    ///  </summary>
    ///  <remarks> Unauthorized access with one of these roles will result in an exception being thrown.
    ///  </remarks>
    property DeniedRoles : TStrings read FDeniedRoles write SetDeniedRoles;
    ///  <summary> List of entities the roles of this item applies to.
    ///  </summary>
    ///  <remarks> See the comment on the TDSCustomRoleItem class for more information. </remarks>
    property ApplyTo : TStrings read FApplyTo write SetApplyTo;
    ///  <summary> List of entities the roles of this item doesn't apply to.
    ///  </summary>
    ///  <remarks> See the comment on the TDSCustomRoleItem class for more information. </remarks>
    property Exclude : TStrings read FExclude write SetExclude;
  end;

  TDSRoleItem = class(TDSCustomRoleItem)
  published
    property AuthorizedRoles;
    property DeniedRoles;
    property ApplyTo;
    property Exclude;
  end;

  TDSRoleItems = class(TCollection)
  private
    FOwner: TPersistent;
    FLastUpdated: TDateTime;
  protected
    function GetOwner: TPersistent; override;
    function GetItem(Index: Integer): TDSRoleItem;
    procedure SetItem(Index: Integer; const Value: TDSRoleItem);
  public
    constructor Create(AOwner: TPersistent); virtual;
    /// <summary> Mark this instance as being updated. TRoleAuth instances created previously from
    ///    this class will be regenerated the next time their method is invoked.
    /// </summary>
    procedure MarkUpdated;
    /// <summary> Specifies the last time the items held by this instance were updated. </summary>
    property LastUpdated: TDateTime read FLastUpdated;
    property Items[Index: Integer]: TDSRoleItem read GetItem write SetItem; default;
  end;

  ///  <summary> User event for user authentication event
  ///  </summary>
  TDSAuthenticationEvent = procedure(Sender: TObject;
                                    const Protocol: string;
                                    const Context: string;
                                    const User: string;
                                    const Password: string;
                                    var valid: boolean;
                                    UserRoles: TStrings) of object;

  ///  <summary> User event for user authentication event
  ///  </summary>
  TDSAuthorizationEvent = procedure(Sender: TObject;
                                    AuthorizeEventObject: TDSAuthorizeEventObject;
                                    var valid: boolean) of object;

  TDSRoleComparison = (rcNoUserRoles, rcNoMethodRoles, rcUserRoleAllowed, rcUserRoleDenied, rcNoMatch);

  TDSCustomAuthenticationManager = class(TComponent)
  strict private
    FOnUserAuthenticate: TDSAuthenticationEvent;
    FOnUserAuthorize: TDSAuthorizationEvent;
    FValidateCertificateEvent: TValidateCertificate;
  private
    FRoleItems: TDSRoleItems;
    procedure SetRoleItems(const Value: TDSRoleItems);
  protected
    function GetOnUserAuthenticate: TDSAuthenticationEvent;
    function GetOnUserAuthorize: TDSAuthorizationEvent;
    function GetValidateCertificateEvent: TValidateCertificate; virtual;
    procedure SetValidateCertificateEvent(const Event: TValidateCertificate); virtual;
    function HasUserAuthenticateEvent: boolean; virtual;
    function SessionUserRoles: TStrings; virtual;
    ///  <summary> Returns true if the specified user can connect to the DS Server
    ///  </summary>
    ///  <remarks> The invocation is done by the specific transport for every session.
    ///  </remarks>
    ///  <param name="AuthenticateEventObject">TDSAuthenticateEventObject - Can contain other information about the connection</param>
    ///  <param name="protocol">String - protocol name</param>
    ///  <param name="context">String - context</param>
    ///  <param name="user">String - user name</param>
    ///  <param name="password">String - user password</param>
    ///  <param name="UserRoles">List of user roles for which the user is authorized to access</param>
    ///  <returns>true if the user and password are a valid combination</returns>
    function Authenticate(const AuthenticateEventObject: TDSAuthenticateEventObject; const Protocol: string; const Context: string;
                          const User: string; const Password: string;
                          UserRoles: TStrings = nil): Boolean; overload; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function CompareRoles(UserRoles: TStrings;
      AuthorizedRoles, DeniedRoles: TStrings): TDSRoleComparison;
    ///  <summary>HTTP specific user authentication</summary>
    function Authenticate(const Protocol: string; const Context: string; const AuthUserName, AuthPassword: string;
      const Request: TObject; const Response: TObject): Boolean;  overload; virtual;
    ///  <summary>Extracts connection authentication values and invokes user event</summary>
    ///  <remarks>Authentication logic for TCP connection into DS Server</remarks>
    ///  <param name="AuthenticateEventObject">Information about the method being authenticated</param>
    ///  <param name="connectionProps">connection properties</param>
    ///  <returns>true if the user can connect to DS Server</returns>
    function Authenticate(
      const AuthenticateEventObject: TDSAuthenticateEventObject;
      connectionProps: TDBXProperties): boolean; overload; virtual;

    ///  <summary> Returns true if the peer certificate is valid</summary>
    ///  <param name="Certificate">X509 certificate</param>
    ///  <param name="ADepth">number of certificates to be validated</param>
    function ValidatePeerCertificate(Certificate: TX509Certificate; const ADepth: Integer): boolean; virtual;

    ///  <summary>
    ///   Returns if the specified user is authorized to access the method in question.
    ///  </summary>
    ///  <remarks> If the OnUserAuthorize property is not set then this function will return Defined.
    ///  </remarks>
    ///  <param name="EventObject">TDSAuthorizeEventObject - information about the user and the method</param>
    ///  <returns>true if the method access is allowed for the given user</returns>
    function Authorize(const EventObject: TDSAuthorizeEventObject): boolean; virtual;
    property OnUserAuthorize: TDSAuthorizationEvent read GetOnUserAuthorize  write FOnUserAuthorize;

    property OnUserAuthenticate: TDSAuthenticationEvent read GetOnUserAuthenticate  write FOnUserAuthenticate;

    ///  <remarks> Certificate validation is ubiquitous</remarks>
    property OnValidatePeerCertificate: TValidateCertificate read GetValidateCertificateEvent write SetValidateCertificateEvent;

    ///  <summary>
    ///    Returns a TRoleAuth instance for the given method, based on the roles
    ///    held by this component.
    ///  </summary>
    ///  <remarks>
    ///    This does not do any special handling of the case where a role appears in both
    ///    the authorized and denied lists. If this situation comes up the Roles
    ///    should either be redesigned, or the Authentication Manager should handle that case.
    ///
    ///    Note that if you assign UserRoles in the authentication for a user,
    ///    then those roles may be used to authorize the user. If this happens and a role assigned to the user
    ///    is in the denies list (even if it is also in the authorized list) then the user will be denied.
    ///  </remarks>
    function GetAuthRole(const ClassName, MethodName: string): TRoleAuth; virtual;
    ///  <summary> Collection of items which define authorization roles
    ///  </summary>
    property Roles: TDSRoleItems read FRoleItems write SetRoleItems;
  end;

  TDSAuthenticationManager = class(TDSCustomAuthenticationManager)
  published
    property OnUserAuthenticate;
    property OnUserAuthorize;
    property Roles;
  end;

implementation

uses Datasnap.DSSession, Datasnap.DSServerResStrs, System.SysUtils;

{ TRoleAuth }

constructor TRoleAuth.Create(AuthorizedRoles: string; DeniedRoles: string = '');
begin
  FIsDesignTime := False;

  FAuthorizedRoles := TStringList.Create;
  FDeniedRoles := TStringList.Create;

  FAuthorizedRoles.CommaText  := AuthorizedRoles;
  FDeniedRoles.CommaText  := DeniedRoles;

  FCreateTime := Now;
end;

constructor TRoleAuth.Create(AllowRoles, DenyRoles: TStrings; DesignTime: Boolean);
begin
  FIsDesignTime := DesignTime;
  if AllowRoles <> nil then
  begin
    FAuthorizedRoles := TStringList.Create;
    FAuthorizedRoles.Assign(AllowRoles);
  end;
  if DenyRoles <> nil then
  begin
    FDeniedRoles := TStringList.Create;
    FDeniedRoles.Assign(DenyRoles);
  end;

  FCreateTime := Now;
end;

destructor TRoleAuth.Destroy;
begin
  FreeAndNil(FAuthorizedRoles);
  FreeAndNil(FDeniedRoles);
  inherited;
end;

{ TDSCustomRoleItem }

procedure TDSCustomRoleItem.AssignTo(Dest: TPersistent);
begin
  if Dest.InheritsFrom(TDSCustomRoleItem) then
  begin
    TDSCustomRoleItem(Dest).FDeniedRoles.Assign(FDeniedRoles);
    TDSCustomRoleItem(Dest).FAuthorizedRoles.Assign(FAuthorizedRoles);
    TDSCustomRoleItem(Dest).FApplyTo.Assign(FApplyTo);
    TDSCustomRoleItem(Dest).FExclude.Assign(FExclude);
  end
  else
    inherited;
end;

procedure TDSCustomRoleItem.Changed;
begin
                                                                                       
end;

constructor TDSCustomRoleItem.Create(Collection: TCollection);
begin
  inherited;
  FDeniedRoles := TStringList.Create;
  FAuthorizedRoles := TStringList.Create;
  FApplyTo := TStringList.Create;
  FExclude := TStringList.Create;
end;

destructor TDSCustomRoleItem.Destroy;
begin
  FDeniedRoles.Free;
  FAuthorizedRoles.Free;
  FApplyTo.Free;
  FExclude.Free;
  inherited;
end;

function TDSCustomRoleItem.GetDisplayName: string;
begin
  Result := Format(sFormatRoleItem,
         [FApplyTo.DelimitedText, FExclude.DelimitedText, FAuthorizedRoles.DelimitedText, FDeniedRoles.DelimitedText]);
end;

procedure TDSCustomRoleItem.SetApplyTo(const Value: TStrings);
begin
  Changed;
  FApplyTo.Assign(Value);
end;

procedure TDSCustomRoleItem.SetAuthorizedRoles(const Value: TStrings);
begin
  Changed;
  FAuthorizedRoles.Assign(Value);
end;

procedure TDSCustomRoleItem.SetDeniedRoles(const Value: TStrings);
begin
  Changed;
  FDeniedRoles.Assign(Value);
end;

procedure TDSCustomRoleItem.SetExclude(const Value: TStrings);
begin
  Changed;
  FExclude.Assign(Value);
end;

{ TDSRoleItems }

constructor TDSRoleItems.Create(AOwner: TPersistent);
begin
  FOwner := AOwner;
  FLastUpdated := Now;
  inherited Create(TDSRoleItem);
end;

function TDSRoleItems.GetItem(Index: Integer): TDSRoleItem;
begin
  Result := TDSRoleItem(inherited GetItem(Index));
end;

function TDSRoleItems.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TDSRoleItems.MarkUpdated;
begin
  FLastUpdated := Now;
end;

procedure TDSRoleItems.SetItem(Index: Integer; const Value: TDSRoleItem);
begin
  inherited SetItem(Index, Value);
end;

{ TDSCustomAuthenticationManager }

function TDSCustomAuthenticationManager.Authenticate(const AuthenticateEventObject: TDSAuthenticateEventObject; const Protocol, Context, User,
  Password: string; UserRoles: TStrings): Boolean;
begin
  Result := true;
  if Assigned(FOnUserAuthenticate) then
    FOnUserAuthenticate(self, Protocol, Context, User, Password, Result, UserRoles)
end;

function TDSCustomAuthenticationManager.SessionUserRoles: TStrings;
var
  session: TDSSession;
begin
  Result := nil;
  session := TDSSessionManager.GetThreadSession;
  if session <> nil then
    Result := session.UserRoles
end;

function TDSCustomAuthenticationManager.Authorize(const EventObject: TDSAuthorizeEventObject): Boolean;
begin
  case CompareRoles(SessionUserRoles, EventObject.AuthorizedRoles, EventObject.DeniedRoles) of
    rcUserRoleAllowed,
    rcNoMethodRoles:
      Result := True
  else
    Result := False;
  end;

  if Assigned(FOnUserAuthorize) then
    FOnUserAuthorize(self, EventObject,
    Result);
end;

constructor TDSCustomAuthenticationManager.Create(AOwner: TComponent);
begin
  inherited;
  FValidateCertificateEvent := nil;
//  FOnUserAuthenticate := nil;
//  FOnUserAuthorize := nil;
  FRoleItems := TDSRoleItems.Create(Self);
end;

class function TDSCustomAuthenticationManager.CompareRoles(
  UserRoles: TStrings; AuthorizedRoles, DeniedRoles: TStrings): TDSRoleComparison;

  function ShareData(const StrContainer1,
    StrContainer2: TStrings): boolean;
  var
    Idx: Integer;
  begin
    if (StrContainer1.Count = 0) or (StrContainer2.Count = 0) then
      exit(false);
    for Idx := 0 to StrContainer1.Count - 1 do
      if StrContainer2.IndexOf(StrContainer1[Idx]) <> -1 then
        exit(true);
    exit(false);
  end;

begin
  if ((AuthorizedRoles = nil) or (AuthorizedRoles.Count = 0)) and ((DeniedRoles = nil) or (DeniedRoles.Count = 0)) then
    exit(rcNoMethodRoles);
  if (UserRoles = nil) or (UserRoles.Count = 0) then
    exit(rcNoUserRoles);
  if ShareData(DeniedRoles, UserRoles) then
    exit(rcUserRoleDenied);
  if ShareData(AuthorizedRoles, UserRoles) then
    exit(rcUserRoleAllowed);
  exit(rcNoMatch);
end;


destructor TDSCustomAuthenticationManager.Destroy;
begin
  FRoleItems.Free;
  inherited;
end;

function TDSCustomAuthenticationManager.GetAuthRole(const ClassName, MethodName: string): TRoleAuth;
var
  Item: TDSRoleItem;
  I: Integer;
  Auth: TStringList;
  Deny: TStringList;
begin
  Result := nil;
  Auth := nil;
  Deny := nil;

  if Assigned(Roles) and (Roles.Count > 0) then
  begin
    Auth := TStringList.Create;
    Deny := TStringList.Create;

    Auth.Duplicates := dupIgnore;
    Deny.Duplicates := dupIgnore;

    for I := 0 to Roles.Count - 1 do
    begin
      Item := Roles[I];

      //applies to everything if 'AppliesTo' is empty
      if (Item.ApplyTo.Count = 0) or
         //handles methods belonging to a specific class
         (Item.ApplyTo.IndexOf(ClassName) > -1) or
         //handles methods (of any class) with the given name
         (Item.ApplyTo.IndexOf(MethodName) > -1) or
         //handles methods with a specific class and name
         (Item.ApplyTo.IndexOf(ClassName + '.' + MethodName) > -1) then
      begin
        //Roles only apply if matching the 'ApplyTo' but not the 'Exclude'
        if (Item.Exclude.Count = 0) or
            //Exclude list must not contain Class name
           ((Item.Exclude.IndexOf(ClassName) = -1) and
            //Exclude list must not contain Method name
            (Item.Exclude.IndexOf(MethodName) = -1) and
            //Eclude list must not contain ClassName.MethodName
            (Item.Exclude.IndexOf(ClassName + '.' + MethodName) = -1)) then
        begin
          Auth.AddStrings(Item.AuthorizedRoles);
          Deny.AddStrings(Item.DeniedRoles);
        end;
      end;
    end;

    //if there are no authorized and no denied roles to match this method,
    //then return nil for the TRoleAuth
    if (Auth.Count <> 0) or (Deny.Count <> 0) then
    begin
      //create the 'design time' TAuthRole
      Result := TRoleAuth.Create(Auth, Deny, True);
    end;

    //free the Auth and Deny lists, and they are copied into TRoleAuth, not used directly.
    FreeAndNil(Auth);
    FreeAndNil(Deny);
  end;
end;

function TDSCustomAuthenticationManager.GetOnUserAuthenticate: TDSAuthenticationEvent;
begin
  Result := FOnUserAuthenticate;
end;

function TDSCustomAuthenticationManager.GetOnUserAuthorize: TDSAuthorizationEvent;
begin
  Result := FOnUserAuthorize;
end;

function TDSCustomAuthenticationManager.GetValidateCertificateEvent: TValidateCertificate;
begin
  Result := FValidateCertificateEvent;
end;

function TDSCustomAuthenticationManager.HasUserAuthenticateEvent: boolean;
begin
  Result := Assigned(FOnUserAuthenticate);
end;

procedure TDSCustomAuthenticationManager.SetRoleItems(const Value: TDSRoleItems);
begin
  FRoleItems.Assign(Value);
end;

procedure TDSCustomAuthenticationManager.SetValidateCertificateEvent(
  const Event: TValidateCertificate);
begin
  FValidateCertificateEvent := Event;
end;

function TDSCustomAuthenticationManager.ValidatePeerCertificate(
  Certificate: TX509Certificate; const ADepth: Integer): boolean;
begin
  Result := true;
  if Assigned(FValidateCertificateEvent) then
    FValidateCertificateEvent(self, Certificate, ADepth, Result);
end;

function TDSCustomAuthenticationManager.Authenticate(const Protocol,
  Context: string; const AuthUserName, AuthPassword: string;
  const Request: TObject; const Response: TObject): Boolean;
var
  user: string;
  password: string;
  UserRoles: TStrings;
begin
  user := AuthUsername;
  password := AuthPassword;
  UserRoles := SessionUserRoles;
  if UserRoles <> nil then
    Result := Authenticate(nil, Protocol, Context, user, password, UserRoles)
  else
    Result := Authenticate(nil, Protocol, Context, user, password);
end;


function TDSCustomAuthenticationManager.Authenticate(const AuthenticateEventObject: TDSAuthenticateEventObject;
  connectionProps: TDBXProperties): boolean;
var
  userName: string;
  userPass: string;
  protocol: string;
  UserRoles: TStrings;
begin
  if not HasUserAuthenticateEvent then
    // nobody is listening - connection allowed
    exit(true);

  userName := connectionProps.Values[TDBXPropertyNames.DSAuthenticationUser];
  userPass := connectionProps.Values[TDBXPropertyNames.DSAuthenticationPassword];
  protocol := connectionProps.Values[TDBXPropertyNames.CommunicationProtocol];
  UserRoles := SessionUserRoles;
  if UserRoles <> nil then
    Result := Authenticate(AuthenticateEventObject, protocol, EmptyStr, userName, userPass, UserRoles)
  else
    Result := Authenticate(AuthenticateEventObject, protocol, EmptyStr, userName, userPass)
end;

end.
