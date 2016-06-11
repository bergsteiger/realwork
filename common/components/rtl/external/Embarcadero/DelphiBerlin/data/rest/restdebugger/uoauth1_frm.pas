{*******************************************************}
{                                                       }
{             Delphi REST Client Framework              }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit uOAuth1_frm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Rtti, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs,
  FMX.StdCtrls, FMX.ListBox, FMX.Edit, FMX.ComboEdit,
  uRESTObjects, REST.Client, FMX.Controls.Presentation;

type
  Tfrm_OAuth1 = class(TForm)
    btn_Cancel: TButton;
    btn_Apply: TButton;
    gb_Endpoints: TGroupBox;
    edt_OAuth1AuthEndpoint: TEdit;
    Label20: TLabel;
    edt_OAuth1AccessTokenEndpoint: TEdit;
    Label21: TLabel;
    edt_OAuth1RequestTokentEndpoint: TEdit;
    Label22: TLabel;
    gb_ClientData: TGroupBox;
    edt_OAuth1ClientID: TEdit;
    Label18: TLabel;
    edt_OAuth1ClientSecret: TEdit;
    Label19: TLabel;
    gb_MiscSettings: TGroupBox;
    gb_CodeTokens: TGroupBox;
    edt_OAuth1AuthCode: TEdit;
    Label17: TLabel;
    edt_OAuth1AccessToken: TEdit;
    Label23: TLabel;
    edt_OAuth1RequestToken: TEdit;
    Label24: TLabel;
    edt_OAuth1RedirectEndpoint: TEdit;
    Label1: TLabel;
    cmb_SigningClass: TComboEdit;
    Label2: TLabel;
    edt_OAuth1AccessTokenSecret: TEdit;
    edt_OAuth1RequestTokenSecret: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    btn_Step1: TButton;
    Button1: TButton;
    procedure btn_ApplyClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_Step1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    procedure InitializeSigningClassCombo;

    procedure ConfigureProxyServer( AClient : TCustomRESTClient );
    procedure DoGetRequestToken;
    procedure DoGetAcessToken;
  public
    { Public declarations }
    procedure FetchParamsFromControls(const AParams: TRESTRequestParams);
    procedure PushParamsToControls(const AParams: TRESTRequestParams);
  end;

var
  frm_OAuth1: Tfrm_OAuth1;

implementation
uses
  uMain_frm,
  uOSUtils,
  REST.Types,
  REST.Utils,
  System.StrUtils,
  REST.Authenticator.OAuth,
  uRESTDebuggerResStrs;

{$R *.fmx}

procedure Tfrm_OAuth1.btn_ApplyClick(Sender: TObject);
begin
  ModalResult := mrOK;
end;

procedure Tfrm_OAuth1.btn_CancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure Tfrm_OAuth1.btn_Step1Click(Sender: TObject);
begin
  DoGetRequestToken;
end;

procedure Tfrm_OAuth1.Button1Click(Sender: TObject);
begin
  DoGetAcessToken;
end;

procedure Tfrm_OAuth1.DoGetAcessToken;
var
  LOAuth1: TCustomAuthenticator;
  LClient: TRESTClient;
  LRequest: TRESTRequest;
  LToken: string;
