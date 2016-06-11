{*******************************************************}
{                                                       }
{             Delphi REST Client Framework              }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit REST.Authenticator.Simple;

interface

uses
  System.Classes,
  Data.Bind.ObjectScope, Data.Bind.Components,
  REST.Types,
  REST.Client,
  REST.Consts,
  REST.BindSource;

type
  TSubSimpleAuthenticationBindSource = class;

  /// <summary>
  /// implements a simple authentication using an username and a password as
  /// GET or POST - parameters
  /// </summary>
  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32 or pidiOSSimulator or pidiOSDevice or pidiOSDevice64 or pidAndroid)]
  TSimpleAuthenticator = class(TCustomAuthenticator)
  private
    FBindSource: TSubSimpleAuthenticationBindSource;
    FUsernameKey: string;
    FUsername: string;
    FPasswordKey: string;
    FPassword: string;
    procedure SetPassword(const AValue: string);
    procedure SetPasswordKey(const AValue: string);
    procedure SetUsername(const AValue: string);
    procedure SetUsernameKey(const AValue: string);
  protected

    procedure DoAuthenticate(ARequest: TCustomRESTRequest); override;
    function CreateBindSource: TBaseObjectBindSource; override;
  public
    constructor Create(const AUsernameKey, AUsername, APasswordKey, APassword: string); reintroduce; overload;

    /// <summary>
    /// Resets a request to default values and clears all entries.
    /// </summary>
    procedure ResetToDefaults; override;
  published
    property UsernameKey: string read FUsernameKey write SetUsernameKey;
    property Username: string read FUsername write SetUsername;
    property PasswordKey: string read FPasswordKey write SetPasswordKey;
    property Password: string read FPassword write SetPassword;

    property BindSource: TSubSimpleAuthenticationBindSource read FBindSource;
  end;

  /// <summary>
  /// LiveBindings bindsource for TSimpleAuthenticator. Publishes subcomponent properties.
  /// </summary>
  TSubSimpleAuthenticationBindSource = class(TRESTAuthenticatorBindSource<TSimpleAuthenticator>)
  protected
    function CreateAdapterT: TRESTAuthenticatorAdapter<TSimpleAuthenticator>; override;
  end;

  /// <summary>
  /// LiveBindings adapter for TSimpleAuthenticator. Create bindable members.
  /// </summary>
  TSimpleAuthenticatorAdapter = class(TRESTAuthenticatorAdapter<TSimpleAuthenticator>)
  protected
    procedure AddFields; override;
  end;

implementation

{ TSimpleAuthenticator }

constructor TSimpleAuthenticator.Create(const AUsernameKey, AUsername, APasswordKey, APassword: string);
begin
  Create(NIL);

  FUsernameKey := AUsernameKey;
  FUsername := AUsername;
  FPasswordKey := APasswordKey;
  FPassword := APassword;
end;

function TSimpleAuthenticator.CreateBindSource: TBaseObjectBindSource;
begin
  FBindSource := TSubSimpleAuthenticationBindSource.Create(Self);
  FBindSource.Name := 'BindSource'; { Do not localize }
  FBindSource.SetSubComponent(True);
  FBindSource.Authenticator := Self;

  result := FBindSource;
end;

procedure TSimpleAuthenticator.DoAuthenticate(ARequest: TCustomRESTRequest);
begin
  inherited;

  ARequest.Params.BeginUpdate;
  try
    ARequest.AddAuthParameter(FUsernameKey, FUsername, TRESTRequestParameterKind.pkGETorPOST);
    ARequest.AddAuthParameter(FPasswordKey, FPassword, TRESTRequestParameterKind.pkGETorPOST);
  finally
    ARequest.Params.EndUpdate;
  end;
end;

procedure TSimpleAuthenticator.ResetToDefaults;
begin
  inherited;

  UsernameKey := '';
  Username := '';
  PasswordKey := '';
  Password := '';
end;

procedure TSimpleAuthenticator.SetPassword(const AValue: string);
begin
  if (AValue <> FPassword) then
  begin
    FPassword := AValue;
    PropertyValueChanged;
  end;
end;

procedure TSimpleAuthenticator.SetPasswordKey(const AValue: string);
begin
  if (AValue <> FPasswordKey) then
  begin
    FPasswordKey := AValue;
    PropertyValueChanged;
  end;
end;

procedure TSimpleAuthenticator.SetUsername(const AValue: string);
begin
  if (AValue <> FUsername) then
  begin
    FUsername := AValue;
    PropertyValueChanged;
  end;
end;

procedure TSimpleAuthenticator.SetUsernameKey(const AValue: string);
begin
  if (AValue <> FUsernameKey) then
  begin
    FUsernameKey := AValue;
    PropertyValueChanged;
  end;
end;

{ TSubSimpleAuthenticationBindSource }

function TSubSimpleAuthenticationBindSource.CreateAdapterT: TRESTAuthenticatorAdapter<TSimpleAuthenticator>;
begin
  result := TSimpleAuthenticatorAdapter.Create(Self);
end;

{ TSimpleAuthenticatorAdapter }

procedure TSimpleAuthenticatorAdapter.AddFields;
const
  sUserName = 'UserName';
  sUserNameKey = 'UserNameKey';
  sPassword = 'Password';
  sPasswordKey = 'PasswordKey';
var
  LGetMemberObject: IGetMemberObject;
begin
  CheckInactive;
  ClearFields;
  if Authenticator <> nil then
  begin
    LGetMemberObject := TBindSourceAdapterGetMemberObject.Create(Self);

    CreateReadWriteField<string>(sUserName, LGetMemberObject, TScopeMemberType.mtText,
      function: string
      begin
        result := Authenticator.Username;
      end,
      procedure(AValue: string)
      begin
        Authenticator.Username := AValue;
      end);
    CreateReadWriteField<string>(sUserNameKey, LGetMemberObject, TScopeMemberType.mtText,
      function: string
      begin
        result := Authenticator.UsernameKey;
      end,
      procedure(AValue: string)
      begin
        Authenticator.UsernameKey := AValue;
      end);

    CreateReadWriteField<string>(sPassword, LGetMemberObject, TScopeMemberType.mtText,
      function: string
      begin
        result := Authenticator.Password;
      end,
      procedure(AValue: string)
      begin
        Authenticator.Password := AValue;
      end);
    CreateReadWriteField<string>(sPasswordKey, LGetMemberObject, TScopeMemberType.mtText,
      function: string
      begin
        result := Authenticator.PasswordKey;
      end,
      procedure(AValue: string)
      begin
        Authenticator.PasswordKey := AValue;
      end);

  end;
end;

end.
