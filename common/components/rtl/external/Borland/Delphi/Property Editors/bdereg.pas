{*******************************************************}
{                                                       }
{       Borland Delphi Visual Component Library         }
{       BDE Component Registration                      }
{                                                       }
{  Copyright (c) 2000-2001 Borland Software Corporation }
{                                                       }
{*******************************************************}


unit BDEReg;

interface

uses

  Report, RSCONSTS, LibHelp, Dialogs, dblookup, FileCtrl,

  SysUtils, Classes, DSDesign, Menus, DBTables, DB, DRIntf, DsnDbCst,
  DSAttrS, DSAttrA, DBReg, Dbxplor, bdeconst, GqeDelph, ColnEdit, TblDsgn,
  DesignIntf, DesignEditors, Dbedit, Ixedit, Updsqled, FldLinks, CNCOLEDT,
  DrTable, TreeIntf, DsnDb, DiagramSupport;

type

{ TTableFieldLinkProperty }

  TTableFieldLinkProperty = class(TFieldLinkProperty)
  private
    FTable: TTable;
  protected
    procedure GetFieldNamesForIndex(List: TStrings); override;
    function GetIndexBased: Boolean; override;
    function GetIndexDefs: TIndexDefs; override;
    function GetIndexFieldNames: string; override;
    function GetIndexName: string; override;
    function GetMasterFields: string; override;
    procedure SetIndexFieldNames(const Value: string); override;
    procedure SetIndexName(const Value: string); override;
    procedure SetMasterFields(const Value: string); override;
  public
    property IndexBased: Boolean read GetIndexBased;
    property IndexDefs: TIndexDefs read GetIndexDefs;
    property IndexFieldNames: string read GetIndexFieldNames write SetIndexFieldNames;
    property IndexName: string read GetIndexName write SetIndexName;
    property MasterFields: string read GetMasterFields write SetMasterFields;
    procedure Edit; override;
  end;

const
  cDefaultSessionSprigName =    '<DefaultSession>'; { do not localize }
  cImpliedSessionSprigPrefix =  '<ImpliedSession>'; { do not localize }
  cImpliedDatabaseSprigPrefix = '<ImpliedDatabase>'; { do not localize }

type
  TSessionSprig = class(TComponentSprig)
  public
    function Name: string; override;
    function Caption: string; override;
    function AnyProblems: Boolean; override;
  end;

  TDefaultSessionSprig = class(TTransientSprig)
  public
    function UniqueName: string; override;
    function Caption: string; override;
    function ItemClass: TClass; override;
  end;

  TImpliedSessionSprig = class(TTransientSprig)
  private
    FSessionName: string;
  public
    function UniqueName: string; override;
    function Caption: string; override;
    function ItemClass: TClass; override;
  end;

  TDatabaseSprig = class(TComponentSprig)
  public
    function Name: string; override;
    function Caption: string; override;
    function AnyProblems: Boolean; override;
    procedure FigureParent; override;
    function DragDropTo(AItem: TSprig): Boolean; override;
    function DragOverTo(AItem: TSprig): Boolean; override;
    class function PaletteOverTo(AParent: TSprig; AClass: TClass): Boolean; override;
  end;

  TImpliedDatabaseSprig = class(TTransientSprig)
  private
    FSessionName: string;
    FAlias: string;
  public
    function AnyProblems: Boolean; override;
    function UniqueName: string; override;
    function Caption: string; override;
    function ItemClass: TClass; override;
    procedure FigureParent; override;
    function DragDropTo(AItem: TSprig): Boolean; override;
    function DragOverTo(AItem: TSprig): Boolean; override;
  end;

  TBatchMoveSprig = class(TComponentSprig)
  public
    function AnyProblems: Boolean; override;
    function Caption: string; override;
  end;

  TUpdateSQLSprig = class(TComponentSprig)
  public
    function AnyProblems: Boolean; override;
  end;

  TBDEDataSetSprig = class(TDataSetSprig)
  public
    function GetDSDesignerClass: TDSDesignerClass; override;
  end;

  TNestedTableSprig = class(TBDEDataSetSprig)
  public
    class function ParentProperty: string; override;
  end;

  TDBDataSetSprig = class(TBDEDataSetSprig)
  public
    function AnyProblems: Boolean; override;
    procedure FigureParent; override;
    procedure Reparent; override;
    function DragDropTo(AItem: TSprig): Boolean; override;
    function DragOverTo(AItem: TSprig): Boolean; override;
    class function PaletteOverTo(AParent: TSprig; AClass: TClass): Boolean; override;
  end;

  TTableSprig = class(TDBDataSetSprig)
  public
    function AnyProblems: Boolean; override;
    function Caption: string; override;
  end;

  TQuerySprig = class(TDBDataSetSprig)
  public
    function AnyProblems: Boolean; override;
  end;

  TStoredProcSprig = class(TDBDataSetSprig)
  public
    function AnyProblems: Boolean; override;
    function Caption: string; override;
  end;

  TBDEDataSetIsland = class(TDataSetIsland)
  end;

  TDBDataSetIsland = class(TBDEDataSetIsland)
  end;

  TTableIsland = class(TDBDataSetIsland)
  end;

  TTableMasterDetailBridge = class(TMasterDetailBridge)
  public
    function CanEdit: Boolean; override;
    class function OmegaIslandClass: TIslandClass; override;
    class function GetOmegaSource(AItem: TPersistent): TDataSource; override;
    class procedure SetOmegaSource(AItem: TPersistent; ADataSource: TDataSource); override;
    function Caption: string; override;
    function Edit: Boolean; override;
  end;

  TQueryIsland = class(TDBDataSetIsland)
  end;

  TQueryMasterDetailBridge = class(TMasterDetailBridge)
  public
    class function RemoveMasterFieldsAsWell: Boolean; override;
    class function OmegaIslandClass: TIslandClass; override;
    class function GetOmegaSource(AItem: TPersistent): TDataSource; override;
    class procedure SetOmegaSource(AItem: TPersistent; ADataSource: TDataSource); override;
    function Caption: string; override;
  end;

function SprigBDESessionName(const AName: string): string;
function SprigBDEImpliedDatabaseName(const AName: string): string;
function SprigBDEImpliedSessionName(const AName: string): string;

procedure Register;

implementation

uses Controls, StrEdit;

type

{ TBDEDesigner }

  TMenuItemID = (miSeparator, miRetrieve, miSave, miSaveAs, miAssociate, miUnassociate);

  TBDEDesigner = class(TDSDesigner)
  private
    FTableID: TTableID;
    FQueryDescs: TQueryDescription;
    FMenuArray: array [TMenuItemID] of TMenuItem;
  protected
    procedure AttributeClick(Sender: TObject);
    function QualifyTableName(DatabaseName: string;
      Database: TDatabase; const TableName: string): string;
    function CheckAttribute(Field: TField): Boolean;
    procedure GetTableDesc(var ADatabase, ATable: string);
    procedure GetFieldInfo(Field: TField; var FieldID: TFieldID;
      var AttrID: TAttrID);
    function FindFieldInfo(Field: TField; var FieldID: TFieldID;
      var AttrID: TAttrID): Boolean;
    function RetrieveAttributes(Field: TField): Boolean;
    function SaveAttributes(Field: TField): Boolean;
    function SaveAttributesAs(Field: TField): Boolean;
    function AssociateAttributes(Field: TField): Boolean;
    function UnassociateAttributes(Field: TField): Boolean;
  public
    destructor Destroy; override;
    procedure BeginCreateFields; override;
    function DoCreateField(const FieldName: string; Origin: string): TField; override;
    procedure EndCreateFields; override;
    function GetControlClass(Field: TField): string; override;
    procedure InitializeMenu(Menu: TPopupMenu); override;
    procedure UpdateMenus(Menu: TPopupMenu; EditState: TEditState); override;
  end;

