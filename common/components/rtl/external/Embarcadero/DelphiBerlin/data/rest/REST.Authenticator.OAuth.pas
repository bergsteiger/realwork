{*******************************************************}
{                                                       }
{             Delphi REST Client Framework              }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{$HPPEMIT LINKUNIT}
unit REST.Authenticator.OAuth;

interface

uses
  System.Classes,
  Data.Bind.ObjectScope, Data.Bind.Components,
  REST.Client,
  REST.Types,
  REST.Consts,
  REST.Utils,
  REST.BindSource;

{$SCOPEDENUMS ON}

type
  TOAuth1SignatureMethod = class;
  TOAuth1Authenticator = class;
  TOAuth2Authenticator = class;

  TOAuth1SignatureMethod = class(TPersistent)
  public
    class function GetName: string; virtual; abstract;
    function BuildSignature(ARequest: TCustomRESTRequest; AAuthenticator: TOAuth1Authenticator): string;
      virtual; abstract;
    property Name: string read GetName;
  end;

  TOAuth1SignatureMethodClass = class of TOAuth1SignatureMethod;

  TOAuth1SignatureMethod_PLAINTEXT = class(TOAuth1SignatureMethod)
  public
    class function GetName: string; override;
    function BuildSignature(ARequest: TCustomRESTRequest; AAuthenticator: TOAuth1Authenticator): string; override;
  end;

  TOAuth1SignatureMethod_HMAC_SHA1 = class(TOAuth1SignatureMethod)
  protected
    function Hash_HMAC_SHA1(const AData, AKey: string): string; virtual;
  public
    class function GetName: string; override;
    function BuildSignature(ARequest: TCustomRESTRequest; AAuthenticator: TOAuth1Authenticator): string; override;
  end;

  TSubOAuth1AuthenticationBindSource = class;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32 or pidiOSSimulator or pidiOSDevice or pidiOSDevice64 or pidAndroid)]
  TOAuth1Authenticator = class(TCustomAuthenticator)
  private
    FNonce: string;
    FSigningClass: TOAuth1SignatureMethod;
    FSigningClassName: string;
    FBindSource: TSubOAuth1AuthenticationBindSource;
    FTimestamp: string;
    FVersion: string;
    FAccessToken: string;
    FAccessTokenSecret: string;
    FAccessTokenEndpoint: string;
    FRequestTokenEndpoint: string;
    FAuthenticationEndpoint: string;
    FCallbackEndpoint: string;
    FConsumerKey: string;
    FConsumerSecret: string;
    FVerifierPIN: string;
    FRequestToken: string;
    FRequestTokenSecret: string;
    FIPImplementationID: string;
    procedure ReadConsumerSecret(Reader: TReader);
    procedure SetSigningClassName(const AValue: string);
    procedure SetSigningClass(const AValue: TOAuth1SignatureMethod);
    procedure SetAccessToken(const AValue: string);
    procedure SetAccessTokenEndpoint(const AValue: string);
    procedure SetAccessTokenSecret(const AValue: string);
    procedure SetAuthenticationEndpoint(const AValue: string);
    procedure SetCallbackEndpoint(const AValue: string);
    procedure SetConsumerSecret(const AValue: string);
    procedure SetConsumerKey(const AValue: string);
    procedure SetRequestToken(const AValue: string);
    procedure SetRequestTokenEndpoint(const AValue: string);
    procedure SetRequestTokenSecret(const AValue: string);
    procedure SetVerifierPIN(const AValue: string);
    function SigningClassNameIsStored: Boolean;
    procedure WriteConsumerSecret(Writer: TWriter);
    procedure AddCommonAuthParameters(const Params: TStrings; const QuoteChar: string);
  protected
    function CreateBindSource: TBaseObjectBindSource; override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure DoAuthenticate(ARequest: TCustomRESTRequest); override;
    /// <summary>
    /// creates a 32 characters long unique string that will be used internally to identify a request
    /// </summary>
    class function GenerateNonce: string; virtual;
    /// <summary>
    /// creates the signature for OAuth1.0 requests
    /// </summary>
    function GenerateSignature(ARequest: TCustomRESTRequest): string; virtual;
    class function GenerateTimeStamp: string; virtual;
    function GetSignatureMethod: string; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(ASource: TOAuth1Authenticator); reintroduce;
    /// <summary>
    /// Resets all values of the authenticator to default values - empty strings in most cases.
    /// </summary>
    procedure ResetToDefaults; override;
    /// <summary>
    /// A random, unique string for each request. Automatically maintained by the authenticator-class.
    /// </summary>
    property Nonce: string read FNonce;
    property SignatureMethod: string read GetSignatureMethod;
    /// <summary>
    /// Timestamp of the current request. Automatically maintained by the authenticator-class.
    /// </summary>
    property Timestamp: string read FTimestamp;
    /// <summary>
    /// Version of OAuth that this Authenticator supports (is always 1.0(a))
    /// </summary>
    property Version: string read FVersion;

    property SigningClass: TOAuth1SignatureMethod read FSigningClass write SetSigningClass;
  published
    /// <summary>
    /// the access-token provided by the service-provider. this value is used to sign the requests
    /// </summary>
    property AccessToken: string read FAccessToken write SetAccessToken;
    /// <summary>
    /// the access-token-secret provided by the service-provider. this value is used to sign the requests
    /// </summary>
    property AccessTokenSecret: string read FAccessTokenSecret write SetAccessTokenSecret;
    /// <summary>
    /// the request-token provided by the service-provider. a request-token is always
    /// a temporary token and must be changed to an access-token. after successfully
    /// requesting the access-token, the request-token becomes invalid.
    /// </summary>
    property RequestToken: string read FRequestToken write SetRequestToken;
    property RequestTokenSecret: string read FRequestTokenSecret write SetRequestTokenSecret;

    /// <summary>
    /// Complete address to the endpoint of the service-provider where an access-token can be obtained
    /// </summary>
    property AccessTokenEndpoint: string read FAccessTokenEndpoint write SetAccessTokenEndpoint;
    /// <summary>
    /// Complete address to the endpoint of the service-provider where an request-token can be obtained
    /// </summary>
    property RequestTokenEndpoint: string read FRequestTokenEndpoint write SetRequestTokenEndpoint;
    /// <summary>
    /// Complete address to the endpoint of the service-provider where the authentication can be done
    /// </summary>
    property AuthenticationEndpoint: string read FAuthenticationEndpoint write SetAuthenticationEndpoint;
    /// <summary>
    /// Complete address to the endpoint for redirecting the user to after authentication
    /// </summary>
    property CallbackEndpoint: string read FCallbackEndpoint write SetCallbackEndpoint;
    /// <summary>
    /// The consumer-key (or "client-id" or "app-id") is provided by the service-provider after registering an application
    /// </summary>
    property ConsumerKey: string read FConsumerKey write SetConsumerKey;
    /// <summary>
    /// The consumer-secret (or client-secret or app-secret) is provided by the service-provider after registering an application. DO NOT SHARE THIS VALUE.
    /// </summary>
    property ConsumerSecret: string read FConsumerSecret write SetConsumerSecret;
    property SigningClassName: string read FSigningClassName write SetSigningClassName stored SigningClassNameIsStored;
    /// <summary>
    /// The verifier ("pin", "auth-code") is used to change a request-token into an access-token and is provided by the service-provider.
    /// after changing the tokens, this value becomes invalid.
    /// </summary>
    property VerifierPIN: string read FVerifierPIN write SetVerifierPIN;
    /// <summary>
    /// HTTP abstraction implementation ID
    /// </summary>
    property IPImplementationID: string read FIPImplementationID write FIPImplementationID;

    property BindSource: TSubOAuth1AuthenticationBindSource read FBindSource;
  end;

  /// <summary>
  /// LiveBindings bindsource for TOAuth1Authenticator. Publishes subcomponent properties.
  /// </summary>
  TSubOAuth1AuthenticationBindSource = class(TRESTAuthenticatorBindSource<TOAuth1Authenticator>)
  protected
    function CreateAdapterT: TRESTAuthenticatorAdapter<TOAuth1Authenticator>; override;
  end;

  /// <summary>
  /// LiveBindings adapter for TOAuth1Authenticator. Create bindable members.
  /// </summary>
  TOAuth1AuthenticatorAdapter = class(TRESTAuthenticatorAdapter<TOAuth1Authenticator>)
  protected
    procedure AddFields; override;
  end;

  TOAuth2ResponseType = (
    /// <summary>
    /// Default workflow including the authentication of the client
    /// </summary>
    rtCODE,
    /// <summary>
    /// Implicit workflow for direct requesting an accesstoken
    /// </summary>
    rtTOKEN);

  TOAuth2TokenType = (ttNONE, ttBEARER);

  /// <summary> Base OAuth exception class replacing non-standard named TOAuth2Exception </summary>
  EOAuth2Exception = class(ERESTException);
  TOAuth2Exception = EOAuth2Exception deprecated 'use EOAuth2Exception'; // do not localize

  TSubOAuth2AuthenticationBindSource = class;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32 or pidiOSSimulator or pidiOSDevice or pidiOSDevice64 or pidAndroid)]
  TOAuth2Authenticator = class(TCustomAuthenticator)
  private
    FBindSource: TSubOAuth2AuthenticationBindSource;
    FAccessToken: string;
    FAccessTokenEndpoint: string;
    FAccessTokenExpiry: TDateTime;
    FAccessTokenParamName: string;
    FAuthCode: string;
    FAuthorizationEndpoint: string;
    FClientID: string;
    FClientSecret: string;
    FLocalState: string;
    FRedirectionEndpoint: string;
    FRefreshToken: string;
    FResponseType: TOAuth2ResponseType;
    FScope: string;
    FTokenType: TOAuth2TokenType;
    procedure SetAccessTokenEndpoint(const AValue: string);
    procedure SetAccessTokenParamName(const AValue: string);
    procedure SetAuthCode(const AValue: string);
    procedure SetAuthorizationEndpoint(const AValue: string);
    procedure SetClientID(const AValue: string);
    procedure SetClientSecret(const AValue: string);
    procedure SetLocalState(const AValue: string);
    procedure SetRedirectionEndpoint(const AValue: string);
    procedure SetRefreshToken(const AValue: string);
    procedure SetResponseType(const AValue: TOAuth2ResponseType);
    procedure SetScope(const AValue: string);
    function ResponseTypeIsStored: Boolean;
    function TokenTypeIsStored: Boolean;
    function AccessTokenParamNameIsStored: Boolean;
    procedure ReadAccessTokenExpiryData(AReader: TReader);
    procedure SetAccessToken(const AValue: string);
    procedure SetAccessTokenExpiry(const AExpiry: TDateTime);
    procedure SetTokenType(const AType: TOAuth2TokenType);
    procedure WriteAccessTokenExpiryData(AWriter: TWriter);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure DoAuthenticate(ARequest: TCustomRESTRequest); override;
    function CreateBindSource: TBaseObjectBindSource; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Assign(ASource: TOAuth2Authenticator); reintroduce;
    function AuthorizationRequestURI: string;
    procedure ChangeAuthCodeToAccesToken;
    /// <summary>
    /// Resets a request to default values and clears all entries.
    /// </summary>
    procedure ResetToDefaults; override;
  published
    property AccessToken: string read FAccessToken write SetAccessToken;
    property AccessTokenEndpoint: string read FAccessTokenEndpoint write SetAccessTokenEndpoint;
    property AccessTokenExpiry: TDateTime read FAccessTokenExpiry write SetAccessTokenExpiry;
    property AccessTokenParamName: string read FAccessTokenParamName write SetAccessTokenParamName stored AccessTokenParamNameIsStored;
    property AuthCode: string read FAuthCode write SetAuthCode;
    property AuthorizationEndpoint: string read FAuthorizationEndpoint write SetAuthorizationEndpoint;
    property ClientID: string read FClientID write SetClientID;
    property ClientSecret: string read FClientSecret write SetClientSecret;
    property LocalState: string read FLocalState write SetLocalState;
    property RedirectionEndpoint: string read FRedirectionEndpoint write SetRedirectionEndpoint;
    property RefreshToken: string read FRefreshToken write SetRefreshToken;
    property ResponseType: TOAuth2ResponseType read FResponseType write SetResponseType stored ResponseTypeIsStored;
    property Scope: string read FScope write SetScope;
    property TokenType: TOAuth2TokenType read FTokenType write SetTokenType stored TokenTypeIsStored;

    property BindSource: TSubOAuth2AuthenticationBindSource read FBindSource;
  end;

  /// <summary>
  /// LiveBindings bindsource for TOAuth2Authenticator. Publishes subcomponent properties.
  /// </summary>
  TSubOAuth2AuthenticationBindSource = class(TRESTAuthenticatorBindSource<TOAuth2Authenticator>)
  protected
    function CreateAdapterT: TRESTAuthenticatorAdapter<TOAuth2Authenticator>; override;
  end;

  /// <summary>
  /// LiveBindings adapter for TOAuth2Authenticator. Create bindable members.
  /// </summary>
  TOAuth2AuthenticatorAdapter = class(TRESTAuthenticatorAdapter<TOAuth2Authenticator>)
  protected
    procedure AddFields; override;
  end;

