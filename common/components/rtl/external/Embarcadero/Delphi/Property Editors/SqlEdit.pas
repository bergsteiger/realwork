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

unit SqlEdit;

interface

{$IFDEF MSWINDOWS}
uses Windows, Messages, ActiveX, SysUtils, Forms, Classes, Controls, Graphics,
  StdCtrls, ExtCtrls, ActnList;
{$ENDIF}
{$IFDEF LINUX}
uses Libc, Messages, ActiveX, SysUtils, Forms, Classes, Controls, Graphics,
  StdCtrls, ExtCtrls, ActnList;
{$ENDIF}

type

  TExecuteEvent = procedure of Object;

  TPopulateThread = class(TThread)
  private
    FExecuteEvent: TExecuteEvent;
  public
    constructor Create(ExecuteEvent: TExecuteEvent);
    procedure Execute; override;
  end;

  TGetTableNamesProc = procedure(List: TStrings; SystemTables: Boolean) of object;
  TGetTableNamesForSchemaProc = procedure(List: TStrings; SchemaName: string; SystemTables: Boolean) of object;
  TGetFieldNamesProc = procedure(const TableName: string; List: TStrings) of Object;
  TGetFieldNamesForSchemaProc = procedure (const TableName: string; SchemaName: string; List: TStrings) of object;
  TRequiresQuoteCharProc = function(const Name: string): Boolean of Object;

  TSQLEditForm = class(TForm)
    MainPanel: TPanel;
    MetaInfoSQLSplitter: TSplitter;
    ButtonPanel: TPanel;
    Image1: TImage;
    OkButton: TButton;
    CancelButton: TButton;
    HelpButton: TButton;
    MetaInfoPanel: TPanel;
    TableFieldsSplitter: TSplitter;
    TableListPanel: TPanel;
    FieldsPanel: TPanel;
    FieldListLabel: TLabel;
    FieldList: TListBox;
    AddFieldButton: TButton;
    ActionList1: TActionList;
    FormUpdateAction: TAction;
    SqlPanel: TPanel;
    SQLMemo: TMemo;
    SqlLabelPanel: TPanel;
    SQLLabel: TLabel;
    TablePanel: TPanel;
    TableList: TListBox;
    AddTableButton: TButton;
    TableLabelPanel: TPanel;
    TableListLabel: TLabel;
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
    FQuoteChar: string;
    SQLCanvas: TControlCanvas;
    procedure InsertText(Text: string; AddComma: Boolean = True);
    procedure DrawCaretPosIndicator;
  protected
    FPopulateThread: TPopulateThread;
    FStartTable: string;
    FSchemaName: string;
    NameRequiresQuoteChar : TRequiresQuoteCharProc;
    GetTableNamesForSchema : TGetTableNamesForSchemaProc;
    GetTableNames: TGetTableNamesProc;
    GetFieldNames: TGetFieldNamesProc;
    GetFieldNamesForSchema: TGetFieldNamesForSchemaProc;
    procedure PopulateTableList;
    procedure PopulateFieldList;
    function TerminatePopulateThread: boolean; virtual;

    function GetSQLMemoControl: TWinControl; virtual;
//    function GetSQLMemoLinesText: WideString; virtual;
    function GetSQLText: string;
    procedure SetSQLText(const Value: string);

    property SQLText: string read GetSQLText write SetSQLText;
    property QuoteChar: string read FQuoteChar write FQuoteChar;
    property StartTable: string read FStartTable write FStartTable;
  end;

function EditSQL(var SQL: string;
                 AGetTableNames: TGetTableNamesProc;
                 AGetFieldNames: TGetFieldNamesProc;
                 AStartTblName : string = '';
                 AQuoteChar : string = '';
                 ANeedsQuoteCharFunc: TRequiresQuoteCharProc = Nil): Boolean; overload;

function EditSQL(var SQL: string;
                 AGetTableNamesForSchema: TGetTableNamesForSchemaProc;
                 AGetFieldNames: TGetFieldNamesProc;
                 AStartTblName : string = '';
                 AQuoteChar : string = '';
                 ANeedsQuoteCharFunc: TRequiresQuoteCharProc = nil;
                 SchemaName : string = ''): Boolean; overload;

function EditSQL(SQL: TStrings;
                 AGetTableNames: TGetTableNamesProc;
                 AGetFieldNames: TGetFieldNamesProc; 
                 AStartTblName : string = '';
                 AQuoteChar : string = ''; 
                 ANeedsQuoteCharFunc: TRequiresQuoteCharProc = nil): Boolean; overload;

function EditSQLSchema(var SQL: string; 
                 AGetTableNamesForSchema: TGetTableNamesForSchemaProc;
                 AGetFieldNamesForSchema: TGetFieldNamesForSchemaProc;
                 AStartTblName : string = '';
                 AQuoteChar : string = ''; 
                 ANeedsQuoteCharFunc: TRequiresQuoteCharProc = Nil; 
                 SchemaName : string = ''): Boolean; overload;

function DefaultReqQuoteChar( Name: string): Boolean;

implementation

