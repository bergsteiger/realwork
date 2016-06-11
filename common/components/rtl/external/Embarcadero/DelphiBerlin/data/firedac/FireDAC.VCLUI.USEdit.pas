{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{           FireDAC TFDUpdateSQL editor form            }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.VCLUI.USEdit;

interface

uses
{$IFDEF MSWINDOWS}
  Winapi.Messages, Winapi.Windows,
{$ENDIF}
  System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms, Vcl.ComCtrls,
    Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Controls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Comp.Client,
  FireDAC.VCLUI.OptsBase, FireDAC.VCLUI.UpdateOptions, FireDAC.VCLUI.Controls,
    FireDAC.VCLUI.Memo;

type
  TfrmFDGUIxFormsUSEdit = class(TfrmFDGUIxFormsOptsBase)
    pcMain: TPageControl;
    tsGenerate: TTabSheet;
    Label1: TLabel;
    cbxTableName: TComboBox;
    btnDSDefaults: TButton;
    btnGenSQL: TButton;
    btnServerInfo: TButton;
    GroupBox2: TLabel;
    lbKeyFields: TListBox;
    GroupBox3: TLabel;
    lbUpdateFields: TListBox;
    GroupBox4: TLabel;
    lbRefetchFields: TListBox;
    tsSQL: TTabSheet;
    tsOptions: TTabSheet;
    ptreeOptions: TFDGUIxFormsPanelTree;
    GroupBox5: TPanel;
    cbQuoteTabName: TCheckBox;
    cbQuoteColName: TCheckBox;
    frmUpdateOptions: TfrmFDGUIxFormsUpdateOptions;
    Bevel4: TBevel;
    Bevel1: TBevel;
    Bevel5: TBevel;
    pcSQL: TPageControl;
    tsInsert: TTabSheet;
    tsModify: TTabSheet;
    tsDelete: TTabSheet;
    tsLock: TTabSheet;
    tsUnlock: TTabSheet;
    tsFetchRow: TTabSheet;
    procedure cbxTableNameDropDown(Sender: TObject);
    procedure btnServerInfoClick(Sender: TObject);
    procedure btnDSDefaultsClick(Sender: TObject);
    procedure btnGenSQLClick(Sender: TObject);
    procedure cbxTableNameExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mmSQLExit(Sender: TObject);
    procedure mmSQLKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbxTableNameChange(Sender: TObject);
    procedure cbxTableNameClick(Sender: TObject);
  private
    FConnection: TFDCustomConnection;
    FDataSet: TFDAdaptedDataSet;
    FUpdateSQL: TFDUpdateSQL;
    FOpts: IFDStanOptions;
    procedure UpdateExistSQLs;
    procedure GenCommands;
    function GetSQL(AIndex: Integer): TFDGUIxFormsMemo;
    function ExecuteBase(AUpdSQL: TFDUpdateSQL; const ACaption: String): Boolean;
    function UseField(const AFieldName: String): Boolean;
  public
    class function Execute(AUpdSQL: TFDUpdateSQL; const ACaption: String): Boolean;
  end;

var
  frmFDGUIxFormsUSEdit: TfrmFDGUIxFormsUSEdit;

implementation

{$R *.dfm}

uses
  System.UITypes,
  Vcl.Dialogs, Data.DB,
  FireDAC.Stan.ResStrs, FireDAC.Stan.Util,
  FireDAC.DatS,
  FireDAC.Phys.Intf;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFormsUSEdit.FormCreate(Sender: TObject);
var
  i: Integer;
  oSQL: TFDGUIxFormsMemo;
begin
  for i := 0 to 5 do begin
    oSQL := TFDGUIxFormsMemo.Create(Self);
    oSQL.Parent := pcSQL.Pages[i];
    oSQL.Left := 5;
    oSQL.Top := 5;
    oSQL.Width := oSQL.Parent.ClientWidth - 12;
    oSQL.Height := oSQL.Parent.ClientHeight - 12;
    oSQL.Anchors := [akLeft, akTop, akRight, akBottom];
    oSQL.Align := alNone;
    oSQL.Visible := True;
    oSQL.OnExit := mmSQLExit;
    oSQL.OnKeyDown := mmSQLKeyDown;
  end;
end;

{ --------------------------------------------------------------------------- }
function TfrmFDGUIxFormsUSEdit.GetSQL(AIndex: Integer): TFDGUIxFormsMemo;
begin
  Result := pcSQL.Pages[AIndex].Controls[0] as TFDGUIxFormsMemo;
end;

{ --------------------------------------------------------------------------- }
function TfrmFDGUIxFormsUSEdit.UseField(const AFieldName: String): Boolean;
begin
  Result := (FDataSet = nil) or (FDataSet.FieldCount = 0) or
    (FDataSet.FindField(AFieldName) <> nil);
end;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFormsUSEdit.cbxTableNameDropDown(Sender: TObject);
begin
{$IFDEF MSWINDOWS}
  cbxTableName.Perform(CB_SETDROPPEDWIDTH, Width div 2, 0);
{$ENDIF}
  if cbxTableName.Items.Count = 0 then
    try
      FConnection.GetTableNames('', '', '', cbxTableName.Items, [osMy]);
    except
      cbxTableName.DroppedDown := False;
      raise;
    end;
end;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFormsUSEdit.cbxTableNameChange(Sender: TObject);
begin
  btnGenSQL.Enabled := (cbxTableName.Text <> '');
end;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFormsUSEdit.cbxTableNameClick(Sender: TObject);
begin
  if cbxTableName.Text <> '' then begin
    btnServerInfoClick(nil);
    btnDSDefaultsClick(nil);
  end;
end;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFormsUSEdit.cbxTableNameExit(Sender: TObject);
begin
end;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFormsUSEdit.btnServerInfoClick(Sender: TObject);
var
  oConnMeta: IFDPhysConnectionMetadata;
  oView: TFDDatSView;
  sName: String;
  eAttrs: TFDDataAttributes;
  i, j: Integer;
begin
  FConnection.ConnectionIntf.CreateMetadata(oConnMeta);
  oView := oConnMeta.GetTableFields('', '', cbxTableName.Text, '');
  try
    lbKeyFields.Items.Clear;
    lbUpdateFields.Items.Clear;
    lbRefetchFields.Items.Clear;
    for i := 0 to oView.Rows.Count - 1 do begin
      sName := oView.Rows[i].GetData('COLUMN_NAME');
      if sName = '' then
        sName := '_' + IntToStr(lbKeyFields.Items.Count);
      lbKeyFields.Items.Add(sName);
      lbUpdateFields.Items.Add(sName);
      lbRefetchFields.Items.Add(sName);
    end;
    for i := 0 to oView.Rows.Count - 1 do begin
      sName := oView.Rows[i].GetData('COLUMN_NAME');
      if UseField(sName) then begin
        j := oView.Rows[i].GetData('COLUMN_ATTRIBUTES');
        eAttrs := TFDDataAttributes(Pointer(@J)^);
        if (sName <> '') and (eAttrs * [caCalculated, caInternal, caUnnamed] = []) then
          lbUpdateFields.Selected[i] := True;
        if eAttrs * [caAutoInc, caROWID, caDefault, caRowVersion, caCalculated, caVolatile] <> [] then
          lbRefetchFields.Selected[i] := True;
      end;
    end;
  finally
    FDFree(oView);
  end;
  oView := oConnMeta.GetTablePrimaryKeyFields('', '', cbxTableName.Text, '');
  try
    for i := 0 to oView.Rows.Count - 1 do begin
      sName := oConnMeta.UnQuoteObjName(oView.Rows[i].GetData('COLUMN_NAME'));
      if UseField(sName) then begin
        j := lbKeyFields.Items.IndexOf(sName);
        if j <> -1 then
          lbKeyFields.Selected[j] := True;
      end;
    end;
  finally
    FDFree(oView);
  end;
end;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFormsUSEdit.btnDSDefaultsClick(Sender: TObject);
var
  oConnMeta: IFDPhysConnectionMetadata;
  i, j: Integer;
  oFld: TField;
  sFldName: String;
begin
  if FDataSet = nil then
    Exit;
  if (FConnection <> nil) and (FConnection.ConnectionIntf <> nil) then
    FConnection.ConnectionIntf.CreateMetadata(oConnMeta)
  else
    oConnMeta := nil;
  if FDataSet.FieldCount <> 0 then begin
    for i := 0 to lbKeyFields.Items.Count - 1 do
      lbKeyFields.Selected[i] := False;
    for i := 0 to lbUpdateFields.Items.Count - 1 do
      lbUpdateFields.Selected[i] := False;
    for i := 0 to lbRefetchFields.Items.Count - 1 do
      lbRefetchFields.Selected[i] := False;
    for i := 0 to FDataSet.FieldCount - 1 do begin
      oFld := FDataSet.Fields[i];
      if oFld.Origin = '' then
        sFldName := oFld.FieldName
      else
        sFldName := oFld.Origin;
      if oConnMeta <> nil then
        sFldName := oConnMeta.UnQuoteObjName(sFldName);
      j := lbKeyFields.Items.IndexOf(sFldName);
      if j <> -1 then begin
        lbKeyFields.Selected[j] := pfInKey in oFld.ProviderFlags;
        lbUpdateFields.Selected[j] := pfInUpdate in oFld.ProviderFlags;
        lbRefetchFields.Selected[j] := (oFld.AutoGenerateValue <> TAutoRefreshFlag.arNone);
      end;
    end;
  end;
  if FDataSet.Adapter <> nil then begin
    FOpts.UpdateOptions.RestoreDefaults;
    frmUpdateOptions.LoadFrom(FOpts.UpdateOptions);
  end;
end;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFormsUSEdit.btnGenSQLClick(Sender: TObject);
begin
  frmUpdateOptions.SaveTo(FOpts.UpdateOptions);
  GenCommands;
  UpdateExistSQLs;
  pcMain.ActivePage := tsSQL;
end;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFormsUSEdit.mmSQLExit(Sender: TObject);
begin
  UpdateExistSQLs;
end;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFormsUSEdit.mmSQLKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift = [ssCtrl]) and ((Key = Ord('A')) or (Key = Ord('a'))) then begin
    TFDGUIxFormsMemo(Sender).SelectAll;
    Key := 0;
  end
  else if Key = VK_ESCAPE then begin
    ModalResult := mrCancel;
    Key := 0;
  end;
