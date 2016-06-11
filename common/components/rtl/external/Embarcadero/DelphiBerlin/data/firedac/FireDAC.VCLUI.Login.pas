{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{                 FireDAC Login dialog                  }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}
{$HPPEMIT LINKUNIT}

unit FireDAC.VCLUI.Login;

interface

uses
{$IFDEF MSWINDOWS}
  Winapi.Messages, Winapi.Windows,
{$ENDIF}
  System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
    Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Dialogs, Vcl.ImgList,
  FireDAC.Stan.Intf,
  FireDAC.UI.Intf, FireDAC.UI, FireDAC.VCLUI.OptsBase;

type
  TFDGUIxFormsLoginDialogImpl = class;
  TfrmFDGUIxFormsLogin = class;

  TFDGUIxFormsLoginDialogImpl = class(TFDGUIxLoginDialogImplBase)
  private
    function CreateDlg: TfrmFDGUIxFormsLogin;
  protected
    function ExecuteLogin: Boolean; override;
    function ExecuteChngPwd: Boolean; override;
  end;

  TfrmFDGUIxFormsLogin = class(TfrmFDGUIxFormsOptsBase)
    pnlLogin: TPanel;
    pnlControls: TPanel;
    pnlHistory: TPanel;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    cbxProfiles: TComboBox;
    Bevel1: TBevel;
    pnlChngPwd: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    edtNewPassword: TEdit;
    edtNewPassword2: TEdit;
    OpenDialog1: TOpenDialog;
    ImageList1: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure cbxProfilesClick(Sender: TObject);
    procedure edtNewPasswordChange(Sender: TObject);
    procedure cbxProfilesChange(Sender: TObject);
    procedure FileEditClick(Sender: TObject);
  private
    FDlg: TFDGUIxFormsLoginDialogImpl;
    FAddToOptionsHeight: Integer;
  public
    function ExecuteLogin: Boolean;
    function ExecuteChngPwd: Boolean;
  end;

var
  frmFDGUIxFormsLogin: TfrmFDGUIxFormsLogin;

implementation

uses
  FireDAC.Stan.Consts, FireDAC.Stan.Error, FireDAC.Stan.Util, FireDAC.Stan.Factory,
    FireDAC.Stan.ResStrs,
  FireDAC.Phys.Intf,
  FireDAC.VCLUI.Controls;

{$R *.dfm}

{-------------------------------------------------------------------------------}
{ TfrmFDGUIxFormsLogin                                                          }
{-------------------------------------------------------------------------------}
type
  __TControl = class(TControl)
  end;

{-------------------------------------------------------------------------------}
function TfrmFDGUIxFormsLogin.ExecuteLogin: Boolean;
var
  i, j: Integer;
  rTmp: TFDLoginItem;
  oPanel: TPanel;
  oLabel: TLabel;
  oCombo: TComboBox;
  oEdit: TEdit;
  oChk: TCheckBox;
  oBEdit: TButtonedEdit;
  oCtrl: TControl;
  oActiveCtrl: TWinControl;
