{*******************************************************}
{                                                       }
{             Delphi REST Client Framework              }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit uOAuth2_frm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Rtti, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs,
  FMX.StdCtrls, FMX.ListBox, FMX.Edit,
  uRESTObjects, REST.Client, FMX.Controls.Presentation;

type
  Tfrm_OAuth2 = class(TForm)
    gb_MiscSettings: TGroupBox;
    cmb_ResponseType: TComboBox;
    Label25: TLabel;
    edt_OAuth2Scope: TEdit;
    Label26: TLabel;
    gb_Endpoints: TGroupBox;
    edt_OAuth2AuthEndpoint: TEdit;
    Label20: TLabel;
    edt_OAuth2AccessTokenEndpoint: TEdit;
    Label21: TLabel;
    edt_OAuth2RedirectEndpoint: TEdit;
    Label22: TLabel;
    gb_ClientData: TGroupBox;
    edt_OAuth2ClientID: TEdit;
    Label18: TLabel;
    edt_OAuth2ClientSecret: TEdit;
    Label19: TLabel;
    gb_CodeTokens: TGroupBox;
    edt_OAuth2AuthCode: TEdit;
    Label17: TLabel;
    edt_OAuth2AccessToken: TEdit;
    Label23: TLabel;
    edt_OAuth2RefreshToken: TEdit;
    Label24: TLabel;
    btn_Cancel: TButton;
    btn_Apply: TButton;
    btn_Authorize: TButton;
    Button2: TButton;
    procedure btn_ApplyClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_AuthorizeClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    procedure InitializeResponseTypeCombo;

    procedure ConfigureProxyServer(AClient: TCustomRESTClient);
    procedure DoAuthorize;
    procedure DoRequestBearerToken;
  public
    { Public declarations }
    procedure FetchParamsFromControls(const AParams: TRESTRequestParams);
    procedure PushParamsToControls(const AParams: TRESTRequestParams);
  end;

var
  frm_OAuth2: Tfrm_OAuth2;

implementation

uses
  uMain_frm,
  uOSUtils,
  REST.Types,
  REST.Utils,
  REST.Authenticator.OAuth,
  uRESTDebuggerResStrs;

{$R *.fmx}

procedure Tfrm_OAuth2.btn_ApplyClick(Sender: TObject);
begin
  ModalResult := mrOK;
end;

procedure Tfrm_OAuth2.btn_AuthorizeClick(Sender: TObject);
begin
  DoAuthorize;
end;

procedure Tfrm_OAuth2.btn_CancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure Tfrm_OAuth2.Button2Click(Sender: TObject);
begin
  DoRequestBearerToken;
end;

procedure Tfrm_OAuth2.ConfigureProxyServer(AClient: TCustomRESTClient);
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

procedure Tfrm_OAuth2.DoAuthorize;
var
  LURL: string;
begin

  /// we need at least two things here:
  /// (1) an auth-endpoint
  /// (2) a client-id

  if (edt_OAuth2AuthEndpoint.Text = '') then
  begin
    MessageDlg(RSProvideAuthEndPoint, TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0);
    EXIT;
  end;
  if (edt_OAuth2ClientID.Text = '') then
  begin
    MessageDlg(RSProvideClientID, TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0);
    EXIT;
  end;

  /// This is the first step in the oauth2-workflow
  LURL := edt_OAuth2AuthEndpoint.Text;
  LURL := LURL + '?client_id=' + edt_OAuth2ClientID.Text;

  if (cmb_ResponseType.ItemIndex > -1) then
    LURL := LURL + '&response_type=' + cmb_ResponseType.Items[cmb_ResponseType.ItemIndex]
  else
    LURL := LURL + '&response_type=' + OAuth2ResponseTypeToString(DefaultOAuth2ResponseType);

  if (edt_OAuth2RedirectEndpoint.Text <> '') then
    LURL := LURL + '&redirect_uri=' + URIEncode(edt_OAuth2RedirectEndpoint.Text);
  if (edt_OAuth2Scope.Text <> '') then
    LURL := LURL + '&scope=' +URIEncode(edt_OAuth2Scope.Text);

  OSExecute(LURL);
end;

procedure Tfrm_OAuth2.DoRequestBearerToken;
var
  LClient: TRESTClient;
  LRequest: TRESTRequest;
  LValue: string;