begin
  LOAuth1 := TOAuth1Authenticator.Create(NIL);
  with (LOAuth1 AS TOAuth1Authenticator) do
  begin
    SigningClass := TOAuth1SignatureMethod_HMAC_SHA1.Create;
    ConsumerKey := edt_OAuth1ClientID.Text;
    ConsumerSecret := edt_OAuth1ClientSecret.Text;
    // yes- in this step we do use the request-token as access-token
    AccessToken := edt_OAuth1RequestToken.Text;
    AccessTokenSecret := edt_OAuth1RequestTokenSecret.Text;
  end;

  LClient := TRESTClient.Create(edt_OAuth1AccessTokenEndpoint.Text);
  LClient.Authenticator := LOAuth1;
  ConfigureProxyServer( LClient );

  LRequest := TRESTRequest.Create(nil);
  try
    LRequest.Method := TRESTRequestMethod.rmPOST;

    LRequest.AddAuthParameter('oauth_verifier', edt_OAuth1AuthCode.Text, TRESTRequestParameterKind.pkGETorPOST,
      [TRESTRequestParameterOption.poDoNotEncode]);
    LRequest.Client := LClient;
    LRequest.Execute;

    //memo_Response.Lines.Text := LRequest.Response.Content;

    if LRequest.Response.GetSimpleValue('oauth_token', LToken) then
      edt_OAuth1AccessToken.Text := LToken;
    if LRequest.Response.GetSimpleValue('oauth_token_secret', LToken) then
      edt_OAuth1AccessTokenSecret.Text := LToken;
  finally
    FreeAndNil(LRequest);
  end;
end;

procedure Tfrm_OAuth1.DoGetRequestToken;
var
  LClient: TRESTClient;
  LRequest: TRESTRequest;
  LOAuth1: TOAuth1Authenticator;
  LURL: string;
  LToken: string;
begin
  /// step #1, get request-token

  LOAuth1 := TOAuth1Authenticator.Create(NIL);
  with (LOAuth1 AS TOAuth1Authenticator) do
  begin
    SigningClass := TOAuth1SignatureMethod_HMAC_SHA1.Create;
    ConsumerKey := edt_OAuth1ClientID.Text;
    ConsumerSecret := edt_OAuth1ClientSecret.Text;
    CallbackEndpoint := edt_OAuth1RedirectEndpoint.Text;
  end;
  try
    LClient := TRESTClient.Create(edt_OAuth1RequestTokentEndpoint.Text);
    LClient.Authenticator := LOAuth1;
    ConfigureProxyServer( LClient );

    LRequest := TRESTRequest.Create(nil);
    LRequest.Method := TRESTRequestMethod.rmPOST;
    LRequest.Resource := '';

    LRequest.Client := LClient;
    LRequest.Execute;

    //memo_Response.Lines.Text := LRequest.Response.Content;

    if LRequest.Response.GetSimpleValue('oauth_token', LToken) then
      edt_OAuth1RequestToken.Text := LToken;
    if LRequest.Response.GetSimpleValue('oauth_token_secret', LToken) then
      edt_OAuth1RequestTokenSecret.Text := LToken;
  finally
    FreeAndNil(LRequest);
    FreeAndNil(LClient);
  end;

  if (edt_OAuth1RequestToken.Text = '') then
  begin
    ShowMessage(RSCannotProceedWithoutRequest);
    EXIT;
  end;

  /// step #2: get the auth-verifier (PIN must be entered by the user!)
  LURL := edt_OAuth1AuthEndpoint.Text;
  if ContainsText( LURL, '?' ) then
    LURL := LURL + '&oauth_token=' + edt_OAuth1RequestToken.Text
  else
    LURL := LURL + '?oauth_token=' + edt_OAuth1RequestToken.Text;

  OSExecute( LURL );
end;

procedure Tfrm_OAuth1.FetchParamsFromControls(const AParams: TRESTRequestParams);
begin
  AParams.EndpointAuth:= edt_OAuth1AuthEndpoint.Text;
  AParams.EndpointAccessToken:= edt_OAuth1AccessTokenEndpoint.Text;
  AParams.EndpointRequestToken:= edt_OAuth1RequestTokentEndpoint.Text;
  AParams.EndpointRedirect:= edt_OAuth1RedirectEndpoint.Text;

  AParams.AuthCode:= edt_OAuth1AuthCode.Text;
  AParams.AccessToken:= edt_OAuth1AccessToken.Text;
  AParams.AccessTokenSecret:= edt_OAuth1AccessTokenSecret.Text;
  AParams.RequestToken:= edt_OAuth1RequestToken.Text;
  AParams.RequestTokenSecret:= edt_OAuth1RequestTokenSecret.Text;

  AParams.ClientID:= edt_OAuth1ClientID.Text;
  AParams.ClientSecret:= edt_OAuth1ClientSecret.Text;

  AParams.OAuth1SignatureMethod:= cmb_SigningClass.Text;