end;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFormsUSEdit.UpdateExistSQLs;
var
  i: Integer;
  s: String;
begin
  for i := 0 to 5 do begin
    s := pcSQL.Pages[i].Caption;
    if GetSQL(i).Lines.Count > 0 then begin
      if Pos('*', s) = 0 then
        s := s + ' *';
    end
    else begin
      if Pos('*', s) <> 0 then
        s := Copy(s, 1, Pos('*', s) - 1);
    end;
    pcSQL.Pages[i].Caption := s;
  end;
end;

{ --------------------------------------------------------------------------- }
procedure TfrmFDGUIxFormsUSEdit.GenCommands;
var
  i, j: Integer;
  oCmdGen: IFDPhysCommandGenerator;
  oTab: TFDDatSTable;
  oCol: TFDDatSColumn;
  oFld: TField;
  sFldName: String;
  oCmd: IFDPhysCommand;
  oOpts: IFDStanOptions;
begin
  oTab := TFDDatSTable.Create;
  FConnection.ConnectionIntf.CreateCommand(oCmd);
  try
    oOpts := oCmd.Options;
    oOpts.UpdateOptions.Assign(FOpts.UpdateOptions);
    oOpts.FetchOptions.RowsetSize := 0;
    oOpts.FetchOptions.Mode := fmManual;
    oOpts.FetchOptions.Items := oOpts.FetchOptions.Items + [fiMeta];

    // define table
    oCmd.Prepare('select * from ' + cbxTableName.Text);
    oCmd.Define(oTab);
    oTab.SourceName := cbxTableName.Text;

    // Include into Where only fields existing in dataset and
    // having pfInWhere in ProviderFlags
    if FDataSet <> nil then
      for i := 0 to oTab.Columns.Count - 1 do begin
        oCol := oTab.Columns[i];
        if coInWhere in oCol.Options then begin
          oCol.Options := oCol.Options - [coInWhere];
          for j := 0 to FDataSet.FieldCount - 1 do begin
            oFld := FDataSet.Fields[j];
            if oFld.Origin = '' then
              sFldName := oFld.FieldName
            else
              sFldName := oFld.Origin;
            if (AnsiCompareText(oCol.Name, sFldName) = 0) and
               (pfInWhere in oFld.ProviderFlags) then
              oCol.Options := oCol.Options + [coInWhere];
          end;
        end;
      end;

    // Include into where selected Key fields
    for i := 0 to lbKeyFields.Items.Count - 1 do begin
      oCol := oTab.Columns.ColumnByName(lbKeyFields.Items[i]);
      if lbKeyFields.Selected[i] then
        oCol.Options := oCol.Options + [coInKey, coInWhere]
      else
        oCol.Options := oCol.Options - [coInKey, coInWhere];
    end;

    // Include into update selected Updating fields
    for i := 0 to lbUpdateFields.Items.Count - 1 do begin
      oCol := oTab.Columns.ColumnByName(lbUpdateFields.Items[i]);
      if lbUpdateFields.Selected[i] then
        oCol.Options := oCol.Options + [coInUpdate, coInWhere]
      else
        oCol.Options := oCol.Options - [coInUpdate, coInWhere];
    end;

    // Include into refetch selected Refreshing fields
    for i := 0 to lbRefetchFields.Items.Count - 1 do begin
      oCol := oTab.Columns.ColumnByName(lbRefetchFields.Items[i]);
      if lbRefetchFields.Selected[i] then
        oCol.Options := oCol.Options + [coAfterInsChanged, coAfterUpdChanged]
      else
        oCol.Options := oCol.Options - [coAfterInsChanged, coAfterUpdChanged];
    end;

    // Setup SQL generator
    FConnection.ConnectionIntf.CreateCommandGenerator(oCmdGen, oCmd);
    oCmdGen.FillRowOptions := [foData, foBlobs, foDetails, foClear] +
      FDGetFillRowOptions(oOpts.FetchOptions);
    oCmdGen.GenOptions := [goBeautify];
    if cbQuoteColName.Checked then
      oCmdGen.GenOptions := oCmdGen.GenOptions + [goForceQuoteCol]
    else
      oCmdGen.GenOptions := oCmdGen.GenOptions + [goForceNoQuoteCol];
    if cbQuoteTabName.Checked then
      oCmdGen.GenOptions := oCmdGen.GenOptions + [goForceQuoteTab]
    else
      oCmdGen.GenOptions := oCmdGen.GenOptions + [goForceNoQuoteTab];
    oCmdGen.Options := oOpts;
    oCmdGen.Table := oTab;

    // Generate commands
    if FOpts.UpdateOptions.EnableInsert then
      GetSQL(0).Lines.Text := oCmdGen.GenerateInsert;
    if FOpts.UpdateOptions.EnableUpdate then
      GetSQL(1).Lines.Text := oCmdGen.GenerateUpdate;
    if FOpts.UpdateOptions.EnableDelete then
      GetSQL(2).Lines.Text := oCmdGen.GenerateDelete;
    if FOpts.UpdateOptions.LockMode <> lmNone then begin
      GetSQL(3).Lines.Text := oCmdGen.GenerateLock;
      GetSQL(4).Lines.Text := oCmdGen.GenerateUnLock;
    end;
    oCmdGen.FillRowOptions := oCmdGen.FillRowOptions + [foAfterIns, foAfterUpd];
    GetSQL(5).Lines.Text := oCmdGen.GenerateSelect(False);
  finally
    FDFree(oTab);
    oCmdGen := nil;
    oCmd := nil;
  end;
