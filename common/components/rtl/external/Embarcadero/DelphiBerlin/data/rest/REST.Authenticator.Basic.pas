{*******************************************************}
{                                                       }
{             Delphi REST Client Framework              }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit REST.Authenticator.Basic;

interface

uses
  System.Classes,
  Data.Bind.ObjectScope, Data.Bind.Components,
  REST.Types,
  REST.Consts,
  REST.Client,
  REST.Utils,
  REST.BindSource;

type
  TSubHTTPBasicAuthenticationBindSource = class;

  /// <summary>
  /// implements the "http basic authentication", according to RFC 2617 an username and a password are encoded to
  /// base64 and embedded into the http-header of the request
  /// </summary>
  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32 or pidiOSSimulator or pidiOSDevice or pidiOSDevice64 or pidAndroid)]
  THTTPBasicAuthenticator = class(TCustomAuthenticator)
  protected
    FBindSource: TSubHTTPBasicAuthenticationBindSource;
    function CreateBindSource: TBaseObjectBindSource; override;
  private
    FUsername: string;
    FPassword: string;
  protected
    procedure SetPassword(const AValue: string); virtual;
    procedure SetUsername(const AValue: string); virtual;

    procedure DoAuthenticate(ARequest: TCustomRESTRequest); override;
  public
    constructor Create(const AUsername, APassword: string); reintroduce; overload;

    /// <summary>
    /// Resets a request to default values and clears all entries.
    /// </summary>
    procedure ResetToDefaults; override;
  published
    property Username: string read FUsername write SetUsername;
    property Password: string read FPassword write SetPassword;

    property BindSource: TSubHTTPBasicAuthenticationBindSource read FBindSource;
  end;

  /// <summary>
  /// LiveBindings bindsource for THTTPBasicAuthenticator.  Publishes subcomponent properties.
  /// </summary>
  TSubHTTPBasicAuthenticationBindSource = class(TRESTAuthenticatorBindSource<THTTPBasicAuthenticator>)
  protected
    function CreateAdapterT: TRESTAuthenticatorAdapter<THTTPBasicAuthenticator>; override;
  end;

  /// <summary>
  /// LiveBindings adapter for THTTPBasicAuthenticator. Create bindable members.
  /// </summary>
  THTTPBasicAuthenticatorAdapter = class(TRESTAuthenticatorAdapter<THTTPBasicAuthenticator>)
  protected
    procedure AddFields; override;
  end;

implementation

uses
  System.SysUtils,
  REST.HttpClient;

{ THTTPBasicAuthenticator }

constructor THTTPBasicAuthenticator.Create(const AUsername, APassword: string);
begin
  Create(NIL);

  FUsername := AUsername;
  FPassword := APassword;
end;

function THTTPBasicAuthenticator.CreateBindSource: TBaseObjectBindSource;
begin
  FBindSource := TSubHTTPBasicAuthenticationBindSource.Create(Self);
  FBindSource.Name := 'BindSource'; { Do not localize }
  FBindSource.SetSubComponent(True);
  FBindSource.Authenticator := Self;

  result := FBindSource;
end;

procedure THTTPBasicAuthenticator.DoAuthenticate(ARequest: TCustomRESTRequest);
var
  LAuthValue: string;
begin
  inherited;
  LAuthValue := TRESTHTTPProcs.CreateBasicAuthenticationString(
    ARequest.Client.IPImplementationID, FUsername, FPassword);
  ARequest.AddAuthParameter(HTTP_HEADERFIELD_AUTH, LAuthValue, TRESTRequestParameterKind.pkHTTPHEADER,
    [TRESTRequestParameterOption.poDoNotEncode]);
end;

procedure THTTPBasicAuthenticator.ResetToDefaults;
begin
  inherited;

  Username := '';
  Password := '';
end;

procedure THTTPBasicAuthenticator.SetPassword(const AValue: string);
begin
  if (AValue <> FPassword) then
  begin
    FPassword := AValue;
    PropertyValueChanged;
  end;
end;

procedure THTTPBasicAuthenticator.SetUsername(const AValue: string);
begin
  if (AValue <> FUsername) then
  begin
    FUsername := AValue;
    PropertyValueChanged;
  end;
end;

{ TSubHTTPBasicAuthenticationBindSource }

function TSubHTTPBasicAuthenticationBindSource.CreateAdapterT: TRESTAuthenticatorAdapter<THTTPBasicAuthenticator>;
begin
  result := THTTPBasicAuthenticatorAdapter.Create(Self);
end;

{ THTTPBasicAuthenticatorAdapter }

procedure THTTPBasicAuthenticatorAdapter.AddFields;
const
  sUserName = 'UserName';
  sPassword = 'Password';
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
    CreateReadWriteField<string>(sPassword, LGetMemberObject, TScopeMemberType.mtText,
      function: string
      begin
        result := Authenticator.Password;
      end,
      procedure(AValue: string)
      begin
        Authenticator.Password := AValue;
      end);
  end;
end;

end.