{$R *.dfm}

const
  SSelect = 'select'; { Do not localize }
  SFrom = 'from'; { Do not localize }

function BaseEditSQL(var SQL: string; 
                     AGetTableNames: TGetTableNamesProc;
                     AGetTableNamesForSchema: TGetTableNamesForSchemaProc = Nil;
                     AGetFieldNames: TGetFieldNamesProc = nil; 
                     AGetFieldNamesForSchema: TGetFieldNamesForSchemaProc = Nil;
                     ANeedsQuoteCharFunc: TRequiresQuoteCharProc = nil; 
                     AStartTblName : string = ''; 
                     AQuoteChar : string = ''; 
                     ASchemaName : string = ''): Boolean; overload;
begin
  with TSQLEditForm.Create(nil) do
  try
    GetTableNamesForSchema := AGetTableNamesForSchema;
    GetTableNames := AGetTableNames;
    GetFieldNamesForSchema := AGetFieldNamesForSchema;
    GetFieldNames := AGetFieldNames;
    QuoteChar := AQuoteChar;
    StartTable := AStartTblName;
    FSchemaName := ASchemaName;
    NameRequiresQuoteChar := ANeedsQuoteCharFunc;
    SQLText := SQL;
    Result := ShowModal = mrOK;
    if Result then
      SQL := SQLText;
  finally
    Free;
  end;
end;

function EditSQL(var SQL: string; AGetTableNamesForSchema: TGetTableNamesForSchemaProc;
  AGetFieldNames: TGetFieldNamesProc; AStartTblName : string = ''; AQuoteChar : string = ''; 
  ANeedsQuoteCharFunc: TRequiresQuoteCharProc = nil; SchemaName : string = ''): Boolean; overload;
var
  AGTNP: TGetTableNamesProc;
  AGFNFSP: TGetFieldNamesForSchemaPRoc;
begin
  AGTNP := nil;
  AGFNFSP := nil;
  Result := BaseEditSQL(SQL, AGTNP, AGetTableNamesForSchema, AGetFieldNames, AGFNFSP,
                        ANeedsQuoteCharFunc, AStartTblName, AQuoteChar, SchemaName);
end;

function EditSQL(var SQL: string; AGetTableNames: TGetTableNamesProc;
  AGetFieldNames: TGetFieldNamesProc; AStartTblName : string = ''; 
  AQuoteChar : string = ''; ANeedsQuoteCharFunc: 
  TRequiresQuoteCharProc = nil): Boolean; overload;
var
  AGTNFS: TGetTableNamesForSchemaProc;
  AGFNFSP: TGetFieldNamesForSchemaProc;
begin
  AGTNFS := Nil;
  AGFNFSP := Nil;
  Result := BaseEditSQL(SQL, AGetTableNames, AGTNFS, AGetFieldNames, AGFNFSP, 
                        ANeedsQuoteCharFunc, AStartTblName, AQuoteChar, '');
end;

function EditSQL(SQL: TStrings; AGetTableNames: TGetTableNamesProc;
  AGetFieldNames: TGetFieldNamesProc; AStartTblName : string = ''; 
  AQuoteChar : string = ''; ANeedsQuoteCharFunc: 
  TRequiresQuoteCharProc = nil ): Boolean; overload;
var
  SQLText: string;
begin
  SQLText := SQL.Text;
  Result := EditSQL(SQLText, AGetTableNames, AGetFieldNames, 
            AStartTblName, AQuoteChar, ANeedsQuoteCharFunc);
  if Result then
    SQL.Text := SQLText;
end;

function EditSQLSchema(var SQL: string; AGetTableNamesForSchema: TGetTableNamesForSchemaProc;
  AGetFieldNamesForSchema: TGetFieldNamesForSchemaProc;
  AStartTblName : string = ''; AQuoteChar : string = ''; ANeedsQuoteCharFunc: 
  TRequiresQuoteCharProc = Nil; SchemaName : string = ''): Boolean; overload;
var
  AGTN: TGetTableNamesProc;
  AGFN: TGetFieldNamesProc;
begin
  AGTN := Nil;
  AGFN := Nil;
  Result := BaseEditSql(SQL, AGTN, AGetTableNamesForSchema, AGFN, 
                        AGetFieldNamesForSchema, ANeedsQuoteCharFunc,
                        AStartTblName, AQuoteChar, SchemaName); 
end;

procedure TSQLEditForm.FormShow(Sender: TObject);
begin
  TableList.Sorted := True;
  HelpContext := 27271; //hcDADOSQLEdit
  SQLCanvas := TControlCanvas.Create;
  SQLCanvas.Control := GetSQLMemoControl;
  CharHeight := SQLCanvas.TextHeight('0');
  PopulateTableList;
//  FPopulateThread := TPopulateThread.Create(PopulateTableList);
end;

procedure TSQLEditForm.FormDestroy(Sender: TObject);
begin
  if Assigned(FPopulateThread) then
  begin
    FPopulateThread.Terminate;
    FPopulateThread.WaitFor;
    FPopulateThread.Free;
  end;
  SQLCanvas.Free;