function OAuth2ResponseTypeToString(const AType: TOAuth2ResponseType): string;
function OAuth2ResponseTypeFromString(const ATypeString: string): TOAuth2ResponseType;

function OAuth2TokenTypeToString(const AType: TOAuth2TokenType): string;
function OAuth2TokenTypeFromString(const ATypeString: string): TOAuth2TokenType;

var
  DefaultOAuth1SignatureClass: TOAuth1SignatureMethodClass = TOAuth1SignatureMethod_HMAC_SHA1;
  DefaultOAuth2ResponseType: TOAuth2ResponseType = TOAuth2ResponseType.rtCODE;
  DefaultOAuth2TokenType: TOAuth2TokenType = TOAuth2TokenType.ttNONE;
  DefaultOAuth2AccessTokenParamName: string = 'access_token'; // do not localize

implementation

uses
  System.SysUtils, System.DateUtils,
  System.NetEncoding, System.Hash,
  REST.HttpClient;

function OAuth2ResponseTypeToString(const AType: TOAuth2ResponseType): string;
begin
  case AType of
    TOAuth2ResponseType.rtCODE:
      result := 'code'; // do not localize
    TOAuth2ResponseType.rtTOKEN:
      result := 'token'; // do not localize
  else
    result := ''; // do not localize
  end;
