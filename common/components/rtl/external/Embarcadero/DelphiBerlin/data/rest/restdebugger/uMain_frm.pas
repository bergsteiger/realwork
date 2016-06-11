{*******************************************************}
{                                                       }
{             Delphi REST Client Framework              }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit uMain_frm;

                                                                               
interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Rtti, System.Classes,
  System.Variants, System.IOUtils, System.IniFiles, System.JSON,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.ComboEdit, FMX.NumberBox,
  FMX.StdCtrls, FMX.Objects, FMX.Edit, FMX.ListBox, FMX.Layouts, FMX.Memo,
  FMX.TabControl, FMX.Grid, FMX.Bind.DBEngExt, FMX.Bind.Grid,
  uRESTObjects, uMRUList, uSettingsList,
  REST.Authenticator.OAuth,
  REST.Authenticator.Basic,
  REST.Authenticator.Simple,
  REST.Response.Adapter,
  REST.Client,
  REST.Consts,
  REST.Json,
  REST.Types,
  REST.Utils,
  Data.DB,
  Data.Bind.EngExt,
  System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.Components,
  Data.Bind.Grid, Data.Bind.DBScope, System.Generics.Collections, uWait,
  Data.Bind.ObjectScope,
  IPPeerAPI, IPPeerClient, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.EditBox,
  FMX.Controls.Presentation, System.Net.URLClient, FMX.ScrollBox, FMX.Grid.Style;

type
  Tfrm_Main = class(TForm)
    pnl_Header: TLayout;
    lbl_MainTitle: TLabel;
    img_Logo: TImage;
    gb_Request: TGroupBox;
    gb_Response: TGroupBox;
    Splitter1: TSplitter;
    tc_Response: TTabControl;
    ti_Response_Headers: TTabItem;
    ti_Response_Body: TTabItem;
    Rectangle1: TRectangle;
    memo_ResponseHeader: TMemo;
    memo_ResponseBody: TMemo;
    lbl_LastRequestStats: TLabel;
    dlg_LoadRequestSettings: TOpenDialog;
    dlg_SaveRequestSettings: TSaveDialog;
    RESTClient: TRESTClient;
    RESTRequest: TRESTRequest;
    RESTResponse: TRESTResponse;
    RESTResponseDataSetAdapter: TRESTResponseDataSetAdapter;
    SimpleAuthenticator: TSimpleAuthenticator;
    HTTPBasicAuthenticator: THTTPBasicAuthenticator;
    OAuth1Authenticator: TOAuth1Authenticator;
    OAuth2Authenticator: TOAuth2Authenticator;
    ti_Response_TableView: TTabItem;
    StringGrid1: TStringGrid;
    BindSourceRESTResponse: TBindSourceDB;
    BindingsList1: TBindingsList;
    StatusBar: TStatusBar;
    lbl_ProxyState: TLabel;
    BindSourceDB1: TBindSourceDB;
    layout_Request: TLayout;
    lbl_LastRequestURL: TLabel;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    ToolBar1: TToolBar;
    LabelJson: TLabel;
    LabelRootElement: TLabel;
    ButtonRootElement: TButton;
    EditRootElement: TClearingEdit;
    Label15: TLabel;
    btn_ExecuteRequest: TButton;
    btn_Newrequest: TButton;
    btn_LoadRequest: TButton;
    btn_SaveRequest: TButton;
    tc_Request: TTabControl;
    ti_Request_Basic: TTabItem;
    cmb_RequestMethod: TComboBox;
    lbl_RequestMethodCaption: TLabel;
    memo_RequestBody: TMemo;
    cmb_RequestURL: TComboEdit;
    lbl_RequestBodyCaption: TLabel;
    lbl_BaseURLCaption: TLabel;
    btn_ClearMRUList: TButton;
    edt_ContentType: TComboEdit;
    Label16: TLabel;
    ti_Request_Advanced: TTabItem;
    lb_CustomParameters: TListBox;
    btn_AddCustomParameter: TButton;
    btn_EditCustomParameter: TButton;
    btn_DeleteCustomParameter: TButton;
    edt_Resource: TEdit;
    Label10: TLabel;
    lbl_CustomHeadersCaption: TLabel;
    ti_Request_Auth: TTabItem;
    cmb_AuthMethod: TComboBox;
    Label5: TLabel;
    edt_AuthPassword: TEdit;
    Label4: TLabel;
    edt_AuthUsername: TEdit;
    Label1: TLabel;
    edt_AuthClientID: TEdit;
    Label2: TLabel;
    edt_AuthAccessToken: TEdit;
    Label3: TLabel;
    edt_AuthRequestToken: TEdit;
    Label6: TLabel;
    edt_AuthClientSecret: TEdit;
    Label7: TLabel;
    edt_AuthPasswordKey: TEdit;
    Label8: TLabel;
    edt_AuthUsernameKey: TEdit;
    Label9: TLabel;
    Connection: TTabItem;
    edt_ProxyServer: TEdit;
    lbl_ProxyServer: TLabel;
    edt_ProxyUser: TEdit;
    Label11: TLabel;
    edt_ProxyPass: TEdit;
    Label12: TLabel;
    cbProxy: TCheckBox;
    edt_ProxyPort: TNumberBox;
    Label13: TLabel;
    btn_OAuthAssistant: TButton;
    FDMemTable1: TFDMemTable;
    ToolBar2: TToolBar;
    LabelJSONTab: TLabel;
    LabelRootElementTab: TLabel;
    ButtonRootElementTab: TButton;
    EditRootElementTab: TClearingEdit;
    btn_CopyToClipboard: TButton;
    cb_NestedFields: TCheckBox;
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    procedure FormCreate(Sender: TObject);
    procedure btn_ExecuteRequestClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_LoadRequestClick(Sender: TObject);
    procedure btn_SaveRequestClick(Sender: TObject);
    procedure btn_EditCustomParameterClick(Sender: TObject);
    procedure lb_CustomParametersDblClick(Sender: TObject);
    procedure btn_AddCustomParameterClick(Sender: TObject);
    procedure btn_DeleteCustomParameterClick(Sender: TObject);
    procedure cbProxyClick(Sender: TObject);
    procedure cmb_AuthMethodChange(Sender: TObject);
    procedure cmb_RequestMethodChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure tc_RequestChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_NewrequestClick(Sender: TObject);
    procedure btn_ClearMRUListClick(Sender: TObject);
    procedure ButtonRootElementClick(Sender: TObject);
    procedure cmb_RequestURLClosePopup(Sender: TObject);
    procedure edt_ResourceExit(Sender: TObject);
    procedure btn_OAuthAssistantClick(Sender: TObject);
    procedure lbl_BaseURLCaptionClick(Sender: TObject);
    procedure cmb_RequestURLChange(Sender: TObject);
    procedure EditRootElementChangeTracking(Sender: TObject);
    procedure EditRootElementTabChangeTracking(Sender: TObject);
    procedure EditRootElementTabKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure EditRootElementKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure ti_Response_BodyClick(Sender: TObject);
    procedure ti_Response_TableViewClick(Sender: TObject);
    procedure StringGrid1HeaderClick(Column: TColumn);
    procedure btn_CopyToClipboardClick(Sender: TObject);
    procedure RESTResponseDataSetAdapterBeforeOpenDataSet(Sender: TObject);
    procedure RESTClientValidateCertificate(const Sender: TObject;
      const ARequest: TURLRequest; const Certificate: TCertificate;
      var Accepted: Boolean);
    procedure cmb_RequestURLKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
  private
    { Private declarations }

    FMRUList: TMRUList;
    FSettingsList: TSettingsList;
    FRESTParams: TRESTRequestParams;
    FProxyINI: string;
    FCurrentRootElement: string;

    FPopupClosed : boolean;

    procedure InitRequestMethodCombo;
    procedure InitAuthMethodCombo;

    procedure DoLoadRequestSettings;
    procedure DoSaveRequestSettings;

    procedure DoResetControls;
    procedure DoFetchRequestParamsFromControls;
    procedure DoPushRequestParamsToControls;
    procedure DoUpdateProxyStateLabel;

    procedure DoAddCustomParameter;
    procedure DoEditCustomParameter;
    procedure DoDeleteCustomParameter;

    procedure DoUpdateAuthEditFields;

    procedure DoExecuteRequest;

    procedure DoAddToMRUList(const AParams: TRESTRequestParams);
    procedure DoClearMRUList;
    procedure DoUpdateMRUList;
    procedure DoClearRequest;

    procedure DoCallOAuthAssistant;

    procedure DoDisplayHTTPResponse(ARequest: TRESTRequest; AClient: TRESTClient; AResponse: TRESTResponse);

    /// <summary>
    /// If a proxy server is to be used, then apply its parameters to the RestClient.
    /// </summary>
    procedure ConfigureProxyServer;
    procedure LoadProxySettings(const AFilename: string);
    procedure SaveProxySettings(const AFilename: string);
    procedure FillReponseContentMemo;
    procedure SynchEditCaret(AEdit1, AEdit2: TCustomEdit);
    procedure UpdateRootElement;
    procedure UpdateComponentProperties;

    procedure SaveGridColumnWidths;
    procedure RestoreGridColumnWidths;
    function MakeWidthKey(const AHeader: string): string;
  public
    { Public declarations }
    procedure KeyDown(var Key: Word; var KeyChar: Char; Shift: TShiftState); override;
  end;

