{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{         FireDAC format options editing frame          }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.VCLUI.FormatOptions;

interface

uses
{$IFDEF MSWINDOWS}
  Winapi.Messages, Winapi.Windows,
{$ENDIF}
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, Vcl.Grids, 
    Vcl.ComCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.VCLUI.Controls;

type                                                              
  TfrmFDGUIxFormsFormatOptions = class(TFrame)
    mo_GroupBox1: TPanel;
    mo_Panel3: TPanel;
    mo_sgMapRules: TStringGrid;
    mo_cbxDataType: TComboBox;
    mo_Panel2: TPanel;
    mo_Panel5: TPanel;
    mo_cbOwnMapRules: TCheckBox;
    mo_gb1: TPanel;
    mo_Label2: TLabel;
    mo_Label3: TLabel;
    mo_edtMaxBcdPrecision: TEdit;
    mo_edtMaxBcdScale: TEdit;
    mo_gb2: TPanel;
    mo_Label1: TLabel;
    mo_Label10: TLabel;
    mo_cbStrsEmpty2Null: TCheckBox;
    mo_cbStrsTrim: TCheckBox;
    mo_edtMaxStringSize: TEdit;
    mo_edtInlineDataSize: TEdit;
    mo_btnAddRule: TSpeedButton;
    mo_btnRemRule: TSpeedButton;
    mo_Panel6: TPanel;
    mo_Label6: TLabel;
    mo_cbDefaultParamDataType: TComboBox;
    mo_Panel7: TPanel;
    mo_cbRound2Scale: TCheckBox;
    mo_cbDataSnapCompatibility: TCheckBox;
    mo_Panel1: TPanel;
    mo_Label15: TLabel;
    mo_edtFmtDisplayDate: TEdit;
    mo_Label16: TLabel;
    mo_edtFmtDisplayTime: TEdit;
    mo_Label17: TLabel;
    mo_edtFmtDisplayDateTime: TEdit;
    mo_Label18: TLabel;
    mo_edtFmtDisplayNum: TEdit;
    mo_Label19: TLabel;
    mo_edtFmtEditNum: TEdit;
    mo_cbStrsTrim2Len: TCheckBox;
    mo_cbCheckPrecision: TCheckBox;
    procedure mo_cbOwnMapRulesClick(Sender: TObject);
    procedure mo_btnAddRuleClick(Sender: TObject);
    procedure mo_btnRemRuleClick(Sender: TObject);
    procedure mo_sgMapRulesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mo_sgMapRulesSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure mo_sgMapRulesTopLeftChanged(Sender: TObject);
    procedure mo_cbxDataTypeExit(Sender: TObject);
    procedure mo_cbxDataTypeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mo_sgMapRulesEnter(Sender: TObject);
    procedure mo_Change(Sender: TObject);
  private
    FOnModified: TNotifyEvent;
    FLockModified: Boolean;
    procedure AdjustComboBox(ABox: TComboBox; ACol, ARow: Integer;
      AGrid: TStringGrid);
    { Private declarations }
  public
    procedure LoadFrom(AOpts: TFDFormatOptions);
    procedure SaveTo(AOpts: TFDFormatOptions);
  published
    property OnModified: TNotifyEvent read FOnModified write FOnModified;
  end;

implementation

{$R *.dfm}

uses
  Data.DB,
  FireDAC.Stan.Consts;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFormsFormatOptions.LoadFrom(AOpts: TFDFormatOptions);

  function IntToStrDef(AValue, ADefault: Integer): String;
  begin
    if AValue = ADefault then
      Result := ''
    else
      Result := IntToStr(AValue);
  end;

  function UIntToStrDef(AValue, ADefault: LongWord): String;
  begin
    if AValue = ADefault then
      Result := ''
    else
      Result := IntToStr(AValue);
  end;

var
  i: Integer;
  oRule: TFDMapRule;
begin
  FLockModified := True;
  try
    mo_sgMapRules.Cells[0, 0] := 'SourceDataType';
    mo_sgMapRules.Cells[1, 0] := 'TargetDataType';
    mo_sgMapRules.Cells[2, 0] := 'PrecMin';
    mo_sgMapRules.Cells[3, 0] := 'PrecMax';
    mo_sgMapRules.Cells[4, 0] := 'ScaleMin';
    mo_sgMapRules.Cells[5, 0] := 'ScaleMax';
    mo_sgMapRules.Cells[6, 0] := 'SizeMin';
    mo_sgMapRules.Cells[7, 0] := 'SizeMax';
    mo_sgMapRules.Cells[8, 0] := 'NameMask';
    mo_sgMapRules.Cells[9, 0] := 'TypeMask';
    if AOpts.MapRules.Count = 0 then begin
      mo_sgMapRules.RowCount := 2;
      for i := 0 to mo_sgMapRules.ColCount - 1 do
        mo_sgMapRules.Cells[i, 1] := ''
    end
    else begin
      mo_sgMapRules.RowCount := AOpts.MapRules.Count + 1;
      for i := 0 to AOpts.MapRules.Count - 1 do begin
        oRule := AOpts.MapRules[i];
        mo_sgMapRules.Cells[0, i + 1] := mo_cbxDataType.Items[Integer(oRule.SourceDataType)];
        mo_sgMapRules.Cells[1, i + 1] := mo_cbxDataType.Items[Integer(oRule.TargetDataType)];
        mo_sgMapRules.Cells[2, i + 1] := IntToStrDef(oRule.PrecMin, C_FD_DefMapPrec);
        mo_sgMapRules.Cells[3, i + 1] := IntToStrDef(oRule.PrecMax, C_FD_DefMapPrec);
        mo_sgMapRules.Cells[4, i + 1] := IntToStrDef(oRule.ScaleMin, C_FD_DefMapScale);
        mo_sgMapRules.Cells[5, i + 1] := IntToStrDef(oRule.ScaleMax, C_FD_DefMapScale);
        mo_sgMapRules.Cells[6, i + 1] := UIntToStrDef(oRule.SizeMin, C_FD_DefMapSize);
        mo_sgMapRules.Cells[7, i + 1] := UIntToStrDef(oRule.SizeMax, C_FD_DefMapSize);
        mo_sgMapRules.Cells[8, i + 1] := oRule.NameMask;
        mo_sgMapRules.Cells[9, i + 1] := oRule.TypeMask;
      end;
    end;
    mo_cbOwnMapRules.Checked := AOpts.OwnMapRules;
    mo_sgMapRules.Enabled := mo_cbOwnMapRules.Checked;
    mo_cbStrsEmpty2Null.Checked := AOpts.StrsEmpty2Null;
    mo_cbStrsTrim.Checked := AOpts.StrsTrim;
    mo_cbStrsTrim2Len.Checked := AOpts.StrsTrim2Len;
    mo_edtMaxStringSize.Text := IntToStr(AOpts.MaxStringSize);
    mo_edtMaxBcdPrecision.Text := IntToStr(AOpts.MaxBcdPrecision);
    mo_edtMaxBcdScale.Text := IntToStr(AOpts.MaxBcdScale);
    mo_cbOwnMapRulesClick(nil);
    mo_sgMapRules.DefaultRowHeight := mo_cbxDataType.Height - GetSystemMetrics(SM_CYBORDER);
    mo_edtInlineDataSize.Text := IntToStr(AOpts.InlineDataSize);
    mo_cbDefaultParamDataType.ItemIndex := Integer(AOpts.DefaultParamDataType);
    mo_cbRound2Scale.Checked := AOpts.Round2Scale;
    mo_cbCheckPrecision.Checked := AOpts.CheckPrecision;
    mo_cbDataSnapCompatibility.Checked := AOpts.DataSnapCompatibility;
    mo_edtFmtDisplayDate.Text := AOpts.FmtDisplayDate;
    mo_edtFmtDisplayTime.Text := AOpts.FmtDisplayTime;
    mo_edtFmtDisplayDateTime.Text := AOpts.FmtDisplayDateTime;
    mo_edtFmtDisplayNum.Text := AOpts.FmtDisplayNumeric;
    mo_edtFmtEditNum.Text := AOpts.FmtEditNumeric;
  finally
    FLockModified := False;
  end;
end;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFormsFormatOptions.SaveTo(AOpts: TFDFormatOptions);

  function OneChar(S: String; ADefault: Char): Char;
  begin
    S := Trim(S);
    if S = '' then
      Result := ADefault
    else
      Result := S[1];
  end;

var
  i: Integer;
  oRule: TFDMapRule;
begin
  if AOpts.OwnMapRules <> mo_cbOwnMapRules.Checked then
    AOpts.OwnMapRules := mo_cbOwnMapRules.Checked;
  if AOpts.OwnMapRules then begin
    AOpts.MapRules.Clear;
    for i := 1 to mo_sgMapRules.RowCount - 1 do
      if ((mo_sgMapRules.Cells[0, i] <> '') or (mo_sgMapRules.Cells[8, i] <> '') or
          (mo_sgMapRules.Cells[9, i] <> '')) and
         (mo_sgMapRules.Cells[1, i] <> '') then begin
        oRule := AOpts.MapRules.Add;
        oRule.SourceDataType := TFDDataType(mo_cbxDataType.Items.IndexOf(mo_sgMapRules.Cells[0, i]));
        oRule.TargetDataType := TFDDataType(mo_cbxDataType.Items.IndexOf(mo_sgMapRules.Cells[1, i]));
        oRule.PrecMin := StrToIntDef(mo_sgMapRules.Cells[2, i], C_FD_DefMapPrec);
        oRule.PrecMax := StrToIntDef(mo_sgMapRules.Cells[3, i], C_FD_DefMapPrec);
        oRule.ScaleMin := StrToIntDef(mo_sgMapRules.Cells[4, i], C_FD_DefMapScale);
        oRule.ScaleMax := StrToIntDef(mo_sgMapRules.Cells[5, i], C_FD_DefMapScale);
        oRule.SizeMin := LongWord(StrToIntDef(mo_sgMapRules.Cells[6, i], Integer(C_FD_DefMapSize)));
        oRule.SizeMax := LongWord(StrToIntDef(mo_sgMapRules.Cells[7, i], Integer(C_FD_DefMapSize)));
        oRule.NameMask := Trim(mo_sgMapRules.Cells[8, i]);
        oRule.TypeMask := Trim(mo_sgMapRules.Cells[9, i]);
      end;
  end;
  if AOpts.StrsEmpty2Null <> mo_cbStrsEmpty2Null.Checked then
    AOpts.StrsEmpty2Null := mo_cbStrsEmpty2Null.Checked;
  if AOpts.StrsTrim <> mo_cbStrsTrim.Checked then
    AOpts.StrsTrim := mo_cbStrsTrim.Checked;
  if AOpts.StrsTrim2Len <> mo_cbStrsTrim2Len.Checked then
    AOpts.StrsTrim2Len := mo_cbStrsTrim2Len.Checked;
  if AOpts.MaxStringSize <> LongWord(StrToInt(mo_edtMaxStringSize.Text)) then
    AOpts.MaxStringSize := LongWord(StrToInt(mo_edtMaxStringSize.Text));
  if AOpts.MaxBcdPrecision <> StrToInt(mo_edtMaxBcdPrecision.Text) then
    AOpts.MaxBcdPrecision := StrToInt(mo_edtMaxBcdPrecision.Text);
  if AOpts.MaxBcdScale <> StrToInt(mo_edtMaxBcdScale.Text) then
    AOpts.MaxBcdScale := StrToInt(mo_edtMaxBcdScale.Text);
  if AOpts.InlineDataSize <> StrToInt(mo_edtInlineDataSize.Text) then
    AOpts.InlineDataSize := StrToInt(mo_edtInlineDataSize.Text);
  if mo_cbDefaultParamDataType.ItemIndex <> Integer(AOpts.DefaultParamDataType) then
    AOpts.DefaultParamDataType := TFieldType(mo_cbDefaultParamDataType.ItemIndex);
  if mo_cbRound2Scale.Checked <> AOpts.Round2Scale then
    AOpts.Round2Scale := mo_cbRound2Scale.Checked;
  if mo_cbCheckPrecision.Checked <> AOpts.CheckPrecision then
    AOpts.CheckPrecision := mo_cbCheckPrecision.Checked;
  if mo_cbDataSnapCompatibility.Checked <> AOpts.DataSnapCompatibility then
    AOpts.DataSnapCompatibility := mo_cbDataSnapCompatibility.Checked;
  if mo_edtFmtDisplayDate.Text <> AOpts.FmtDisplayDate then
    AOpts.FmtDisplayDate := mo_edtFmtDisplayDate.Text;
  if mo_edtFmtDisplayTime.Text <> AOpts.FmtDisplayTime then
    AOpts.FmtDisplayTime := mo_edtFmtDisplayTime.Text;
  if mo_edtFmtDisplayDateTime.Text <> AOpts.FmtDisplayDateTime then
    AOpts.FmtDisplayDateTime := mo_edtFmtDisplayDateTime.Text;
  if mo_edtFmtDisplayNum.Text <> AOpts.FmtDisplayNumeric then
    AOpts.FmtDisplayNumeric := mo_edtFmtDisplayNum.Text;
  if mo_edtFmtEditNum.Text <> AOpts.FmtEditNumeric then
    AOpts.FmtEditNumeric := mo_edtFmtEditNum.Text;
end;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFormsFormatOptions.mo_Change(Sender: TObject);
begin
  if not FLockModified and Assigned(FOnModified) then
    FOnModified(Self);
end;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFormsFormatOptions.mo_cbOwnMapRulesClick(Sender: TObject);
begin
  mo_sgMapRules.Enabled := mo_cbOwnMapRules.Checked;
  mo_btnAddRule.Enabled := mo_cbOwnMapRules.Checked;
  mo_btnRemRule.Enabled := mo_cbOwnMapRules.Checked;
  mo_Change(nil);
end;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFormsFormatOptions.mo_btnAddRuleClick(Sender: TObject);
var
  i, j: Integer;
begin
  mo_sgMapRules.RowCount := mo_sgMapRules.RowCount + 1;
  for i := mo_sgMapRules.Row to mo_sgMapRules.RowCount - 2 do
    for j := 0 to mo_sgMapRules.ColCount - 1 do
      mo_sgMapRules.Cells[j, i + 1] := mo_sgMapRules.Cells[j, i];
  mo_Change(nil);
end;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFormsFormatOptions.mo_btnRemRuleClick(Sender: TObject);
var
  i, j: Integer;
begin
  if mo_sgMapRules.RowCount > 1 then begin
    for i := mo_sgMapRules.Row to mo_sgMapRules.RowCount - 2 do
      for j := 0 to mo_sgMapRules.ColCount - 1 do
        mo_sgMapRules.Cells[j, i] := mo_sgMapRules.Cells[j, i + 1];
    if mo_sgMapRules.RowCount = 2 then
      for j := 0 to mo_sgMapRules.ColCount - 1 do
        mo_sgMapRules.Cells[j, 1] := ''
    else
      mo_sgMapRules.RowCount := mo_sgMapRules.RowCount - 1;
    mo_Change(nil);
  end;
end;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFormsFormatOptions.mo_sgMapRulesKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_F2) and mo_cbxDataType.Visible then begin
    mo_cbxDataType.BringToFront;
    mo_cbxDataType.SetFocus;
  end;