destructor TBDEDesigner.Destroy;
begin
  inherited Destroy;
  if DSDesign.DesignerCount <= 0 then DictionaryDeactivate;
end;

function TBDEDesigner.QualifyTableName(DatabaseName: string;
  Database: TDatabase; const TableName: string): string;
begin
  if not Assigned(Database) then
    Result := QualifyTableNameByName(TDBDataset(Dataset).SessionName,
      DatabaseName, TableName) else
    Result := DrIntf.QualifyTableName(Database, TableName);
end;

procedure TBDEDesigner.GetTableDesc(var ADatabase, ATable: string);
var
  Database: TDatabase;
begin
  ADatabase := '';
  ATable := '';
  if Dataset is TTable then
  begin
    ADatabase := TTable(Dataset).DatabaseName;
    Database := TTable(Dataset).Database;
    ATable := QualifyTableName(ADatabase, Database, TTable(Dataset).TableName);
  end;
end;

function TBDEDesigner.CheckAttribute(Field: TField): Boolean;
var
  FieldID: TFieldID;
  AttrID: TAttrID;
begin
  Result := False;
  if Field.AttributeSet <> '' then Exit;
  FindFieldInfo(Field, FieldID, AttrID);
  if not IsNullID(AttrID) then Exit;
  Result := True;
end;

procedure TBDEDesigner.GetFieldInfo(Field: TField; var FieldID: TFieldID;
  var AttrID: TAttrID);
begin
  if not FindFieldInfo(Field, FieldID, AttrID) then
    raise Exception.CreateResFmt(@SDSFieldNotInDict, [Field.FullName]);
end;

function TBDEDesigner.FindFieldInfo(Field: TField; var FieldID: TFieldID;
  var AttrID: TAttrID): Boolean;
var
  DatabaseName, TableName: string;
begin
  GetTableDesc(Databasename, TableName);
  AttrID := NullAttrID;
  FieldID := FindFieldID(FindTableID(FindDatabaseID(DatabaseName), TableName),
    Field.FieldName);
  if not IsNullID(FieldID) then
    AttrID := GetAttrID(FieldID)
  else if Field.AttributeSet <> '' then
    AttrID := FindAttrID(Field.AttributeSet);
  Result := not IsNullID(FieldID) or not IsNullID(AttrID);
end;

function TBDEDesigner.RetrieveAttributes(Field: TField): Boolean;
var
  FieldID: TFieldID;
  AttrID: TAttrID;
begin
  if FindFieldInfo(Field, FieldID, AttrID) then
  begin
    UpdateField(Field, FieldID, AttrID);
    Field.AttributeSet := GetAttrName(AttrID);
  end;
  Result := True;
end;

function TBDEDesigner.SaveAttributes(Field: TField): Boolean;
var
  FieldID: TFieldID;
  AttrID: TAttrID;
begin
  Result := True;
  GetFieldInfo(Field, FieldID, AttrID);
  if not IsNullID(AttrID) then
    UpdateAttr(Field, FieldID, AttrID)
  else
    Result := SaveAttributesAs(Field);
end;

function TBDEDesigner.SaveAttributesAs(Field: TField): Boolean;
var
  DatabaseName, TableName, AttributeName: string;
  FieldID: TFieldID;
  AttrID: TAttrID;
begin
  GetTableDesc(DatabaseName, TableName);
  GetFieldInfo(Field, FieldID, AttrID);
  Result := SaveAttributesAsDlg(TableName, Field.FieldName, AttributeName, AttrID);
  if Result then NewAttr(Field, FieldID, AttributeName, AttrID);
end;

function TBDEDesigner.AssociateAttributes(Field: TField): Boolean;
var
  FieldID: TFieldID;
  AttrID: TAttrID;
begin
  FindFieldInfo(Field, FieldID, AttrID);
  if GetAssociateAttributes(AttrID, Result) then
  begin
    if not IsNullID(FieldID) then AssociateAttr(AttrID, FieldID);
    UpdateField(Field, FieldID, AttrID);
    Field.AttributeSet := GetAttrName(AttrID);
  end;
end;

function TBDEDesigner.UnassociateAttributes(Field: TField): Boolean;
var
  FieldID: TFieldID;
  AttrID: TAttrID;
begin
  Field.AttributeSet := '';
  FindFieldInfo(Field, FieldID, AttrID);
  if not IsNullID(FieldID) then UnassociateAttr(FieldID);
  Field.AttributeSet := '';
  Result := True;
end;

procedure TBDEDesigner.AttributeClick(Sender: TObject);
var
  MenuID: TMenuItemID;
  Proc: TSelectionProc;
begin
  if Assigned(Sender) and (Sender is TComponent) then
    MenuID := TMenuItemID(TComponent(Sender).Tag) else
    MenuID := miSeparator;
  try
    case MenuID of
      miRetrieve: Proc := RetrieveAttributes;
      miSave: Proc := SaveAttributes;
      miSaveAs: Proc := SaveAttributesAs;
      miAssociate: Proc := AssociateAttributes;
      miUnassociate: Proc := UnassociateAttributes;
    else
      Proc := nil;
    end;
    if Assigned(Proc) then
      FieldsEditor.ForEachSelection(Proc);
  finally
    if MenuID in [miAssociate, miRetrieve] then
      FieldsEditor.Designer.Modified;
  end;
end;

function TBDEDesigner.GetControlClass(Field: TField): string;
var
  FieldID: TFieldID;
  AttrId: TAttrID;
begin
  if Assigned(Field) then
  begin
    FindFieldInfo(Field, FieldID, AttrID);
    Result := DRIntf.GetControlClass(AttrID);
  end else
    Result := '';
  if Result = '' then
    Result := inherited GetControlClass(Field);
end;

procedure TBDEDesigner.BeginCreateFields;
var
  DatabaseName, TableName: string;
begin
  if Dataset is TTable then
  begin
    GetTableDesc(DatabaseName, TableName);
    FTableID := FindTableID(FindDatabaseID(DatabaseName), TableName);
  end
  else
  if Dataset is TQuery then
  begin
    FQueryDescs := TQueryDescription.Create(nil);
    try
      FQueryDescs.Query := TQuery(Dataset);
      FQueryDescs.Open;
    except
      FQueryDescs.Free;
      FQueryDescs := nil;
    end;
  end;
  inherited BeginCreateFields;
end;

procedure TBDEDesigner.EndCreateFields;
begin
  FQueryDescs.Free;
  FQueryDescs := nil;
  FTableID := NullTableId;
  inherited EndCreateFields;
