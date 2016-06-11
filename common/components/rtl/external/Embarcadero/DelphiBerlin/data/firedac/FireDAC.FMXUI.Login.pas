{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{            FireDAC FireMonkey Login dialog            }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}
{$HPPEMIT LINKUNIT}

unit FireDAC.FMXUI.Login;

interface

{$SCOPEDENUMS ON}

uses
{$IFDEF MSWINDOWS}
  Winapi.Messages, Winapi.Windows,
{$ENDIF}
  System.SysUtils, System.Classes, FMX.Forms, FMX.Dialogs, FMX.Edit, FMX.ListBox,
    FMX.Controls, FMX.Objects, FMX.Types, FMX.Effects, FMX.StdCtrls,
  FireDAC.Stan.Intf,
  FireDAC.UI.Intf, FireDAC.UI, FireDAC.FMXUI.OptsBase;

type
  TFDGUIxFMXLoginDialogImpl = class;
  TfrmFDGUIxFMXLogin = class;

  TFDGUIxFMXLoginDialogImpl = class(TFDGUIxLoginDialogImplBase)
  private
    function CreateDlg: TfrmFDGUIxFMXLogin;
  protected
    function ExecuteLogin: Boolean; override;
    function ExecuteChngPwd: Boolean; override;
  end;

  TfrmFDGUIxFMXLogin = class(TfrmFDGUIxFMXOptsBase)
    pnlLogin: TPanel;
    pnlControls: TPanel;
    pnlHistory: TPanel;
    Label1: TLabel;
    cbxProfiles: TComboBox;
    pnlChngPwd: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    edtNewPassword: TEdit;
    edtNewPassword2: TEdit;
    OpenDialog1: TOpenDialog;
    Line5: TLine;
    Line6: TLine;
    imgEnabled: TImage;
    imgDisabled: TImage;
    imgOpen: TImage;
    pnlButton: TPanel;
    pnlCombo: TPanel;
    ShadowEffect1: TShadowEffect;
    procedure FormCreate(Sender: TObject);
    procedure cbxProfilesClick(Sender: TObject);
    procedure edtNewPasswordChange(Sender: TObject);
    procedure cbxProfilesChange(Sender: TObject);
    procedure FileEditClick(Sender: TObject);
    procedure imgEnabledClick(Sender: TObject);
  private
    FDlg: TFDGUIxFMXLoginDialogImpl;
    FAddToOptionsHeight: Integer;
    FResult: Boolean;
    procedure PostprocessLoginDialog(AOk: Boolean);
  public
    function ExecuteLogin: Boolean;
    function ExecuteChngPwd: Boolean;
  end;

var
  frmFDGUIxFormsLogin: TfrmFDGUIxFMXLogin;

implementation

uses
  System.UITypes,
  FireDAC.Stan.Consts, FireDAC.Stan.Error, FireDAC.Stan.Util, FireDAC.Stan.Factory,
    FireDAC.Stan.ResStrs,
  FireDAC.Phys.Intf;

{$R *.fmx}

{-------------------------------------------------------------------------------}
{ TfrmFDGUIxFMXLogin                                                            }
{-------------------------------------------------------------------------------}
procedure TfrmFDGUIxFMXLogin.PostprocessLoginDialog(AOk: Boolean);
var
  i: Integer;
  oCtrl: TFmxObject;
begin
  try
    if AOk then begin
      for i := 0 to pnlControls.ChildrenCount - 1 do begin
        if not (pnlControls.Children[i] is TPanel) then
          Continue;
        oCtrl := pnlControls.Children[i].Children[2];
        if oCtrl is TCheckBox then
          if FDlg.FParams[oCtrl.Tag].FType = '@Y' then
            FDlg.FConnectionDef.AsYesNo[FDlg.FParams[oCtrl.Tag].FParam] := TCheckBox(oCtrl).IsChecked
          else
            FDlg.FConnectionDef.AsBoolean[FDlg.FParams[oCtrl.Tag].FParam] := TCheckBox(oCtrl).IsChecked
        else if oCtrl is TEdit then
          FDlg.FConnectionDef.AsString[FDlg.FParams[oCtrl.Tag].FParam] := TEdit(oCtrl).Text
        else if oCtrl is TComboBox then
          if TComboBox(oCtrl).ItemIndex <> -1 then
            FDlg.FConnectionDef.AsString[FDlg.FParams[oCtrl.Tag].FParam] := TComboBox(oCtrl).Selected.Text;
      end;
    end;
  finally
    Hide;
  end;