begin
  pnlChngPwd.Visible := False;
  pnlLogin.Align := alClient;
  pnlLogin.Visible := True;
  lblPrompt.Caption := S_FD_LoginCredentials;

  while pnlControls.ControlCount > 0 do
    FDFree(pnlControls.Controls[0]);

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
    oPanel.BevelInner := bvNone;
    oPanel.BevelOuter := bvNone;
    oPanel.BorderStyle := bsNone;
    oPanel.Parent := pnlControls;
    oPanel.Top := i * 26;
    oPanel.Height := 26;
    oPanel.Left := 3;
    oPanel.Width := pnlControls.ClientWidth;

    oLabel := TLabel.Create(Self);
    oLabel.Parent := oPanel;
    oLabel.Top := 5;
    oLabel.Left := 3;
    oLabel.Caption := '&' + FDlg.FParams[i].FCaption + ':';

    if (FDlg.FParams[i].FType = '@L') or (FDlg.FParams[i].FType = '@Y') then begin
      oChk := TCheckBox.Create(Self);
      oChk.Parent := oPanel;
      oChk.Top := 4;
      oChk.Left := 70;
      oChk.Tag := i;
      oChk.Checked := (CompareText(FDlg.FParams[i].FValue, S_FD_True) = 0) or
        (CompareText(FDlg.FParams[i].FValue, S_FD_Yes) = 0);
      oLabel.FocusControl := oChk;
    end
    else if Copy(FDlg.FParams[i].FType, 1, 2) = '@F' then begin
      oBEdit := TButtonedEdit.Create(Self);
      oBEdit.Parent := oPanel;
      oBEdit.Top := 2;
      oBEdit.Left := 70;
      oBEdit.Width := 166;
      oBEdit.Tag := i;
      oBEdit.Images := ImageList1;
      oBEdit.RightButton.ImageIndex := 0;
      oBEdit.RightButton.Visible := True;
      oBEdit.OnRightButtonClick := FileEditClick;
      FDGUIxSetupEditor(nil, nil, oBEdit, OpenDialog1, FDlg.FParams[i].FType);
      oBEdit.Text := FDlg.FParams[i].FValue;
      if (oBEdit.Text = '') and (oActiveCtrl = nil) then
        oActiveCtrl := oBEdit;
      oLabel.FocusControl := oBEdit;
    end
    else if (FDlg.FParams[i].FType <> '@S') and (FDlg.FParams[i].FType <> '@I') and
            (FDlg.FParams[i].FType <> '@P') then begin
      oCombo := TComboBox.Create(Self);
      oCombo.Parent := oPanel;
      oCombo.Top := 2;
      oCombo.Left := 70;
      oCombo.Width := 166;
      oCombo.Tag := i;
      FDGUIxSetupEditor(oCombo, nil, nil, nil, FDlg.FParams[i].FType);
      oCombo.Text := FDlg.FParams[i].FValue;
      if (oCombo.Text = '') and (oActiveCtrl = nil) then
        oActiveCtrl := oCombo;
      oLabel.FocusControl := oCombo;
    end
    else begin
      oEdit := TEdit.Create(Self);
      if FDlg.FParams[i].FType = '@P' then
        oEdit.PasswordChar := '#';
      oEdit.Parent := oPanel;
      oEdit.Top := 2;
      oEdit.Left := 70;
      oEdit.Width := 166;
      oEdit.Tag := i;
      oEdit.Text := FDlg.FParams[i].FValue;
      if (oEdit.Text = '') and (oActiveCtrl = nil) then
        oActiveCtrl := oEdit;
      oLabel.FocusControl := oEdit;
    end;
  end;

  ClientHeight := FAddToOptionsHeight + Length(FDlg.FParams) * 26;
  Width := 100 + 150;
  if oActiveCtrl = nil then
    ActiveControl := btnOk
  else
    ActiveControl := oActiveCtrl;

  if FDlg.FHistoryEnabled then begin
    cbxProfiles.Items := FDlg.FHistory;
    cbxProfiles.ItemIndex := FDlg.FHistoryIndex;
{$IFDEF MSWINDOWS}
    SendMessage(cbxProfiles.Handle, CB_SETDROPPEDWIDTH, Width, 0);
{$ENDIF}
    cbxProfiles.OnChange(nil);
  end
  else begin
    cbxProfiles.Items.Clear;
    Height := Height - pnlHistory.Height;
    pnlHistory.Visible := False;
  end;

  Result := (ShowModal = mrOK);

  if Result then begin
    for i := 0 to pnlControls.ControlCount - 1 do begin
      oCtrl := TPanel(pnlControls.Controls[i]).Controls[1];
      if oCtrl is TCheckBox then
        if FDlg.FParams[oCtrl.Tag].FType = '@Y' then
          FDlg.FConnectionDef.AsYesNo[FDlg.FParams[oCtrl.Tag].FParam] := TCheckBox(oCtrl).Checked
        else
          FDlg.FConnectionDef.AsBoolean[FDlg.FParams[oCtrl.Tag].FParam] := TCheckBox(oCtrl).Checked
      else
        FDlg.FConnectionDef.AsString[FDlg.FParams[oCtrl.Tag].FParam] := __TControl(oCtrl).Caption;
    end;

  end;
  Application.ProcessMessages;