end;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFormsFormatOptions.mo_sgMapRulesEnter(Sender: TObject);
var
  lCanSelect: Boolean;
begin
  if not mo_cbxDataType.Visible then
    mo_sgMapRulesSelectCell(mo_sgMapRules, mo_sgMapRules.Col,
      mo_sgMapRules.Row, lCanSelect);
end;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFormsFormatOptions.mo_sgMapRulesSelectCell(Sender: TObject;
  ACol, ARow: Integer; var CanSelect: Boolean);
begin
  if (ARow >= 1) and (ACol <= 1) then begin
    mo_cbxDataType.ItemIndex := mo_cbxDataType.Items.IndexOf(
      mo_sgMapRules.Cells[ACol, ARow]);
    AdjustComboBox(mo_cbxDataType, ACol, ARow, mo_sgMapRules);
  end
  else
    mo_cbxDataType.Visible := False;
  CanSelect := True;
  if mo_cbxDataType.Visible then
    mo_cbxDataType.SetFocus;
end;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFormsFormatOptions.mo_sgMapRulesTopLeftChanged(
  Sender: TObject);
begin
  if mo_cbxDataType.Visible then
    AdjustComboBox(mo_cbxDataType, mo_sgMapRules.Col, mo_sgMapRules.Row, mo_sgMapRules);