end;

{-------------------------------------------------------------------------------}
function TfrmFDGUIxFMXLogin.ExecuteLogin: Boolean;
var
  i, j: Integer;
  rTmp: TFDLoginItem;
  oPanel: TPanel;
  oLabel: TLabel;
  oCombo: TComboBox;
  oEdit: TEdit;
  oChk: TSwitch;
  oBEdit: TEdit;
  oImg: TImage;
  oEff: TShadowEffect;
  oStream: TMemoryStream;
  oActiveCtrl: TStyledControl;
  oWait: IFDGUIxWaitCursor;
  oObj: TFmxObject;
begin
  pnlChngPwd.Visible := False;
  pnlLogin.Align := TAlignLayout.Client;
  pnlLogin.Visible := True;
  lblPrompt.Text := S_FD_LoginCredentials;

  for i := pnlControls.ChildrenCount - 1 downto 0 do begin
    oObj := pnlControls.Children[i];
    if oObj is TPanel then
      FDFree(oObj);
  end;

  for i := 0 to Length(FDlg.FParams) - 1 do
    for j := i to Length(FDlg.FParams) - 2 do
      if FDlg.FParams[j].FOrder > FDlg.FParams[j + 1].FOrder then begin
        rTmp := FDlg.FParams[j + 1];
        FDlg.FParams[j + 1] := FDlg.FParams[j];
        FDlg.FParams[j] := rTmp;
      end;

  oActiveCtrl := nil;
  for i := 0 to Length(FDlg.FParams) - 1 do begin
    oPanel := TPanel.Create(Self);
    oPanel.StyleLookup := 'backgroundstyle';
    oPanel.Parent := pnlControls;
    oPanel.Position.Y := i * 26;
    oPanel.Position.X := 3;
    oPanel.Height := 26;
    oPanel.Width := pnlControls.Width;

    oLabel := TLabel.Create(Self);
    oLabel.Parent := oPanel;
    oLabel.Position.Y := 5;
    oLabel.Position.X := 3;
    oLabel.Text := FDlg.FParams[i].FCaption + ':';

    if (FDlg.FParams[i].FType = '@L') or (FDlg.FParams[i].FType = '@Y') then begin
      oChk := TSwitch.Create(Self);
      oChk.Parent := oPanel;
      oChk.Position.Y := 2;
      oChk.Position.X := 206;
      oChk.Width := 40;
      oChk.Height := 20;
      oChk.Tag := i;
      oChk.IsChecked := (CompareText(FDlg.FParams[i].FValue, S_FD_True) = 0) or
        (CompareText(FDlg.FParams[i].FValue, S_FD_Yes) = 0);
    end
    else if Copy(FDlg.FParams[i].FType, 1, 2) = '@F' then begin
      oBEdit := TEdit.Create(Self);
      oBEdit.Parent := oPanel;
      oBEdit.Position.Y := 2;
      oBEdit.Position.X := 80;
      oBEdit.Width := 166;
      oBEdit.Tag := i;
      oImg := TImage.Create(Self);
      oImg.Parent := oBEdit;
      oImg.Width := 22;
      oImg.Align := TAlignLayout.Right;
      oImg.OnClick := FileEditClick;
      oImg.Cursor := crArrow;
      oEff := TShadowEffect.Create(Self);
      oEff.Parent := oImg;
      oEff.Trigger := 'IsMouseOver=true';
      oStream := TMemoryStream.Create;
      try
        imgOpen.Bitmap.SaveToStream(oStream);
        oImg.Bitmap.LoadFromStream(oStream);
      finally
        FDFree(oStream);
      end;
      FDGUIxFMXSetupEditor(nil, nil, oBEdit, OpenDialog1, FDlg.FParams[i].FType);
      oBEdit.Text := FDlg.FParams[i].FValue;
      if (oBEdit.Text = '') and (oActiveCtrl = nil) then
        oActiveCtrl := oBEdit;
    end
    else if (FDlg.FParams[i].FType <> '@S') and (FDlg.FParams[i].FType <> '@I') and
            (FDlg.FParams[i].FType <> '@P') then begin
      oCombo := TComboBox.Create(Self);
      oCombo.Parent := oPanel;
      oCombo.Position.Y := 2;
      oCombo.Position.X := 80;
      oCombo.Width := 166;
      oCombo.Tag := i;
      FDGUIxFMXSetupEditor(oCombo, nil, nil, nil, FDlg.FParams[i].FType);
      oCombo.ItemIndex := oCombo.Items.IndexOf(FDlg.FParams[i].FValue);
      if (oCombo.ItemIndex = -1) and (FDlg.FParams[i].FValue <> '') then begin
        oCombo.Items.Add(FDlg.FParams[i].FValue);
        oCombo.ItemIndex := oCombo.Items.Count - 1;
      end;
      if (oCombo.ItemIndex = -1) and (oActiveCtrl = nil) then
        oActiveCtrl := oCombo;
    end
    else begin
      oEdit := TEdit.Create(Self);
      oEdit.Password := FDlg.FParams[i].FType = '@P';
      oEdit.Parent := oPanel;
      oEdit.Position.Y := 2;
      oEdit.Position.X := 80;
      oEdit.Width := 166;
      oEdit.Tag := i;
      oEdit.Text := FDlg.FParams[i].FValue;
      if (oEdit.Text = '') and (oActiveCtrl = nil) then
        oActiveCtrl := oEdit;
    end;
  end;

  ClientHeight := FAddToOptionsHeight + Length(FDlg.FParams) * 26;
  Width := 100 + 160;
  if oActiveCtrl = nil then
    ActiveControl := btnOk
  else
    ActiveControl := oActiveCtrl;

  if FDlg.FHistoryEnabled then begin
    cbxProfiles.Items := FDlg.FHistory;
    cbxProfiles.ItemIndex := FDlg.FHistoryIndex;
    cbxProfiles.OnChange(nil);
  end
  else begin
    cbxProfiles.Items.Clear;
    Height := Height - Trunc(pnlHistory.Height);
    pnlHistory.Visible := False;
  end;

  FDCreateInterface(IFDGUIxWaitCursor, oWait);
  try
    oWait.PopWait;
{$IFNDEF ANDROID}
    FResult := (ShowModal = mrOK);
    PostprocessLoginDialog(FResult);
{$ELSE}
    ShowModal(procedure(AModalResult: TModalResult)
      begin
        FResult := AModalResult = mrOK;
        PostprocessLoginDialog(FResult);
      end);
    WaitModal;
{$ENDIF}
    Result := FResult;
  finally
    oWait.PushWait;
  end;