var
  frm_Main: Tfrm_Main;

var
  DefaultStorageFolder: string = '';
  /// will be initialized on startup

implementation

uses
  System.UIConsts,
  uOAuth1_frm,
  uOAuth2_frm,
  uCustomHeaderDlg_frm, uComponentToClipboard,
  REST.HttpClient,
  uRESTDebuggerResStrs;

{$R *.fmx}

const
  PROXYDBFILE = 'proxy.dat'; // do not localize


procedure Tfrm_Main.btn_AddCustomParameterClick(Sender: TObject);
begin
  DoAddCustomParameter;
end;

procedure Tfrm_Main.btn_ClearMRUListClick(Sender: TObject);
begin
  DoClearMRUList;
end;

procedure Tfrm_Main.btn_CopyToClipboardClick(Sender: TObject);
var
  LList: TList<TComponent>;
  LNames: string;
  LComponent: TComponent;
  LDataSetActive: Boolean;
begin
  LDataSetActive := False;
  LList := TList<TComponent>.Create;
  try
    LList.AddRange([RESTClient, RESTRequest, RESTResponse]);
    if Self.tc_Response.ActiveTab = ti_Response_TableView then
    begin
      LDataSetActive := RESTResponseDataSetAdapter.Active;
      SaveGridColumnWidths;
      RESTResponseDataSetAdapter.Active := False;
      FDMemTable1.StoreDefs := False; // don't copy field defs to clipboard
      LList.AddRange([RESTResponseDataSetAdapter, FDMemTable1]);
    end;
    UpdateComponentProperties;
    if RESTClient.Authenticator <> nil then
      LList.Add(RESTClient.Authenticator);
    StreamToClipboard(LList.ToArray);
    if LDataSetActive then
    begin
      RESTResponseDataSetAdapter.Active := True;
      RestoreGridColumnWidths;
    end;
    for LComponent in LList do
    begin
      if LNames <> '' then
        LNames := LNames + ', ';
      LNames := LNames + LComponent.ClassName;
    end;
    MessageDlg(Format(RSComponentsCopied, [LNames]),
      TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
  finally
    LList.Free;
  end;
end;

procedure Tfrm_Main.btn_DeleteCustomParameterClick(Sender: TObject);
begin
  DoDeleteCustomParameter;
end;

procedure Tfrm_Main.btn_EditCustomParameterClick(Sender: TObject);
begin
  DoEditCustomParameter;
end;

procedure Tfrm_Main.btn_ExecuteRequestClick(Sender: TObject);
begin
  TWait.Start;
  try
    DoExecuteRequest;
  finally
    TWait.Done;
  end;
end;

procedure Tfrm_Main.btn_LoadRequestClick(Sender: TObject);
begin
  DoLoadRequestSettings;
end;

procedure Tfrm_Main.btn_NewrequestClick(Sender: TObject);
begin
  DoClearRequest;
end;

procedure Tfrm_Main.btn_OAuthAssistantClick(Sender: TObject);
begin
  DoCallOAuthAssistant;
end;

procedure Tfrm_Main.btn_SaveRequestClick(Sender: TObject);
begin
  DoSaveRequestSettings;
end;

procedure Tfrm_Main.ButtonRootElementClick(Sender: TObject);
begin
  UpdateRootElement;
end;

procedure Tfrm_Main.cbProxyClick(Sender: TObject);
begin
  edt_ProxyServer.Enabled := not cbProxy.IsChecked;
  edt_ProxyPort.Enabled := not cbProxy.IsChecked;
  edt_ProxyUser.Enabled := not cbProxy.IsChecked;
  edt_ProxyPass.Enabled := not cbProxy.IsChecked;
end;

procedure Tfrm_Main.cmb_AuthMethodChange(Sender: TObject);
begin
  DoUpdateAuthEditFields;
end;

procedure Tfrm_Main.cmb_RequestMethodChange(Sender: TObject);
var
  LMethod: TRESTRequestMethod;
begin
  if (cmb_RequestMethod.ItemIndex > -1) then
  begin
    LMethod := RESTRequestMethodFromString(cmb_RequestMethod.Items[cmb_RequestMethod.ItemIndex]);
    memo_RequestBody.Enabled := LMethod in [TRESTRequestMethod.rmPOST, TRESTRequestMethod.rmPUT];
  end
  else
    memo_RequestBody.Enabled := false;
end;

procedure Tfrm_Main.cmb_RequestURLChange(Sender: TObject);
var
  LItem: TRESTRequestParams;
begin
  if (FPopupClosed) then
  begin
    FPopupClosed:= FALSE;

    if (cmb_RequestURL.ItemIndex > -1) then
    begin
      LItem := (cmb_RequestURL.Items.Objects[cmb_RequestURL.ItemIndex] AS TRESTRequestParams);
      FRESTParams.Assign(LItem);

      DoPushRequestParamsToControls;
    end;
  end;
end;

procedure Tfrm_Main.cmb_RequestURLClosePopup(Sender: TObject);
begin
  FPopupClosed:= TRUE;

  /// this is not optimal, we have to invoke the onchange-event again
  cmb_RequestURLChange( Sender );
end;

procedure Tfrm_Main.cmb_RequestURLKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if TComboEdit(Sender).Items.Count > 0 then
    if Key = vkReturn then
      btn_ExecuteRequestClick(nil);
end;

procedure Tfrm_Main.DoAddCustomParameter;
var
  LParameter: TRESTRequestParameter;
  LDialog: Tfrm_CustomHeaderDlg;
  LKind: TRESTRequestParameterKind;
begin
  self.DoFetchRequestParamsFromControls;

  LDialog := Tfrm_CustomHeaderDlg.Create(self, NIL);
  try
    if (LDialog.ShowModal = mrOK) then
    begin

      if (LDialog.cmb_ParameterKind.ItemIndex > -1) then
        LKind := RESTRequestParameterKindFromString
          (LDialog.cmb_ParameterKind.Items[LDialog.cmb_ParameterKind.ItemIndex])
      else
        LKind := DefaultRESTRequestParameterKind;

      LParameter := FRESTParams.CustomParams.AddItem;
      LParameter.Name := LDialog.cmb_ParameterName.Text;
      LParameter.Value := LDialog.edt_ParameterValue.Text;
      LParameter.Kind := LKind;

      self.DoPushRequestParamsToControls;
    end;
  finally
    LDialog.Release;
  end;
end;

procedure Tfrm_Main.DoAddToMRUList(const AParams: TRESTRequestParams);
begin
  Assert(Assigned(AParams));

  FMRUList.AddItem(FRESTParams);
  DoUpdateMRUList;
end;

procedure Tfrm_Main.DoCallOAuthAssistant;
var
  frm1: Tfrm_OAuth1;
  frm2: Tfrm_OAuth2;
  res: integer;
begin
  DoFetchRequestParamsFromControls;

  if (FRESTParams.AuthMethod = amOAUTH) then
  begin
    frm1 := Tfrm_OAuth1.Create(self);
    TRY
      frm1.PushParamsToControls(FRESTParams);
      res := frm1.ShowModal;

      if IsPositiveResult(res) then
      begin
        frm1.FetchParamsFromControls(FRESTParams);
        DoPushRequestParamsToControls;
      end;
    FINALLY
      frm1.Release;
    END;
  end
  else if (FRESTParams.AuthMethod = amOAUTH2) then
  begin
    frm2 := Tfrm_OAuth2.Create(self);
    TRY
      frm2.PushParamsToControls(FRESTParams);
      res := frm2.ShowModal;

      if IsPositiveResult(res) then
      begin
        frm2.FetchParamsFromControls(FRESTParams);
        DoPushRequestParamsToControls;
      end;
    FINALLY
      frm2.Release;
    END;
  end;

end;

procedure Tfrm_Main.DoClearMRUList;
begin
  if (MessageDlg(RSConfirmClearRecentRequests, TMsgDlgType.mtConfirmation,
    [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0, TMsgDlgBtn.mbNo) = mrYes) then
  begin
    DoFetchRequestParamsFromControls;

    FMRUList.Clear;
    cmb_RequestURL.Items.Clear;

    DoPushRequestParamsToControls;
  end;
end;

procedure Tfrm_Main.DoClearRequest;
begin
  EditRootElement.Text := '';
  FRESTParams.ResetToDefaults;
  DoPushRequestParamsToControls;
end;

procedure Tfrm_Main.DoEditCustomParameter;
var
  LParameter: TRESTRequestParameter;
  LDialog: Tfrm_CustomHeaderDlg;
begin
  if (lb_CustomParameters.ItemIndex < 0) then
  begin
    MessageDlg(RSNoCustomParameterSelected, TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0);
    EXIT;
  end;

  self.DoFetchRequestParamsFromControls;

  LParameter := FRESTParams.CustomParams.ParameterByIndex(lb_CustomParameters.ItemIndex);

  LDialog := Tfrm_CustomHeaderDlg.Create(self, LParameter);
  try
    if (LDialog.ShowModal = mrOK) then
    begin
      LParameter.Name := LDialog.cmb_ParameterName.Text;
      LParameter.Value := LDialog.edt_ParameterValue.Text;
      if (LDialog.cmb_ParameterKind.ItemIndex > -1) then
        LParameter.Kind := RESTRequestParameterKindFromString
          (LDialog.cmb_ParameterKind.Items[LDialog.cmb_ParameterKind.ItemIndex])
      else
        LParameter.Kind := DefaultRESTRequestParameterKind;

      self.DoPushRequestParamsToControls;
    end;
  finally
    LDialog.Release;
  end;
end;

procedure Tfrm_Main.DoDeleteCustomParameter;
var
  LParameter: TRESTRequestParameter;
begin
  if (lb_CustomParameters.ItemIndex < 0) then
  begin
    MessageDlg(RSNoCustomParameterSelected, TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0);
    EXIT;
  end;

  self.DoFetchRequestParamsFromControls;

  LParameter := FRESTParams.CustomParams.ParameterByIndex(lb_CustomParameters.ItemIndex);

  if (MessageDlg(RSConfirmDeleteCustomParameter + LineFeed + '"' + LParameter.ToString + '"?',
    TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0, TMsgDlgBtn.mbNo) = mrYes) then
  begin
    FRESTParams.CustomParams.Delete(LParameter);
    DoPushRequestParamsToControls;
  end;
end;

procedure Tfrm_Main.DoDisplayHTTPResponse(ARequest: TRESTRequest; AClient: TRESTClient; AResponse: TRESTResponse);
var
  i: integer;
begin
  if AResponse.StatusCode >= 300 then
  begin
    lbl_LastRequestStats.FontColor := claRed;
  end
  else
  begin
    lbl_LastRequestStats.FontColor := claBlack;
  end;

  /// we need to duplicate the ampersands to display them in a label ... ...
  lbl_LastRequestURL.Text := StringReplace( AResponse.FullRequestURI, '&', '&&', [rfReplaceAll] );

  lbl_LastRequestStats.Text :=
    Format(RSBytesOfDataReturnedAndTiming,
    [AResponse.StatusCode, AResponse.StatusText, AResponse.ContentLength,
    ARequest.ExecutionPerformance.PreProcessingTime, ARequest.ExecutionPerformance.ExecutionTime,
    ARequest.ExecutionPerformance.PostProcessingTime, ARequest.ExecutionPerformance.TotalExecutionTime]);

  /// transfer http-headers into memo
  memo_ResponseHeader.Lines.Clear;
  for i := 0 to AResponse.Headers.Count - 1 do
    memo_ResponseHeader.Lines.Add(AResponse.Headers[i]);

  FillReponseContentMemo;
end;

procedure Tfrm_Main.DoExecuteRequest;
begin
  DoFetchRequestParamsFromControls;
  ConfigureProxyServer;

  // Fielddefs are recreated with every request. If FieldDefs already exist,
  // then RestResponseDatasetadpater will try to re-use them - which means that
  // we would end up with no-matching Responses and FieldDefs for different requests
  SaveGridColumnWidths;
  RESTResponseDataSetAdapter.FieldDefs.Clear;

  RESTRequest.ResetToDefaults;
  RESTResponse.ResetToDefaults;

  UpdateComponentProperties;

  if Trim(RESTClient.BaseURL) = '' then
  begin
    TWait.Done;
    MessageDlg(sRESTErrorEmptyURL, TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0);
    exit;
  end;

  try
    RESTRequest.Execute;
  except
    on E: TRESTResponseDataSetAdapter.EJSONValueError do
    begin
      // Ignore
    end;
    on E: TRESTResponse.EJSONValueError do
    begin
      // Ignore
    end
    else
      raise;
  end;
  RestoreGridColumnWidths;

  DoDisplayHTTPResponse(RESTRequest, RESTClient, RESTResponse);

  /// add the current request to the MRU-list
  DoAddToMRUList(FRESTParams);
end;

procedure Tfrm_Main.UpdateComponentProperties;
begin
  //EditRootElement.Text := '';
  DoFetchRequestParamsFromControls;
  ConfigureProxyServer;

  RESTClient.BaseURL := cmb_RequestURL.Text;
  RESTRequest.Resource := FRESTParams.Resource;

  RESTRequest.Params.Clear;
  RESTRequest.Params.Assign(FRESTParams.CustomParams);

  if FRESTParams.CustomBody.Size > 0 then
  begin
    RESTRequest.AddBody(FRESTParams.CustomBody, ContentTypeFromString(FRESTParams.ContentType));
  end;

  RESTRequest.Method := FRESTParams.Method;

  case FRESTParams.AuthMethod of
    TRESTAuthMethod.amNONE:
      begin
        RESTClient.Authenticator := NIL;
      end;
    TRESTAuthMethod.amSIMPLE:
      begin
        RESTClient.Authenticator := SimpleAuthenticator;
        SimpleAuthenticator.Username := FRESTParams.AuthUsername;
        SimpleAuthenticator.UsernameKey := FRESTParams.AuthUsernameKey;
        SimpleAuthenticator.Password := FRESTParams.AuthPassword;
        SimpleAuthenticator.PasswordKey := FRESTParams.AuthPasswordKey;
      end;
    TRESTAuthMethod.amBASIC:
      begin
        RESTClient.Authenticator := HTTPBasicAuthenticator;
        HTTPBasicAuthenticator.Username := FRESTParams.AuthUsername;
        HTTPBasicAuthenticator.Password := FRESTParams.AuthPassword;
      end;
    TRESTAuthMethod.amOAUTH:
      begin
        RESTClient.Authenticator := OAuth1Authenticator;
        OAuth1Authenticator.ConsumerKey := FRESTParams.ClientID;
        OAuth1Authenticator.ConsumerSecret := FRESTParams.ClientSecret;
        OAuth1Authenticator.AccessToken := FRESTParams.AccessToken;
        OAuth1Authenticator.AccessTokenSecret := FRESTParams.AccessTokenSecret;
      end;
    TRESTAuthMethod.amOAUTH2:
      begin
        RESTClient.Authenticator := OAuth2Authenticator;
        OAuth2Authenticator.AccessToken := FRESTParams.AccessToken;
      end;
  else
    raise ERESTException.Create(sRESTUnsupportedAuthMethod);
  end;

  RESTRequest.Client := RESTClient;
end;


procedure Tfrm_Main.DoFetchRequestParamsFromControls;
var
  LURL: string;
  I: Integer;
begin
  /// workaround for a bug in FMX - the onchange-events are triggered too early.
  /// this is not a problem for our objects, but we get an AV while querying a
  /// tedit for it's text.
  if NOT Visible then
    EXIT;

  if (cmb_RequestMethod.ItemIndex > -1) then
    FRESTParams.Method := RESTRequestMethodFromString(cmb_RequestMethod.Items[cmb_RequestMethod.ItemIndex])
  else
    FRESTParams.Method := DefaultRESTRequestMethod;

  LURL := Trim(cmb_RequestURL.Text);
  I := LURL.IndexOf('+ -->');
  if I > 0 then
    LURL := Trim(LURL.Substring(0, I));


  cmb_RequestURL.Text := TRESTHTTPProcs.FixupURL('', LURL);
  FRESTParams.URL := cmb_RequestURL.Text;
  FRESTParams.Resource := edt_Resource.Text;
  FRESTParams.ContentType := edt_ContentType.Text;

  /// after fetching the resource, we try to re-create the parameter-list
  //FRESTParams.CustomParams.FromString('', FRESTParams.Resource);
  FRESTParams.CustomParams.CreateURLSegmentsFromString(FRESTParams.Resource);

  if (cmb_AuthMethod.ItemIndex > -1) then
    FRESTParams.AuthMethod := RESTAuthMethodFromString(cmb_AuthMethod.Items[cmb_AuthMethod.ItemIndex])
  else
    FRESTParams.AuthMethod := DefaultRESTAuthMethod;

  FRESTParams.AuthUsername := edt_AuthUsername.Text;
  FRESTParams.AuthUsernameKey := edt_AuthUsernameKey.Text;
  FRESTParams.AuthPassword := edt_AuthPassword.Text;
  FRESTParams.AuthPasswordKey := edt_AuthPasswordKey.Text;
  FRESTParams.ClientID := edt_AuthClientID.Text;
  FRESTParams.ClientSecret := edt_AuthClientSecret.Text;
  FRESTParams.AccessToken := edt_AuthAccessToken.Text;
  FRESTParams.RequestToken := edt_AuthRequestToken.Text;

  DoUpdateProxyStateLabel;

  FRESTParams.CustomBody.Clear;
  memo_RequestBody.Lines.SaveToStream(FRESTParams.CustomBody);
end;

procedure Tfrm_Main.DoPushRequestParamsToControls;
var
  s: string;
  LParameter: TRESTRequestParameter;
begin
  s := RESTRequestMethodToString(FRESTParams.Method);
  if (cmb_RequestMethod.Items.IndexOf(s) > -1) then
    cmb_RequestMethod.ItemIndex := cmb_RequestMethod.Items.IndexOf(s)
  else
    cmb_RequestMethod.ItemIndex := -1;

  cmb_RequestURL.Text := FRESTParams.URL;
  edt_Resource.Text := FRESTParams.Resource;

  if (edt_ContentType.Items.IndexOf(FRESTParams.ContentType) > -1) then
  begin
    edt_ContentType.ItemIndex := edt_ContentType.Items.IndexOf(FRESTParams.ContentType);
    edt_ContentType.Text := FRESTParams.ContentType;
  end
  else
  begin
    edt_ContentType.ItemIndex := -1;
    edt_ContentType.Text := '';
  end;

  s := RESTAuthMethodToString(FRESTParams.AuthMethod);
  if (cmb_AuthMethod.Items.IndexOf(s) > -1) then
    cmb_AuthMethod.ItemIndex := cmb_AuthMethod.Items.IndexOf(s)
  else
    cmb_RequestMethod.ItemIndex := -1;

  edt_AuthUsername.Text := FRESTParams.AuthUsername;
  edt_AuthUsernameKey.Text := FRESTParams.AuthUsernameKey;
  edt_AuthPassword.Text := FRESTParams.AuthPassword;
  edt_AuthPasswordKey.Text := FRESTParams.AuthPasswordKey;
  edt_AuthClientID.Text := FRESTParams.ClientID;
  edt_AuthClientSecret.Text := FRESTParams.ClientSecret;
  edt_AuthAccessToken.Text := FRESTParams.AccessToken;
  edt_AuthRequestToken.Text := FRESTParams.RequestToken;

  DoUpdateProxyStateLabel;

  lb_CustomParameters.BeginUpdate;
  lb_CustomParameters.Items.BeginUpdate;
  TRY
    lb_CustomParameters.Clear;
    for LParameter IN FRESTParams.CustomParams do
    begin
      lb_CustomParameters.Items.AddObject(LParameter.ToString, LParameter);
    end;
  FINALLY
    lb_CustomParameters.Items.EndUpdate;
    lb_CustomParameters.EndUpdate;
  END;

  if (FRESTParams.CustomBody.Size > 0) then
  begin
    FRESTParams.CustomBody.Seek(0, soFromBeginning);
    memo_RequestBody.Lines.LoadFromStream(FRESTParams.CustomBody);
  end
  else
    memo_RequestBody.Lines.Clear;
end;

procedure Tfrm_Main.DoResetControls;
begin
  lbl_LastRequestStats.Text := '';

  memo_RequestBody.Lines.Clear;
  memo_ResponseHeader.Lines.Clear;
  memo_ResponseBody.Lines.Clear;

  cmb_RequestMethod.ItemIndex := cmb_RequestMethod.Items.IndexOf(RESTRequestMethodToString(DefaultRESTRequestMethod));

  /// try to set the itemindex to the default-value
  cmb_AuthMethod.ItemIndex := cmb_AuthMethod.Items.IndexOf(RESTAuthMethodToString(DefaultRESTAuthMethod));
  edt_AuthUsername.Text := '';
  edt_AuthPassword.Text := '';

  DoUpdateAuthEditFields;

  cbProxy.IsChecked := false;
  edt_ProxyServer.Text := '';
  edt_ProxyUser.Text := '';
  edt_ProxyPass.Text := '';
  edt_ProxyPort.Value := 0;

  lb_CustomParameters.Clear;
end;

procedure Tfrm_Main.DoLoadRequestSettings;
begin
  if dlg_LoadRequestSettings.Execute then
  begin
    FRESTParams.LoadFromFile(dlg_LoadRequestSettings.FileName);
    DoPushRequestParamsToControls;
  end;
end;

procedure Tfrm_Main.DoSaveRequestSettings;
begin
  DoFetchRequestParamsFromControls;
  if dlg_SaveRequestSettings.Execute then
  begin
    FRESTParams.SaveToFile(dlg_SaveRequestSettings.FileName);
  end;
end;

procedure Tfrm_Main.DoUpdateAuthEditFields;
var
  LSelectedMethod: TRESTAuthMethod;
begin
  if (cmb_AuthMethod.ItemIndex > -1) then
    LSelectedMethod := RESTAuthMethodFromString(cmb_AuthMethod.Items[cmb_AuthMethod.ItemIndex])
  else
    LSelectedMethod := DefaultRESTAuthMethod;

  case LSelectedMethod of
    amNONE:
      begin
        edt_AuthUsername.Enabled := false;
        edt_AuthUsernameKey.Enabled := false;
        edt_AuthPassword.Enabled := false;
        edt_AuthPasswordKey.Enabled := false;
        edt_AuthClientID.Enabled := false;
        edt_AuthClientSecret.Enabled := false;
        edt_AuthAccessToken.Enabled := false;
        edt_AuthClientSecret.Enabled := false;
        edt_AuthRequestToken.Enabled := false;

        btn_OAuthAssistant.Enabled := false;
      end;
    amSIMPLE:
      begin
        edt_AuthUsername.Enabled := true;
        edt_AuthUsernameKey.Enabled := true;
        edt_AuthPassword.Enabled := true;
        edt_AuthPasswordKey.Enabled := true;
        edt_AuthClientID.Enabled := false;
        edt_AuthClientSecret.Enabled := false;
        edt_AuthAccessToken.Enabled := false;
        edt_AuthClientSecret.Enabled := false;
        edt_AuthRequestToken.Enabled := false;

        btn_OAuthAssistant.Enabled := false;
      end;
    amBASIC:
      begin
        edt_AuthUsername.Enabled := true;
        edt_AuthUsernameKey.Enabled := false;
        edt_AuthPassword.Enabled := true;
        edt_AuthPasswordKey.Enabled := false;
        edt_AuthClientID.Enabled := false;
        edt_AuthClientSecret.Enabled := false;
        edt_AuthAccessToken.Enabled := false;
        edt_AuthClientSecret.Enabled := false;
        edt_AuthRequestToken.Enabled := false;

        btn_OAuthAssistant.Enabled := false;
      end;
    amOAUTH:
      begin
        edt_AuthUsername.Enabled := false;
        edt_AuthUsernameKey.Enabled := false;
        edt_AuthPassword.Enabled := false;
        edt_AuthPasswordKey.Enabled := false;
        edt_AuthClientID.Enabled := true;
        edt_AuthClientSecret.Enabled := true;
        edt_AuthAccessToken.Enabled := true;
        edt_AuthClientSecret.Enabled := true;
        edt_AuthRequestToken.Enabled := true;

        btn_OAuthAssistant.Enabled := true;
      end;
    amOAUTH2:
      begin
        edt_AuthUsername.Enabled := false;
        edt_AuthUsernameKey.Enabled := false;
        edt_AuthPassword.Enabled := false;
        edt_AuthPasswordKey.Enabled := false;
        edt_AuthClientID.Enabled := true;
        edt_AuthClientSecret.Enabled := true;
        edt_AuthAccessToken.Enabled := true;
        edt_AuthClientSecret.Enabled := true;
        edt_AuthRequestToken.Enabled := true;

        btn_OAuthAssistant.Enabled := true;
      end;
  end;
end;

procedure Tfrm_Main.DoUpdateMRUList;
var
  LItem: TRESTRequestParams;
begin
  cmb_RequestURL.Items.BeginUpdate;
  cmb_RequestURL.Items.Clear;
  for LItem IN FMRUList.Items do
    cmb_RequestURL.Items.AddObject(LItem.ToString, LItem);
  cmb_RequestURL.Items.EndUpdate;

  /// we do know that the last executed request is on top of the
  /// mru-list. so the item-index of the dropdown must be set to
  /// zero.
  if (cmb_RequestURL.Items.Count > 0) AND (cmb_RequestURL.Text <> '') then
    cmb_RequestURL.ItemIndex := 0
  else
    cmb_RequestURL.ItemIndex := -1;

  if (cmb_RequestURL.ItemIndex > -1) then
    cmb_RequestURL.Text := TRESTRequestParams(cmb_RequestURL.Items.Objects[cmb_RequestURL.ItemIndex]).URL;
end;

procedure Tfrm_Main.DoUpdateProxyStateLabel;
begin
  if cbProxy.IsChecked then
  begin
    lbl_ProxyState.Text := RSProxyServerEnabled + edt_ProxyServer.Text;
    if (edt_ProxyPort.Value > 0.1) then
      lbl_ProxyState.Text := lbl_ProxyState.Text + ':' + IntToStr(Trunc(edt_ProxyPort.Value));
  end
  else
    lbl_ProxyState.Text := RSProxyServerDisabled;
end;

procedure Tfrm_Main.EditRootElementChangeTracking(Sender: TObject);
begin
  EditRootElementTab.Text := EditRootElement.Text;
end;

procedure Tfrm_Main.EditRootElementKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if (KeyChar = #0) and (Key = 13) and (Shift = []) then
    UpdateRootElement;
end;

procedure Tfrm_Main.EditRootElementTabChangeTracking(Sender: TObject);
begin
  EditRootElement.Text := EditRootElementTab.Text;
end;

procedure Tfrm_Main.UpdateRootElement;
var
  LIntf: IRESTResponseJSON;
begin
  Assert(EditRootElement.Text = EditRootElementTab.Text);
  if (RESTResponse.RootElement <> EditRootElement.Text) or (cb_NestedFields.IsChecked <> RESTResponseDataSetAdapter.NestedElements) then
  begin

    SaveGridColumnWidths;
    try
     LIntf := RESTResponse;
      if not LIntf.HasJSONResponse then
        if RESTResponse.ContentLength > 0 then
          raise Exception.Create(Format(RSRootElementAppliesToJSON, [EditRootElement.Text]));
      RESTResponse.RootElement := EditRootElement.Text;
    except
      TWait.Done;
      RESTResponse.RootElement := FCurrentRootElement;
      if tc_Response.ActiveTab = ti_Response_TableView then
        EditRootElementTab.SetFocus
      else
      begin
        tc_Response.ActiveTab := ti_Response_Body;
        EditRootElement.SetFocus
      end;
      raise;
    end;
    RESTResponseDataSetAdapter.NestedElements := cb_NestedFields.IsChecked;
    RestoreGridColumnWidths;
    FillReponseContentMemo;
  end;
end;

procedure Tfrm_Main.EditRootElementTabKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if (KeyChar = #0) and (Key = 13) and (Shift = []) then
    UpdateRootElement;
end;

procedure Tfrm_Main.edt_ResourceExit(Sender: TObject);
begin
  DoFetchRequestParamsFromControls;
  //FRESTParams.CustomParams.FromString('', edt_Resource.Text);
  FRESTParams.CustomParams.CreateURLSegmentsFromString(edt_Resource.Text);
  DoPushRequestParamsToControls;
end;

procedure Tfrm_Main.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveProxySettings(FProxyINI);
  FSettingsList.SaveToFile;

  FreeAndNil(FRESTParams);
  FreeAndNil(FMRUList);
  FreeAndNil(FSettingsList);

  Action := TCloseAction.caFree;
end;

procedure Tfrm_Main.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := true;
end;

procedure Tfrm_Main.FormCreate(Sender: TObject);
begin
  /// init the form
  tc_Request.ActiveTab := ti_Request_Basic;
  tc_Response.ActiveTab := ti_Response_Headers;

  InitRequestMethodCombo;
  InitAuthMethodCombo;
  DoResetControls;

  FPopupClosed:= FALSE;

  dlg_LoadRequestSettings.InitialDir := DefaultStorageFolder;
  dlg_SaveRequestSettings.InitialDir := DefaultStorageFolder;

  FRESTParams := TRESTRequestParams.Create;
  FMRUList := TMRUList.Create(DefaultStorageFolder + MRUDBFILE);
  FSettingsList := TSettingsList.Create(DefaultStorageFolder + SETTINGSDBFILE);
  FSettingsList.LoadFromFile;

  FProxyINI := DefaultStorageFolder + PROXYDBFILE;
  LoadProxySettings(FProxyINI);

  DoUpdateMRUList;
  DoPushRequestParamsToControls;
end;

procedure Tfrm_Main.FormDestroy(Sender: TObject);
begin
  SaveProxySettings(FProxyINI);
end;

procedure Tfrm_Main.InitAuthMethodCombo;
var
  LAuthMethod: TRESTAuthMethod;
begin
  cmb_AuthMethod.BeginUpdate;
  TRY
    cmb_AuthMethod.Clear;
    for LAuthMethod IN [Low(TRESTAuthMethod) .. High(TRESTAuthMethod)] do
      cmb_AuthMethod.Items.Add(RESTAuthMethodToString(LAuthMethod));
  FINALLY
    cmb_AuthMethod.EndUpdate;
  END;

  /// try to set the itemindex to the default-value
  if (cmb_AuthMethod.Items.IndexOf(RESTAuthMethodToString(DefaultRESTAuthMethod)) > -1) then
    cmb_AuthMethod.ItemIndex := cmb_AuthMethod.Items.IndexOf(RESTAuthMethodToString(DefaultRESTAuthMethod));
end;

procedure Tfrm_Main.InitRequestMethodCombo;
var
  LRequestMethod: TRESTRequestMethod;
begin
  cmb_RequestMethod.BeginUpdate;
  TRY
    cmb_RequestMethod.Clear;
    for LRequestMethod IN [Low(TRESTRequestMethod) .. High(TRESTRequestMethod)] do
      cmb_RequestMethod.Items.Add(RESTRequestMethodToString(LRequestMethod));
  FINALLY
    cmb_RequestMethod.EndUpdate;
  END;

  /// try to set the itemindex to the default-value
  if (cmb_RequestMethod.Items.IndexOf(RESTRequestMethodToString(DefaultRESTRequestMethod)) > -1) then
    cmb_RequestMethod.ItemIndex := cmb_RequestMethod.Items.IndexOf(RESTRequestMethodToString(DefaultRESTRequestMethod));
end;

procedure Tfrm_Main.KeyDown(var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if (Key = vkF9) then
  begin
    Key := 0;
    DoExecuteRequest;
  end;

  inherited;
end;

procedure Tfrm_Main.FillReponseContentMemo;

  procedure SetLabel(const AValue: string);
  begin
    LabelJson.Text := AValue;
    LabelJsonTab.Text := AValue;
  end;
var
  LJson: TJSONValue;
  LIntf: IRESTResponseJSON;
begin
  // Json or not?
  LJson := RESTResponse.JSONValue;

  if Assigned(LJson) then
  begin
    // it's Json
    memo_ResponseBody.Lines.Text := TJson.Format(LJson);
    SetLabel(RSContentIsValidJSON);
  end
  else
  begin
    LIntf := RESTREsponse;
    // pure text
    memo_ResponseBody.Lines.Text := RESTResponse.Content;
    if LIntf.HasJSONResponse then
      SetLabel(RSInvalidRootElement)
    else
      SetLabel(RSContentIsNotJSON);
    // EditRootElement.Enabled := false;
    // ButtonRootElement.Enabled := false;
  end;
  memo_ResponseBody.Repaint;
end;

procedure Tfrm_Main.ConfigureProxyServer;
begin
  if cbProxy.IsChecked then
  begin
    RESTClient.ProxyServer := edt_ProxyServer.Text;
    RESTClient.ProxyPort := Trunc(edt_ProxyPort.Value);
    RESTClient.ProxyUsername := edt_ProxyUser.Text;
    RESTClient.ProxyPassword := edt_ProxyPass.Text;
  end
  else
  begin
    RESTClient.ProxyServer := '';
    RESTClient.ProxyPort := 0;
    RESTClient.ProxyUsername := '';
    RESTClient.ProxyPassword := '';
  end;
end;

procedure Tfrm_Main.lbl_BaseURLCaptionClick(Sender: TObject);
begin
  DoFetchRequestParamsFromControls;
  DoAddToMRUList(FRESTParams);
end;

procedure Tfrm_Main.lb_CustomParametersDblClick(Sender: TObject);
begin
  DoEditCustomParameter;
end;

procedure Tfrm_Main.LoadProxySettings(const AFilename: string);
var
  LINI: TMemIniFile;
begin
  LINI := TMemIniFile.Create(AFilename);
  TRY
    cbProxy.IsChecked := LINI.ReadBool('proxy', 'enabled', false);
    edt_ProxyServer.Text := LINI.ReadString('proxy', 'server', '');
    edt_ProxyPort.Value := LINI.ReadInteger('proxy', 'port', 0);
    edt_ProxyUser.Text := SimpleDecryptStr(LINI.ReadString('proxy', 'username', SimpleEncryptStr('', AUTH_CRYPTO_VALUE)
      ), AUTH_CRYPTO_VALUE);
    edt_ProxyPass.Text := SimpleDecryptStr(LINI.ReadString('proxy', 'password', SimpleEncryptStr('', AUTH_CRYPTO_VALUE)
      ), AUTH_CRYPTO_VALUE);
  FINALLY
    FreeAndNil(LINI);
  END;

  /// update proxy-controls
  edt_ProxyServer.Enabled := cbProxy.IsChecked;
  edt_ProxyPort.Enabled := cbProxy.IsChecked;
  edt_ProxyUser.Enabled := cbProxy.IsChecked;
  edt_ProxyPass.Enabled := cbProxy.IsChecked;
end;


function Tfrm_Main.MakeWidthKey(const AHeader: string): string;
var
  I, J: Integer;
begin
  Result := AHeader;
  if RESTResponse.RootElement <> '' then
    if RESTResponse.JSONValue is TJSONObject then
      Result := RESTREsponse.RootElement + '.' + AHeader;
  // Normalize [0]
  repeat
    I := Result.IndexOf('[');
    if I >= 0 then
    begin
      J := Result.IndexOf(']', I);
      if J > 0 then
        Result := Result.Substring(0, I) + '||' + Result.Substring(J+1, Length(Result))
      else
        Result := Result.Substring(0, I) + '||';
    end;
  until I < 0;
  if Result.StartsWith('||.') then
    Result := Result.SubString(3);
end;

procedure Tfrm_Main.RESTClientValidateCertificate(const Sender: TObject;
  const ARequest: TURLRequest; const Certificate: TCertificate;
  var Accepted: Boolean);
begin
  if not Accepted then
    if MessageDlg(RSUnableToValidateCertifcate, TMsgDlgType.mtError, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0) = mrYes then
      Accepted := True;

end;

procedure Tfrm_Main.RestoreGridColumnWidths;
var
  I: Integer;
  LColumn: TColumn;
  LKey: string;
  LWidth: Integer;
begin
  for I := 0 to StringGrid1.ColumnCount - 1 do
  begin
    LColumn := StringGrid1.Columns[I];
    LKey := MakeWidthKey(LColumn.Header);
    if FSettingsList.GetWidth(LKey, LWidth) then
      LColumn.Width := LWidth;
  end;
end;

procedure Tfrm_Main.RESTResponseDataSetAdapterBeforeOpenDataSet(
  Sender: TObject);
begin
  FCurrentRootElement := RESTResponse.RootElement;
end;

procedure Tfrm_Main.SaveGridColumnWidths;
var
  I: Integer;
  LColumn: TColumn;
  LKey: string;
begin
  for I := 0 to StringGrid1.ColumnCount - 1 do
  begin
    LColumn := StringGrid1.Columns[I];
    LKey := MakeWidthKey(LColumn.Header);
    FSettingsList.AddWidth(LKey, Round(LColumn.Width));
  end;
  FSettingsList.SaveToFile;

end;

procedure Tfrm_Main.SaveProxySettings(const AFilename: string);
var
  LINI: TMemIniFile;
begin
  LINI := TMemIniFile.Create(AFilename);
  TRY
    LINI.WriteBool('proxy', 'enabled', cbProxy.IsChecked);
    LINI.WriteString('proxy', 'server', edt_ProxyServer.Text);
    LINI.WriteInteger('proxy', 'port', Trunc(edt_ProxyPort.Value));
    LINI.WriteString('proxy', 'username', SimpleEncryptStr(edt_ProxyUser.Text, AUTH_CRYPTO_VALUE));
    LINI.WriteString('proxy', 'password', SimpleEncryptStr(edt_ProxyPass.Text, AUTH_CRYPTO_VALUE));

    LINI.UpdateFile;
  FINALLY
    FreeAndNil(LINI);
  END;
end;

procedure Tfrm_Main.StringGrid1HeaderClick(Column: TColumn);
var
  LPath: string;
begin
  if (Column <> nil) and (not Column.Header.StartsWith('TJSON')) then
  begin
    LPath := FCurrentRootElement;
    if RESTResponse.JSONValue is TJSONArray then
    begin
      if TJSONArray(RESTResponse.JSONValue).Count > 0 then
        LPath := LPath + '[0].' + Column.Header;
    end
    else
    begin
      if LPath <> '' then
        LPath := LPath + '.';
      LPath := LPath + Column.Header;
    end;
  end;
  if LPath <> '' then
    EditRootElementTab.Text := LPath;
end;

procedure Tfrm_Main.tc_RequestChange(Sender: TObject);
begin
  DoFetchRequestParamsFromControls;
end;

procedure Tfrm_Main.SynchEditCaret(AEdit1, AEdit2: TCustomEdit);
var
  LCaret: Integer;
begin
  if AEdit2.Text <> '' then
  begin
    AEdit2.SetFocus;
    AEdit2.SelLength := 0;
    LCaret := AEdit1.CaretPosition;
    AEdit2.CaretPosition := LCaret;
  end;
end;

procedure Tfrm_Main.ti_Response_BodyClick(Sender: TObject);
begin
  SynchEditCaret(EditRootElementTab, EditRootElement);
end;

procedure Tfrm_Main.ti_Response_TableViewClick(Sender: TObject);
begin
  SynchEditCaret(EditRootElement, EditRootElementTab);
end;

initialization

DefaultStorageFolder := IncludeTrailingPathDelimiter(System.IOUtils.TPath.GetDocumentsPath) + 'RESTDebugger' +
  PathDelim;

if NOT TDirectory.Exists(DefaultStorageFolder) then
  TDirectory.CreateDirectory(DefaultStorageFolder);

end.
