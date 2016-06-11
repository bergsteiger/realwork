{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{          FireDAC fetch options editing frame          }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.VCLUI.UpdateOptions;

interface

uses
{$IFDEF MSWINDOWS}
  Winapi.Messages, Winapi.Windows,
{$ENDIF}
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Menus, Vcl.Buttons,
  FireDAC.Stan.Option,
  FireDAC.VCLUI.Controls;

type
  TfrmFDGUIxFormsUpdateOptions = class(TFrame)
    uo_GroupBox3: TPanel;
    uo_Label4: TLabel;
    uo_Label5: TLabel;
    uo_edtUpdateTableName: TEdit;
    uo_cbxUpdateMode: TComboBox;
    uo_cbUpdateChangedFields: TCheckBox;
    uo_cbCountUpdatedRecords: TCheckBox;
    uo_GroupBox2: TPanel;
    uo_Label1: TLabel;
    uo_Label2: TLabel;
    uo_cbxLockMode: TComboBox;
    uo_cbxLockPoint: TComboBox;
    uo_cbLockWait: TCheckBox;
    uo_GroupBox4: TPanel;
    uo_Panel6: TPanel;
    uo_PopupMenu1: TPopupMenu;
    uo_ReadOnly1: TMenuItem;
    uo_ReadWrite1: TMenuItem;
    uo_N1: TMenuItem;
    uo_Fastupdates1: TMenuItem;
    uo_Standardupdates1: TMenuItem;
    uo_cbEnableInsert: TCheckBox;
    uo_cbEnableUpdate: TCheckBox;
    uo_cbEnableDelete: TCheckBox;
    uo_SpeedButton1: TSpeedButton;
    Label1: TLabel;
    uo_cbRefreshMode: TComboBox;
    uo_Label6: TLabel;
    uo_edtKeyFields: TEdit;
    uo_GroupBox5: TPanel;
    uo_Label7: TLabel;
    uo_cbxFetchGeneratorsPoint: TComboBox;
    uo_Label8: TLabel;
    uo_edtGeneratorName: TEdit;
    uo_Label9: TLabel;
    uo_edtAutoIncFields: TEdit;
    uo_cbCheckRequired: TCheckBox;
    uo_cbCheckReadOnly: TCheckBox;
    uo_cbUpdateNonBaseFields: TCheckBox;
    procedure uo_Change(Sender: TObject);
    procedure uo_ReadOnly1Click(Sender: TObject);
    procedure uo_ReadWrite1Click(Sender: TObject);
    procedure uo_Fastupdates1Click(Sender: TObject);
    procedure uo_Standardupdates1Click(Sender: TObject);
    procedure uo_SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
    FOnModified: TNotifyEvent;
    FModifiedLocked: Boolean;
    FSQLGenerator: Boolean;
    FTableOptions: Boolean;
    procedure SetSQLGenerator(const AValue: Boolean);
    procedure SetTableOptions(const Value: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
    procedure LoadFrom(AOpts: TFDUpdateOptions);
    procedure SaveTo(AOpts: TFDUpdateOptions);
  published
    property SQLGenerator: Boolean read FSQLGenerator write SetSQLGenerator
      default False;
    property TableOptions: Boolean read FTableOptions write SetTableOptions
      default True;
    property OnModified: TNotifyEvent read FOnModified write FOnModified;
  end;

implementation

{$R *.dfm}

uses
  Data.DB;

{ --------------------------------------------------------------------------- }
constructor TfrmFDGUIxFormsUpdateOptions.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FTableOptions := True;
end;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFormsUpdateOptions.LoadFrom(AOpts: TFDUpdateOptions);
var
  lBottom: Boolean;
begin
  FModifiedLocked := True;
  try
    lBottom := AOpts is TFDBottomUpdateOptions;
    if not FSQLGenerator then begin
      uo_Label5.Enabled := lBottom;
      uo_edtUpdateTableName.Enabled := lBottom;
      uo_Label6.Enabled := lBottom;
      uo_edtKeyFields.Enabled := lBottom;
      uo_Label9.Enabled := lBottom;
      uo_edtAutoIncFields.Enabled := lBottom;
    end;
    if uo_cbEnableDelete.Enabled then
      uo_cbEnableDelete.Checked := AOpts.EnableDelete;
    if uo_cbEnableInsert.Enabled then
      uo_cbEnableInsert.Checked := AOpts.EnableInsert;
    if uo_cbEnableUpdate.Enabled then
      uo_cbEnableUpdate.Checked := AOpts.EnableUpdate;
    if uo_cbxLockMode.Enabled then
      uo_cbxLockMode.ItemIndex := Integer(AOpts.LockMode);
    if uo_cbxLockPoint.Enabled then
      uo_cbxLockPoint.ItemIndex := Integer(AOpts.LockPoint);
    if uo_cbLockWait.Enabled then
      uo_cbLockWait.Checked := AOpts.LockWait;
    if uo_cbUpdateChangedFields.Enabled then
      uo_cbUpdateChangedFields.Checked := AOpts.UpdateChangedFields;
    if uo_cbUpdateNonBaseFields.Enabled then
      uo_cbUpdateNonBaseFields.Checked := AOpts.UpdateNonBaseFields;
    if uo_cbxUpdateMode.Enabled then
      uo_cbxUpdateMode.ItemIndex := Integer(AOpts.UpdateMode);
    if uo_cbCountUpdatedRecords.Enabled then
      uo_cbCountUpdatedRecords.Checked := AOpts.CountUpdatedRecords;
    if uo_cbRefreshMode.Enabled then
      uo_cbRefreshMode.ItemIndex := Integer(AOpts.RefreshMode);
    if uo_edtUpdateTableName.Enabled and lBottom then
      uo_edtUpdateTableName.Text := TFDBottomUpdateOptions(AOpts).UpdateTableName;
    if uo_edtKeyFields.Enabled and lBottom then
      uo_edtKeyFields.Text := TFDBottomUpdateOptions(AOpts).KeyFields;
    if uo_cbxFetchGeneratorsPoint.Enabled then
      uo_cbxFetchGeneratorsPoint.ItemIndex := Integer(AOpts.FetchGeneratorsPoint);
    if uo_edtGeneratorName.Enabled then
      uo_edtGeneratorName.Text := AOpts.GeneratorName;
    if uo_edtAutoIncFields.Enabled and lBottom then
      uo_edtAutoIncFields.Text := TFDBottomUpdateOptions(AOpts).AutoIncFields;
    if uo_cbCheckRequired.Enabled then
      uo_cbCheckRequired.Checked := AOpts.CheckRequired;
    if uo_cbCheckReadOnly.Enabled then
      uo_cbCheckReadOnly.Checked := AOpts.CheckReadOnly;
  finally
    FModifiedLocked := False;
  end;
end;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFormsUpdateOptions.SaveTo(AOpts: TFDUpdateOptions);
begin
  if uo_cbEnableDelete.Enabled and (AOpts.EnableDelete <> uo_cbEnableDelete.Checked) then
    AOpts.EnableDelete := uo_cbEnableDelete.Checked;
  if uo_cbEnableInsert.Enabled and (AOpts.EnableInsert <> uo_cbEnableInsert.Checked) then
    AOpts.EnableInsert := uo_cbEnableInsert.Checked;
  if uo_cbEnableUpdate.Enabled and (AOpts.EnableUpdate <> uo_cbEnableUpdate.Checked) then
    AOpts.EnableUpdate := uo_cbEnableUpdate.Checked;
  if uo_cbxLockMode.Enabled and (AOpts.LockMode <> TFDLockMode(uo_cbxLockMode.ItemIndex)) then
    AOpts.LockMode := TFDLockMode(uo_cbxLockMode.ItemIndex);
  if uo_cbxLockPoint.Enabled and (AOpts.LockPoint <> TFDLockPoint(uo_cbxLockPoint.ItemIndex)) then
    AOpts.LockPoint := TFDLockPoint(uo_cbxLockPoint.ItemIndex);
  if uo_cbLockWait.Enabled and (AOpts.LockWait <> uo_cbLockWait.Checked) then
    AOpts.LockWait := uo_cbLockWait.Checked;
  if uo_cbUpdateChangedFields.Enabled and (AOpts.UpdateChangedFields <> uo_cbUpdateChangedFields.Checked) then
    AOpts.UpdateChangedFields := uo_cbUpdateChangedFields.Checked;
  if uo_cbUpdateNonBaseFields.Enabled and (AOpts.UpdateNonBaseFields <> uo_cbUpdateNonBaseFields.Checked) then
    AOpts.UpdateNonBaseFields := uo_cbUpdateNonBaseFields.Checked;
  if uo_cbxUpdateMode.Enabled and (AOpts.UpdateMode <> TUpdateMode(uo_cbxUpdateMode.ItemIndex)) then
    AOpts.UpdateMode := TUpdateMode(uo_cbxUpdateMode.ItemIndex);
  if uo_cbCountUpdatedRecords.Enabled and (AOpts.CountUpdatedRecords <> uo_cbCountUpdatedRecords.Checked) then
    AOpts.CountUpdatedRecords := uo_cbCountUpdatedRecords.Checked;
  if uo_cbRefreshMode.Enabled and (AOpts.RefreshMode <> TFDRefreshMode(uo_cbRefreshMode.ItemIndex)) then
    AOpts.RefreshMode := TFDRefreshMode(uo_cbRefreshMode.ItemIndex);
  if uo_edtUpdateTableName.Enabled and (AOpts is TFDBottomUpdateOptions) and
     (TFDBottomUpdateOptions(AOpts).UpdateTableName <> uo_edtUpdateTableName.Text) then
    TFDBottomUpdateOptions(AOpts).UpdateTableName := uo_edtUpdateTableName.Text;
  if uo_edtKeyFields.Enabled and (AOpts is TFDBottomUpdateOptions) and
     (TFDBottomUpdateOptions(AOpts).KeyFields <> uo_edtKeyFields.Text) then
    TFDBottomUpdateOptions(AOpts).KeyFields := uo_edtKeyFields.Text;
  if uo_cbxFetchGeneratorsPoint.Enabled and (AOpts.FetchGeneratorsPoint <> TFDFetchGeneratorsPoint(uo_cbxFetchGeneratorsPoint.ItemIndex)) then
    AOpts.FetchGeneratorsPoint := TFDFetchGeneratorsPoint(uo_cbxFetchGeneratorsPoint.ItemIndex);
  if uo_edtGeneratorName.Enabled and (AOpts.GeneratorName <> uo_edtGeneratorName.Text) then
    AOpts.GeneratorName := uo_edtGeneratorName.Text;
  if uo_edtAutoIncFields.Enabled and (AOpts is TFDBottomUpdateOptions) and
     (TFDBottomUpdateOptions(AOpts).AutoIncFields <> uo_edtAutoIncFields.Text) then
    TFDBottomUpdateOptions(AOpts).AutoIncFields := uo_edtAutoIncFields.Text;
  if uo_cbCheckRequired.Enabled and (uo_cbCheckRequired.Checked <> AOpts.CheckRequired) then
    AOpts.CheckRequired := uo_cbCheckRequired.Checked;
  if uo_cbCheckReadOnly.Enabled and (uo_cbCheckReadOnly.Checked <> AOpts.CheckReadOnly) then
    AOpts.CheckReadOnly := uo_cbCheckReadOnly.Checked;
end;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFormsUpdateOptions.uo_Change(Sender: TObject);
begin
  if not FModifiedLocked and Assigned(FOnModified) then
    FOnModified(Self);
end;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFormsUpdateOptions.SetSQLGenerator(const AValue: Boolean);
begin
  if FSQLGenerator <> AValue then begin
    FSQLGenerator := AValue;
    FModifiedLocked := True;
    try
      uo_Label2.Enabled := not AValue;
      uo_cbxLockPoint.Enabled := not AValue;
      uo_cbUpdateChangedFields.Enabled := not AValue;
      uo_cbUpdateChangedFields.Checked := False;
      uo_cbCheckRequired.Enabled := not AValue;
      uo_cbCheckReadOnly.Enabled := not AValue;
      uo_cbUpdateNonBaseFields.Enabled := not AValue;
      uo_cbUpdateNonBaseFields.Checked := False;
      uo_cbCountUpdatedRecords.Enabled := not AValue;
      uo_cbCountUpdatedRecords.Checked := True;
      uo_Label5.Enabled := not AValue;
      uo_edtUpdateTableName.Enabled := not AValue;
      uo_edtUpdateTableName.Text := '';
      uo_Label6.Enabled := not AValue;
      uo_edtKeyFields.Enabled := not AValue;
      uo_edtKeyFields.Text := '';
      uo_Label7.Enabled := not AValue;
      uo_cbxFetchGeneratorsPoint.Enabled := not AValue;
      uo_cbxFetchGeneratorsPoint.ItemIndex := -1;
      uo_Label8.Enabled := not AValue;
      uo_edtGeneratorName.Enabled := not AValue;
      uo_edtGeneratorName.Text := '';
      uo_Label9.Enabled := not AValue;
      uo_edtAutoIncFields.Enabled := not AValue;
      uo_edtAutoIncFields.Text := '';
    finally
      FModifiedLocked := False;
    end;
  end;
end;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFormsUpdateOptions.SetTableOptions(const Value: Boolean);
begin
  if FTableOptions <> Value then begin
    FTableOptions := Value;
    {
    if FTableOptions then begin
      uo_GroupBox5.Left := 2;
      uo_GroupBox5.Top := 77;
      uo_GroupBox4.Left := 277;
      uo_GroupBox4.Top := 97;
      uo_GroupBox5.Visible := True;
    end
    else begin
      uo_GroupBox5.Visible := False;
      uo_GroupBox4.Left := 2;
      uo_GroupBox4.Top := 77;
    end;
    }
  end;
end;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFormsUpdateOptions.uo_ReadOnly1Click(Sender: TObject);
begin
  uo_cbEnableInsert.Checked := False;
  uo_cbEnableUpdate.Checked := False;
  uo_cbEnableDelete.Checked := False;
end;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFormsUpdateOptions.uo_ReadWrite1Click(Sender: TObject);
begin
  uo_cbEnableInsert.Checked := True;
  uo_cbEnableUpdate.Checked := True;
  uo_cbEnableDelete.Checked := True;
end;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFormsUpdateOptions.uo_Fastupdates1Click(Sender: TObject);
begin
  uo_cbUpdateChangedFields.Checked := False;
  uo_cbxUpdateMode.ItemIndex := 2;
  uo_cbxLockMode.ItemIndex := 2;
  uo_cbRefreshMode.ItemIndex := 0;
  uo_cbCheckRequired.Checked := False;
  uo_cbCheckReadOnly.Checked := False;
end;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFormsUpdateOptions.uo_Standardupdates1Click(Sender: TObject);
begin
  uo_cbUpdateChangedFields.Checked := True;
  uo_cbxUpdateMode.ItemIndex := 0;
  uo_cbxLockMode.ItemIndex := 2;
  uo_cbRefreshMode.ItemIndex := 1;
  uo_cbCheckRequired.Checked := True;
  uo_cbCheckReadOnly.Checked := True;
end;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFormsUpdateOptions.uo_SpeedButton1Click(Sender: TObject);
var
  P: TPoint;
begin
  P := uo_Panel6.ClientToScreen(uo_SpeedButton1.BoundsRect.TopLeft);
  uo_PopupMenu1.Popup(P.X, P.Y);
end;

end.