end;

procedure Tfrm_OAuth1.FormCreate(Sender: TObject);
begin
  InitializeSigningClassCombo;
end;

procedure Tfrm_OAuth1.PushParamsToControls(const AParams: TRESTRequestParams);
begin
  edt_OAuth1AuthEndpoint.Text:= AParams.EndpointAuth;
  edt_OAuth1AccessTokenEndpoint.Text:= AParams.EndpointAccessToken;
  edt_OAuth1RequestTokentEndpoint.Text:= AParams.EndpointRequestToken;
  edt_OAuth1RedirectEndpoint.Text:= AParams.EndpointRedirect;

  edt_OAuth1AuthCode.Text:= AParams.AuthCode;
  edt_OAuth1AccessToken.Text:= AParams.AccessToken;
  edt_OAuth1AccessTokenSecret.Text:= AParams.AccessTokenSecret;
  edt_OAuth1RequestToken.Text:= AParams.RequestToken;
  edt_OAuth1RequestTokenSecret.Text:= AParams.RequestTokenSecret;

  edt_OAuth1ClientID.Text:= AParams.ClientID;
  edt_OAuth1ClientSecret.Text:= AParams.ClientSecret;


  if (AParams.OAuth1SignatureMethod <> '') then
  begin
    if (cmb_SigningClass.Items.IndexOf(AParams.OAuth1SignatureMethod) > -1) then
      cmb_SigningClass.ItemIndex:= cmb_SigningClass.Items.IndexOf(AParams.OAuth1SignatureMethod)
    else
    begin
      cmb_SigningClass.ItemIndex:= -1;
      cmb_SigningClass.Text:= AParams.OAuth1SignatureMethod;
    end;
  end
  else
  begin
    if (cmb_SigningClass.Items.IndexOf(DefaultOAuth1SignatureClass.GetName) > -1) then
      cmb_SigningClass.ItemIndex:= cmb_SigningClass.Items.IndexOf(DefaultOAuth1SignatureClass.GetName)
    else
    begin
      cmb_SigningClass.ItemIndex:= -1;
      cmb_SigningClass.Text:= '';
    end;
  end;
end;

procedure Tfrm_OAuth1.InitializeSigningClassCombo;
begin
  cmb_SigningClass.Items.BeginUpdate;
  TRY
    cmb_SigningClass.Items.Clear;

    cmb_SigningClass.Items.Add(TOAuth1SignatureMethod_HMAC_SHA1.GetName);
    cmb_SigningClass.Items.Add(TOAuth1SignatureMethod_PLAINTEXT.GetName);
  FINALLY
    cmb_SigningClass.Items.EndUpdate;
  END;

  /// well, it *really* should be > 0 here, but cheking cannot be wrong...
  if (cmb_SigningClass.Items.Count > 0) then
    cmb_SigningClass.ItemIndex := 0;
end;

procedure Tfrm_OAuth1.ConfigureProxyServer( AClient : TCustomRESTClient );
begin
  if frm_Main.cbProxy.IsChecked then
  begin
    AClient.ProxyServer := frm_Main.edt_ProxyServer.Text;
    AClient.ProxyPort := Trunc(frm_Main.edt_ProxyPort.Value);
    AClient.ProxyUsername := frm_Main.edt_ProxyUser.Text;
    AClient.ProxyPassword := frm_Main.edt_ProxyPass.Text;
  end
  else
  begin
    AClient.ProxyServer := '';
    AClient.ProxyPort := 0;
    AClient.ProxyUsername := '';
    AClient.ProxyPassword := '';
  end;
end;

end.