end;

{ --------------------------------------------------------------------------- }
function TfrmFDGUIxFormsUSEdit.ExecuteBase(AUpdSQL: TFDUpdateSQL; const ACaption: String): Boolean;
var
  oTestCmd: TFDCustomCommand;
  i: Integer;

  function GetConnection: TFDCustomConnection;
  begin
    if FUpdateSQL.ConnectionName <> '' then
      Result := FDManager.AcquireConnection(FUpdateSQL.ConnectionName, FUpdateSQL.Name)
    else begin
      if FUpdateSQL.Connection <> nil then
        Result := FUpdateSQL.Connection
      else if (FDataSet <> nil) and (FDataSet.PointedConnection <> nil) then
        Result := FDataSet.PointedConnection
      else
        Result := oTestCmd.GetConnection(False);
      if Result = nil then
        raise Exception.Create(S_FD_USEditCantEdit);
      Result := FDManager.AcquireConnection(Result, FUpdateSQL.Name);
    end;
  end;

  function GetParentObject: TPersistent;
  begin
    if FDataSet <> nil then
      Result := FDataSet
    else
      Result := oTestCmd;
  end;

  function GetUpdateOptions: TFDBottomUpdateOptions;
  begin
    if FDataSet <> nil then
      Result := FDataSet.OptionsIntf.UpdateOptions as TFDBottomUpdateOptions
    else
      Result := oTestCmd.UpdateOptions;
  end;