end;

function OAuth2ResponseTypeFromString(const ATypeString: string): TOAuth2ResponseType;
var
  LType: TOAuth2ResponseType;
begin
  result := DefaultOAuth2ResponseType;

  for LType IN [Low(TOAuth2ResponseType) .. High(TOAuth2ResponseType)] do
  begin
    if SameText(ATypeString, OAuth2ResponseTypeToString(LType)) then
    begin
      result := LType;
      BREAK;
    end;
  end;
end;

function OAuth2TokenTypeToString(const AType: TOAuth2TokenType): string;
begin
  case AType of
    TOAuth2TokenType.ttBEARER:
      result := 'bearer'; // do not localize
  else
    result := ''; // do not localize
  end;
end;

function OAuth2TokenTypeFromString(const ATypeString: string): TOAuth2TokenType;
var
  LType: TOAuth2TokenType;
begin
  result := DefaultOAuth2TokenType;

  for LType IN [Low(TOAuth2TokenType) .. High(TOAuth2TokenType)] do
  begin
    if SameText(ATypeString, OAuth2TokenTypeToString(LType)) then
    begin
      result := LType;
      BREAK;
    end;
  end;
end;

{ TOAuth1SignatureMethod_PLAINTEXT }

function TOAuth1SignatureMethod_PLAINTEXT.BuildSignature(ARequest: TCustomRESTRequest;
  AAuthenticator: TOAuth1Authenticator): string;
