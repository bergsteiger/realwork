{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{*******************************************************}
{             ADO Component Registration                }
{*******************************************************}

unit ADOReg;

interface

uses
  SysUtils, Classes, Forms, Controls,
  FldLinks, DsnDb, TreeIntf,
  DB, DesignIntf, DesignEditors, DsnDBCst, DBReg, ColnEdit, Data.Win.ADODB, WideStrings;
  //DiagramSupport;

type

{ Property Editors }

{ TProviderProperty }

  TProviderProperty = class(TDBStringProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

{ TConnectionStringProperty }

  TConnectionStringProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

{ TCommandTextProperty }

  TCommandTextProperty = class(TDBStringProperty)
  private
    FCommandType: TCommandType;
    FConnection: TADOConnection;
  public
    procedure Activate; override;
    function AutoFill: Boolean; override;
    procedure Edit; override;
    procedure EditSQLText; virtual;
    function GetAttributes: TPropertyAttributes; override;
    function GetConnection(Opened: Boolean): TADOConnection;
    procedure GetValueList(List: TStrings); override;
    property CommandType: TCommandType read FCommandType write FCommandType;
  end;

{ TTableNameProperty }

  TTableNameProperty = class(TCommandTextProperty)
  public
    procedure Activate; override;
  end;

{ TProcedureNameProperty }

  TProcedureNameProperty = class(TCommandTextProperty)
  public
    procedure Activate; override;
  end;

{ TParametersProperty }

  TParametersProperty = class(TCollectionProperty)
  public
    procedure Edit; override;
  end;

{ TADODataSetFieldLinkProperty }

  TADODataSetFieldLinkProperty = class(TFieldLinkProperty)
  private
    FADODataSet: TADODataSet;
  protected
    function GetIndexFieldNames: string; override;
    function GetMasterFields: string; override;
    procedure SetIndexFieldNames(const Value: string); override;
    procedure SetMasterFields(const Value: string); override;
  public
    procedure Edit; override;
  end;

{ TADOTableFieldLinkProperty }

  TADOTableFieldLinkProperty = class(TFieldLinkProperty)
  private
    FTable: TADOTable;
  protected
    function GetIndexFieldNames: string; override;
    function GetMasterFields: string; override;
    procedure SetIndexFieldNames(const Value: string); override;
    procedure SetMasterFields(const Value: string); override;
  public
    procedure Edit; override;
  end;

{ TADOIndexNameProperty }

  TADOIndexNameProperty = class(TDBStringProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;
  
{ Component Editors }

{ TADOConnectionEditor }

  TADOConnectionEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

{ TADOCommandEditor }

  TADOCommandEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

{ TADODataSetEditor }

  TADODataSetEditor = class(TDataSetEditor)
  private
    FCanCreate: Boolean;
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

{ Data Module Designer Support }

const
  cConnectionSprigPrefix = '<ImpliedConnection>'; { do not localize }

type
  TADOConnectionSprig = class(TComponentSprig)
  public
    function AnyProblems: Boolean; override;
    function Caption: string; override;
  end;

  TADOImpliedConnectionSprig = class(TTransientSprig)
  private
    FConnectionString: string;
  public
    function AnyProblems: Boolean; override;
    function UniqueName: string; override;
    function Caption: string; override;
    function ItemClass: TClass; override;
  end;

  TRDSConnectionSprig = class(TComponentSprig)
  end;

  TADOCommandSprig = class(TComponentSprig)
  public
    procedure FigureParent; override;
    function DragDropTo(AItem: TSprig): Boolean; override;
    function DragOverTo(AItem: TSprig): Boolean; override;
    function AnyProblems: Boolean; override;
    class function PaletteOverTo(AParent: TSprig; AClass: TClass): Boolean; override;
    function Caption: string; override;
  end;

{  TADOCommandIsland = class(TIsland)
  public
    function VisibleTreeParent: Boolean; override;
  end; }

  TCustomADODataSetSprig = class(TDataSetSprig)
  public
    procedure FigureParent; override;
    function AnyProblems: Boolean; override;
    function DragDropTo(AItem: TSprig): Boolean; override;
    function DragOverTo(AItem: TSprig): Boolean; override;
    class function PaletteOverTo(AParent: TSprig; AClass: TClass): Boolean; override;
  end;

  TADODataSetSprig = class(TCustomADODataSetSprig)
  public
    procedure FigureParent; override;
    function AnyProblems: Boolean; override;
    function DragDropTo(AItem: TSprig): Boolean; override;
    function DragOverTo(AItem: TSprig): Boolean; override;
    class function PaletteOverTo(AParent: TSprig; AClass: TClass): Boolean; override;
    function Caption: string; override;
  end;

  TADOTableSprig = class(TCustomADODataSetSprig)
  public
    function AnyProblems: Boolean; override;
    function Caption: string; override;
  end;

  TADOStoredProcSprig = class(TCustomADODataSetSprig)
  public
    function AnyProblems: Boolean; override;
    function Caption: string; override;
  end;

  TADOQuerySprig = class(TCustomADODataSetSprig)
  public
    function AnyProblems: Boolean; override;
  end;

{  TCustomADODataSetIsland = class(TDataSetIsland)
  public
    function VisibleTreeParent: Boolean; override;
  end;

  TADODataSetIsland = class(TCustomADODataSetIsland)
  end;

  TADOTableIsland = class(TCustomADODataSetIsland)
  end;

  TADOQueryIsland = class(TCustomADODataSetIsland)
  end;

  TCustomADODataSetMasterDetailBridge = class(TMasterDetailBridge)
  public
    class function GetOmegaSource(AItem: TPersistent): TDataSource; override;
    class procedure SetOmegaSource(AItem: TPersistent; ADataSource: TDataSource); override;
    function Caption: string; override;
  end;

  TADODataSetMasterDetailBridge = class(TCustomADODataSetMasterDetailBridge)
  public
    function CanEdit: Boolean; override;
    function Edit: Boolean; override;
    class function OmegaIslandClass: TIslandClass; override;
  end;

  TADOTableMasterDetailBridge = class(TCustomADODataSetMasterDetailBridge)
  public
    function CanEdit: Boolean; override;
    function Edit: Boolean; override;
    class function OmegaIslandClass: TIslandClass; override;
  end;

  TADOQueryMasterDetailBridge = class(TCustomADODataSetMasterDetailBridge)
  public
    class function OmegaIslandClass: TIslandClass; override;
  end; }

procedure Register;

implementation

uses TypInfo, Data.Win.AdoConEd, Consts, SqlEdit, Dialogs, DBCommon;

{ Utility functions }

function EditFileName(ADataSet: TADODataSet; LoadData: Boolean): Boolean;
begin
  with TOpenDialog.Create(nil) do
  try
    Title := sOpenFileTitle;
    DefaultExt := 'adtg';
    Filter := SADODataFilter;
    Result := Execute;
    if Result then
      if LoadData then
        ADataSet.LoadFromFile(FileName) else
        ADataSet.CommandText := FileName;
  finally
    Free;
  end;
end;

procedure SaveToFile(ADataSet: TADODataSet);
var
  PersistFormat: TPersistFormat;
begin
  with TSaveDialog.Create(nil) do
  try
    Options := [ofOverwritePrompt];
    DefaultExt := 'adtg';
    Filter := SADODataFilter;
    if Execute then
    begin
      if FilterIndex = 2 then
        PersistFormat := pfXML else
        PersistFormat := pfADTG;
      ADataSet.SaveToFile(FileName, PersistFormat);
    end;
  finally
    Free;
  end;
end;

{ TProviderProperty }

procedure TProviderProperty.GetValueList(List: TStrings);
begin
  GetProviderNames(List);
end;

{ TConnectionStringProperty }

function TConnectionStringProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

procedure TConnectionStringProperty.Edit;
begin
  if EditConnectionString(GetComponent(0) as TComponent) then
    Modified;
end;

{ TCommandTextProperty }

function TCommandTextProperty.GetAttributes: TPropertyAttributes;
begin
  if CommandType in [cmdTable, cmdTableDirect, cmdStoredProc] then
    Result := [paValueList, paSortList, paMultiSelect] else {Drop down list for name list}
    Result := [paMultiSelect, paRevertable, paDialog]; {SQL or File}
end;

procedure TCommandTextProperty.Activate;
var
  PropInfo: PPropInfo;
  Component: TComponent;
begin
  Component := GetComponent(0) as TComponent;
  PropInfo := TypInfo.GetPropInfo(Component.ClassInfo, 'CommandType'); { do not localize }
  if Assigned(PropInfo) then
    CommandType := TCommandType(GetOrdProp(Component, PropInfo)) else
    CommandType := cmdText;
end;

procedure TCommandTextProperty.EditSQLText;
var
  Command: string;
  Connection: TADOConnection;
  TableName: string;
begin
  if paDialog in GetAttributes then
  begin
    Command := GetStrValue;
    Connection := GetConnection(True);
    try
      if Command <> '' then
        TableName := GetTableNameFromSQL(Command);
      if EditSQL(Command, Connection.GetTableNames, Connection.GetFieldNames,
         TableName) then
        SetStrValue(Command);
    finally
      FConnection.Free;
      FConnection := nil;
    end;
  end;
end;

procedure TCommandTextProperty.Edit;
begin
  case CommandType of
    cmdText, cmdUnknown: EditSQLText;
    cmdFile: EditFileName(GetComponent(0) as TADODataSet, False);
  else
    inherited;
  end;
end;

function TCommandTextProperty.GetConnection(Opened: Boolean): TADOConnection;
var
  Component: TComponent;
  ConnectionString: string;
begin
  Component := GetComponent(0) as TComponent;
  Result := TObject(GetOrdProp(Component, TypInfo.GetPropInfo(Component.ClassInfo,
    'Connection'))) as TADOConnection; { do not localize }
  if not Opened then Exit;
  if not Assigned(Result) then
  begin
    ConnectionString := TypInfo.GetStrProp(Component,
      TypInfo.GetPropInfo(Component.ClassInfo, 'ConnectionString')); { do not localize }
    if ConnectionString = '' then Exit;
    FConnection := TADOConnection.Create(nil);
    FConnection.ConnectionString := ConnectionString;
    FConnection.LoginPrompt := False;
    Result := FConnection;
  end;
  Result.Open;
end;

procedure TCommandTextProperty.GetValueList(List: TStrings);
var
  Connection: TADOConnection;
begin
  Connection := GetConnection(True);
  if Assigned(Connection) then
  try
    case CommandType of
      cmdTable, cmdTableDirect:
        Connection.GetTableNames(List);
      cmdStoredProc:
        Connection.GetProcedureNames(List);
    end;
  finally
    FConnection.Free;
    FConnection := nil;
  end;
end;

function TCommandTextProperty.AutoFill: Boolean;
var
  Connection: TADOConnection;
begin
  Connection := GetConnection(False);
  Result := Assigned(Connection) and Connection.Connected;
end;

{ TTableNameProperty }

procedure TTableNameProperty.Activate;
begin
  CommandType := cmdTable;
end;

{ TProcedureNameProperty }

procedure TProcedureNameProperty.Activate;
begin
  CommandType := cmdStoredProc;
end;


{ TParametersProperty }

procedure TParametersProperty.Edit;
var
  Parameters: TParameters;
begin
  try
    Parameters := TParameters(GetOrdValue);
    if Parameters.Count = 0 then Parameters.Refresh;
  except
    { Ignore any error when trying to refresh the params }
  end;
  inherited Edit;
end;

{ TADODataSetFieldLinkProperty }

procedure TADODataSetFieldLinkProperty.Edit;
begin
  FADODataSet := DataSet as TADODataSet;
  inherited Edit;
end;

function TADODataSetFieldLinkProperty.GetIndexFieldNames: string;
begin
  Result := FADODataSet.IndexFieldNames;
end;

function TADODataSetFieldLinkProperty.GetMasterFields: string;
begin
  Result := FADODataSet.MasterFields;
end;

procedure TADODataSetFieldLinkProperty.SetIndexFieldNames(const Value: string);
begin
  FADODataSet.IndexFieldNames := Value;
end;

procedure TADODataSetFieldLinkProperty.SetMasterFields(const Value: string);
begin
  FADODataSet.MasterFields := Value;
end;

{ TADOTableFieldLinkProperty }

procedure TADOTableFieldLinkProperty.Edit;
begin
  FTable := DataSet as TADOTable;
  inherited Edit;
end;

function TADOTableFieldLinkProperty.GetIndexFieldNames: string;
begin
  Result := FTable.IndexFieldNames;
end;

function TADOTableFieldLinkProperty.GetMasterFields: string;
begin
  Result := FTable.MasterFields;
end;

procedure TADOTableFieldLinkProperty.SetIndexFieldNames(const Value: string);
begin
  FTable.IndexFieldNames := Value;
end;

procedure TADOTableFieldLinkProperty.SetMasterFields(const Value: string);
begin
  FTable.MasterFields := Value;
end;

{ TADOIndexNameProperty }

procedure TADOIndexNameProperty.GetValueList(List: TStrings);
var
  IndexDefs: TIndexDefs;
begin
  if GetComponent(0) is TADODataSet then
    IndexDefs := TADODataSet(GetComponent(0)).IndexDefs
  else
    IndexDefs := TADOTable(GetComponent(0)).IndexDefs;
  IndexDefs.Updated := False;
  IndexDefs.Update;
  IndexDefs.GetItemNames(List);
end;

{ TADOConnectionEditor }

procedure TADOConnectionEditor.ExecuteVerb(Index: Integer);
var
  I: Integer;
begin
  I := inherited GetVerbCount;
  if Index < I then inherited else
  begin
    case Index - I of
      0: if EditConnectionString(Component) then Designer.Modified;
    end;
  end;
end;

function TADOConnectionEditor.GetVerb(Index: Integer): string;
var
  I: Integer;
begin
  I := inherited GetVerbCount;
  if Index < I then Result := inherited GetVerb(Index) else
    case Index - I of
      0: Result := SADOConnectionEditor;
    end;
end;

function TADOConnectionEditor.GetVerbCount: Integer;
begin
  Result := inherited GetVerbCount + 1;
end;


{ TADOCommandEditor }

procedure TADOCommandEditor.ExecuteVerb(Index: Integer);
var
  I: Integer;
begin
  I := inherited GetVerbCount;
  if Index < I then inherited else
  begin
    case Index - I of
      0: TADOCommand(Component).Execute;
    end;
  end;
end;

function TADOCommandEditor.GetVerb(Index: Integer): string;
var
  I: Integer;
begin
  I := inherited GetVerbCount;
  if Index < I then Result := inherited GetVerb(Index) else
    case Index - I of
      0: Result := SCommandExecute;
    end;
end;

function TADOCommandEditor.GetVerbCount: Integer;
begin
  Result := inherited GetVerbCount;
  if TADOCommand(Component).CommandText <> '' then
     Inc(Result);
end;

{ TADODataSetEditor }

procedure TADODataSetEditor.ExecuteVerb(Index: Integer);
begin
  if Index <= inherited GetVerbCount - 1 then
    inherited ExecuteVerb(Index) else
  begin
    Dec(Index, inherited GetVerbCount);
    if (Index > 0) and not FCanCreate then Inc(Index);
    case Index of
      0: begin
           EditFileName(Component as TADODataSet, True);
           Designer.Modified;
         end;
      1: begin
           TADODataSet(Component).CreateDataSet;
           Designer.Modified;
         end;
      2: SaveToFile(Component as TADODataSet);
    end;
  end;
end;

function TADODataSetEditor.GetVerb(Index: Integer): string;
begin
  if Index <= inherited GetVerbCount - 1 then
    Result := inherited GetVerb(Index) else
  begin
    Dec(Index, inherited GetVerbCount);
    if (Index > 0) and not FCanCreate then Inc(Index);
    case Index of
      0: Result := SLoadFromBinaryFile;
      1: Result := SCreateDataSet;
      2: Result := SSaveToBinaryFile;
    end;
  end;
end;

function TADODataSetEditor.GetVerbCount: Integer;
begin
  Result := inherited GetVerbCount + 1; { LoadFromFile }
  with TADODataSet(Component) do
  begin
    FCanCreate := not Active and ((FieldCount > 0) or (FieldDefs.Count > 0));
    { either CreateDataSet or SaveToFile (but never both) }
    if FCanCreate or Active then Inc(Result);
  end;
end;


{ Data Module Designer Support }

const
  cCommandTypes: array [TCommandType] of string = ('Unknown', 'Text', 'Table', { Do not localize }
                                                   'StoredProc', 'File', { Do not localize }
                                                   'TableDirect'); { Do not localize }

function SprigADOImpliedConnectionName(const AName: string): string;
begin
  Result := Format('%s.%s', [cConnectionSprigPrefix, AName]); { do not localize }
end;

{ TADOConnectionSprig }

function TADOConnectionSprig.AnyProblems: Boolean;
begin
  Result := TADOConnection(Item).ConnectionString = '';
end;

function TADOConnectionSprig.Caption: string;
begin
  Result := CaptionFor(TADOConnection(Item).Provider, UniqueName);
end;

{ TADOImpliedConnectionSprig }

function TADOImpliedConnectionSprig.AnyProblems: Boolean;
begin
  Result := FConnectionString = '';
end;

function TADOImpliedConnectionSprig.Caption: string;
begin
  Result := CaptionFor(FConnectionString, 'Implied ADO Connection'); { Do not localize }
end;

function TADOImpliedConnectionSprig.UniqueName: string;
begin
  Result := SprigADOImpliedConnectionName(FConnectionString);
end;

function TADOImpliedConnectionSprig.ItemClass: TClass;
begin
  Result := TADOConnection;
end;

{ ADO connection/connectionstring support }

function ADOConAnyProblems(AConnection: TADOConnection; const AConnectionString: WideString): Boolean;
begin
  Result := (AConnection = nil) and
            (AConnectionString = '');
end;

function ADOConDropOver(AParent: TSprig; var AConnection: TADOConnection; var AConnectionString: WideString): Boolean;
begin
  Result := False;
  if AParent is TADOConnectionSprig then
  begin
    Result := TADOConnection(AParent.Item) <> AConnection;
    if Result then
      AConnection := TADOConnection(AParent.Item);
  end
  else if AParent is TADOImpliedConnectionSprig then
  begin
    Result := AConnectionString <> TADOImpliedConnectionSprig(AParent).FConnectionString;
    if Result then
      AConnectionString := TADOImpliedConnectionSprig(AParent).FConnectionString;
  end;
end;

function ADOConDragOver(AItem: TSprig): Boolean;
begin
  Result := (AItem is TADOConnectionSprig) or
            (AItem is TADOImpliedConnectionSprig);
end;

function ADOConFigureParent(ASprig: TSprig; AConnection: TADOConnection; const AConnectionString: WideString): Boolean;
var
  LConnection: TSprig;
begin
  // assume failure
  LConnection := nil;

  // if connection is not nil then look for it
  if AConnection <> nil then
    LConnection := ASprig.Root.Find(AConnection, False);

  // else if connection string is not nil then look for it
  if LConnection = nil then
  begin
    LConnection := ASprig.Root.Find(SprigADOImpliedConnectionName(AConnectionString), False);

    // if connection string cannot be found then make one
    if LConnection = nil then
    begin
      LConnection := ASprig.Root.Add(TADOImpliedConnectionSprig.Create(nil));
      TADOImpliedConnectionSprig(LConnection).FConnectionString := AConnectionString;
    end;
  end;

  // use the parent
  LConnection.Add(ASprig);
  Result := (LConnection <> nil);  // Added to fix warning, result must not be used by the caller.
end;

{ TADOCommandSprig }

function TADOCommandSprig.AnyProblems: Boolean;
begin
  with TADOCommand(Item) do
    Result := ADOConAnyProblems(Connection, ConnectionString);
end;

function TADOCommandSprig.Caption: string;
var
  LPrefix: string;
begin
  with TADOCommand(Item) do
  begin
    LPrefix := cCommandTypes[CommandType];
    if CommandText <> '' then
      LPrefix := LPrefix + ' ' + CommandText;
    Result := CaptionFor(LPrefix, UniqueName);
  end;
end;

function TADOCommandSprig.DragDropTo(AItem: TSprig): Boolean;
var
  LConnection: TADOConnection;
  LConnectionString: WideString;
begin
  with TADOCommand(Item) do
  begin
    LConnection := Connection;
    LConnectionString := ConnectionString;
    Result := ADOConDropOver(AItem, LConnection, LConnectionString);
    if Result then
    begin
      Connection := LConnection;
      ConnectionString := LConnectionString;
    end;
  end;
end;

function TADOCommandSprig.DragOverTo(AItem: TSprig): Boolean;
begin
  Result := ADOConDragOver(AItem);
end;

procedure TADOCommandSprig.FigureParent;
begin
  ADOConFigureParent(Self, TADOCommand(Item).Connection,
                           TADOCommand(Item).ConnectionString);
end;

class function TADOCommandSprig.PaletteOverTo(AParent: TSprig;
  AClass: TClass): Boolean;
begin
  Result := ADOConDragOver(AParent);
end;

{ TCustomAdoDataSetSprig }

function TCustomADODataSetSprig.AnyProblems: Boolean;
begin
  with TCustomADODataSet(Item) do
    Result := (DataSetField = nil) and
              ADOConAnyProblems(Connection, ConnectionString);
end;

procedure TCustomADODataSetSprig.FigureParent;
begin
  with TCustomADODataSet(Item) do
    if DataSetField <> nil then
      SeekParent(DataSetField).Add(Self)
    else
      ADOConFigureParent(Self, Connection, ConnectionString);
end;

function TCustomADODataSetSprig.DragDropTo(AItem: TSprig): Boolean;
var
  LConnection: TADOConnection;
  LConnectionString: WideString;
begin
  with TCustomADODataSet(Item) do
    if AItem is TFieldSprig then
    begin
      Result := DataSetField <> AItem.Item;
      if Result then
        DataSetField := TDataSetField(AItem.Item);
      Connection := nil;
      ConnectionString := '';
    end
    else
    begin
      LConnection := Connection;
      LConnectionString := ConnectionString;
      Result := ADOConDropOver(AItem, LConnection, LConnectionString);
      if Result then
      begin
        Connection := LConnection;
        ConnectionString := LConnectionString;
      end;
      DataSetField := nil;
    end;
end;

function TCustomADODataSetSprig.DragOverTo(AItem: TSprig): Boolean;
begin
  Result := ((AItem is TFieldSprig) and
             (TFieldSprig(AItem).Item is TDataSetField)) or
            ADOConDragOver(AItem);
end;

class function TCustomADODataSetSprig.PaletteOverTo(AParent: TSprig;
  AClass: TClass): Boolean;
begin
  Result := ((AParent is TFieldSprig) and
             (TFieldSprig(AParent).Item is TDataSetField)) or
            ADOConDragOver(AParent);
end;

{ TADODataSetSprig }

function TADODataSetSprig.AnyProblems: Boolean;
begin
  Result := ((TADODataSet(Item).RDSConnection = nil) and
             inherited AnyProblems) or
            (TADODataSet(Item).CommandText = '');
end;

function TADODataSetSprig.Caption: string;
var
  LPrefix: string;
begin
  with TADODataSet(Item) do
  begin
    LPrefix := cCommandTypes[CommandType];
    if CommandText <> '' then
      LPrefix := LPrefix + ' ' + CommandText;
    Result := CaptionFor(LPrefix, UniqueName);
  end;
end;

function TADODataSetSprig.DragDropTo(AItem: TSprig): Boolean;
begin
  with TADODataSet(Item) do
    if AItem is TRDSConnectionSprig then
    begin
      Result := RDSConnection <> AItem.Item;
      if Result then
        RDSConnection := TRDSConnection(AItem.Item);
    end
    else
      Result := inherited DragDropTo(AItem);
end;

function TADODataSetSprig.DragOverTo(AItem: TSprig): Boolean;
begin
  Result := (AItem is TRDSConnectionSprig) or
            inherited DragOverTo(AItem);
end;

procedure TADODataSetSprig.FigureParent;
begin
  with TADODataSet(Item) do
    if RDSConnection <> nil then
      SeekParent(RDSConnection).Add(Self)
    else
      inherited;
end;

class function TADODataSetSprig.PaletteOverTo(AParent: TSprig;
  AClass: TClass): Boolean;
begin
  Result := (AParent is TRDSConnectionSprig) or
            inherited PaletteOverTo(AParent, AClass);
end;

{ TADOTableSprig }

function TADOTableSprig.AnyProblems: Boolean;
begin
  Result := TADOTable(Item).TableName = '';
end;

function TADOTableSprig.Caption: string;
begin
  Result := CaptionFor(TADOTable(Item).TableName, UniqueName);
end;

{ TADOStoredProcSprig }

function TADOStoredProcSprig.AnyProblems: Boolean;
begin
  Result := TADOStoredProc(Item).ProcedureName = '';
end;

function TADOStoredProcSprig.Caption: string;
begin
  Result := CaptionFor(TADOStoredProc(Item).ProcedureName, UniqueName);
end;

{ TADOQuerySprig }

function TADOQuerySprig.AnyProblems: Boolean;
begin
  Result := TADOQuery(Item).SQL.Text = '';
end;

{ TCustomADODataSetMasterDetailBridge }
(*
class function TCustomADODataSetMasterDetailBridge.GetOmegaSource(
  AItem: TPersistent): TDataSource;
begin
  Result := TADODataSet(AItem).DataSource;
end;

class procedure TCustomADODataSetMasterDetailBridge.SetOmegaSource(
  AItem: TPersistent; ADataSource: TDataSource);
begin
  TADODataSet(AItem).DataSource := ADataSource;
end;

type
  TCustomADODataSetHack = class(TCustomADODataSet)
  end;

function TCustomADODataSetMasterDetailBridge.Caption: string;
begin
  Result := SNoMasterFields;
  if TCustomADODataSetHack(Omega.Item).CommandType = cmdText then
    Result := SParamsFields
  else if TCustomADODataSetHack(Omega.Item).MasterFields <> '' then
    Result := TCustomADODataSetHack(Omega.Item).MasterFields;
end;

{ TADODataSetMasterDetailBridge }

function TADODataSetMasterDetailBridge.CanEdit: Boolean;
begin
  Result := TADODataSet(Omega.Item).CommandType <> cmdText;
end;

function TADODataSetMasterDetailBridge.Edit: Boolean;
var
  LPropEd: TADODataSetFieldLinkProperty;
begin
  Result := False;
  if TADODataSet(Omega.Item).CommandType <> cmdText then
  begin
    LPropEd := TADODataSetFieldLinkProperty.CreateWith(TADODataSet(Omega.Item));
    try
      LPropEd.Edit;
      Result := LPropEd.Changed;
    finally
      LPropEd.Free;
    end;
  end;
end;

class function TADODataSetMasterDetailBridge.OmegaIslandClass: TIslandClass;
begin
  Result := TADODataSetIsland;
end;

{ TADOTableMasterDetailBridge }

function TADOTableMasterDetailBridge.CanEdit: Boolean;
begin
  Result := True;
end;

function TADOTableMasterDetailBridge.Edit: Boolean;
var
  LPropEd: TADOTableFieldLinkProperty;
begin
  LPropEd := TADOTableFieldLinkProperty.CreateWith(TADOTable(Omega.Item));
  try
    LPropEd.Edit;
    Result := LPropEd.Changed;
  finally
    LPropEd.Free;
  end;
end;

class function TADOTableMasterDetailBridge.OmegaIslandClass: TIslandClass;
begin
  Result := TADOTableIsland;
end;

{ TADOQueryMasterDetailBridge }

class function TADOQueryMasterDetailBridge.OmegaIslandClass: TIslandClass;
begin
  Result := TADOQueryIsland;
end;

{ TADOCommandIsland }

function TADOCommandIsland.VisibleTreeParent: Boolean;
begin
  with TADOCommand(Sprig.Item) do
    Result := (Connection = nil);
end;

{ TCustomADODataSetIsland }

function TCustomADODataSetIsland.VisibleTreeParent: Boolean;
begin
  with TCustomADODataSet(Sprig.Item) do
    Result := (DataSetField = nil) and
              (Connection = nil);
end;
*)
procedure Register;
begin
  RegisterComponents(srADO, [TADOConnection, TADOCommand, TADODataSet,
    TADOTable, TADOQuery, TADOStoredProc, TRDSConnection]);

  RegisterPropertyEditor(TypeInfo(WideString), TADOConnection, 'Provider', TProviderProperty);
  RegisterPropertyEditor(TypeInfo(WideString), TADOConnection, 'ConnectionString', TConnectionStringProperty);
  RegisterPropertyEditor(TypeInfo(WideString), TADOCommand, 'ConnectionString', TConnectionStringProperty);
  RegisterPropertyEditor(TypeInfo(WideString), TCustomADODataSet, 'ConnectionString', TConnectionStringProperty);
  RegisterPropertyEditor(TypeInfo(WideString), TADODataSet, 'CommandText', TCommandTextProperty);
  RegisterPropertyEditor(TypeInfo(WideString), TADOCommand, 'CommandText', TCommandTextProperty);
  RegisterPropertyEditor(TypeInfo(WideString), TADOTable, 'TableName', TTableNameProperty);
  RegisterPropertyEditor(TypeInfo(WideString), TADOStoredProc, 'ProcedureName', TProcedureNameProperty);
  RegisterPropertyEditor(TypeInfo(TParameters), TCustomADODataSet, 'Parameters', TParametersProperty);
  RegisterPropertyEditor(TypeInfo(TParameters), TADOCommand, 'Parameters', TParametersProperty);
  RegisterPropertyEditor(TypeInfo(WideString), TCustomADODataSet, 'IndexName', TADOIndexNameProperty);
  RegisterComponentEditor(TADOConnection, TADOConnectionEditor);
  RegisterComponentEditor(TADOCommand, TADOCommandEditor);
  RegisterComponentEditor(TADODataSet, TADODataSetEditor);

  RegisterPropertyEditor(TypeInfo(WideString), TADODataSet, 'MasterFields', TADODataSetFieldLinkProperty);
  RegisterPropertyEditor(TypeInfo(WideString), TADOTable, 'MasterFields', TADOTableFieldLinkProperty);

  RegisterPropertiesInCategory(sDatabaseCategoryName, TADOConnection,
      ['Attributes','Command*','Connect*','DefaultDatabase','IsolationLevel',
       'LoginPrompt','Mode','Provider']);

  RegisterPropertiesInCategory(sDatabaseCategoryName, TADOCommand,
      ['Command*','Connect*','Cursor*','ExecuteOptions','Param*','Prepared']);

  RegisterPropertiesInCategory(sDatabaseCategoryName, TCustomADODataSet,
      ['CacheSize', 'ConnectionString', 'ExecuteOptions', 'MarshalOptions',
       'MaxRecords', 'Prepared', 'ProcedureName', 'Command*']);

  RegisterSprigType(TADOConnection, TADOConnectionSprig);
  RegisterSprigType(TRDSConnection, TRDSConnectionSprig);
  RegisterSprigType(TADOCommand, TADOCommandSprig);

  RegisterSprigType(TCustomADODataSet, TCustomADODataSetSprig);
  RegisterSprigType(TADODataSet, TADODataSetSprig);
  RegisterSprigType(TADOTable, TADOTableSprig);
  RegisterSprigType(TADOStoredProc, TADOStoredProcSprig);
  RegisterSprigType(TADOQuery, TADOQuerySprig);

{  RegisterIslandType(TADOCommandSprig, TADOCommandIsland);
  RegisterIslandType(TCustomADODataSetSprig, TCustomADODataSetIsland);
  RegisterIslandType(TADODataSetSprig, TADODataSetIsland);
  RegisterIslandType(TADOTableSprig, TADOTableIsland);
  RegisterIslandType(TADOQuerySprig, TADOQueryIsland);

  RegisterBridgeType(TDataSetIsland, TADODataSetIsland, TADODataSetMasterDetailBridge);
  RegisterBridgeType(TDataSetIsland, TADOTableIsland, TADOTableMasterDetailBridge);
  RegisterBridgeType(TDataSetIsland, TADOQueryIsland, TADOQueryMasterDetailBridge); }
end;

end.
