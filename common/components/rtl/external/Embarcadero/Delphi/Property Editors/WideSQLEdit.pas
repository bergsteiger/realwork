{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{*******************************************************}
{             Generic SQL Property Editor               }
{*******************************************************}

unit WideSqlEdit;

interface

uses Forms, SysUtils,
  ActnList, StdCtrls, Controls, Graphics, ExtCtrls, SqlEdit,
//  IDEWideStdCtrls,
//  IDEWideControls,
  WideStrings, Classes;


type

  TGetTableNamesProcW = procedure(List: TWideStrings; SystemTables: Boolean) of object;
  TGetTableNamesForSchemaProcW = procedure(List: TWideStrings; SchemaName: WideString; SystemTables: Boolean) of object;
  TGetFieldNamesProcW = procedure(const TableName: WideString; List: TWideStrings) of Object;
  TGetFieldNamesForSchemaProcW = procedure (const TableName: WideString; SchemaName: WideString; List: TWideStrings) of object;
  TRequiresQuoteCharProcW = function(const Name: WideString): Boolean of Object;

  TWideSQLEditForm = class(TSQLEditForm)
    procedure FormShow(Sender: TObject);
    procedure HelpButtonClick(Sender: TObject);
    procedure TableFieldsSplitterCanResize(Sender: TObject; var NewSize: Integer;
      var Accept: Boolean);
    procedure MetaInfoSQLSplitterCanResize(Sender: TObject;
      var NewSize: Integer; var Accept: Boolean);
    procedure MetaInfoSQLSplitterMoved(Sender: TObject);
    procedure TableListClick(Sender: TObject);
    procedure AddTableButtonClick(Sender: TObject);
    procedure AddFieldButtonClick(Sender: TObject);
    procedure SQLMemoExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SQLMemoEnter(Sender: TObject);
    procedure FormUpdateActionUpdate(Sender: TObject);
  private
    CharHeight: Integer;
    FQuoteChar: WideString;
    SQLCanvas: TControlCanvas;
    procedure InsertText(Text: WideString; AddComma: Boolean = True);
    procedure DrawCaretPosIndicator;
  protected
    FStartTable: WideString;
    FSchemaName: WideString;
    NameRequiresQuoteCharW : TRequiresQuoteCharProcW;
    GetTableNamesForSchemaW : TGetTableNamesForSchemaProcW;
    GetTableNamesW: TGetTableNamesProcW;
    GetFieldNamesW: TGetFieldNamesProcW;
    GetFieldNamesForSchemaW: TGetFieldNamesForSchemaProcW;
    procedure PopulateTableList;
    procedure PopulateFieldList;
    property QuoteChar: WideString read FQuoteChar write FQuoteChar;
    property StartTable: WideString read FStartTable write FStartTable;
  end;

function EditSQL(var SQL: WideString;
                 AGetTableNames: TGetTableNamesProcW;
                 AGetFieldNames: TGetFieldNamesProcW;
                 AStartTblName : WideString = '';
                 AQuoteChar : WideString = '';
                 ANeedsQuoteCharFunc: TRequiresQuoteCharProcW = Nil): Boolean; overload;

function EditSQL(var SQL: WideString;
                 AGetTableNamesForSchema: TGetTableNamesForSchemaProcW;
                 AGetFieldNames: TGetFieldNamesProcW;
                 AStartTblName : WideString = '';
                 AQuoteChar : WideString = '';
                 ANeedsQuoteCharFunc: TRequiresQuoteCharProcW = nil;
                 SchemaName : WideString = ''): Boolean; overload;

function EditSQL(SQL: TWideStrings;
                 AGetTableNames: TGetTableNamesProcW;
                 AGetFieldNames: TGetFieldNamesProcW;
                 AStartTblName : WideString = '';
                 AQuoteChar : WideString = '';
                 ANeedsQuoteCharFunc: TRequiresQuoteCharProcW = nil): Boolean; overload;

function EditSQLSchema(var SQL: WideString;
                 AGetTableNamesForSchema: TGetTableNamesForSchemaProcW;
                 AGetFieldNamesForSchema: TGetFieldNamesForSchemaProcW;
                 AStartTblName : WideString = '';
                 AQuoteChar : WideString = '';
                 ANeedsQuoteCharFunc: TRequiresQuoteCharProcW = Nil;
                 SchemaName : WideString = ''): Boolean; overload;

function DefaultReqQuoteChar( Name: WideString): Boolean;

implementation

uses
  //IDEWideGraphics,
  WideStrUtils;

{$R *.dfm}

const
  SSelect = 'select'; { Do not localize }
  SFrom = 'from'; { Do not localize }

function BaseEditSQL(var SQL: WideString;
                     AGetTableNames: TGetTableNamesProcW;
                     AGetTableNamesForSchema: TGetTableNamesForSchemaProcW = Nil;
                     AGetFieldNames: TGetFieldNamesProcW = nil;
                     AGetFieldNamesForSchema: TGetFieldNamesForSchemaProcW = Nil;
                     ANeedsQuoteCharFunc: TRequiresQuoteCharProcW = nil;
                     AStartTblName : WideString = '';
                     AQuoteChar : WideString = '';
                     ASchemaName : WideString = ''): Boolean; overload;
begin
  with TWideSQLEditForm.Create(nil) do
  try
    GetTableNamesForSchemaW := AGetTableNamesForSchema;
    GetTableNamesW := AGetTableNames;
    GetFieldNamesForSchemaW := AGetFieldNamesForSchema;
    GetFieldNamesW := AGetFieldNames;
    QuoteChar := AQuoteChar;
    StartTable := AStartTblName;
    FSchemaName := ASchemaName;
    NameRequiresQuoteCharW := ANeedsQuoteCharFunc;
    SQLMemo.Lines.Text := SQL;
    Result := ShowModal = mrOK;
    if Result then
      SQL := SQLMemo.Lines.Text;
  finally
    Free;
  end;
end;

function EditSQL(var SQL: Widestring; AGetTableNamesForSchema: TGetTableNamesForSchemaProcW;
  AGetFieldNames: TGetFieldNamesProcW; AStartTblName : Widestring = ''; AQuoteChar : Widestring = '';
  ANeedsQuoteCharFunc: TRequiresQuoteCharProcW = nil; SchemaName : Widestring = ''): Boolean; overload;
var
  AGTNP: TGetTableNamesProcW;
  AGFNFSP: TGetFieldNamesForSchemaPRocW;
begin
  AGTNP := nil;
  AGFNFSP := nil;
  Result := BaseEditSQL(SQL, AGTNP, AGetTableNamesForSchema, AGetFieldNames, AGFNFSP,
                        ANeedsQuoteCharFunc, AStartTblName, AQuoteChar, SchemaName);
end;

function EditSQL(var SQL: Widestring; AGetTableNames: TGetTableNamesProcW;
  AGetFieldNames: TGetFieldNamesProcW; AStartTblName : Widestring = '';
  AQuoteChar : Widestring = ''; ANeedsQuoteCharFunc:
  TRequiresQuoteCharProcW = nil): Boolean; overload;
var
  AGTNFS: TGetTableNamesForSchemaProcW;
  AGFNFSP: TGetFieldNamesForSchemaProcW;
begin
  AGTNFS := Nil;
  AGFNFSP := Nil;
  Result := BaseEditSQL(SQL, AGetTableNames, AGTNFS, AGetFieldNames, AGFNFSP,
                        ANeedsQuoteCharFunc, AStartTblName, AQuoteChar, '');
end;

function EditSQL(SQL: TWideStrings; AGetTableNames: TGetTableNamesProcW;
  AGetFieldNames: TGetFieldNamesProcW; AStartTblName : Widestring = '';
  AQuoteChar : Widestring = ''; ANeedsQuoteCharFunc:
  TRequiresQuoteCharProcW = nil ): Boolean; overload;
var
  SQLText: WideString;
begin
  SQLText := SQL.Text;
  Result := EditSQL(SQLText, AGetTableNames, AGetFieldNames,
            AStartTblName, AQuoteChar, ANeedsQuoteCharFunc);
  if Result then
    SQL.Text := SQLText;
end;

function EditSQLSchema(var SQL: Widestring; AGetTableNamesForSchema: TGetTableNamesForSchemaProcW;
  AGetFieldNamesForSchema: TGetFieldNamesForSchemaProcW;
  AStartTblName : Widestring = ''; AQuoteChar : Widestring = ''; ANeedsQuoteCharFunc:
  TRequiresQuoteCharProcW = Nil; SchemaName : Widestring = ''): Boolean; overload;
var
  AGTN: TGetTableNamesProcW;
  AGFN: TGetFieldNamesProcW;
begin
  AGTN := Nil;
  AGFN := Nil;
  Result := BaseEditSql(SQL, AGTN, AGetTableNamesForSchema, AGFN,
                        AGetFieldNamesForSchema, ANeedsQuoteCharFunc,
                        AStartTblName, AQuoteChar, SchemaName);
end;

procedure TWideSQLEditForm.FormShow(Sender: TObject);
begin
  TableList.Sorted := True;
  HelpContext := 27271; //hcDADOSQLEdit
  SQLCanvas := TControlCanvas.Create;
  SQLCanvas.Control := SQLMemo;
  CharHeight := SQLCanvas.TextHeight('0');
  PopulateTableList;
//  FPopulateThread := TPopulateThread.Create(PopulateTableList);
end;

procedure TWideSQLEditForm.FormDestroy(Sender: TObject);
begin
  if Assigned(FPopulateThread) then
  begin
    FPopulateThread.Terminate;
    FPopulateThread.WaitFor;
    FPopulateThread.Free;
  end;
  SQLCanvas.Free;
end;

procedure TWideSQLEditForm.HelpButtonClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

procedure TWideSQLEditForm.PopulateTableList;
var
  I: integer;
  wList : TWideStringList;
begin
  if (@GetTableNamesW = Nil) and (@GetTableNamesForSchemaW = Nil) then Exit;
  try
    Screen.Cursor := crHourGlass;
    wList := TWideStringList.Create;
    try
      if @GetTableNamesW = Nil then
        GetTableNamesForSchemaW(wList, FSchemaName, False)
      else
        GetTableNamesW(wList, False);
      TableList.Items.Assign(wList);
    finally
      wList.Free;
    end;
    Screen.Cursor := crDefault;
    if FStartTable <> '' then
    begin
      for I := 0 to TableList.Items.Count -1 do
      begin
        if WideCompareStr( FStartTable, TableList.Items[I] ) = 0 then
        begin
          TableList.ItemIndex := I;
          TableListClick(nil);
          break;
        end;
      end;
    end;
    if TerminatePopulateThread then Exit;
    if (TableList.Items.Count > 0) and (TableList.ItemIndex = -1) then
    begin
      TableList.ItemIndex := 0;
      TableListClick(nil);
    end;
  except
    Screen.Cursor := crDefault;
  end;
end;

procedure TWideSQLEditForm.TableFieldsSplitterCanResize(Sender: TObject;
  var NewSize: Integer; var Accept: Boolean);
begin
  Accept := (NewSize > 44) and (NewSize < (MetaInfoPanel.Height - 65));
end;

procedure TWideSQLEditForm.MetaInfoSQLSplitterCanResize(Sender: TObject;
  var NewSize: Integer; var Accept: Boolean);
begin
  Accept := (NewSize > 100) and (NewSize < (ClientWidth - 100));
end;

procedure TWideSQLEditForm.MetaInfoSQLSplitterMoved(Sender: TObject);
begin
  SQLLabel.Left := SQLMemo.Left;
end;

procedure TWideSQLEditForm.PopulateFieldList;
var
  wList: TWideStringList;
begin
  FieldList.Items.Clear;
  if (@GetFieldNamesW = nil) and (@GetFieldNamesForSchemaW = nil) then Exit;
  try
    wList := TWideStringList.Create;
    try
      if @GetFieldNamesW = Nil then
        GetFieldNamesForSchemaW(TableList.Items[TableList.ItemIndex], FSchemaName, wList)
      else
        GetFieldNamesW(TableList.Items[TableList.ItemIndex], wList);
      FieldList.Items.Assign(wList);
    finally
      wList.Free;
    end;
    if (FieldList.Items.Count > 0) then
    begin
      FieldList.Items.Insert(0, '*');
      FieldList.Selected[0] := True;
    end;
  except
  end;
end;

procedure TWideSQLEditForm.TableListClick(Sender: TObject);
begin
  PopulateFieldList;
end;

procedure TWideSQLEditForm.InsertText(Text: WideString; AddComma: Boolean = True);
var
  StartSave: Integer;
  S: WideString;
begin
  S := SQLMemo.Text;
  StartSave := SQLMemo.SelStart;
  if (S <> '') and (StartSave > 0) and not InOpSet(S[StartSave], [' ','(']) and
    not (Text[1] = ' ') then
  begin
    if AddComma and (S[StartSave] <> ',') then
      Text := ', '+Text else
      Text := ' ' + Text;
  end;
  System.Insert(Text, S, StartSave+1);
  SQLMemo.Text := S;
  SQLMemo.SelStart := StartSave + Length(Text);
  SQLMemo.Update;
  DrawCaretPosIndicator;
end;

procedure TWideSQLEditForm.AddTableButtonClick(Sender: TObject);
var
  TableName,
  SQLText: WideString;
  NeedsQuote, Blank: Boolean;
begin
  if TableList.ItemIndex > -1 then
  begin
    SQLText := SQLMemo.Text;
    TableName := TableList.Items[TableList.ItemIndex];
    if (QuoteChar <>'') and (QuoteChar <> ' ') then
    begin
      if Assigned(NameRequiresQuoteChar) then
        NeedsQuote := NameRequiresQuoteChar(TableName)
      else
        NeedsQuote := DefaultReqQuoteChar(TableName);
      if NeedsQuote then
        TableName := QuoteChar + TableName + QuoteChar;
    end;
    Blank := SQLText = '';
    if Blank or (Copy(SQLText, 1, 6) = SSelect) then
      InsertText(WideFormat(' %s %s', [SFrom, TableName]), False)
    else
      InsertText(TableName, False);
    if Blank then
    begin
      SQLMemo.SelStart := 0;
      SQLMemo.Update;
      InsertText(SSelect+' ', False);
    end;
  end;
end;

procedure TWideSQLEditForm.AddFieldButtonClick(Sender: TObject);
var
  I: Integer;
  ColumnName: WideString;
  NeedsQuote: Boolean;
begin
  if FieldList.ItemIndex > -1 then
  begin
    { Help the user and assume this is a select if starting with nothing }
    if SQLMemo.Text = '' then
    begin
      SQLMemo.Text := SSelect;
      SQLMemo.SelStart := Length(SQLMemo.Text);
    end;
    for I := 0 to FieldList.Items.Count - 1 do
      if FieldList.Selected[I] then
      begin
        ColumnName := FieldList.Items[I];
        if (ColumnName <> '*') and (QuoteChar <> '') and (QuoteChar <> ' ') then
        begin
          if Assigned(NameRequiresQuoteChar) then
            NeedsQuote := NameRequiresQuoteChar(ColumnName)
          else
            NeedsQuote := DefaultReqQuoteChar(ColumnName);
          if NeedsQuote then
            ColumnName := QuoteChar + ColumnName + QuoteChar;
        end;
        InsertText(ColumnName, (SQLMemo.Text <> SSelect) and (ColumnName <> '*'));
      end;
  end;
end;

procedure TWideSQLEditForm.SQLMemoExit(Sender: TObject);
begin
  DrawCaretPosIndicator;
end;

procedure TWideSQLEditForm.SQLMemoEnter(Sender: TObject);
begin
  { Erase the CaretPos indicator }
  SQLMemo.Invalidate;
end;

procedure TWideSQLEditForm.DrawCaretPosIndicator;
var
  XPos, YPos: Integer;
begin
  with SQLMemo.CaretPos do
  begin
    YPos := (Y+1)*CharHeight;
    XPos := SQLCanvas.TextWidth(Copy(SQLMemo.Lines[Y], 1, X)) - 3;
    SQLCanvas.Draw(XPos ,YPos, Image1.Picture.Graphic);
  end;
end;

function DefaultReqQuoteChar( Name: WideString): Boolean;
var
  p: PWideChar;
begin
  p := PWideChar(Name);
  Result := False;
  repeat
    if not InOpSet(p^, ['A'..'Z', '0'..'9', '_']) then
    begin
      Result := True;
      break;
    end;
    Inc(p)
  until p^ = #0;
end;

procedure TWideSQLEditForm.FormUpdateActionUpdate(Sender: TObject);
begin
  AddTableButton.Enabled := TableList.Items.Count > 0;
  AddFieldButton.Enabled := FieldList.Items.Count > 0;
end;

end.
