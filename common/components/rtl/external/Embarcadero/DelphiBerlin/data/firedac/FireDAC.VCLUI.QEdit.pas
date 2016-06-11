{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{             FireDAC TFDQuery editor form              }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.VCLUI.QEdit;

interface

uses
{$IFDEF MSWINDOWS}
  Winapi.Messages, Winapi.Windows,
{$ENDIF}
  System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
    Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Grids,
    Vcl.DBGrids, Data.DB, Vcl.Buttons, Vcl.CheckLst, Vcl.ActnList,
    Vcl.ImgList, System.IniFiles,
  FireDAC.VCLUI.OptsBase, FireDAC.VCLUI.Controls, FireDAC.VCLUI.ResourceOptions,
    FireDAC.VCLUI.UpdateOptions, FireDAC.VCLUI.FormatOptions, FireDAC.VCLUI.FetchOptions,
    FireDAC.VCLUI.Memo, FireDAC.UI.Intf,
  FireDAC.DatS, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
    FireDAC.Stan.Param,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Stan.Async, FireDAC.DApt,
  System.Actions;

type
  TfrmFDGUIxFormsQEdit = class(TfrmFDGUIxFormsOptsBase)
    pcMain: TPageControl;
    pcResult: TPageControl;
    tsSQL: TTabSheet;
    tsAdvOptions: TTabSheet;
    ptAdvOptions: TFDGUIxFormsPanelTree;
    frmFetchOptions: TfrmFDGUIxFormsFetchOptions;
    frmFormatOptions: TfrmFDGUIxFormsFormatOptions;
    frmUpdateOptions: TfrmFDGUIxFormsUpdateOptions;
    frmResourceOptions: TfrmFDGUIxFormsResourceOptions;
    DataSource1: TDataSource;
    tsRecordSet: TTabSheet;
    tsStructure: TTabSheet;
    DBGrid1: TDBGrid;
    Splitter1: TSplitter;
    tsMessages: TTabSheet;
    lvStructure: TListView;
    mmMessages: TMemo;
    tsParameters: TTabSheet;
    lbParams: TListBox;
    Panel19: TPanel;
    tsMacros: TTabSheet;
    FQuery: TFDQuery;
    alActions: TActionList;
    ilImages: TImageList;
    lbMacros: TListBox;
    pnlRight: TPanel;
    Panel16: TPanel;
    btnExecute: TButton;
    btnNextRecordSet: TButton;
    btnQBuilder: TButton;
    acNextRS: TAction;
    acQueryBuilder: TAction;
    acExecute: TAction;
    BitBtn1: TButton;
    acUpdateSQLEditor: TAction;
    acCodeEditor: TAction;
    Bevel5: TBevel;
    Bevel7: TBevel;
    pnlResult: TPanel;
    cbRollback: TCheckBox;
    Label1: TLabel;
    cbParamType: TComboBox;
    Label2: TLabel;
    edtValue: TEdit;
    Label3: TLabel;
    cbDataType: TComboBox;
    Label4: TLabel;
    edtDataSize: TEdit;
    Bevel1: TBevel;
    Label5: TLabel;
    cbArrayType: TComboBox;
    Label6: TLabel;
    edtArraySize: TEdit;
    Label7: TLabel;
    edtPosition: TEdit;
    Bevel4: TBevel;
    Panel1: TPanel;
    Bevel9: TBevel;
    Label10: TLabel;
    Label11: TLabel;
    cbMacroType: TComboBox;
    edtMacroValue: TEdit;
    procedure FormShow(Sender: TObject);
    procedure mmSQLKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lbParamsClick(Sender: TObject);
    procedure lbMacrosClick(Sender: TObject);
    procedure mmSQLChange(Sender: TObject);
    procedure acExecuteExec(Sender: TObject);
    procedure acNextRSExecute(Sender: TObject);
    procedure acNextRSUpdate(Sender: TObject);
    procedure acQueryBuilderExecute(Sender: TObject);
    procedure acExecuteUpdate(Sender: TObject);
    procedure frmOptionsModified(Sender: TObject);
    procedure acUpdateSQLEditorUpdate(Sender: TObject);
    procedure acUpdateSQLEditorExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure pcMainChanging(Sender: TObject; var AllowChange: Boolean);
    procedure edtParametersExit(Sender: TObject);
    procedure edtMacrosExit(Sender: TObject);
  private
    FDefinitionChanged: Boolean;
    mmSQL: TFDGUIxFormsMemo;
    procedure LoadParameters(AIndex: Integer);
    procedure LoadParameter(AIndex: Integer);
    procedure SaveParameter(AIndex: Integer);
    procedure LoadMacros(AIndex: Integer);
    procedure LoadMacro(AIndex: Integer);
    procedure SaveMacros(AIndex: Integer);
    procedure ExecQuery;
    procedure NextRecordSet;
    procedure FillMessages(AMessages: EFDDBEngineException);
    procedure FillStructure(ATable: TFDDatSTable);
    procedure FillInfos;
    procedure UpdateQuery;
    function ExecuteBase(AQuery: TFDCustomQuery; const ACaption: String): Boolean;
  protected
    procedure LoadFormState(AIni: TCustomIniFile); override;
    procedure SaveFormState(AIni: TCustomIniFile); override;
  public
    class function Execute(AQuery: TFDCustomQuery; const ACaption: String): Boolean;
  end;

implementation

uses
  System.Variants, Data.DBCommon, System.Math,
  FireDAC.Stan.Consts, FireDAC.Stan.ResStrs, FireDAC.Stan.Util,
  FireDAC.VCLUI.USEdit;

{$R *.dfm}

{ --------------------------------------------------------------------------- }
function GetStringValue(AValue: Variant): string;
var
  iVarType: Integer;
begin
  iVarType := VarType(AValue);
  if iVarType = varEmpty then
    Result := '<unassigned>'
  else if iVarType = varNull then
    Result := '<null>'
  else
    Result := VarToStr(AValue);
end;

{ --------------------------------------------------------------------------- }
function GetVariantValue(AVarType: Integer; const AValue: string): Variant;
begin
  if CompareText(AValue, '<unassigned>') = 0 then
    Result := Unassigned
  else if CompareText(AValue, '<null>') = 0 then
    Result := Null
  else if AVarType = varError then
    Result := AValue
  else
    VarCast(Result, AValue, AVarType);
end;

{ --------------------------------------------------------------------------- }
{ TfrmFDGUIxFormsQEdit                                                        }
{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFormsQEdit.FormCreate(Sender: TObject);
var
  ePT: TParamType;
  eFT: TFieldType;
  eAT: TFDParamArrayType;
  eMT: TFDMacroDataType;
begin
  mmSQL := TFDGUIxFormsMemo.Create(Self);
  mmSQL.Parent := tsSQL;
  mmSQL.Left := 5;
  mmSQL.Top := 5;
  mmSQL.Width := tsSQL.ClientWidth - 11;
  mmSQL.Height := tsSQL.ClientHeight - 11;
  mmSQL.Align := alNone;
  mmSQL.Anchors := [akLeft, akTop, akRight, akBottom];
  mmSQL.ScrollBars := ssBoth;
  mmSQL.TabOrder := 0;
  mmSQL.OnChange := mmSQLChange;
  mmSQL.OnKeyDown := mmSQLKeyDown;

  cbParamType.Items.Clear;
  for ePT := Low(TParamType) to High(TParamType) do
    cbParamType.Items.Add(C_ParamTypeNames[ePT]);
  cbDataType.Items.Clear;
  for eFT := Low(TFieldType) to High(TFieldType) do
    cbDataType.Items.Add('ft' + FieldTypeNames[eFT]);
  cbArrayType.Items.Clear;
  for eAT := Low(TFDParamArrayType) to High(TFDParamArrayType) do
    cbArrayType.Items.Add(C_FDParamArrayTypeNames[eAT]);
  cbMacroType.Items.Clear;
  for eMT := Low(TFDMacroDataType) to High(TFDMacroDataType) do
    cbMacroType.Items.Add(C_MacroTypeNames[eMT]);

  acQueryBuilder.Visible := False;
  acQueryBuilder.Enabled := False;
end;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFormsQEdit.FormShow(Sender: TObject);
begin
end;

{ --------------------------------------------------------------------------- }
function TfrmFDGUIxFormsQEdit.ExecuteBase(AQuery: TFDCustomQuery;
  const ACaption: String): Boolean;
var
  oConn: TFDCustomConnection;
begin
  LoadState;
  Caption := Format(S_FD_QEditCaption, [ACaption]);
  // Referenced objects
  FQuery.OptionsIntf := AQuery.OptionsIntf;
  FQuery.ConnectionName := AQuery.ConnectionName;
  FQuery.Connection := AQuery.Connection;
  FQuery.UpdateObject := TFDQuery(AQuery).UpdateObject;
  // SQL
  if (AQuery is TFDTable) and (TFDTable(AQuery).SQL.Count = 0) and
     (TFDTable(AQuery).TableName <> '') then
    TFDTable(AQuery).GenerateSQL;
  FQuery.SQL.SetStrings(AQuery.SQL);
  mmSQL.Lines.SetStrings(AQuery.SQL);
  oConn := AQuery.PointedConnection;
  if oConn <> nil then
    mmSQL.RDBMSKind := oConn.RDBMSKind;
  FDefinitionChanged := False;
  // Parameters
  FQuery.Params.Assign(TFDQuery(AQuery).Params);
  LoadParameters(0);
  // Macroses
  FQuery.Macros.Assign(TFDQuery(AQuery).Macros);
  LoadMacros(0);
  // Load options
  frmFetchOptions.LoadFrom(TFDQuery(AQuery).FetchOptions);
  frmUpdateOptions.LoadFrom(TFDQuery(AQuery).UpdateOptions);
  frmFormatOptions.LoadFrom(TFDQuery(AQuery).FormatOptions);
  frmResourceOptions.LoadFrom(TFDQuery(AQuery).ResourceOptions);
  try
    pcMain.ActivePageIndex := 0;
    Result := ShowModal = mrOK;
  finally
    TFDQuery(AQuery).UpdateObject := FQuery.UpdateObject;
  end;
  if Result then begin
    UpdateQuery;
    if AQuery is TFDTable then
      TFDTable(AQuery).TableName := GetTableNameFromSQLEx(FQuery.SQL.Text, idKeepQuotes)
    else begin
      AQuery.SQL.SetStrings(FQuery.SQL);
      TFDQuery(AQuery).Params.Assign(FQuery.Params);
      TFDQuery(AQuery).Macros.Assign(FQuery.Macros);
    end;
    frmFetchOptions.SaveTo(TFDQuery(AQuery).FetchOptions);
    frmUpdateOptions.SaveTo(TFDQuery(AQuery).UpdateOptions);
    frmFormatOptions.SaveTo(TFDQuery(AQuery).FormatOptions);
    frmResourceOptions.SaveTo(TFDQuery(AQuery).ResourceOptions);
  end;
  SaveState;
end;

{ --------------------------------------------------------------------------- }
class function TfrmFDGUIxFormsQEdit.Execute(AQuery: TFDCustomQuery;
  const ACaption: String): Boolean;
var
  oFrm: TfrmFDGUIxFormsQEdit;
begin
  oFrm := TfrmFDGUIxFormsQEdit.Create(nil);
  try
    Result := oFrm.ExecuteBase(AQuery, ACaption);
  finally
    FDFree(oFrm);
  end;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsQEdit.LoadFormState(AIni: TCustomIniFile);
begin
  inherited LoadFormState(AIni);
  // If to uncomment, then form will have pnlButtons in the middle and
  // splitter stops to work.
  //  pnlResult.Height := AIni.ReadInteger(Name, 'Spliter', pnlResult.Height);
  ptAdvOptions.LoadState(Name, AIni);
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsQEdit.SaveFormState(AIni: TCustomIniFile);
begin
  inherited SaveFormState(AIni);
  //  AIni.WriteInteger(Name, 'Spliter', pnlResult.Height);
  ptAdvOptions.SaveState(Name, AIni);
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsQEdit.LoadParameters(AIndex: Integer);
var
  i: Integer;
begin
  lbParams.Items.BeginUpdate;
  try
    lbParams.Items.Clear;
    for i := 0 to FQuery.Params.Count - 1 do
      lbParams.Items.Add(FQuery.Params[i].Name);
    if AIndex > -1 then begin
      if AIndex < lbParams.Items.Count then
        lbParams.ItemIndex := AIndex
      else
        lbParams.ItemIndex := lbParams.Items.Count - 1;
    end
    else if lbParams.Items.Count > 0 then
      lbParams.ItemIndex := 0
    else
      lbParams.ItemIndex := -1;
    lbParamsClick(nil);
  finally
    lbParams.Items.EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsQEdit.LoadParameter(AIndex: Integer);
var
  oParam: TFDParam;
begin
  // Following properties are editable, but in most cases, this is not required
  // - IsCaseSensitive
  // - FDDataType
  // - Precision
  // - NumericScale
  if AIndex >= 0 then begin
    oParam := FQuery.Params[AIndex];
    cbParamType.ItemIndex := Integer(oParam.ParamType);
    cbDataType.ItemIndex := Integer(oParam.DataType);
    edtDataSize.Text := IntToStr(oParam.Size);
    edtValue.Text := GetStringValue(oParam.Value);
    cbArrayType.ItemIndex := Integer(oParam.ArrayType);
    edtArraySize.Text := IntToStr(oParam.ArraySize);
    edtPosition.Text := IntToStr(oParam.Position);
  end
  else begin
    cbParamType.ItemIndex := -1;
    cbDataType.ItemIndex := -1;
    edtDataSize.Text := '';
    edtValue.Text := '';
    cbArrayType.ItemIndex := -1;
    edtArraySize.Text := '';
    edtPosition.Text := '';
  end;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsQEdit.SaveParameter(AIndex: Integer);
var
  oParam: TFDParam;
begin
  if AIndex >= 0 then begin
    oParam := FQuery.Params[AIndex];
    if cbParamType.ItemIndex <> -1 then
      oParam.ParamType := TParamType(cbParamType.ItemIndex);
    if cbDataType.ItemIndex <> -1 then
      oParam.DataType := TFieldType(cbDataType.ItemIndex);
    if edtDataSize.Text <> '' then
      oParam.Size := StrToInt(edtDataSize.Text);
    oParam.Value := GetVariantValue(C_FieldType2VarType[oParam.DataType], edtValue.Text);
    if cbArrayType.ItemIndex <> -1 then
      oParam.ArrayType := TFDParamArrayType(cbArrayType.ItemIndex);
    if edtArraySize.Text <> '' then
      oParam.ArraySize := StrToInt(edtArraySize.Text);
    if edtPosition.Text <> '' then
      oParam.Position := StrToInt(edtPosition.Text);
  end;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsQEdit.LoadMacros(AIndex: Integer);
var
  i: Integer;
begin
  lbMacros.Items.BeginUpdate;
  try
    lbMacros.Items.Clear;
    for i := 0 to FQuery.Macros.Count - 1 do
      lbMacros.Items.Add(FQuery.Macros[i].Name);
    if AIndex > -1 then begin
      if AIndex < lbMacros.Items.Count then
        lbMacros.ItemIndex := AIndex
      else
        lbMacros.ItemIndex := lbMacros.Items.Count - 1;
    end
    else if lbMacros.Items.Count > 0 then
      lbMacros.ItemIndex := 0
    else
      lbMacros.ItemIndex := -1;
    lbMacrosClick(nil);
  finally
    lbMacros.Items.EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsQEdit.LoadMacro(AIndex: Integer);
var
  oMacro: TFDMacro;
begin
  if AIndex >= 0 then begin
    oMacro := FQuery.Macros[AIndex];
    cbMacroType.ItemIndex := Integer(oMacro.DataType);
    edtMacroValue.Text := GetStringValue(oMacro.Value);
  end
  else begin
    cbMacroType.ItemIndex := -1;
    edtMacroValue.Text := '';
  end;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsQEdit.SaveMacros(AIndex: Integer);
var
  oMacro: TFDMacro;
begin
  if AIndex >= 0 then begin
    oMacro := FQuery.Macros[AIndex];
    if cbMacroType.ItemIndex <> -1 then
      oMacro.DataType := TFDMacroDataType(cbMacroType.ItemIndex);
    oMacro.Value := GetVariantValue(C_MacroDataType2VarType[oMacro.DataType], edtMacroValue.Text);
  end;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsQEdit.UpdateQuery;
begin
  if FDefinitionChanged then begin
    FDefinitionChanged := False;
    FQuery.SQL.SetStrings(mmSQL.Lines);
    LoadParameters(lbParams.ItemIndex);
    LoadMacros(lbMacros.ItemIndex);
    frmFetchOptions.SaveTo(FQuery.FetchOptions);
    frmUpdateOptions.SaveTo(FQuery.UpdateOptions);
    frmFormatOptions.SaveTo(FQuery.FormatOptions);
    frmResourceOptions.SaveTo(FQuery.ResourceOptions);
  end;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsQEdit.ExecQuery;
var
  oConn: TFDCustomConnection;
  oConnMeta: IFDPhysConnectionMetadata;
begin
  FQuery.DisableControls;
  try
    FQuery.Disconnect;
    UpdateQuery;
    SaveParameter(lbParams.ItemIndex);
    SaveMacros(lbMacros.ItemIndex);
    oConn := nil;
    if cbRollback.Checked then begin
      oConn := FQuery.Command.AcquireConnection;
      oConn.Open;
      oConn.ConnectionIntf.CreateMetadata(oConnMeta);
      if oConnMeta.TxSupported then
        oConn.StartTransaction;
    end;
    try
      FQuery.Prepare;
      FQuery.OpenOrExecute;
    finally
      FillInfos;
      if cbRollback.Checked then begin
        if oConnMeta.TxSupported then
          oConn.Rollback;
        FQuery.Command.ReleaseConnection(oConn);
      end;
    end;
  finally
    FQuery.EnableControls;
    if not FQuery.Active and
       (FQuery.PointedConnection <> nil) and
       (FQuery.PointedConnection.Messages <> nil) then
      pcResult.ActivePage := tsMessages;
  end;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsQEdit.NextRecordSet;
begin
  FQuery.DisableControls;
  try
    UpdateQuery;
    FQuery.NextRecordSet;
  finally
    FillInfos;
    FQuery.EnableControls;
  end;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsQEdit.FillMessages(AMessages: EFDDBEngineException);
var
  i: Integer;
begin
  mmMessages.Lines.BeginUpdate;
  try
    mmMessages.Lines.Clear;
    if AMessages <> nil then begin
      for i := 0 to AMessages.ErrorCount - 1 do
        mmMessages.Lines.Add(AMessages.Errors[i].Message);
    end;
  finally
    mmMessages.Lines.EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsQEdit.FillStructure(ATable: TFDDatSTable);
var
  i: Integer;
  sTmp: string;
  eAttribute: TFDDataAttribute;
  oColumn: TFDDatSColumn;
  oItem: TListItem;

  function FormatDataType(ADataType: TFDDataType; ASize, APrecision, AScale: Integer): String;
  begin
    Result := C_FD_DataTypeNames[ADataType];
    case ADataType of
    dtAnsiString,
    dtWideString,
    dtByteString:
      Result := Result + Format('(%d)', [ASize]);
    dtSByte,
    dtInt16,
    dtInt32,
    dtInt64,
    dtByte,
    dtUInt16,
    dtUInt32,
    dtUInt64:
      if APrecision > 0 then
        Result := Result + Format('(%d)', [APrecision]);
    dtSingle,
    dtDouble,
    dtExtended,
    dtCurrency,
    dtBCD,
    dtFmtBCD:
      if APrecision = 0 then
        Result := Result + Format('(*, %d)', [AScale])
      else
        Result := Result + Format('(%d, %d)', [APrecision, AScale]);
    dtDateTime,
    dtDateTimeStamp,
    dtTime:
      if AScale > 0 then
        Result := Result + Format('(*, %d msec)', [AScale]);
    dtTimeIntervalFull,
    dtTimeIntervalYM,
    dtTimeIntervalDS:
      if (APrecision <> 0) or (AScale <> 0) then
        if APrecision = 0 then
          Result := Result + Format('(*, %d)', [AScale])
        else
          Result := Result + Format('(%d, %d)', [APrecision, AScale]);
    end;
  end;

begin
  lvStructure.Items.BeginUpdate;
  try
    lvStructure.Items.Clear;
    if ATable <> nil then begin
      for i := 0 to ATable.Columns.Count - 1 do begin
        oColumn := ATable.Columns.ItemsI[i];
        oItem := lvStructure.Items.Add;
        oItem.Caption := oColumn.Name;
        oItem.SubItems.Add(FormatDataType(oColumn.DataType, oColumn.Size,
          oColumn.Precision, oColumn.Scale));
        sTmp := '';
        for eAttribute := Low(TFDDataAttribute) to High(TFDDataAttribute) do
          if eAttribute in oColumn.Attributes then
            sTmp := sTmp + C_FDDataAttributeNames[eAttribute] + '; ';
        if sTmp <> '' then
          SetLength(sTmp, Length(sTmp) - 2);
        oItem.SubItems.Add(sTmp);
        sTmp := oColumn.OriginTabName;
        if oColumn.OriginColName <> '' then begin
          if sTmp <> '' then
            sTmp := sTmp + '.';
          sTmp := sTmp + oColumn.OriginColName;
        end;
        oItem.SubItems.Add(sTmp);
        oItem.SubItems.Add(FormatDataType(oColumn.SourceDataType, oColumn.SourceSize,
          oColumn.SourcePrecision, oColumn.SourceScale));
        oItem.SubItems.Add(oColumn.SourceDataTypeName);
      end;
    end;
  finally
    lvStructure.Items.EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsQEdit.FillInfos;
begin
  if FQuery.Table <> nil then
    FillStructure(FQuery.Table);
  if (FQuery.PointedConnection <> nil) and
     (FQuery.PointedConnection.ConnectionIntf <> nil) and
     (FQuery.PointedConnection.ConnectionIntf.Messages <> nil) then
    FillMessages(FQuery.Connection.ConnectionIntf.Messages);
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsQEdit.lbParamsClick(Sender: TObject);
begin
  LoadParameter(lbParams.ItemIndex);
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsQEdit.edtParametersExit(Sender: TObject);
begin
  SaveParameter(lbParams.ItemIndex);
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsQEdit.lbMacrosClick(Sender: TObject);
begin
  LoadMacro(lbMacros.ItemIndex);
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsQEdit.edtMacrosExit(Sender: TObject);
begin
  SaveMacros(lbMacros.ItemIndex);
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsQEdit.mmSQLChange(Sender: TObject);
begin
  FDefinitionChanged := True;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsQEdit.frmOptionsModified(Sender: TObject);
begin
  FDefinitionChanged := True;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsQEdit.mmSQLKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift = [ssCtrl]) and ((Key = Ord('A')) or (Key = Ord('a'))) then begin
    mmSQL.SelectAll;
    Key := 0;
  end
  else if Key = VK_ESCAPE then begin
    ModalResult := mrCancel;
    Key := 0;
  end;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsQEdit.pcMainChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  UpdateQuery;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsQEdit.acExecuteUpdate(Sender: TObject);
begin
  acExecute.Enabled := mmSQL.Lines.Count > 0;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsQEdit.acExecuteExec(Sender: TObject);
begin
  ExecQuery;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsQEdit.acNextRSUpdate(Sender: TObject);
begin
  acNextRS.Enabled := FQuery.Active;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsQEdit.acNextRSExecute(Sender: TObject);
begin
  NextRecordSet;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsQEdit.acQueryBuilderExecute(Sender: TObject);
begin
//  UpdateQuery;
//  if ShowQueryBuilder then begin
//    FQuery.Close;
//    pcMain.ActivePage := tsSQL;
//  end;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsQEdit.acUpdateSQLEditorUpdate(Sender: TObject);
begin
  acUpdateSQLEditor.Enabled := (FQuery.UpdateObject <> nil) and
    (FQuery.UpdateObject is TFDUpdateSQL);
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsQEdit.acUpdateSQLEditorExecute(Sender: TObject);
begin
  UpdateQuery;
  TfrmFDGUIxFormsUSEdit.Execute(TFDUpdateSQL(FQuery.UpdateObject),
    FQuery.UpdateObject.Name);
end;

end.