begin
  LoadState;
  FUpdateSQL := AUpdSQL;
  FDataSet := FUpdateSQL.DataSet;
  oTestCmd := FUpdateSQL.Commands[arInsert];
  FConnection := GetConnection;
  try
    FConnection.CheckActive;
    if (FDataSet <> nil) and not FDataSet.Active and
       (FDataSet.Command <> nil) and (Trim(FDataSet.Command.CommandText.Text) <> '') and
       (MessageDlg(S_FD_USEditOpenDS, mtConfirmation, [mbYes, mbNo], -1) = mrYes) then
      FDataSet.Open;

    FOpts := TFDOptionsContainer.Create(GetParentObject, TFDFetchOptions,
      TFDUpdateOptions, TFDTopResourceOptions, nil);
    FOpts.ParentOptions := GetUpdateOptions.Container as IFDStanOptions;
    FOpts.UpdateOptions.Assign(GetUpdateOptions);

    Caption := Format(S_FD_USEditCaption, [ACaption]);
    btnDSDefaults.Enabled := (FDataSet <> nil);
    btnGenSQL.Enabled := False;
    pcMain.ActivePage := tsGenerate;
    ActiveControl := cbxTableName;

    frmUpdateOptions.LoadFrom(FOpts.UpdateOptions);
    frmUpdateOptions.SQLGenerator := True;

    cbxTableName.Text := GetUpdateOptions.UpdateTableName;
    if (cbxTableName.Text = '') and (FDataSet <> nil) and (FDataSet.Table <> nil) then
      cbxTableName.Text := FDataSet.Table.ActualOriginName;
    if cbxTableName.Text <> '' then begin
      cbxTableNameChange(cbxTableName);
      cbxTableNameClick(cbxTableName);
    end;

    if btnDSDefaults.Enabled then
      btnDSDefaultsClick(nil);

    for i := 0 to 5 do
      GetSQL(0).RDBMSKind := FConnection.RDBMSKind;
    GetSQL(0).Lines.SetStrings(AUpdSQL.InsertSQL);
    GetSQL(1).Lines.SetStrings(AUpdSQL.ModifySQL);
    GetSQL(2).Lines.SetStrings(AUpdSQL.DeleteSQL);
    GetSQL(3).Lines.SetStrings(AUpdSQL.LockSQL);
    GetSQL(4).Lines.SetStrings(AUpdSQL.UnlockSQL);
    GetSQL(5).Lines.SetStrings(AUpdSQL.FetchRowSQL);
    UpdateExistSQLs;

    Result := (ShowModal = mrOK);

  finally
    FDManager.ReleaseConnection(FConnection);
  end;

  if Result then begin
    AUpdSQL.InsertSQL.SetStrings(GetSQL(0).Lines);
    AUpdSQL.ModifySQL.SetStrings(GetSQL(1).Lines);
    AUpdSQL.DeleteSQL.SetStrings(GetSQL(2).Lines);
    AUpdSQL.LockSQL.SetStrings(GetSQL(3).Lines);
    AUpdSQL.UnlockSQL.SetStrings(GetSQL(4).Lines);
    AUpdSQL.FetchRowSQL.SetStrings(GetSQL(5).Lines);
  end;
  SaveState;
end;

{ --------------------------------------------------------------------------- }
class function TfrmFDGUIxFormsUSEdit.Execute(AUpdSQL: TFDUpdateSQL; const ACaption: String): Boolean;
var
  oFrm: TfrmFDGUIxFormsUSEdit;
begin
  oFrm := TfrmFDGUIxFormsUSEdit.Create(nil);
  try
    Result := oFrm.ExecuteBase(AUpdSQL, ACaption);
  finally
    FDFree(oFrm);
  end;
end;

end.