end;

function TSQLEditForm.GetSQLMemoControl: TWinControl;
begin
  Result := SQLMemo;
end;

function TSQLEditForm.GetSQLText: string;
begin
  Result := SQLMemo.Lines.Text;
end;

procedure TSQLEditForm.SetSQLText(const Value: string);
begin
  SQLMemo.Lines.Text := Value;
end;

procedure TSQLEditForm.HelpButtonClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

procedure TSQLEditForm.PopulateTableList;
var
  I: integer;
begin
  if (@GetTableNames = Nil) and (@GetTableNamesForSchema = Nil) then Exit;
  try
    Screen.Cursor := crHourGlass;
    if @GetTableNames = Nil then
      GetTableNamesForSchema(TableList.Items, FSchemaName, False)
    else
      GetTableNames(TableList.Items, False);
    Screen.Cursor := crDefault;
    if FStartTable <> '' then
    begin
      for I := 0 to TableList.Items.Count -1 do
      begin
        if AnsiCompareStr( FStartTable, TableList.Items[I] ) = 0 then
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

procedure TSQLEditForm.TableFieldsSplitterCanResize(Sender: TObject;
  var NewSize: Integer; var Accept: Boolean);
begin
  Accept := (NewSize > 44) and (NewSize < (MetaInfoPanel.Height - 65));
end;

procedure TSQLEditForm.MetaInfoSQLSplitterCanResize(Sender: TObject;
  var NewSize: Integer; var Accept: Boolean);
begin
  Accept := (NewSize > 100) and (NewSize < (ClientWidth - 100));
end;

procedure TSQLEditForm.MetaInfoSQLSplitterMoved(Sender: TObject);
begin
  SQLLabel.Left := GetSQLMemoControl.Left;
end;

procedure TSQLEditForm.PopulateFieldList;
begin
  FieldList.Items.Clear;
  if (@GetFieldNames = nil) and (@GetFieldNamesForSchema = nil) then Exit;
  try
    if @GetFieldNames = Nil then
      GetFieldNamesForSchema(TableList.Items[TableList.ItemIndex], FSchemaName, FieldList.Items)
    else
      GetFieldNames(TableList.Items[TableList.ItemIndex], FieldList.Items);
    if (FieldList.Items.Count > 0) then
    begin
      FieldList.Items.Insert(0, '*');
      FieldList.Selected[0] := True;
    end;
  except
  end;
end;

function TSQLEditForm.TerminatePopulateThread: boolean;
begin
  Result := False;
  if Assigned(FPopulateThread) then
    Result := FPopulateThread.Terminated;
end;

procedure TSQLEditForm.TableListClick(Sender: TObject);
begin
  PopulateFieldList;
end;

procedure TSQLEditForm.InsertText(Text: string; AddComma: Boolean = True);
var
  StartSave: Integer;
  S: string;
begin
  S := SQLText;
  StartSave := SQLMemo.SelStart;
  if (S <> '') and (StartSave > 0) and not CharInSet(S[StartSave], [' ','(']) and
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

procedure TSQLEditForm.AddTableButtonClick(Sender: TObject);
var
  TableName,
  SQLText: string;
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
      InsertText(Format(' %s %s', [SFrom, TableName]), False)
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

procedure TSQLEditForm.AddFieldButtonClick(Sender: TObject);
var
  I: Integer;
  ColumnName: string;
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

procedure TSQLEditForm.SQLMemoExit(Sender: TObject);
begin
  DrawCaretPosIndicator;
end;

procedure TSQLEditForm.SQLMemoEnter(Sender: TObject);
begin
  { Erase the CaretPos indicator }
  SQLMemo.Invalidate;
end;

procedure TSQLEditForm.DrawCaretPosIndicator;
var
  XPos, YPos: Integer;
begin
  with SQLMemo.CaretPos do
  begin
    YPos := (Y+1)*CharHeight;
    XPos := SQLCanvas.TextWidth(Copy(SQLMemo.Lines[Y], 1, X)) - 3 ;
    SQLCanvas.Draw(XPos ,YPos, Image1.Picture.Graphic);
  end;
end;

{ TPopulateThread }

constructor TPopulateThread.Create(ExecuteEvent: TExecuteEvent);
begin
  FExecuteEvent := ExecuteEvent;
  inherited Create(False);
end;

procedure TPopulateThread.Execute;
begin
  CoInitialize(nil);
  try
    FExecuteEvent;
  except
  end;
  CoUninitialize;
end;

function DefaultReqQuoteChar( Name: string): Boolean;
var
  p: PChar;
begin
  p := PChar(Name);
  Result := False;
  repeat 
    if not CharInSet(p^, ['A'..'Z', '0'..'9', '_']) then
    begin
      Result := True;
      break;
    end;
    Inc(p) 
  until p^ = #0;
end;

procedure TSQLEditForm.FormUpdateActionUpdate(Sender: TObject);
begin
  AddTableButton.Enabled := TableList.Items.Count > 0;
  AddFieldButton.Enabled := FieldList.Items.Count > 0;
end;

end.