end;

{-------------------------------------------------------------------------------}
function TfrmFDGUIxFMXLogin.ExecuteChngPwd: Boolean;
begin
  ClientHeight := Trunc(pnlButtons.Height + pnlTop.Height + pnlChngPwd.Height);
  Width := 250;

  pnlLogin.Visible := False;
  pnlChngPwd.Align := TAlignLayout.Client;
  pnlChngPwd.Visible := True;
  lblPrompt.Text := S_FD_LoginNewPassword;

  btnOk.Enabled := False;
  ActiveControl := edtNewPassword;

{$IFNDEF ANDROID}
  FResult := ShowModal = mrOK;
  if FResult then
    FDlg.FConnectionDef.Params.NewPassword := edtNewPassword.Text;
{$ELSE}
  ShowModal(procedure(AModalResult: TModalResult)
    begin
      FResult := AModalResult = mrOK;
      if FResult then
        FDlg.FConnectionDef.Params.NewPassword := edtNewPassword.Text;
      Hide;
    end);
  WaitModal;
{$ENDIF}
  Result := FResult;
end;

{-------------------------------------------------------------------------------}
procedure TfrmFDGUIxFMXLogin.FormCreate(Sender: TObject);
begin
  FAddToOptionsHeight := Trunc(pnlButtons.Height + pnlTop.Height +
    pnlHistory.Height);