begin
  (*
    oauth_signature is set to the concatenated encoded values
    of the Consumer Secret and Token Secret, separated by a ‘&’
    character (ASCII code 38), even if either secret is empty.
    The result MUST be encoded again.
  *)
  result := URIEncode(AAuthenticator.ConsumerSecret + #38 + AAuthenticator.AccessTokenSecret);
end;

class function TOAuth1SignatureMethod_PLAINTEXT.GetName: string;
begin
  result := 'PLAINTEXT'; // do not localize
end;

{ TOAuthSignatureMethod_HMAC_SHA1 }

function TOAuth1SignatureMethod_HMAC_SHA1.BuildSignature(ARequest: TCustomRESTRequest;
  AAuthenticator: TOAuth1Authenticator): string;
var
  LPayLoadParams: TRESTRequestParameterArray;
  LParamList: TStringList;
  LURL: string;
  LParamsStr: string;
  LSigBaseStr: string;
  LSigningKey: string;
  LParam: TRESTRequestParameter;
begin
  Assert(Assigned(ARequest) and Assigned(AAuthenticator));

  Result := '';

  // This code is duplicated.  Use common representation of name/value pairs.  Don't build the same list in two places.

  // Step #1 - collect all relevant parameters, this includes
  // all oauth_params as well as the params from the payload
  // (payload-params ==> params from client and request)
  LParamList := TStringList.Create;
  try
    AAuthenticator.AddCommonAuthParameters(LParamList, '');
    // now collect the parameters from the payload. we do need the
    // union of the client-parameters and the request-parameters
    LPayLoadParams := ARequest.CreateUnionParameterList;
    for LParam in LPayLoadParams do
    begin
      if (LParam.Kind = TRESTRequestParameterKind.pkGETorPOST) then
        LParamList.Values[LParam.Name] := URIEncode(LParam.Value);
    end;

    // OAuth-spec requires the parameters to be sorted by their name
    LParamList.Sort;

    LParamList.LineBreak := '&';

    // Step #2 - build a single string from the params
    LParamsStr := LParamList.Text;
    // Remove the trailing "linebreak" '&' character.
    LParamsStr := LParamsStr.Remove(Length(LParamsStr) - Length(LParamList.LineBreak));
  finally
    LParamList.Free;
  end;

  // as per oauth-spec we do need the full URL without (!) any query-params
  LURL := ARequest.GetFullRequestURL(FALSE);

  // Step #3 - build the SignatureBaseString, the LSigningKey and the Signature
  LSigBaseStr := UpperCase(RESTRequestMethodToString(ARequest.Method)) + '&' + URIEncode(LURL) + '&' +
    URIEncode(LParamsStr); // do not localize

  LSigningKey := AAuthenticator.ConsumerSecret + '&';

  if AAuthenticator.AccessTokenSecret <> '' then
    LSigningKey := LSigningKey + AAuthenticator.AccessTokenSecret // do not localize
  else if AAuthenticator.RequestTokenSecret <> '' then
    LSigningKey := LSigningKey + AAuthenticator.RequestTokenSecret; // do not localize

  Result := Hash_HMAC_SHA1(LSigBaseStr, LSigningKey);
end;

class function TOAuth1SignatureMethod_HMAC_SHA1.GetName: string;
begin
  result := 'HMAC-SHA1'; // do not localize
end;

function TOAuth1SignatureMethod_HMAC_SHA1.Hash_HMAC_SHA1(const AData, AKey: string): string;
begin
  Result := TRESTHTTPProcs.HashHMACSHA1(AData, AKey);
end;

procedure TOAuth1Authenticator.AddCommonAuthParameters(const Params: TStrings; const QuoteChar: string);

  function FormatValue(const Value, QuoteChar: string): string; inline;
  begin
    Result := QuoteChar + URIEncode(Value) + QuoteChar;
  end;

begin
  if CallbackEndpoint <> '' then
    Params.Values['oauth_callback'] := FormatValue(CallbackEndpoint, QuoteChar); // do not localize
  if ConsumerKey <> '' then
    Params.Values['oauth_consumer_key'] := FormatValue(ConsumerKey, QuoteChar); // do not localize
  Params.Values['oauth_nonce'] := FormatValue(Nonce, QuoteChar); // do not localize
  Params.Values['oauth_signature_method'] := FormatValue(SignatureMethod, QuoteChar); // do not localize
  Params.Values['oauth_timestamp'] := FormatValue(Timestamp, QuoteChar); // do not localize
  if AccessToken <> '' then
    Params.Values['oauth_token'] := FormatValue(AccessToken, QuoteChar)  // do not localize
  else if RequestToken <> '' then
    Params.Values['oauth_token'] := FormatValue(RequestToken, QuoteChar); // do not localize
  if VerifierPIN <> '' then
    Params.Values['oauth_verifier'] := FormatValue(VerifierPIN, QuoteChar); // do not localize
  Params.Values['oauth_version'] := FormatValue(Version, QuoteChar); // do not localize
end;

procedure TOAuth1Authenticator.Assign(ASource: TOAuth1Authenticator);
begin
  ResetToDefaults;

  AccessTokenEndpoint := ASource.AccessTokenEndpoint;
  RequestTokenEndpoint := ASource.RequestTokenEndpoint;
  AuthenticationEndpoint := ASource.AuthenticationEndpoint;
  CallbackEndpoint := ASource.CallbackEndpoint;

  AccessToken := ASource.AccessToken;
  AccessTokenSecret := ASource.AccessTokenSecret;
  RequestToken := ASource.RequestToken;
  RequestTokenSecret := ASource.RequestTokenSecret;

  VerifierPIN := ASource.VerifierPIN;

  ConsumerKey := ASource.ConsumerKey;
  ConsumerSecret := ASource.ConsumerSecret;
  SigningClassName := ASource.SigningClassName;
end;

constructor TOAuth1Authenticator.Create(AOwner: TComponent);
begin
  inherited;
  ResetToDefaults;
  FVersion := '1.0';
end;

function TOAuth1Authenticator.CreateBindSource: TBaseObjectBindSource;
begin
  FBindSource := TSubOAuth1AuthenticationBindSource.Create(self);
  FBindSource.Name := 'BindSource'; { Do not localize }
  FBindSource.SetSubComponent(True);
  FBindSource.Authenticator := self;

  Result := FBindSource;
end;

procedure TOAuth1Authenticator.DefineProperties(Filer: TFiler);

  function DesignerDataStored: Boolean;
  begin
    if Filer.Ancestor <> nil then
      Result := TOAuth1Authenticator(Filer.Ancestor).ConsumerSecret <> ConsumerSecret
    else
      Result := ConsumerSecret <> '';
  end;

begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('ConsumerSecrect', ReadConsumerSecret, WriteConsumerSecret, DesignerDataStored);
end;

destructor TOAuth1Authenticator.Destroy;
begin
  FreeAndNil(FSigningClass);

  inherited Destroy;
end;

{ TOAuth1Authenticator }

procedure TOAuth1Authenticator.DoAuthenticate(ARequest: TCustomRESTRequest);
var
  LToken: string;
  LTokenBuilder: TStringList;
begin
  // update timestamp and nonce for this request
  // --> these values must not change while a request is running
  FNonce := GenerateNonce;
  FTimestamp := GenerateTimeStamp;

  LTokenBuilder := TStringList.Create;
  try

    AddCommonAuthParameters(LTokenBuilder, '"');

    LTokenBuilder.Values['oauth_timestamp'] := Format('"%s"', [URIEncode(Timestamp)]);
    LTokenBuilder.Values['oauth_signature'] := Format('"%s"', [URIEncode(GenerateSignature(ARequest))]);

    LTokenBuilder.Sort;

    LTokenBuilder.LineBreak := ', ';
    LToken := 'OAuth ' + LTokenBuilder.Text; // do not localize, trailing space IS important
    LToken := LToken.Remove(Length(LToken) - Length(LTokenBuilder.LineBreak));

    ARequest.AddAuthParameter(HTTP_HEADERFIELD_AUTH, LToken, TRESTRequestParameterKind.pkHTTPHEADER,
      [TRESTRequestParameterOption.poDoNotEncode]);
  finally
    LTokenBuilder.Free;
  end;
end;

class function TOAuth1Authenticator.GenerateNonce: string;
begin
  Result := TRESTHTTPProcs.HashStringAsHex('', GenerateTimeStamp + IntToStr(Random(MAXINT)));
end;

function TOAuth1Authenticator.GenerateSignature(ARequest: TCustomRESTRequest): string;
begin
  Assert(Assigned(FSigningClass));

  Result := FSigningClass.BuildSignature(ARequest, self);
end;

class function TOAuth1Authenticator.GenerateTimeStamp: string;
begin
  Result := IntToStr(DateTimeToUnix(TTimeZone.Local.ToUniversalTime(Now)));
end;

function TOAuth1Authenticator.GetSignatureMethod: string;
begin
  Result := FSigningClass.Name;
end;

procedure TOAuth1Authenticator.ReadConsumerSecret(Reader: TReader);
begin
  ConsumerSecret := Reader.ReadString;
end;

procedure TOAuth1Authenticator.ResetToDefaults;
begin
  inherited;

  FreeAndNil(FSigningClass);

  FSigningClassName := DefaultOAuth1SignatureClass.ClassName;
  FSigningClass := DefaultOAuth1SignatureClass.Create;

  FAccessTokenEndpoint := '';
  FRequestTokenEndpoint := '';
  FAuthenticationEndpoint := '';
  FCallbackEndpoint := '';

  FAccessToken := '';
  FAccessTokenSecret := '';
  FRequestToken := '';
  FRequestTokenSecret := '';
  FVerifierPIN := '';

  FConsumerKey := '';
  FConsumerSecret := '';

  FNonce := GenerateNonce;
  FTimestamp := GenerateTimeStamp;
end;

procedure TOAuth1Authenticator.SetAccessToken(const AValue: string);
begin
  if AValue <> FAccessToken then
  begin
    FAccessToken := AValue;
    PropertyValueChanged;
  end;
end;

procedure TOAuth1Authenticator.SetAccessTokenEndpoint(const AValue: string);
begin
  if AValue <> FAccessTokenEndpoint then
  begin
    FAccessTokenEndpoint := AValue;
    PropertyValueChanged;
  end;
end;

procedure TOAuth1Authenticator.SetAccessTokenSecret(const AValue: string);
begin
  if AValue <> FAccessTokenSecret then
  begin
    FAccessTokenSecret := AValue;
    PropertyValueChanged;
  end;
end;

procedure TOAuth1Authenticator.SetAuthenticationEndpoint(const AValue: string);
begin
  if AValue <> FAuthenticationEndpoint then
  begin
    FAuthenticationEndpoint := AValue;
    PropertyValueChanged;
  end;
end;

procedure TOAuth1Authenticator.SetCallbackEndpoint(const AValue: string);
begin
  if AValue <> FCallbackEndpoint then
  begin
    FCallbackEndpoint := AValue;
    PropertyValueChanged;
  end;
end;

procedure TOAuth1Authenticator.SetConsumerSecret(const AValue: string);
begin
  if AValue <> FConsumerSecret then
  begin
    FConsumerSecret := AValue;
    PropertyValueChanged;
  end;
end;

procedure TOAuth1Authenticator.SetConsumerKey(const AValue: string);
begin
  if AValue <> FConsumerKey then
  begin
    FConsumerKey := AValue;
    PropertyValueChanged;
  end;
end;

procedure TOAuth1Authenticator.SetRequestToken(const AValue: string);
begin
  if AValue <> FRequestToken then
  begin
    FRequestToken := AValue;
    PropertyValueChanged;
  end;
end;

procedure TOAuth1Authenticator.SetRequestTokenEndpoint(const AValue: string);
begin
  if AValue <> FRequestTokenEndpoint then
  begin
    FRequestTokenEndpoint := AValue;
    PropertyValueChanged;
  end;
end;

procedure TOAuth1Authenticator.SetRequestTokenSecret(const AValue: string);
begin
  if (AValue <> FRequestTokenSecret) then
  begin
    FRequestTokenSecret := AValue;
    PropertyValueChanged;
  end;
end;

procedure TOAuth1Authenticator.SetSigningClass(const AValue: TOAuth1SignatureMethod);
begin
  if AValue <> FSigningClass then
  begin
    FreeAndNil(FSigningClass);

    FSigningClass := AValue;

    if FSigningClass <> nil then
      FSigningClassName := FSigningClass.ClassName
    else
      FSigningClassName := '';
  end;
end;

procedure TOAuth1Authenticator.SetSigningClassName(const AValue: string);
var
  LFinder: TClassFinder;
  LSignClass: TPersistentClass;
begin
  if AValue <> FSigningClassName then
  begin
    FSigningClassName := AValue;

    // we want to allow "PLAINTEXT" or "HMAC-SHA1" as names and
    // translate them into the correct classnames
    if SameText(FSigningClassName, TOAuth1SignatureMethod_PLAINTEXT.GetName) then
      FSigningClassName := TOAuth1SignatureMethod_PLAINTEXT.ClassName
    else if SameText(FSigningClassName, TOAuth1SignatureMethod_HMAC_SHA1.GetName) then
      FSigningClassName := TOAuth1SignatureMethod_HMAC_SHA1.ClassName;

    FreeAndNil(FSigningClass);

    LFinder := TClassFinder.Create;
    try
      LSignClass := LFinder.GetClass(FSigningClassName);
      if LSignClass <> nil then
        FSigningClass := TOAuth1SignatureMethod(LSignClass.Create);
    finally
      FreeAndNil(LFinder);
    end;
  end;
end;

procedure TOAuth1Authenticator.SetVerifierPIN(const AValue: string);
begin
  if AValue <> FVerifierPIN then
  begin
    FVerifierPIN := AValue;
    PropertyValueChanged;
  end;
end;

function TOAuth1Authenticator.SigningClassNameIsStored: Boolean;
begin
  Result := SigningClassName <> DefaultOAuth1SignatureClass.ClassName;
end;

procedure TOAuth1Authenticator.WriteConsumerSecret(Writer: TWriter);
begin
  Writer.WriteString(ConsumerSecret);
end;

{ TOAuth2Authenticator }

constructor TOAuth2Authenticator.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ResetToDefaults;
end;

function TOAuth2Authenticator.CreateBindSource: TBaseObjectBindSource;
begin
  FBindSource := TSubOAuth2AuthenticationBindSource.Create(self);
  FBindSource.Name := 'BindSource'; { Do not localize }
  FBindSource.SetSubComponent(True);
  FBindSource.Authenticator := self;

  Result := FBindSource;
end;

function TOAuth2Authenticator.AccessTokenParamNameIsStored: Boolean;
begin
  Result := AccessTokenParamName <> DefaultOAuth2AccessTokenParamName;
end;

procedure TOAuth2Authenticator.Assign(ASource: TOAuth2Authenticator);
begin
  ResetToDefaults;

  ClientID := ASource.ClientID;
  ClientSecret := ASource.ClientSecret;
  AuthCode := ASource.AuthCode;
  AccessToken := ASource.AccessToken;
  AccessTokenParamName := ASource.AccessTokenParamName;

  AccessTokenExpiry := ASource.AccessTokenExpiry;

  Scope := ASource.Scope;
  RefreshToken := ASource.RefreshToken;
  LocalState := ASource.LocalState;

  TokenType := ASource.TokenType;

  ResponseType := ASource.ResponseType;
  AuthorizationEndpoint := ASource.AuthorizationEndpoint;
  AccessTokenEndpoint := ASource.AccessTokenEndpoint;
  RedirectionEndpoint := ASource.RedirectionEndpoint;
end;

function TOAuth2Authenticator.AuthorizationRequestURI: string;
begin
  Result := FAuthorizationEndpoint;
  Result := Result + '?response_type=' + URIEncode(OAuth2ResponseTypeToString(FResponseType));
  if FClientID <> '' then
    Result := Result + '&client_id=' + URIEncode(FClientID);
  if FRedirectionEndpoint <> '' then
    Result := Result + '&redirect_uri=' + URIEncode(FRedirectionEndpoint);
  if FScope <> '' then
    Result := Result + '&scope=' + URIEncode(FScope);
end;

procedure TOAuth2Authenticator.ChangeAuthCodeToAccesToken;
var
  LClient: TRestClient;
  LRequest: TRESTRequest;
  LToken: string;
  LIntValue: int64;
begin

  // we do need an authorization-code here, because we want
  // to send it to the servce and exchange the code into an
  // access-token.
  if FAuthCode = '' then
    raise EOAuth2Exception.Create(SAuthorizationCodeNeeded);

  LClient := TRestClient.Create(FAccessTokenEndpoint);
  try
    LRequest := TRESTRequest.Create(LClient); // The LClient now "owns" the Request and will free it.
    LRequest.Method := TRESTRequestMethod.rmPOST;
    // LRequest.Client := LClient; // unnecessary since the client "owns" the request it will assign the client

    LRequest.AddAuthParameter('code', FAuthCode, TRESTRequestParameterKind.pkGETorPOST);
    LRequest.AddAuthParameter('client_id', FClientID, TRESTRequestParameterKind.pkGETorPOST);
    LRequest.AddAuthParameter('client_secret', FClientSecret, TRESTRequestParameterKind.pkGETorPOST);
    LRequest.AddAuthParameter('redirect_uri', FRedirectionEndpoint, TRESTRequestParameterKind.pkGETorPOST);
    LRequest.AddAuthParameter('grant_type', 'authorization_code', TRESTRequestParameterKind.pkGETorPOST);

    LRequest.Execute;

    if LRequest.Response.GetSimpleValue('access_token', LToken) then
      FAccessToken := LToken;
    if LRequest.Response.GetSimpleValue('refresh_token', LToken) then
      FRefreshToken := LToken;

    // detect token-type. this is important for how using it later
    if LRequest.Response.GetSimpleValue('token_type', LToken) then
      FTokenType := OAuth2TokenTypeFromString(LToken);

    // if provided by the service, the field "expires_in" contains
    // the number of seconds an access-token will be valid
    if LRequest.Response.GetSimpleValue('expires_in', LToken) then
    begin
      LIntValue := StrToIntdef(LToken, -1);
      if (LIntValue > -1) then
        FAccessTokenExpiry := IncSecond(Now, LIntValue)
      else
        FAccessTokenExpiry := 0.0;
    end;

    // an authentication-code may only be used once.
    // if we succeeded here and got an access-token, then
    // we do clear the auth-code as is is not valid anymore
    // and also not needed anymore.
    if (FAccessToken <> '') then
      FAuthCode := '';
  finally
    LClient.DisposeOf;
  end;

end;

procedure TOAuth2Authenticator.DefineProperties(Filer: TFiler);
begin
  inherited;

  Filer.DefineProperty('AccessTokenExpiryDate', ReadAccessTokenExpiryData, WriteAccessTokenExpiryData,
    (FAccessTokenExpiry > 0.1));
end;

procedure TOAuth2Authenticator.DoAuthenticate(ARequest: TCustomRESTRequest);
var
  LName: string;
begin
  inherited;

  case FTokenType of
    TOAuth2TokenType.ttBEARER:
      begin
        ARequest.AddAuthParameter(HTTP_HEADERFIELD_AUTH, 'Bearer ' + FAccessToken,
          TRESTRequestParameterKind.pkHTTPHEADER, [TRESTRequestParameterOption.poDoNotEncode]);
      end;
  else
    begin
      // depending on the service-provider, some of them want the access-token
      // submitted as "access_token", while others require it as "oauth_token"
      // please see documentation of your service-provider
      LName := FAccessTokenParamName;
      if (Trim(LName) = '') then
        LName := DefaultOAuth2AccessTokenParamName;

      ARequest.AddAuthParameter(LName, FAccessToken, TRESTRequestParameterKind.pkGETorPOST,
        [TRESTRequestParameterOption.poDoNotEncode]);
    end;
  end;
end;

procedure TOAuth2Authenticator.ReadAccessTokenExpiryData(AReader: TReader);
begin
  FAccessTokenExpiry := AReader.ReadDate;
end;

procedure TOAuth2Authenticator.ResetToDefaults;
begin
  inherited;

  ClientID := '';
  ClientSecret := '';
  AuthCode := '';
  AccessToken := '';
  FAccessTokenExpiry := 0.0;
  Scope := '';
  RefreshToken := '';
  LocalState := '';

  FTokenType := DefaultOAuth2TokenType;
  ResponseType := DefaultOAuth2ResponseType;
  AccessTokenParamName := DefaultOAuth2AccessTokenParamName;

  AuthorizationEndpoint := '';
  AccessTokenEndpoint := '';
  RedirectionEndpoint := '';
end;

function TOAuth2Authenticator.ResponseTypeIsStored: Boolean;
begin
  Result := ResponseType <> DefaultOAuth2ResponseType;
end;

procedure TOAuth2Authenticator.SetAccessToken(const AValue: string);
begin
  if AValue <> FAccessToken then
  begin
    FAccessToken := AValue;
    PropertyValueChanged;
  end;
end;

procedure TOAuth2Authenticator.SetAccessTokenEndpoint(const AValue: string);
begin
  if AValue <> FAccessTokenEndpoint then
  begin
    FAccessTokenEndpoint := AValue;
    PropertyValueChanged;
  end;
end;

procedure TOAuth2Authenticator.SetAccessTokenExpiry(const AExpiry: TDateTime);
begin
  if AExpiry <> FAccessTokenExpiry then
  begin
    FAccessTokenExpiry := AExpiry;
    PropertyValueChanged;
  end;
end;

procedure TOAuth2Authenticator.SetAccessTokenParamName(const AValue: string);
begin
  if AValue <> FAccessTokenParamName then
  begin
    FAccessTokenParamName := AValue;
    PropertyValueChanged;
  end;
end;

procedure TOAuth2Authenticator.SetAuthCode(const AValue: string);
begin
  if AValue <> FAuthCode then
  begin
    FAuthCode := AValue;
    PropertyValueChanged;
  end;
end;

procedure TOAuth2Authenticator.SetAuthorizationEndpoint(const AValue: string);
begin
  if AValue <> FAuthorizationEndpoint then
  begin
    FAuthorizationEndpoint := AValue;
    PropertyValueChanged;
  end;
end;

procedure TOAuth2Authenticator.SetClientID(const AValue: string);
begin
  if AValue <> FClientID then
  begin
    FClientID := AValue;
    PropertyValueChanged;
  end;
end;

procedure TOAuth2Authenticator.SetClientSecret(const AValue: string);
begin
  if AValue <> FClientSecret then
  begin
    FClientSecret := AValue;
    PropertyValueChanged;
  end;
end;

procedure TOAuth2Authenticator.SetLocalState(const AValue: string);
begin
  if AValue <> FLocalState then
  begin
    FLocalState := AValue;
    PropertyValueChanged;
  end;
end;

procedure TOAuth2Authenticator.SetRedirectionEndpoint(const AValue: string);
begin
  if AValue <> FRedirectionEndpoint then
  begin
    FRedirectionEndpoint := AValue;
    PropertyValueChanged;
  end;
end;

procedure TOAuth2Authenticator.SetRefreshToken(const AValue: string);
begin
  if AValue <> FRefreshToken then
  begin
    FRefreshToken := AValue;
    PropertyValueChanged;
  end;
end;

procedure TOAuth2Authenticator.SetResponseType(const AValue: TOAuth2ResponseType);
begin
  if AValue <> FResponseType then
  begin
    FResponseType := AValue;
    PropertyValueChanged;
  end;
end;

procedure TOAuth2Authenticator.SetScope(const AValue: string);
begin
  if AValue <> FScope then
  begin
    FScope := AValue;
    PropertyValueChanged;
  end;
end;

procedure TOAuth2Authenticator.SetTokenType(const AType: TOAuth2TokenType);
begin
  if AType <> FTokenType then
  begin
    FTokenType := AType;
    PropertyValueChanged;
  end;
end;

function TOAuth2Authenticator.TokenTypeIsStored: Boolean;
begin
  Result := TokenType <> DefaultOAuth2TokenType;
end;

procedure TOAuth2Authenticator.WriteAccessTokenExpiryData(AWriter: TWriter);
begin
  AWriter.WriteDate(FAccessTokenExpiry);
end;

{ TSubOAuth1AuthenticationBindSource }

function TSubOAuth1AuthenticationBindSource.CreateAdapterT: TRESTAuthenticatorAdapter<TOAuth1Authenticator>;
begin
  result := TOAuth1AuthenticatorAdapter.Create(self);
end;

{ TOAuth1AuthenticatorAdapter }

procedure TOAuth1AuthenticatorAdapter.AddFields;
const
  sAccessToken = 'AccessToken';
  sAccessTokenSecret = 'AccessTokenSecret';
  sAccessTokenEndpoint = 'AccessTokenEndpoint';
  sRequestToken = 'RequestToken';
  sRequestTokenSecret = 'RequestTokenSecret';
  sRequestTokenEndpoint = 'RequestTokenEndpoint';
  sAuthenticationEndpoint = 'AuthenticationEndpoint';
  sCallbackEndpoint = 'CallbackEndpoint';
  sConsumerKey = 'ConsumerKey';
  sConsumerSecret = 'ConsumerSecret';
  sVerifierPIN = 'VerifierPIN';
var
  LGetMemberObject: IGetMemberObject;
begin
  CheckInactive;
  ClearFields;
  if Authenticator <> nil then
  begin
    LGetMemberObject := TBindSourceAdapterGetMemberObject.Create(self);

    CreateReadWriteField<string>(sAccessToken, LGetMemberObject, TScopeMemberType.mtText,
      function: string
      begin
        result := Authenticator.AccessToken;
      end,
      procedure(AValue: string)
      begin
        Authenticator.AccessToken := AValue;
      end);

    CreateReadWriteField<string>(sAccessTokenSecret, LGetMemberObject, TScopeMemberType.mtText,
      function: string
      begin
        result := Authenticator.AccessTokenSecret;
      end,
      procedure(AValue: string)
      begin
        Authenticator.AccessTokenSecret := AValue;
      end);

    CreateReadWriteField<string>(sAccessTokenEndpoint, LGetMemberObject, TScopeMemberType.mtText,
      function: string
      begin
        result := Authenticator.AccessTokenEndpoint;
      end,
      procedure(AValue: string)
      begin
        Authenticator.AccessTokenEndpoint := AValue;
      end);

    CreateReadWriteField<string>(sRequestToken, LGetMemberObject, TScopeMemberType.mtText,
      function: string
      begin
        result := Authenticator.RequestToken;
      end,
      procedure(AValue: string)
      begin
        Authenticator.RequestToken := AValue;
      end);

    CreateReadWriteField<string>(sRequestTokenSecret, LGetMemberObject, TScopeMemberType.mtText,
      function: string
      begin
        result := Authenticator.RequestTokenSecret;
      end,
      procedure(AValue: string)
      begin
        Authenticator.RequestTokenSecret := AValue;
      end);

    CreateReadWriteField<string>(sRequestTokenEndpoint, LGetMemberObject, TScopeMemberType.mtText,
      function: string
      begin
        result := Authenticator.RequestTokenEndpoint;
      end,
      procedure(AValue: string)
      begin
        Authenticator.RequestTokenEndpoint := AValue;
      end);

    CreateReadWriteField<string>(sAuthenticationEndpoint, LGetMemberObject, TScopeMemberType.mtText,
      function: string
      begin
        result := Authenticator.AuthenticationEndpoint;
      end,
      procedure(AValue: string)
      begin
        Authenticator.AuthenticationEndpoint := AValue;
      end);

    CreateReadWriteField<string>(sCallbackEndpoint, LGetMemberObject, TScopeMemberType.mtText,
      function: string
      begin
        result := Authenticator.CallbackEndpoint;
      end,
      procedure(AValue: string)
      begin
        Authenticator.CallbackEndpoint := AValue;
      end);

    CreateReadWriteField<string>(sConsumerKey, LGetMemberObject, TScopeMemberType.mtText,
      function: string
      begin
        result := Authenticator.ConsumerKey;
      end,
      procedure(AValue: string)
      begin
        Authenticator.ConsumerKey := AValue;
      end);

    CreateReadWriteField<string>(sConsumerSecret, LGetMemberObject, TScopeMemberType.mtText,
      function: string
      begin
        result := Authenticator.ConsumerSecret;
      end,
      procedure(AValue: string)
      begin
        Authenticator.ConsumerSecret := AValue;
      end);

    CreateReadWriteField<string>(sVerifierPIN, LGetMemberObject, TScopeMemberType.mtText,
      function: string
      begin
        result := Authenticator.VerifierPIN;
      end,
      procedure(AValue: string)
      begin
        Authenticator.VerifierPIN := AValue;
      end);

  end;
end;

{ TSubOAuth2AuthenticationBindSource }

function TSubOAuth2AuthenticationBindSource.CreateAdapterT: TRESTAuthenticatorAdapter<TOAuth2Authenticator>;
begin
  result := TOAuth2AuthenticatorAdapter.Create(self);
end;

{ TOAuth2AuthenticatorAdapter }

procedure TOAuth2AuthenticatorAdapter.AddFields;
const
  sAccessToken = 'AccessToken';
  sAccessTokenEndpoint = 'AccessTokenEndpoint';
  sRefreshToken = 'RefreshToken';
  sAuthCode = 'AuthCode';
  sClientID = 'ClientID';
  sClientSecret = 'ClientSecret';
  sAuthorizationEndpoint = 'AuthorizationEndpoint';
  sRedirectionEndpoint = 'RedirectionEndpoint';
  sScope = 'Scope';
  sLocalState = 'LocalState';
var
  LGetMemberObject: IGetMemberObject;
begin
  CheckInactive;
  ClearFields;
  if Authenticator <> nil then
  begin
    LGetMemberObject := TBindSourceAdapterGetMemberObject.Create(self);

    CreateReadWriteField<string>(sAccessToken, LGetMemberObject, TScopeMemberType.mtText,
      function: string
      begin
        result := Authenticator.AccessToken;
      end,
      procedure(AValue: string)
      begin
        Authenticator.AccessToken := AValue;
      end);

    CreateReadWriteField<string>(sAccessTokenEndpoint, LGetMemberObject, TScopeMemberType.mtText,
      function: string
      begin
        result := Authenticator.AccessTokenEndpoint;
      end,
      procedure(AValue: string)
      begin
        Authenticator.AccessTokenEndpoint := AValue;
      end);

    CreateReadWriteField<string>(sRefreshToken, LGetMemberObject, TScopeMemberType.mtText,
      function: string
      begin
        result := Authenticator.RefreshToken;
      end,
      procedure(AValue: string)
      begin
        Authenticator.RefreshToken := AValue;
      end);

    CreateReadWriteField<string>(sAuthCode, LGetMemberObject, TScopeMemberType.mtText,
      function: string
      begin
        result := Authenticator.AuthCode;
      end,
      procedure(AValue: string)
      begin
        Authenticator.AuthCode := AValue;
      end);

    CreateReadWriteField<string>(sClientID, LGetMemberObject, TScopeMemberType.mtText,
      function: string
      begin
        result := Authenticator.ClientID;
      end,
      procedure(AValue: string)
      begin
        Authenticator.ClientID := AValue;
      end);

    CreateReadWriteField<string>(sClientSecret, LGetMemberObject, TScopeMemberType.mtText,
      function: string
      begin
        result := Authenticator.ClientSecret;
      end,
      procedure(AValue: string)
      begin
        Authenticator.ClientSecret := AValue;
      end);

    CreateReadWriteField<string>(sAuthorizationEndpoint, LGetMemberObject, TScopeMemberType.mtText,
      function: string
      begin
        result := Authenticator.AuthorizationEndpoint;
      end,
      procedure(AValue: string)
      begin
        Authenticator.AuthorizationEndpoint := AValue;
      end);

    CreateReadWriteField<string>(sRedirectionEndpoint, LGetMemberObject, TScopeMemberType.mtText,
      function: string
      begin
        result := Authenticator.RedirectionEndpoint;
      end,
      procedure(AValue: string)
      begin
        Authenticator.RedirectionEndpoint := AValue;
      end);

    CreateReadWriteField<string>(sScope, LGetMemberObject, TScopeMemberType.mtText,
      function: string
      begin
        result := Authenticator.Scope;
      end,
      procedure(AValue: string)
      begin
        Authenticator.Scope := AValue;
      end);

    CreateReadWriteField<string>(sLocalState, LGetMemberObject, TScopeMemberType.mtText,
      function: string
      begin
        result := Authenticator.LocalState;
      end,
      procedure(AValue: string)
      begin
        Authenticator.LocalState := AValue;
      end);

  end;
end;

initialization
  RegisterClasses([TOAuth1SignatureMethod_PLAINTEXT, TOAuth1SignatureMethod_HMAC_SHA1]);

end.