end;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFormsFormatOptions.mo_cbxDataTypeExit(Sender: TObject);
begin
  if (mo_cbxDataType.ItemIndex >= 0) and
     (mo_cbxDataType.ItemIndex < mo_cbxDataType.Items.Count) and
     (mo_sgMapRules.Cells[mo_sgMapRules.Col, mo_sgMapRules.Row] <>
        mo_cbxDataType.Items[mo_cbxDataType.ItemIndex]) then begin
    mo_sgMapRules.Cells[mo_sgMapRules.Col, mo_sgMapRules.Row] :=
      mo_cbxDataType.Items[mo_cbxDataType.ItemIndex];
    mo_Change(nil);
  end;
end;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFormsFormatOptions.mo_cbxDataTypeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if mo_cbxDataType.DroppedDown then
    Exit;
  if Key = VK_ESCAPE then begin
    AdjustComboBox(mo_cbxDataType, mo_sgMapRules.Col, mo_sgMapRules.Row, mo_sgMapRules);
    mo_cbxDataType.SelectAll;
    Key := 0;
  end
  else if (Key = VK_RETURN) or (Key = VK_DOWN) then begin
    mo_cbxDataType.OnExit(mo_cbxDataType);
    if mo_sgMapRules.Row < mo_sgMapRules.RowCount - 1 then
      mo_sgMapRules.Row := mo_sgMapRules.Row + 1;
    Key := 0;
  end
  else if Key = VK_UP then begin
    mo_cbxDataType.OnExit(mo_cbxDataType);
    if mo_sgMapRules.Row > mo_sgMapRules.FixedRows then
      mo_sgMapRules.Row := mo_sgMapRules.Row - 1;
    Key := 0;
  end;
end;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFormsFormatOptions.AdjustComboBox(ABox: TComboBox; ACol, ARow: Integer;
  AGrid: TStringGrid);
var
  R: TRect;
begin
  if ABox = nil then
    Exit;
  R := AGrid.CellRect(ACol, ARow);
  R.TopLeft := ABox.Parent.ScreenToClient(AGrid.ClientToScreen(R.TopLeft));
  R.BottomRight := ABox.Parent.ScreenToClient(AGrid.ClientToScreen(R.BottomRight));
  ABox.Left := R.Left;
  ABox.Top := R.Top;
  ABox.Width := R.Right - R.Left + 1;
  ABox.Text := AGrid.Cells[ACol, ARow];
  ABox.Visible := True;
end;

end.