end;

{-------------------------------------------------------------------------------}
function TfrmFDGUIxFormsLogin.ExecuteChngPwd: Boolean;
begin
  ClientHeight := pnlButtons.Height + pnlTop.Height + pnlChngPwd.Height;
  Width := 250;

  pnlLogin.Visible := False;
  pnlChngPwd.Align := alClient;
  pnlChngPwd.Visible := True;
  lblPrompt.Caption := S_FD_LoginNewPassword;

  btnOk.Enabled := False;
  ActiveControl := edtNewPassword;

  Result := (ShowModal = mrOK);
  if Result then
    FDlg.FConnectionDef.Params.NewPassword := edtNewPassword.Text;
end;

{-------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsLogin.FormCreate(Sender: TObject);
begin
  FAddToOptionsHeight := pnlButtons.Height + pnlTop.Height + pnlHistory.Height;
end;

{-------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsLogin.SpeedButton1Click(Sender: TObject);
begin
  if cbxProfiles.ItemIndex = -1 then
    Exit;
  FDlg.RemoveHistory(cbxProfiles.Text);
  cbxProfiles.Items.Delete(cbxProfiles.ItemIndex);
  cbxProfiles.ItemIndex := -1;
  cbxProfiles.Text := '';
end;

{-------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsLogin.cbxProfilesClick(Sender: TObject);
var
  i: Integer;
  oCtrl: TControl;
  oList: TStrings;
begin
  oList := TFDStringList.Create;
  try
    FDlg.ReadHistory(cbxProfiles.Text, oList);
    for i := 0 to pnlControls.ControlCount - 1 do begin
      oCtrl := TPanel(pnlControls.Controls[i]).Controls[1];
      __TControl(oCtrl).Caption := oList.Values[FDlg.FParams[oCtrl.Tag].FParam];
    end;
  finally
    FDFree(oList);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsLogin.cbxProfilesChange(Sender: TObject);
begin
  SpeedButton1.Enabled := cbxProfiles.Text <> '';
end;

{-------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsLogin.edtNewPasswordChange(Sender: TObject);
begin
  btnOk.Enabled := (edtNewPassword.Text = edtNewPassword2.Text);
end;

{-------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsLogin.FileEditClick(Sender: TObject);
begin
  OpenDialog1.FileName := TCustomEdit(Sender).Text;
  if OpenDialog1.Execute then
    TCustomEdit(Sender).Text := OpenDialog1.FileName;
end;

{-------------------------------------------------------------------------------}
{ TFDGUIxFormsLoginDialogImpl                                                   }
{-------------------------------------------------------------------------------}
function TFDGUIxFormsLoginDialogImpl.CreateDlg: TfrmFDGUIxFormsLogin;
begin
  Result := TfrmFDGUIxFormsLogin.Create(Application);
  Result.FDlg := Self;
  Result.Caption := FCaption;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxFormsLoginDialogImpl.ExecuteLogin: Boolean;
var
  oLogin: TfrmFDGUIxFormsLogin;
begin
  oLogin := CreateDlg;
  Result := oLogin.ExecuteLogin;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxFormsLoginDialogImpl.ExecuteChngPwd: Boolean;
var
  oLogin: TfrmFDGUIxFormsLogin;
begin
  oLogin := CreateDlg;
  Result := oLogin.ExecuteChngPwd;
end;

{-------------------------------------------------------------------------------}
var
  oFact: TFDFactory;

initialization
  oFact := TFDMultyInstanceFactory.Create(TFDGUIxFormsLoginDialogImpl,
    IFDGUIxLoginDialog, C_FD_GUIxFormsProvider);

finalization
  FDReleaseFactory(oFact);

end.