begin

  /// we need at least two things here:
  /// (1) an token-endpoint
  /// (2) a client-id
  /// (3) a client-secret
  /// (4) an auth-code (from step #1)

  if (edt_OAuth2AuthCode.Text = '') then
  begin
    MessageDlg(RSProvideAuthCode,
      TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0);
    EXIT;
  end;
  if (edt_OAuth2AccessTokenEndpoint.Text = '') then
  begin
    MessageDlg(RSProvideTokenEndPoint, TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0);
    EXIT;
  end;
  if (edt_OAuth2ClientID.Text = '') OR (edt_OAuth2ClientSecret.Text = '') then
  begin
    MessageDlg(RSProvideClientIDAndClientSecret,
      TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0);
    EXIT;
  end;

  LClient := TRESTClient.Create(self);
  ConfigureProxyServer( LClient );

  LRequest := TRESTRequest.Create(self);
  LRequest.Client := LClient;
  LRequest.Method := TRESTRequestMethod.rmPOST;

  TRY
    LClient.BaseURL := edt_OAuth2AccessTokenEndpoint.Text;
    LRequest.AddParameter('code', edt_OAuth2AuthCode.Text);
    LRequest.AddParameter('client_id', edt_OAuth2ClientID.Text);
    LRequest.AddParameter('client_secret', edt_OAuth2ClientSecret.Text);
    LRequest.AddParameter('grant_type', 'authorization_code');
    if (edt_OAuth2RedirectEndpoint.Text <> '') then
      LRequest.AddParameter('redirect_uri', edt_OAuth2RedirectEndpoint.Text);

    LRequest.Execute;
    if (LRequest.Response.StatusCode = 200) then
    begin
      edt_OAuth2AuthCode.Text := '';
      if LRequest.Response.GetSimpleValue('access_token', LValue) then
        edt_OAuth2AccessToken.Text := LValue;
    end;

  FINALLY
    FreeAndNIL(LRequest);
    FreeAndNIL(LClient);
  END;
end;

procedure Tfrm_OAuth2.PushParamsToControls(const AParams: TRESTRequestParams);
begin
  edt_OAuth2AuthEndpoint.Text := AParams.EndpointAuth;
  edt_OAuth2AccessTokenEndpoint.Text := AParams.EndpointAccessToken;
  edt_OAuth2RedirectEndpoint.Text := AParams.EndpointRedirect;

  edt_OAuth2ClientID.Text := AParams.ClientID;
  edt_OAuth2ClientSecret.Text := AParams.ClientSecret;

  edt_OAuth2AuthCode.Text := AParams.AuthCode;
  edt_OAuth2AccessToken.Text := AParams.AccessToken;
  edt_OAuth2RefreshToken.Text := AParams.RefreshToken;

  edt_OAuth2Scope.Text := AParams.AuthScope;

  if (cmb_ResponseType.Items.IndexOf(AParams.OAuth2ResponseType) > -1) then
    cmb_ResponseType.ItemIndex := cmb_ResponseType.Items.IndexOf(AParams.OAuth2ResponseType)
  else
    cmb_ResponseType.ItemIndex := cmb_ResponseType.Items.IndexOf(OAuth2ResponseTypeToString(DefaultOAuth2ResponseType));
end;

procedure Tfrm_OAuth2.FetchParamsFromControls(const AParams: TRESTRequestParams);
begin
  AParams.EndpointAuth := edt_OAuth2AuthEndpoint.Text;
  AParams.EndpointAccessToken := edt_OAuth2AccessTokenEndpoint.Text;
  AParams.EndpointRedirect := edt_OAuth2RedirectEndpoint.Text;

  AParams.ClientID := edt_OAuth2ClientID.Text;
  AParams.ClientSecret := edt_OAuth2ClientSecret.Text;

  AParams.AuthCode := edt_OAuth2AuthCode.Text;
  AParams.AccessToken := edt_OAuth2AccessToken.Text;
  AParams.RefreshToken := edt_OAuth2RefreshToken.Text;

  AParams.AuthScope := edt_OAuth2Scope.Text;

  if (cmb_ResponseType.ItemIndex > -1) then
    AParams.OAuth2ResponseType := cmb_ResponseType.Items[cmb_ResponseType.ItemIndex]
  else
    AParams.OAuth2ResponseType := OAuth2ResponseTypeToString(DefaultOAuth2ResponseType);
end;

procedure Tfrm_OAuth2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  /// important: do *not* release the form here, as we might want
  /// to fetch the data from the controls (wich get's more complicated
  /// when the form is about to be released)
  Action := TCloseAction.caHide;
end;

procedure Tfrm_OAuth2.FormCreate(Sender: TObject);
begin
  InitializeResponseTypeCombo;
end;

procedure Tfrm_OAuth2.InitializeResponseTypeCombo;
var
  LType: TOAuth2ResponseType;
begin
  cmb_ResponseType.Items.BeginUpdate;
  TRY
    cmb_ResponseType.Items.Clear;
    for LType IN [Low(TOAuth2ResponseType) .. High(TOAuth2ResponseType)] do
      cmb_ResponseType.Items.Add(OAuth2ResponseTypeToString(LType));
  FINALLY
    cmb_ResponseType.Items.EndUpdate;
  END;

  /// try to set the itemindex to the default-value
  if (cmb_ResponseType.Items.IndexOf(OAuth2ResponseTypeToString(DefaultOAuth2ResponseType)) > -1) then
    cmb_ResponseType.ItemIndex := cmb_ResponseType.Items.IndexOf(OAuth2ResponseTypeToString(DefaultOAuth2ResponseType));
end;

end.