end;

function TBDEDesigner.DoCreateField(const FieldName: string; Origin: string): TField;
var
  FieldID: TFieldID;
  AttrID: TAttrID;
  DatabaseName: string;
  TableName: string;
  FldName: string;

  function NeedsBackslashing(const Name: string): Boolean;
  var
    N: PChar;
  begin
    Result := True;
    N := PChar(Pointer(Name));
    while N^ <> #0 do
      if N^ in ['\','"'] then Exit
      else if N^ in LeadBytes then Inc(N, 2)
      else Inc(N);
    Result := False;
  end;

  function Backslash(const Name: string): string;
  var
    CName: array[0..1024] of Char;
    N, C: PChar;
  begin
    N := PChar(Pointer(Name));
    C := CName;
    while N^ <> #0 do
    begin
      if N^ in ['\', '"'] then
      begin
        C^ := '\';
        Inc(C);
      end;
      C^ := N^;
      if N^ in LeadBytes then
      begin
        Inc(C);
        Inc(N);
        C^ := N^;
      end;
      Inc(C);
      Inc(N);
    end;
    SetString(Result, CName, C - CName);
  end;

  function Delimit(const Name: string): string;
  begin
    Result := Name;
    if NeedsBackslashing(Result) then Result := Backslash(Result);
    if Pos('.', Name) <> 0 then Result := '"' + Result + '"';
  end;

begin
  FieldID := NullFieldID;
  AttrID := NullAttrID;
  if Origin = '' then
  begin
    if DataSet is TTable then
    begin
      FieldID := FindFieldID(FTableID, FieldName);
      AttrID := GetAttrID(FieldID);
      Origin := '';
    end else
    if DataSet is TQuery then
    try
      FQueryDescs.RecNo := DataSet.FieldDefs.Find(FieldName).FieldNo;
      DatabaseName := FQueryDescs['DATABASE']; { Do not localize }
      TableName := FQueryDescs['TABLENAME']; { Do not localize }
      FldName := FQueryDescs['FIELDNAME']; { Do not localize }
      FieldID := FindFieldID(FindTableID(FindDatabaseID(DatabaseName),
        QualifyTableName(DatabaseName, nil, FQueryDescs['TABLENAME'])), { Do not localize }
        FQueryDescs['FIELDNAME']); { Do not localize }
      AttrID := GetAttrID(FieldID);
      Origin := Delimit(TableName) + '.' + Delimit(FldName);
      if (TQuery(Dataset).Database = nil) or
         AnsiSameText(TQuery(Dataset).DatabaseName, DatabaseName) then
        Origin := Delimit(DatabaseName) + '.' + Origin;
    except
      FieldID := NullFieldID;
      AttrID := NullAttrID;
      Origin := '';
    end;
  end;
  Result := inherited DoCreateField(FieldName, Origin);
  try
    if DictionaryActive then UpdateField(Result, FieldID, AttrID);
  except
    Result.Free;
    raise;
  end;
end;

procedure TBDEDesigner.InitializeMenu(Menu: TPopupMenu);
type
  TMenuInfo = record
    Name: string;
    HelpContext: Integer;
    Caption: string;
    ShortCut: string;
    Tag: TMenuItemID;
  end;
const
  AttributeMenus: array[TMenuItemID] of TMenuInfo = (
   (Name: 'N2'; HelpContext: 0; Caption: '-'; ShortCut: ''; Tag: miSeparator), { Do not localize }
   (Name: 'RetrieveItem'; HelpContext: 30138; Caption: SRetrieveAttributes;{ Do not localize }
    ShortCut: 'Ctrl+R'; Tag: miRetrieve),{ Do not localize }
   (Name: 'UpdateItem'; HelpContext: 30139; Caption: SSaveAttributes;{ Do not localize }
    ShortCut: 'Ctrl+S'; Tag: miSave),{ Do not localize }
   (Name: 'SaveAttributesAsItem'; HelpContext: 30140; Caption: SSaveAttributesAs;{ Do not localize }
    ShortCut: 'Ctrl+E'; Tag: miSaveAs),{ Do not localize }
   (Name: 'AssociateItem'; HelpContext: 30141; Caption: SAssociateAttributes;{ Do not localize }
    ShortCut: 'Ctrl+O'; Tag: miAssociate),{ Do not localize }
   (Name: 'Unassociate'; HelpContext: 30142; Caption: SUnassociateAttributes;{ Do not localize }
    ShortCut: 'Ctrl+U'; Tag: miUnassociate){ Do not localize }
  );
var
  i: TMenuItemID;
begin
  FTableID := NullTableID;
  FQueryDescs := nil;
  inherited InitializeMenu(Menu);
  for i := Low(AttributeMenus) to High(AttributeMenus) do
  begin
    FMenuArray[i] := TMenuItem.Create(nil);
    FMenuArray[i].Name := AttributeMenus[i].Name;
    FMenuArray[i].HelpContext := AttributeMenus[i].HelpContext;
    FMenuArray[i].Caption := AttributeMenus[i].Caption;
    if AttributeMenus[i].ShortCut <> '' then
      FMenuArray[i].ShortCut := TextToShortCut(AttributeMenus[i].ShortCut);
    FMenuArray[i].Tag := Integer(AttributeMenus[i].Tag);
    FMenuArray[i].OnClick := AttributeClick;
    Menu.Items.Add(FMenuArray[i]);
  end;
end;

procedure TBDEDesigner.UpdateMenus(Menu: TPopupMenu; EditState: TEditState);
var
  i: TMenuItemID;
  Active: Boolean;
  HasAttributes: Boolean;
  Update: Boolean;
  HasSelection: Boolean;
begin
  inherited UpdateMenus(Menu, EditState);
  HasSelection := esCanCopy in EditState;
  Active := DictionaryActive;
  Update := HasSelection and Active;
  HasAttributes := HasSelection and Update and not FieldsEditor.ForEachSelection(CheckAttribute);
  for i := Low(FMenuArray) to High(FMenuArray) do
    if Assigned(FMenuArray[i]) then
      case i of
        miRetrieve: FMenuArray[i].Enabled := HasSelection and Active;
        miSave: FMenuArray[i].Enabled := HasAttributes;
        miSaveAs: FMenuArray[i].Enabled := HasAttributes or (Update and (DataSet is TTable));
        miAssociate: FMenuArray[i].Enabled := Update;
        miUnassociate: FMenuArray[i].Enabled := HasAttributes;
      end;
end;

{ TDBDataSetEditor }

type
  TDBDataSetEditor = class(TDataSetEditor)
  protected
    function GetDSDesignerClass: TDSDesignerClass; override;
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

function TDBDataSetEditor.GetDSDesignerClass: TDSDesignerClass;
begin
  Result := TBDEDesigner;
end;

procedure TDBDataSetEditor.ExecuteVerb(Index: Integer);
begin
  if Index <= inherited GetVerbCount - 1 then
    inherited ExecuteVerb(Index) else
  begin
    Dec(Index, inherited GetVerbCount);
    case Index of
      0: ExploreDataset(TDBDataset(Component));
    end;
  end;
end;

function TDBDataSetEditor.GetVerb(Index: Integer): string;
begin
  if Index <= inherited GetVerbCount - 1 then
    Result := inherited GetVerb(Index) else
  begin
    Dec(Index, inherited GetVerbCount);
    case Index of
      0: Result := SExplore;
    end;
  end;
end;

function TDBDataSetEditor.GetVerbCount: Integer;
begin
  Result := inherited GetVerbCount + 1;
end;

{ TQueryEditor }

type
  TQueryEditor = class(TDBDataSetEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

procedure TQueryEditor.ExecuteVerb(Index: Integer);
var
  Database: TDatabase;
  Query: TQuery;
begin
  if Index < inherited GetVerbCount then
    inherited ExecuteVerb(Index) else
  begin
    Query := Component as TQuery;
    Dec(Index, inherited GetVerbCount);
    case Index of
      0: Query.ExecSQL;
      1:
      if GQELoaded then
      begin
        Database := Query.OpenDatabase;
        try
          BuildQuery(Query);
        finally
          Query.CloseDatabase(Database);
        end;
        if Designer <> nil then Designer.Modified;
      end;
    end;
  end;
end;

function TQueryEditor.GetVerb(Index: Integer): string;
begin
  if Index < inherited GetVerbCount then
    Result := inherited GetVerb(Index) else
  begin
    Dec(Index, inherited GetVerbCount);
    case Index of
      0: Result := SExecute;
      1: if GQELoaded then Result := SGQEVerb;
    end;
  end;
end;

function TQueryEditor.GetVerbCount: Integer;
begin
  Result := inherited GetVerbCount + 1 + Ord(LoadGQE);
end;

{ TQueryParamsProperty }

type
  TQueryParamsProperty = class(TCollectionProperty)
  public
    function GetColOptions: TColOptions; override;
  end;

function TQueryParamsProperty.GetColOptions: TColOptions;
begin
  Result := [];
end;

{ TStoredProcEditor }

type
  TStoredProcEditor = class(TDBDataSetEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

procedure TStoredProcEditor.ExecuteVerb(Index: Integer);
begin
  if Index < inherited GetVerbCount then
    inherited ExecuteVerb(Index) else
  begin
    Dec(Index, inherited GetVerbCount);
    if Index = 0 then (Component as TStoredProc).ExecProc;
  end;
end;

function TStoredProcEditor.GetVerb(Index: Integer): string;
begin
  if Index < inherited GetVerbCount then
    Result := inherited GetVerb(Index) else
  begin
    Dec(Index, inherited GetVerbCount);
    if Index = 0 then Result := SExecute;
  end;
end;

function TStoredProcEditor.GetVerbCount: Integer;
begin
  Result := inherited GetVerbCount + 1;
end;

{ TStoredProcParamsProperty }

type
  TStoredProcParamsProperty = class(TCollectionProperty)
  public
    procedure Edit; override;
  end;

procedure TStoredProcParamsProperty.Edit;
var
  StoredProc: TStoredProc;
  Params: TParams;
begin
  StoredProc := (GetComponent(0) as TStoredProc);
  Params := TParams.Create(nil);
  try
    StoredProc.CopyParams(Params);
  finally
    Params.Free;
  end;
  inherited Edit;
end;

{ TTableEditor }

function IsDatabaseOpen(DataSet: TDBDataSet): Boolean;
var
  Session: TSession;
  DB: TDatabase;
begin
  Result := False;
  with DataSet do
  begin
    Session := Sessions.FindSession(SessionName);
    if Session <> nil then
    begin
      DB := Session.FindDatabase(DatabaseName);
      Result := (DB <> nil) and DB.Connected;
    end;
  end;
end;

type
  TTableEditor = class(TDBDataSetEditor)
  private
    FActions: TTableDesignActions;
    procedure UpdateActions;
    function IndexToAction(Index: Integer): TTableDesignAction;
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

procedure TTableEditor.UpdateActions;
const
  ExistsActions: array [Boolean] of TTableDesignActions =
    ([tdCreate, tdUpdate], [tdDelete, tdUpdate, tdRename]);
begin
  FActions := [];
  if IsDatabaseOpen(TTable(Component)) then
  try
    FActions := ExistsActions[TTable(Component).Exists];
    if (tdCreate in FActions) and (TTable(Component).FieldDefs.Count = 0) then
      Exclude(FActions, tdCreate);
    if (tdUpdate in FActions) and (TTable(Component).TableName = '') then
      Exclude(FActions, tdUpdate);
  except
  end;
end;

function TTableEditor.IndexToAction(Index: Integer): TTableDesignAction;
begin
  for Result := Low(TTableDesignAction) to High(TTableDesignAction) do
    if Result in FActions then if Index = 0 then Exit else Dec(Index);
  Result := tdCreate; // Error
end;

procedure TTableEditor.ExecuteVerb(Index: Integer);
var
  I: Integer;
begin
  I := inherited GetVerbCount;
  if Index < I then inherited
  else if TableDesigner(TTable(Component), IndexToAction(Index - I)) then
    Designer.Modified;
end;

function TTableEditor.GetVerb(Index: Integer): string;
var
  I: Integer;
begin
  I := inherited GetVerbCount;
  if Index < I then
    Result := inherited GetVerb(Index) else
    Result := TableDesignMenu[IndexToAction(Index - I)];
end;

function TTableEditor.GetVerbCount: Integer;
var
  T: TTableDesignAction;
begin
  Result := inherited GetVerbCount;
  UpdateActions;
  for T := Low(TableDesignMenu) to High(TableDesignMenu) do
    if T in FActions then Inc(Result);
end;

{ TDatabaseEditor }

type
  TDatabaseEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

procedure TDatabaseEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0: if EditDatabase(TDatabase(Component)) then Designer.Modified;
    1: ExploreDatabase(TDatabase(Component));
  end;
end;

function TDatabaseEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := SDatabaseEditor;
    1: Result := SExplore;
  end;
end;

function TDatabaseEditor.GetVerbCount: Integer;
begin
  Result := 2;
end;

{ TBatchMoveEditor }

type
  TBatchMoveEditor = class(TDefaultEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

procedure TBatchMoveEditor.ExecuteVerb(Index: Integer);
begin
  TBatchMove(Component).Execute;
end;

function TBatchMoveEditor.GetVerb(Index: Integer): string;
begin
  Result := SBatchExecute;
end;

function TBatchMoveEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{ TSessionNameProperty }

type
  TSessionNameProperty = class(TDBStringProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

procedure TSessionNameProperty.GetValueList(List: TStrings);
begin
  Sessions.GetSessionNames(List);
end;

{ TDatabaseNameProperty }

type
  TDatabaseNameProperty = class(TDBStringProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

procedure TDatabaseNameProperty.GetValueList(List: TStrings);
begin
  (GetComponent(0) as TDBDataSet).DBSession.GetDatabaseNames(List);
end;

{ TAliasNameProperty }

type
  TAliasNameProperty = class(TDBStringProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

procedure TAliasNameProperty.GetValueList(List: TStrings);
begin
  (GetComponent(0) as TDatabase).Session.GetAliasNames(List);
end;

{ TDriverNameProperty }

type
  TDriverNameProperty = class(TDBStringProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

procedure TDriverNameProperty.GetValueList(List: TStrings);
begin
  (GetComponent(0) as TDatabase).Session.GetDriverNames(List);
end;

{ TTableNameProperty }

type
  TTableNameProperty = class(TDBStringProperty)
  public
    function AutoFill: Boolean; override;
    procedure GetValueList(AList: TStrings); override;
  end;

function TTableNameProperty.AutoFill: Boolean;
begin
  Result := IsDatabaseOpen(GetComponent(0) as TDBDataSet);
end;

procedure TTableNameProperty.GetValueList(AList: TStrings);
const
  Masks: array[TTableType] of string[5] = ('', '*.DB', '*.DBF', '*.DBF', '*.TXT'); { Do not localize }
begin
  with GetComponent(0) as TTable do
    DBSession.GetTableNames(DatabaseName, Masks[TableType],
      TableType = ttDefault, False, AList);
end;

{ TProcedureNameProperty }

type
  TProcedureNameProperty = class(TDBStringProperty)
  public
    function AutoFill: Boolean; override;
    procedure GetValueList(List: TStrings); override;
  end;

function TProcedureNameProperty.AutoFill: Boolean;
begin
  Result := (GetComponent(0) as TDBDataSet).Active;
end;

procedure TProcedureNameProperty.GetValueList(List: TStrings);
var
  DBDataSet: TDBDataSet;
begin
  DBDataSet := GetComponent(0) as TDBDataSet;
  DBDataSet.DBSession.GetStoredProcNames(DBDataSet.DatabaseName, List);
end;
{ TIndexFilesProperty }

type
  TIndexFilesProperty = class(TPropertyEditor)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
    function GetValue: string; override;
  end;

function TIndexFilesProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;

function TIndexFilesProperty.GetValue: string;
begin
  Result := Format('(%s)', [TIndexFiles.ClassName]); { Do not localize }
end;

procedure TIndexFilesProperty.Edit;
var
  List: TStringList;
  Table: TTable;
  I: Integer;
  IndexFile: string;
begin
  Table := GetComponent(0) as TTable;
  List := TStringList.Create;
  try
    List.Assign(Table.IndexFiles);
    if EditIndexFiles(Table, List) then
    begin
      for I := 0 to List.Count - 1 do
      begin
        IndexFile := List[I];
        with Table.IndexFiles do
          if IndexOf(IndexFile) = -1 then Add(IndexFile);
      end;
      for I := Table.IndexFiles.Count - 1 downto 0 do
      begin
        IndexFile := Table.IndexFiles[I];
        with Table.IndexFiles do
          if List.IndexOf(IndexFile) = -1 then Delete(IndexOf(IndexFile));
      end;
      Modified;
    end;
  finally
    List.Free;
  end;
end;

{ TUpdateSQLEditor }

type
  TUpdateSQLEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

procedure TUpdateSQLEditor.ExecuteVerb(Index: Integer);
begin
  if EditUpdateSQL(TUpdateSQL(Component)) then Designer.Modified;
end;

function TUpdateSQLEditor.GetVerb(Index: Integer): string;
begin
  Result := SUpdateSQLEditor;
end;

function TUpdateSQLEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{ TTableFieldLinkProperty }

procedure TTableFieldLinkProperty.Edit;
var
  Table: TTable;
begin
  Table := DataSet as TTable;
  FTable := TTable.Create(nil);
  try
    FTable.SessionName := Table.SessionName;
    FTable.DatabaseName := Table.DatabaseName;
    FTable.TableName := Table.TableName;
    if Table.IndexFieldNames <> '' then
      FTable.IndexFieldNames := Table.IndexFieldNames else
      FTable.IndexName := Table.IndexName;
    FTable.MasterFields := Table.MasterFields;
    FTable.Open;
    inherited Edit;
    if Changed then
    begin
      Table.MasterFields := FTable.MasterFields;
      if FTable.IndexFieldNames <> '' then
        Table.IndexFieldNames := FTable.IndexFieldNames else
        Table.IndexName := FTable.IndexName;
    end;
  finally
    FTable.Free;
  end;
end;

procedure TTableFieldLinkProperty.GetFieldNamesForIndex(List: TStrings);
var
  i: Integer;
begin
  for i := 0 to FTable.IndexFieldCount - 1 do
    List.Add(FTable.IndexFields[i].FieldName);
end;

function TTableFieldLinkProperty.GetIndexBased: Boolean;
begin
  Result := not IProviderSupport(FTable).PSIsSQLBased;
end;

function TTableFieldLinkProperty.GetIndexDefs: TIndexDefs;
begin
  Result := FTable.IndexDefs;
end;

function TTableFieldLinkProperty.GetIndexFieldNames: string;
begin
  Result := FTable.IndexFieldNames;
end;

function TTableFieldLinkProperty.GetIndexName: string;
begin
  Result := FTable.IndexName;
end;

function TTableFieldLinkProperty.GetMasterFields: string;
begin
  Result := FTable.MasterFields;
end;

procedure TTableFieldLinkProperty.SetIndexFieldNames(const Value: string);
begin
  FTable.IndexFieldNames := Value;
end;

procedure TTableFieldLinkProperty.SetIndexName(const Value: string);
begin
  if Value = SPrimary then
    FTable.IndexName := '' else
    FTable.IndexName := Value;
end;

procedure TTableFieldLinkProperty.SetMasterFields(const Value: string);
begin
  FTable.MasterFields := Value;
end;



type
  TReportEditor = class(TComponentEditor)
  public
    procedure Edit; override;
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  TReportDirProperty = class(TPropertyEditor)
  public
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

  TReportNameProperty = class(TPropertyEditor)
  public
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

{ TReportEditor }

procedure TReportEditor.Edit;
begin
  TReport(Component).Run;
end;

procedure TReportEditor.ExecuteVerb(Index: Integer);
begin
  if Index = 0 then Edit;
end;

function TReportEditor.GetVerb(Index: Integer): string;
begin
  Result := SReportVerb;
end;

function TReportEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{ TReportDirProperty }

function TReportDirProperty.GetValue: string;
begin
  Result := (GetComponent(0) as TReport).ReportDir;
end;

procedure TReportDirProperty.SetValue(const Value: string);
begin
  (GetComponent(0) as TReport).ReportDir := Value;
  Modified;
end;

function TReportDirProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paMultiSelect];
end;

procedure TReportDirProperty.Edit;
var
  FilePath: string;
begin
  FilePath := '';
  if SelectDirectory(FilePath, [], hcDSelectReportDir) then
  begin
    if AnsiLastChar(FilePath)^ <> '\' then FilePath := FilePath + '\';
    SetValue(FilePath);
  end;
end;

{ TReportNameProperty }

function TReportNameProperty.GetValue: string;
begin
  Result := (GetComponent(0) as TReport).ReportName;
end;

procedure TReportNameProperty.SetValue(const Value: string);
begin
  (GetComponent(0) as TReport).ReportName := Value;
  Modified;
end;

function TReportNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paMultiSelect];
end;

procedure TReportNameProperty.Edit;
var                                                       
  Dialog: TOpenDialog;
  FilePath: string;
begin
  Dialog := TOpenDialog.Create(nil);
  try
    with Dialog do
    begin
      DefaultExt := 'rpt';
      Filter := SReportFilter;
      if Execute then
        with GetComponent(0) as TReport do
        begin
          FileName := FileName;
          FilePath := ExtractFilePath(FileName);
          ReportDir := FilePath;
          ReportName := ExtractFileName(FileName);
          Modified;
        end;
    end;
  finally
    Dialog.Free;
  end;
end;


function SprigBDESessionName(const AName: string): string;
begin
  Result := AName;
  if (Result = '') or
     AnsiSameText(Result, Session.SessionName) then
    Result := cDefaultSessionSprigName;
end;

function SprigBDEImpliedDatabaseName(const AName: string): string;
begin
  Result := Format('%s.%s', [cImpliedDatabaseSprigPrefix, AName]); { do not localize }
end;

function SprigBDEImpliedSessionName(const AName: string): string;
begin
  Result := Format('%s.%s', [cImpliedSessionSprigPrefix, AName]); { do not localize }
end;

{ TDBDataSetSprig }

function TDBDataSetSprig.AnyProblems: Boolean;
begin
  Result := inherited AnyProblems or
            (TDBDataSet(Item).DatabaseName = '');
end;

procedure TDBDataSetSprig.FigureParent;
var
  LSessionName: string;
  LSession, LDatabase: TSprig;
begin
  with TDBDataSet(Item) do
  begin
    // find real or default session
    LSessionName := SprigBDESessionName(SessionName);
    LSession := Root.Find(LSessionName, False);

    // if not found see if its the default session
    if (LSession = nil) and
       (LSessionName = cDefaultSessionSprigName) then
      LSession := Root.Add(TDefaultSessionSprig.Create(nil));

    // still not found, try for an implied session
    if LSession = nil then
    begin
      LSession := Root.Find(SprigBDEImpliedSessionName(SessionName), False);

      // if not make an implied session
      if LSession = nil then
      begin
        LSession := Root.Add(TImpliedSessionSprig.Create(nil));
        TImpliedSessionSprig(LSession).FSessionName := SessionName;
      end;
    end;

    // find data base under session
    LDatabase := LSession.Find(DatabaseName, False);

    // if not find a database alias
    if LDatabase = nil then
    begin
      LDatabase := LSession.Find(SprigBDEImpliedDatabaseName(DatabaseName), False);

      // if not make a database alias
      if LDatabase = nil then
      begin
        LDatabase := LSession.Add(TImpliedDatabaseSprig.Create(nil));
        TImpliedDatabaseSprig(LDatabase).FAlias := DatabaseName;
        TImpliedDatabaseSprig(LDatabase).FSessionName := SessionName;
      end;
    end;

    // set parent to the database
    LDatabase.Add(Self);
  end;
end;

function TDBDataSetSprig.DragDropTo(AItem: TSprig): Boolean;
begin
  if AItem is TImpliedDatabaseSprig then
  begin
    Result := not AnsiSameText(TImpliedDatabaseSprig(AItem).FAlias, TDBDataSet(Item).DatabaseName) or
              not AnsiSameText(TImpliedDatabaseSprig(AItem).FSessionName, TDBDataSet(Item).SessionName);
    if Result then
    begin
      TDBDataSet(Item).DatabaseName := TImpliedDatabaseSprig(AItem).FAlias;
      TDBDataSet(Item).SessionName := TImpliedDatabaseSprig(AItem).FSessionName;
    end;
  end
  else if AItem is TDatabaseSprig then
  begin
    Result := not AnsiSameText(TDatabase(AItem.Item).DatabaseName, TDBDataSet(Item).DatabaseName) or
              not AnsiSameText(TDatabase(AItem.Item).SessionName, TDBDataSet(Item).SessionName);
    if Result then
    begin
      TDBDataSet(Item).DatabaseName := TDatabase(AItem.Item).DatabaseName;
      TDBDataSet(Item).SessionName := TDatabase(AItem.Item).SessionName;
    end;
  end
  else
    Result := False;
end;

function TDBDataSetSprig.DragOverTo(AItem: TSprig): Boolean;
begin
  Result := ((AItem is TDatabaseSprig) and (TDatabase(AItem.Item).DatabaseName <> '')) or
            (AItem is TImpliedDatabaseSprig);
end;

class function TDBDataSetSprig.PaletteOverTo(AParent: TSprig; AClass: TClass): Boolean;
begin
  Result := ((AParent is TDatabaseSprig) and (TDatabase(AParent.Item).DatabaseName <> '')) or
            (AParent is TImpliedDatabaseSprig);
end;

procedure TDBDataSetSprig.Reparent;
begin
  if Parent is TDatabaseSprig then
    TDBDataSet(Item).SessionName := TDatabase(Parent.Item).SessionName
  else if Parent is TImpliedDatabaseSprig then
    TDBDataSet(Item).SessionName := TImpliedDatabaseSprig(Parent).FSessionName;
end;

{ TSessionSprig }

function TSessionSprig.Name: string;
begin
  Result := TSession(Item).SessionName;
end;

function TSessionSprig.AnyProblems: Boolean;
begin
  Result := TSession(Item).SessionName = '';
end;

function TSessionSprig.Caption: string;
begin
  Result := CaptionFor(Name, UniqueName);
end;

{ TDefaultSessionSprig }

function TDefaultSessionSprig.Caption: string;
begin
  Result := CaptionFor(Session.SessionName, Copy(Session.ClassName, 2, 255));
end;

function TDefaultSessionSprig.ItemClass: TClass;
begin
  Result := TSession;
end;

function TDefaultSessionSprig.UniqueName: string;
begin
  Result := cDefaultSessionSprigName;
end;

{ TImpliedSessionSprig }

function TImpliedSessionSprig.Caption: string;
begin
  Result := CaptionFor(FSessionName, 'Implied Session'); { do not localize }
end;

function TImpliedSessionSprig.ItemClass: TClass;
begin
  Result := TSession;
end;

function TImpliedSessionSprig.UniqueName: string;
begin
  Result := SprigBDEImpliedSessionName(FSessionName);
end;

{ TDatabaseSprig }

function TDatabaseSprig.Name: string;
begin
  Result := TDatabase(Item).DatabaseName;
end;

function TDatabaseSprig.AnyProblems: Boolean;
begin
  Result := TDatabase(Item).DatabaseName = '';
end;

function TDatabaseSprig.Caption: string;
var
  LName: string;
begin
  LName := Name;
  if TDatabase(Item).AliasName <> '' then
    Result := Format('%s:%s', [LName, TDatabase(Item).AliasName]); { Do not localize }
  Result := CaptionFor(LName, UniqueName);
end;

procedure TDatabaseSprig.FigureParent;
var
  LSessionName: string;
  LSession: TSprig;
begin
  with TDatabase(Item) do
  begin
    // find real or default session
    LSessionName := SprigBDESessionName(SessionName);
    LSession := Root.Find(LSessionName, False);

    // if not found see if its the default session
    if (LSession = nil) and
       (LSessionName = cDefaultSessionSprigName) then
      LSession := Root.Add(TDefaultSessionSprig.Create(nil));

    // still not found, try for an implied session
    if LSession = nil then
    begin
      LSession := Root.Find(SprigBDEImpliedSessionName(SessionName), False);

      // if not make an implied session
      if LSession = nil then
      begin
        LSession := Root.Add(TImpliedSessionSprig.Create(nil));
        TImpliedSessionSprig(LSession).FSessionName := SessionName;
      end;
    end;

    // well put it
    LSession.Add(Self);
  end;
end;

function TDatabaseSprig.DragDropTo(AItem: TSprig): Boolean;
begin
  if AItem is TSessionSprig then
  begin
    Result := not AnsiSameText(TSession(AItem.Item).SessionName, TDatabase(Item).SessionName);
    if Result then
      TDatabase(Item).SessionName := TSession(AItem.Item).SessionName;
  end
  else if AItem is TImpliedSessionSprig then
  begin
    Result := not AnsiSameText(TImpliedSessionSprig(AItem).FSessionName, TDatabase(Item).SessionName);
    if Result then
      TDatabase(Item).SessionName := TImpliedSessionSprig(AItem).FSessionName;
  end
  else if AItem is TDefaultSessionSprig then
  begin
    Result := not AnsiSameText(TDatabase(Item).SessionName, Session.SessionName) or
              (TDatabase(Item).SessionName <> '');
    if Result then
      TDatabase(Item).SessionName := '';
  end
  else
    Result := False;
  ReparentChildren;
end;

function TDatabaseSprig.DragOverTo(AItem: TSprig): Boolean;
begin
  Result := ((AItem is TSessionSprig) and (TSession(AItem.Item).SessionName <> '')) or
            (AItem is TImpliedSessionSprig) or
            (AItem is TDefaultSessionSprig);
end;

class function TDatabaseSprig.PaletteOverTo(AParent: TSprig; AClass: TClass): Boolean;
begin
  Result := ((AParent is TSessionSprig) and (TSession(AParent.Item).SessionName <> '')) or
            (AParent is TImpliedSessionSprig) or
            (AParent is TDefaultSessionSprig);
end;

{ TImpliedDatabaseSprig }

function TImpliedDatabaseSprig.AnyProblems: Boolean;
begin
  Result := FAlias = '';
end;

function TImpliedDatabaseSprig.Caption: string;
begin
  Result := CaptionFor(FAlias, 'Alias'); { Do not localize }
end;

function TImpliedDatabaseSprig.DragDropTo(AItem: TSprig): Boolean;
begin
  if AItem is TSessionSprig then
  begin
    Result := not AnsiSameText(TSession(AItem.Item).SessionName, FSessionName);
    if Result then
      FSessionName := TSession(AItem.Item).SessionName;
  end
  else if AItem is TImpliedSessionSprig then
  begin
    Result := not AnsiSameText(TImpliedSessionSprig(AItem).FSessionName, FSessionName);
    if Result then
      FSessionName := TImpliedSessionSprig(AItem).FSessionName;
  end
  else if AItem is TDefaultSessionSprig then
  begin
    Result := not AnsiSameText(FSessionName, Session.SessionName) or
              (FSessionName <> '');
    if Result then
      FSessionName := '';
  end
  else
    Result := False;
  ReparentChildren;
end;

function TImpliedDatabaseSprig.DragOverTo(AItem: TSprig): Boolean;
begin
  Result := (AItem is TSessionSprig) or
            (AItem is TImpliedSessionSprig) or
            (AItem is TDefaultSessionSprig);
end;

procedure TImpliedDatabaseSprig.FigureParent;
var
  LSessionName: string;
  LSession: TSprig;
begin
  // find real or default session
  LSessionName := SprigBDESessionName(FSessionName);
  LSession := Root.Find(LSessionName, False);

  // if not found see if its the default session
  if (LSession = nil) and
     (LSessionName = cDefaultSessionSprigName) then
    LSession := Root.Add(TDefaultSessionSprig.Create(nil));

  // still not found, try for an implied session
  if LSession = nil then
  begin
    LSession := Root.Find(SprigBDEImpliedSessionName(FSessionName), False);

    // if not make an implied session
    if LSession = nil then
    begin
      LSession := Root.Add(TImpliedSessionSprig.Create(nil));
      TImpliedSessionSprig(LSession).FSessionName := FSessionName;
    end;
  end;

  // put ourself here
  LSession.Add(Self);
end;

function TImpliedDatabaseSprig.ItemClass: TClass;
begin
  Result := TDatabase;
end;

function TImpliedDatabaseSprig.UniqueName: string;
begin
  Result := SprigBDEImpliedDatabaseName(FAlias);
end;

{ TNestedTableSprig }

class function TNestedTableSprig.ParentProperty: string;
begin
  Result := 'DataSetField'; { do not localize }
end;

{ TTableSprig }

function TTableSprig.AnyProblems: Boolean;
begin
  Result := inherited AnyProblems or
            (TTable(Item).TableName = '');
end;

function TTableSprig.Caption: string;
begin
  Result := CaptionFor(TTable(Item).TableName, UniqueName);
end;

{ TQuerySprig }

function TQuerySprig.AnyProblems: Boolean;
begin
  Result := inherited AnyProblems or
            (TQuery(Item).SQL.Count = 0);
end;

{ TStoredProcSprig }

function TStoredProcSprig.AnyProblems: Boolean;
begin
  Result := inherited AnyProblems or
            (TStoredProc(Item).StoredProcName = '');
end;

function TStoredProcSprig.Caption: string;
begin
  Result := CaptionFor(TStoredProc(Item).StoredProcName, UniqueName);
end;

{ TTableMasterDetailBridge }

class function TTableMasterDetailBridge.GetOmegaSource(
  AItem: TPersistent): TDataSource;
begin
  Result := TTable(AItem).MasterSource;
end;

class function TTableMasterDetailBridge.OmegaIslandClass: TIslandClass;
begin
  Result := TTableIsland;
end;

class procedure TTableMasterDetailBridge.SetOmegaSource(AItem: TPersistent;
  ADataSource: TDataSource);
begin
  TTable(AItem).MasterSource := ADataSource;
end;

function TTableMasterDetailBridge.CanEdit: Boolean;
begin
  Result := True;
end;

function TTableMasterDetailBridge.Edit: Boolean;
var
  LPropEd: TTableFieldLinkProperty;
begin
  LPropEd := TTableFieldLinkProperty.CreateWith(TDataSet(Omega.Item));
  try
    LPropEd.Edit;
    Result := LPropEd.Changed;
  finally
    LPropEd.Free;
  end;
end;

function TTableMasterDetailBridge.Caption: string;
begin
  if TTable(Omega.Item).MasterFields = '' then
    Result := SNoMasterFields
  else
    Result := TTable(Omega.Item).MasterFields;
end;

{ TQueryMasterDetailBridge }

function TQueryMasterDetailBridge.Caption: string;
begin
  Result := SParamsFields;
end;

class function TQueryMasterDetailBridge.GetOmegaSource(
  AItem: TPersistent): TDataSource;
begin
  Result := TQuery(AItem).DataSource;
end;

class function TQueryMasterDetailBridge.OmegaIslandClass: TIslandClass;
begin
  Result := TQueryIsland;
end;

class function TQueryMasterDetailBridge.RemoveMasterFieldsAsWell: Boolean;
begin
  Result := False;
end;

class procedure TQueryMasterDetailBridge.SetOmegaSource(AItem: TPersistent;
  ADataSource: TDataSource);
begin
  TQuery(AItem).DataSource := ADataSource;
end;

{ TBatchMoveSprig }

function TBatchMoveSprig.AnyProblems: Boolean;
begin
  Result := (TBatchMove(Item).Destination = nil) or
            (TBatchMove(Item).Source = nil);
end;

function TBatchMoveSprig.Caption: string;
var
  LFrom, LTo: string;
begin
  if TBatchMove(Item).Source <> nil then
    LFrom := TBatchMove(Item).Source.Name
  else
    LFrom := '?';
  if TBatchMove(Item).Destination <> nil then
    LTo := TBatchMove(Item).Destination.Name
  else
    LTo := '?';
  Result := CaptionFor(Format('%s -> %s', [LFrom, LTo]), UniqueName); { do not localize }
end;

{ TUpdateSQLSprig }

function TUpdateSQLSprig.AnyProblems: Boolean;
begin
  with TUpdateSQL(Item) do
    Result := (ModifySQL.Count = 0) and
              (InsertSQL.Count = 0) and
              (DeleteSQL.Count = 0);
end;

procedure Register;
begin
  { Database Components are excluded from the STD SKU }
  if GDAL <> LongWord(-16) then
  begin
    // Restrict these components to only be used with VCL components.
    GroupDescendentsWith(TBDEDataSet, Controls.TControl);
    GroupDescendentsWith(TDatabase, Controls.TControl);
    GroupDescendentsWith(TSession, Controls.TControl);
    GroupDescendentsWith(TBatchMove, Controls.TControl);
    GroupDescendentsWith(TUpdateSQL, Controls.TControl);

    RegisterComponents(srBDE, [TTable, TQuery, TStoredProc, TDatabase,
      TSession, TBatchMove, TUpdateSQL]);

    { Components that are excluded from the STD & PRO SKUs }
    if GDAL = 0 then
      RegisterComponents(srBDE, [TNestedTable]);
    RegisterPropertyEditor(TypeInfo(TStrings), TDatabase, 'Params', TValueListProperty);
    RegisterPropertyEditor(TypeInfo(string), TDatabase, 'AliasName', TAliasNameProperty);
    RegisterPropertyEditor(TypeInfo(string), TDatabase, 'DriverName', TDriverNameProperty);
    RegisterPropertyEditor(TypeInfo(string), TDatabase, 'SessionName', TSessionNameProperty);
    RegisterPropertyEditor(TypeInfo(string), TDBDataSet, 'SessionName', TSessionNameProperty);
    RegisterPropertyEditor(TypeInfo(string), TDBDataSet, 'DatabaseName', TDatabaseNameProperty);
    RegisterPropertyEditor(TypeInfo(TDataSetUpdateObject), TDataSet, 'UpdateObject', TComponentProperty);
    RegisterPropertyEditor(TypeInfo(TFileName), TTable, 'TableName', TTableNameProperty);
    RegisterPropertyEditor(TypeInfo(string), TTable, 'IndexName', TIndexNameProperty);
    RegisterPropertyEditor(TypeInfo(string), TTable, 'IndexFieldNames', TIndexFieldNamesProperty);
    RegisterPropertyEditor(TypeInfo(string), TTable, 'MasterFields', TTableFieldLinkProperty);
    RegisterPropertyEditor(TypeInfo(string), TStoredProc, 'StoredProcName', TProcedureNameProperty);
    RegisterPropertyEditor(TypeInfo(TParams), TQuery, 'Params', TQueryParamsProperty);
    RegisterPropertyEditor(TypeInfo(TParams), TStoredProc, 'Params', TStoredProcParamsProperty);
    RegisterPropertyEditor(TypeInfo(TStrings), TTable, 'IndexFiles', TIndexFilesProperty);
    RegisterPropertyEditor(TypeInfo(TCheckConstraints), TDBDataSet, 'Constraints', TCheckConstraintsProperty);
    RegisterComponentEditor(TDBDataset, TDBDataSetEditor);
    RegisterComponentEditor(TTable, TTableEditor);
    RegisterComponentEditor(TDatabase, TDatabaseEditor);
    RegisterComponentEditor(TBatchMove, TBatchMoveEditor);
    RegisterComponentEditor(TQuery, TQueryEditor);
    RegisterComponentEditor(TStoredProc, TStoredProcEditor);
    RegisterComponentEditor(TUpdateSQL, TUpdateSQLEditor);

    { Obsolete Components }
    
//      if HexDisplayPrefix = '$' then  // Only register TReport for Delphi
//      begin
//        RegisterComponents(srBDE, [TReport]);
//        RegisterPropertyEditor(TypeInfo(string), TReport, 'ReportDir', TReportDirProperty);
//        RegisterPropertyEditor(TypeInfo(string), TReport, 'ReportName', TReportNameProperty);
//        RegisterComponentEditor(TReport, TReportEditor);
//      end;
      RegisterComponents(srWin31, [TDBLookupList, TDBLookupCombo]);
      RegisterNonActiveX([TDBLookupList, TDBLookupCombo], axrIncludeDescendants);
    

    { Property Category registration }
    RegisterPropertiesInCategory(sDatabaseCategoryName, TDBDataSet,
      ['DatabaseName', 'SessionName']);

    RegisterPropertiesInCategory(sDatabaseCategoryName, TDatabase,
      ['AliasName', 'DriverName', 'SessionName', 'DatabaseName']);

    { Property Category registration }
    RegisterPropertiesInCategory(sDatabaseCategoryName, TDataSetUpdateObject, ['*SQL']);

    RegisterSprigType(TSession, TSessionSprig);
    RegisterSprigType(TDatabase, TDatabaseSprig);
    RegisterSprigType(TNestedTable, TNestedTableSprig);
    RegisterSprigType(TBDEDataSet, TBDEDataSetSprig);
    RegisterSprigType(TDBDataSet, TDBDataSetSprig);
    RegisterSprigType(TTable, TTableSprig);
    RegisterSprigType(TQuery, TQuerySprig);
    RegisterSprigType(TStoredProc, TStoredProcSprig);
    RegisterSprigType(TBatchMove, TBatchMoveSprig);
    RegisterSprigType(TUpdateSQL, TUpdateSQLSprig);

    RegisterIslandType(TBDEDataSetSprig, TBDEDataSetIsland);
    RegisterIslandType(TDBDataSetSprig, TDBDataSetIsland);
    RegisterIslandType(TTableSprig, TTableIsland);
    RegisterIslandType(TQuerySprig, TQueryIsland);

    RegisterBridgeType(TDataSetIsland, TTableIsland, TTableMasterDetailBridge);
    RegisterBridgeType(TDataSetIsland, TQueryIsland, TQueryMasterDetailBridge);
  end;
end;

{ TBDEDataSetSprig }

function TBDEDataSetSprig.GetDSDesignerClass: TDSDesignerClass;
begin
  Result := TBDEDesigner;
end;

end.