end;

{-------------------------------------------------------------------------------}
procedure TfrmFDGUIxFMXLogin.imgEnabledClick(Sender: TObject);
begin
  if cbxProfiles.ItemIndex = -1 then
    Exit;
  FDlg.RemoveHistory(cbxProfiles.Selected.Text);
  cbxProfiles.Items.Delete(cbxProfiles.ItemIndex);
  cbxProfiles.ItemIndex := -1;
end;

{-------------------------------------------------------------------------------}
procedure TfrmFDGUIxFMXLogin.cbxProfilesClick(Sender: TObject);
var
  i: Integer;
  oCtrl: TFmxObject;
  sVal: String;
  oList: TStrings;
  oCombo: TComboBox;
begin
  if cbxProfiles.ItemIndex = -1 then
    Exit;
  oList := TFDStringList.Create;
  try
    FDlg.ReadHistory(cbxProfiles.Selected.Text, oList);
    for i := 0 to pnlControls.ChildrenCount - 1 do begin
      if not (pnlControls.Children[i] is TPanel) then
        Continue;
      oCtrl := pnlControls.Children[i].Children[2];
      if oCtrl is TCheckBox then
        TCheckBox(oCtrl).IsChecked := StrToIntDef(oList.Values[FDlg.FParams[oCtrl.Tag].FParam], 0) <> 0
      else begin
        sVal := oList.Values[FDlg.FParams[oCtrl.Tag].FParam];
        if oCtrl is TEdit then
          TEdit(oCtrl).Text := sVal
        else if oCtrl is TComboBox then begin
          oCombo := TComboBox(oCtrl);
          oCombo.ItemIndex := oCombo.Items.IndexOf(sVal);
        end;
      end;
    end;
  finally
    FDFree(oList);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TfrmFDGUIxFMXLogin.cbxProfilesChange(Sender: TObject);
begin
  imgEnabled.Visible := cbxProfiles.ItemIndex <> -1;
  imgDisabled.Enabled := not imgEnabled.Visible;
  if Visible then
    cbxProfilesClick(nil);
end;

{-------------------------------------------------------------------------------}
procedure TfrmFDGUIxFMXLogin.edtNewPasswordChange(Sender: TObject);
begin
  btnOk.Enabled := (edtNewPassword.Text = edtNewPassword2.Text);
end;

{-------------------------------------------------------------------------------}
procedure TfrmFDGUIxFMXLogin.FileEditClick(Sender: TObject);
var
  oEdit: TEdit;
begin
  oEdit := TEdit(TImage(Sender).Parent);
  OpenDialog1.FileName := oEdit.Text;
  if OpenDialog1.Execute then
    oEdit.Text := OpenDialog1.FileName;
end;

{-------------------------------------------------------------------------------}
{ TFDGUIxFMXLoginDialogImpl                                                     }
{-------------------------------------------------------------------------------}
function TFDGUIxFMXLoginDialogImpl.CreateDlg: TfrmFDGUIxFMXLogin;
begin
  Result := TfrmFDGUIxFMXLogin.Create(Application);
  Result.FDlg := Self;
  Result.Caption := FCaption;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxFMXLoginDialogImpl.ExecuteLogin: Boolean;
var
  oLogin: TfrmFDGUIxFMXLogin;
begin
  oLogin := CreateDlg;
  try
    Result := oLogin.ExecuteLogin;
  finally
    FDFree(oLogin);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxFMXLoginDialogImpl.ExecuteChngPwd: Boolean;
var
  oLogin: TfrmFDGUIxFMXLogin;
begin
  oLogin := CreateDlg;
  try
    Result := oLogin.ExecuteChngPwd;
  finally
    FDFree(oLogin);
  end;
end;

{-------------------------------------------------------------------------------}
var
  oFact: TFDFactory;

initialization
  oFact := TFDMultyInstanceFactory.Create(TFDGUIxFMXLoginDialogImpl,
    IFDGUIxLoginDialog, C_FD_GUIxFMXProvider);

finalization
  FDReleaseFactory(oFact);

end.
