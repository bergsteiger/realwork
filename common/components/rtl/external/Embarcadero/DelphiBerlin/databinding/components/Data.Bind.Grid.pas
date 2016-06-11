{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{$HPPEMIT LINKUNIT}
unit Data.Bind.Grid;

interface

uses System.SysUtils, System.Classes, Data.Bind.Components, System.Bindings.Outputs,
  Generics.Collections;

type

  TBaseLinkToDataSource = class(TBindComponentDelegate)
  protected
    procedure SetSourceControl(const Value: TBaseLinkingBindSource);
    function GetSourceControl: TBaseLinkingBindSource;
    procedure SetSourceMember(const Value: string);
    function GetSourceMember: string;
    function GetControlComponent: TComponent; override;
    procedure SetControlComponent(const Value: TComponent);  override;
    procedure MemberRenaming(Sender: TComponent; AComponent: TComponent;
      const ACurMemberName, ANewMemberName: string); override;
    //function GetExpressionEvaluation: TBindCompExpressionEvaluation; virtual;
  public
    procedure UpdateColumns; virtual; abstract;
    function ColumnsHaveChanged: Boolean; virtual; abstract;
    property DataSource: TBaseLinkingBindSource read GetSourceControl write SetSourceControl;
  end;


  TBaseLinkGridToDataSourceColumn = class;
  TBaseLinkGridToDataSourceColumns = class;
  TLinkGridToDataSourceColumns = class;
  TLinkGridColumnDescriptions = class;
  TLinkGridToDataSourceColumn = class;
  TLinkGridColumnDescription = class;

  ILinkGridToDataSource = interface
    ['{E14CC39A-D660-4801-9FFB-7CA7F2B6A99F}']
    function GetReadOnly: Boolean;
    function GetDataSource: TBaseLinkingBindSource;
    function GetActive: Boolean;
    function GetDefaultMembers: Boolean;
    function GetComponentState: TComponentState;
    function CreateColumns: TBaseLinkGridToDataSourceColumns;
    procedure BeginUpdate;
    procedure CancelLayout;
    procedure EndUpdate;
    procedure BeginLayout;
    procedure EndLayout;
    procedure LayoutChanged;
    procedure InvalidateColumn(AColumn: TBaseLinkGridToDataSourceColumn);
//    procedure InvalidateField(AField: TField);
    function AcquireLayoutLock: Boolean;
    property ReadOnly: Boolean read GetReadOnly;
    property DataSource: TBaseLinkingBindSource read GetDataSource;
    property Active: Boolean read GetActive;
    property DefaultMembers: Boolean read GetDefaultMembers;
    property ComponentState: TComponentState read GetComponentState;
  end;

  ILinkGridToDataSourceControlManager = interface;

  TBaseLinkGridToDataSource = class(TBaseLinkToDataSource, ILinkGridToDataSource)
  private
    FBindGridLink: TCustomBindGridLink;
    FUpdateLock: Byte;
    FLayoutLock: Byte;
    FDefaultColumnWidth: Integer;
    function GetAutoActivate: Boolean;
    procedure SetAutoActivate(const Value: Boolean);
    procedure SetActive(const Value: Boolean);
    procedure InternalLayout;
    function GetBufferCount: Integer;
    procedure SetBufferCount(const Value: Integer);
    procedure SetDefaultColumnWidth(const Value: Integer);
  protected
    function GetColumns: TBaseLinkGridToDataSourceColumns; virtual; abstract;
    function GetGridColumnManagerFactory(AGuid: TGuid): IInterface; virtual;
    function GetGridColumnManager: ILinkGridToDataSourceControlManager; virtual;
    procedure Loaded; override;
    procedure ClearColumns(AManager: ILinkGridToDataSourceControlManager); virtual;
    function GetMemberDisplayName(const AMemberName: string; out ADisplayName: string): Boolean; virtual;
    { ILinkGridToDataSource }
    procedure BeginUpdate;
    procedure CancelLayout;
    procedure EndUpdate;
    function GetReadOnly: Boolean;
    function GetDataSource: TBaseLinkingBindSource;
    function GetActive: Boolean; override;
    function GetDefaultMembers: Boolean;
    function GetComponentState: TComponentState;
    function CreateColumns: TBaseLinkGridToDataSourceColumns;
    function AcquireLayoutLock: Boolean;
    procedure LayoutChanged;
    procedure InvalidateColumn(AColumn: TBaseLinkGridToDataSourceColumn); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure BeginLayout;
    procedure EndLayout;
    function CanActivate(Sender: TComponent): Boolean; override;
    function GetDelegates: TArray<TCommonBindComponent>; override;
    procedure ClearGeneratedExpressions(Sender: TComponent); override;
    property BindGridLink: TCustomBindGridLink read FBindGridLink;
    property Active: Boolean read GetActive write SetActive;
    [Default(-1)]
    property BufferCount: Integer read GetBufferCount write SetBufferCount default -1;
    [Default(True)]
    property AutoActivate: Boolean read GetAutoActivate write SetAutoActivate default True;
    [Default(64)]
    property DefaultColumnWidth: Integer read FDefaultColumnWidth write SetDefaultColumnWidth default 64;
  end;


  TCustomLinkGridToDataSource = class(TBaseLinkGridToDataSource)
  public
  type
    TMemberKey = record
    private
      FMemberName: string;
      FColumn: TBaseLinkGridToDataSourceColumn;
    public
      constructor CreateMemberName(const AMemberName: string);
      constructor CreateColumn(AColumn: TBaseLinkGridToDataSourceColumn);
    end;
  protected
    function GetControl: TComponent;
    procedure SetControl(const Value: TComponent);
  private
    FLinkGridColumnDescriptionsLookup: TDictionary<TMemberKey, Integer>;
    FLinkGridColumnDescriptions: TLinkGridColumnDescriptions;
    FLinkGridToDataSourceColumns: TLinkGridToDataSourceColumns;
    FDeprecatedAutoBufferCount: Boolean;
    FUseEvalShortcuts: Boolean;
    procedure CreateDefaultGridColumns;
    procedure CreateCollectionGridColumns;
     procedure SetColumns(Value: TLinkGridToDataSourceColumns);
    function CreateDefaultGridColumnDescriptions: TLinkGridColumnDescriptions;
    function CreateCollectionGridColumnDescriptions: TLinkGridColumnDescriptions;
    function CreateGridColumnDescriptions: TLinkGridColumnDescriptions;
    procedure OnListRefreshing(Sender: TObject);
    function GetDataSetFields: TArray<string>;
    procedure ReadBoolean(Reader: TReader);
    procedure ReadInteger(Reader: TReader);
  protected
    function GetMemberDisplayName(const AMemberName: string; out ADisplayName: string): Boolean; override;
    procedure MemberRenaming(Sender: TComponent; AComponent: TComponent; const ACurMemberName,
      ANewMemberName: string); override;
    function GetColumns: TBaseLinkGridToDataSourceColumns; override;
    procedure InvalidateColumn(AColumn: TBaseLinkGridToDataSourceColumn); override;
    procedure ClearColumns(AManager: ILinkGridToDataSourceControlManager); override;
    function GetUseEvalShortcuts: Boolean; override;
    // Backward compatability
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function CanSetControlComponent(Value: TComponent): Boolean; override;
    procedure ClearGeneratedExpressions(Sender: TComponent); override;
    procedure GenerateExpressions(Sender: TComponent); override;
    procedure UpdateColumns; override;
    function ColumnsHaveChanged: Boolean; override;
    procedure CreateGridColumns;
    property GridControl: TComponent read GetControl write SetControl;
    property Columns: TLinkGridToDataSourceColumns read FLinkGridToDataSourceColumns write SetColumns;
    property AutoBufferCount: Boolean read FDeprecatedAutoBufferCount write FDeprecatedAutoBufferCount;
    [Default(True)]
    property UseEvalShortcuts: Boolean read GetUseEvalShortcuts write FUseEvalShortcuts default True;
  end;

  TLinkGridToDataSource = class(TCustomLinkGridToDataSource)
  published
    property DataSource;
    property GridControl;
    property AutoActivate;
    property Columns;
    property OnAssignedValue;
    property OnAssigningValue;
    property OnEvalError;
    property OnActivating;
    property OnActivated;
    property DefaultColumnWidth;
    property UseEvalShortcuts;
  end;

  TBaseLinkGridToDataSourceColumn = class(TCollectionItem)
  private
    FMemberName: string;
    function  GetDataSource: TBaseLinkingBindSource;
    function  GetParentColumn: TBaseLinkGridToDataSourceColumn;
    procedure SetFieldName(const Value: string);
  protected
    procedure Initialize; virtual;
    function GetGridIntf: ILinkGridToDataSource;
    function  GetGrid: TComponent;
    function GetDisplayName: string; override;
    procedure SetIndex(Value: Integer); override;
  public
    constructor Create(Collection: TCollection); override;
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; virtual;
    property  DataSource: TBaseLinkingBindSource read GetDataSource;
    property  ParentColumn: TBaseLinkGridToDataSourceColumn read GetParentColumn;
    property  MemberName: string read FMemberName write SetFieldName;
  end;

  TBaseLinkGridToDataSourceColumnClass = class of TBaseLinkGridToDataSourceColumn;
  TBaseLinkGridToDataSourceColumns = class(TCollection)
  private
    FGrid: TComponent;
    function GetColumn(Index: Integer): TBaseLinkGridToDataSourceColumn;
    procedure SetColumn(Index: Integer; Value: TBaseLinkGridToDataSourceColumn);
    function GetDataSource: TBaseLinkingBindSource;
    function GetDataSourceMemberNames: TArray<string>;
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
    function GetGridIntf: ILinkGridToDataSource;
  public
    constructor Create(Grid: TComponent; ColumnClass: TBaseLinkGridToDataSourceColumnClass); virtual;
    function Add: TBaseLinkGridToDataSourceColumn;
    function Updating: Boolean;
    procedure LoadFromFile(const Filename: string);
    procedure LoadFromStream(S: TStream);
    procedure RestoreDefaults;
    procedure RebuildColumns;
    procedure SaveToFile(const Filename: string);
    procedure SaveToStream(S: TStream);
    property Grid: TComponent read FGrid;
    property BaseItems[Index: Integer]: TBaseLinkGridToDataSourceColumn read GetColumn write SetColumn;
  end;

  TLinkGridColumnExpressionPair = record
  private
    FControlExpression: string;
    FSourceExpression: string;
    FCustom: Boolean;
  public
    constructor Create(const AControlExpression, ASourceExpression: string; ACustom: Boolean);
    property ControlExpression: string read FControlExpression;
    property SourceExpression: string read FSourceExpression;
    property Custom: Boolean read FCustom;
  end;

  TLinkGridColumnDescriptions = class
  private
    FList: TList<TLinkGridColumnDescription>;
    function GetList: TArray<TLinkGridColumnDescription>;
    function GetCount: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Add(AItem: TLinkGridColumnDescription);
    property List: TArray<TLinkGridColumnDescription> read GetList;
    property Count: Integer read GetCount;
    procedure Clear;
    function Extract(
      AIndex: Integer): TLinkGridColumnDescription;
  end;

  TLinkGridColumnDescription = class
  private
    FColumnControl: TComponent;
    FColumnName: string;
    FColumnIndex: Integer;
    FSourceMemberName: string;
    FControlMemberName: string;
    FColumnStyle: string;
    FFormatCellExpressions: TArray<TLinkGridColumnExpressionPair>;
    FFormatColumnExpressions: TArray<TLinkGridColumnExpressionPair>;
    FParseCellExpressions: TArray<TLinkGridColumnExpressionPair>;
  public
    constructor Create(AColumnControl: TComponent; const AColumnName: string;
      AColumnIndex: Integer;
      const AControlMemberName, ASourceMemberName, AColumnStyle: string;
      AFormatColumnExpressions, AFormatCellExpressions, AParseCellExpression:
        TArray<TLinkGridColumnExpressionPair>);
    property ColumnControl: TComponent read FColumnControl;
    property ColumnName: string read FColumnName;
    property ColumnIndex: Integer read FColumnIndex;
    property SourceMemberName: string read FSourceMemberName;
    property ControlMemberName: string read FControlMemberName;
    property ColumnStyle: string read FColumnStyle;
    property ParseCellExpression: TArray<TLinkGridColumnExpressionPair> read FParseCellExpressions;
    property FormatCellExpressions: TArray<TLinkGridColumnExpressionPair> read FFormatCellExpressions;
    property FormatColumnExpressions: TArray<TLinkGridColumnExpressionPair> read FFormatColumnExpressions;
    function IsEqual(const ADescription: TLinkGridColumnDescription): Boolean; virtual;
  end;

  TCreateColumnDescription = record
  private
    [weak] FDataSource: TBaseLinkingBindSource;
    FHeader: string;
    FReadOnly: Boolean;
    FMemberName: string;
    FVisible: Boolean;
    FWidth: Integer;
    FMemberType: TScopeMemberType;
    FMemberGetter: string;
    FMemberSetter: string;
    FCustomFormat: string;
    FCustomParse: string;
    FColumnStyle: string;
  public
    constructor Create(AColumn: TLinkGridToDataSourceColumn); overload;
    constructor Create(ADataSource: TBaseLinkingBindSource; const AMemberName: string); overload;
    property DataSource: TBaseLinkingBindSource read FDataSource;
    property Header: string read FHeader write FHeader;
    property MemberName: string read FMemberName;
    property Visible: Boolean read FVisible write FVisible;
    property Width: Integer read FWidth write FWidth;
    property ReadOnly: Boolean read FReadOnly write FReadOnly;
    property MemberType: TScopeMemberType read FMemberType write FMemberType;
    property MemberSetter: string read FMemberSetter write FMemberSetter;
    property MemberGetter: string read FMemberGetter write FMemberGetter;
    property CustomParse: string read FCustomParse write FCustomParse;
    property CustomFormat: string read FCustomFormat write FCustomFormat;
    property ColumnStyle: string read FColumnStyle write FColumnStyle;
  end;

  ILinkGridToDataSourceControlManager = interface
    ['{F631C178-78F7-4164-A532-6F335760A26A}']
    function GetDefaultColumnWidth: Integer;
    procedure SetDefaultColumnWidth(AWidth: Integer);
    procedure BeginUpdate;
    procedure EndUpdate;
    procedure ClearColumns;
    function CanAddColumn(AColumn: TBaseLinkGridToDataSourceColumn): Boolean; overload;
    function CanAddColumn(ADataSource: TBaseLinkingBindSource; const AMemberName: string): Boolean; overload;
    function AddColumn(AColumn: TBaseLinkGridToDataSourceColumn): Integer; overload;
    function AddColumn(ADataSource: TBaseLinkingBindSource; const AMemberName: string): Integer; overload;
    procedure UpdateColumn(AIndex: Integer; AColumn: TBaseLinkGridToDataSourceColumn); overload;
    procedure UpdateColumn(AIndex: Integer; ADataSource: TBaseLinkingBindSource; const AMemberName: string); overload;
    function DescribeColumn(AIndex: Integer; AColumn: TBaseLinkGridToDataSourceColumn): TLinkGridColumnDescription; overload;
    function DescribeColumn(AIndex: Integer; ADataSource: TBaseLinkingBindSource; const AMemberName: string): TLinkGridColumnDescription; overload;
    property DefaultColumnWidth: Integer read GetDefaultColumnWidth write SetDefaultColumnWidth;
  end;

  TLinkGridToDataSourceColumnFactory = class
  public
    constructor Create; virtual;
    function FrameworkExt: string; virtual;
    function GridClasses: TArray<TComponentClass>; virtual;
    function Supports(AIntf: TGuid; AGrid: TComponent): Boolean; virtual; abstract;
    function UsesUnits: TArray<string>; virtual; abstract;
    function CreateFactory(AIntf: TGuid;
     AGrid: TComponent): IInterface; virtual; abstract;
    function GetColumnStyles: TArray<string>; virtual;
  end;

  TLinkGridToDataSourceColumnsEnumerator = class(TCollectionEnumerator)
  public
    function GetCurrent: TLinkGridToDataSourceColumn; inline;
    property Current: TLinkGridToDataSourceColumn read GetCurrent;
  end;

  TLinkGridToDataSourceColumns = class(TBaseLinkGridToDataSourceColumns)
  private
    function GetItem(I: Integer): TLinkGridToDataSourceColumn;
    procedure SetItem(I: Integer; const Value: TLinkGridToDataSourceColumn);
  public
    function GetEnumerator: TLinkGridToDataSourceColumnsEnumerator;
    function Add: TLinkGridToDataSourceColumn;
    property Items[I: Integer]: TLinkGridToDataSourceColumn read GetItem write SetItem; default;
  end;

  TLinkGridToDataSourceColumnValue = (cvWidth, cvHeader);
  TLinkGridToDataSourceColumnValues = set of TLinkGridToDataSourceColumnValue;

  TLinkGridToDataSourceColumn = class(TBaseLinkGridToDataSourceColumn)
  private
    FAssignedValues: TLinkGridToDataSourceColumnValues;
    FHeader: string;
    FVisible: Boolean;
    FReadOnly: Boolean;
    FWidth: Integer;
    FCustomFormat: string;
    FCustomParse: string;
    FColumnStyle: string;
    function GetWidth: Integer;
    function GetShowing: Boolean;
    function GetReadOnly: Boolean;
    function GetVisible: Boolean;
    function IsHeaderStored: Boolean;
    function IsWidthStored: Boolean;
    procedure SetHeader(const Value: string);
    procedure SetReadOnly(const Value: Boolean);
    procedure SetVisible(const Value: Boolean);
    procedure SetWidth(const Value: Integer);
    function DefaultHeader: string;
    function DefaultWidth: Integer;
    function GetHeader: string;
    procedure SetCustomFormat(const Value: string);
    procedure SetCustomParse(const Value: string);
    procedure SetColumnStyle(const Value: string);
  protected
    procedure Initialize; override;
  public
    procedure RestoreDefaults; override;
    property  AssignedValues: TLinkGridToDataSourceColumnValues read FAssignedValues;
    property Showing: Boolean read GetShowing;
    procedure Assign(Source: TPersistent); override;
  published
    property MemberName;
    [Default(False)]
    property  ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    [Stored('IsHeaderStored')]
    property  Header: string read GetHeader write SetHeader stored IsHeaderStored;
    [Stored('IsWidthStored')]
    property  Width: Integer read GetWidth write SetWidth stored IsWidthStored;
    [Default(True)]
    property  Visible: Boolean read GetVisible write SetVisible default True;
    property  CustomFormat: string read FCustomFormat write SetCustomFormat;
    property  CustomParse: string read FCustomParse write SetCustomParse;
    property  ColumnStyle: string read FColumnStyle write SetColumnStyle;
  end;

  TLinkGridToDataSourceColumnFactoryClass = class of TLinkGridToDataSourceColumnFactory;


procedure RegisterLinkGridToDataSourceColumnFactory(AFactories: array of TLinkGridToDataSourceColumnFactoryClass);
procedure UnregisterLinkGridToDataSourceColumnFactory(AFactories: array of TLinkGridToDataSourceColumnFactoryClass);
function GetIsLinkGridToDataSourceControl(AGrid: TComponent): Boolean;
function GetLinkGridToDataSourceControlUsesUnits(AGrid: TComponent): TArray<string>;
function GetLinkGridToDataSourceControlColumnStyles(AGrid: TComponent): TArray<string>;
function GetGridClasses(const AFrameworkExt: string): TArray<TComponentClass>;

implementation

uses Data.Bind.Consts, System.Bindings.Methods,
  System.Bindings.EvalProtocol, System.RTTI;

type

  TInternalBindGridLink = class(TCustomBindGridLink, IBindLayoutChanged,
    IBindListRefresh, IBindListRefreshing)
  private
    [weak] FBaseLinkToDataSource: TBaseLinkToDataSource;
    FListRefreshing: TNotifyEvent;
    FDeactivating: Boolean;
  protected
    procedure MemberRenaming(AComponent: TComponent; const ACurMemberName,
      ANewMemberName: string); override;
    procedure ApplyComponents; override;
    function GetBindingsList: TCustomBindingsList; override;
    function CanActivate: Boolean; override;
    function GetDisplayName: string; override;
    function Designing: Boolean; override;
    function Loading: Boolean; override;
    procedure DoOnActivating; override;
    procedure DoOnDeactivated; override;
    procedure DoOnDeactivating; override;
    procedure ResetGrid; override;
    function GetUseEvalShortcuts: Boolean; override;
    { IBindLayoutChanged }
    procedure BindLayoutChanged;
    procedure IBindLayoutChanged.LayoutChanged = BindLayoutChanged;
    { IBindListRefresh }
    procedure RefreshList;
    function RefreshNeeded: Boolean;
    { IBindListRefreshing }
    function GetListRefreshing: TNotifyEvent;
    procedure SetListRefreshing(AEvent: TNotifyEvent);
  public
    constructor Create(ABaseLinkToDataSource: TBaseLinkToDataSource); reintroduce;
    procedure ClearGrid; override;
    procedure FillGrid; override;
  end;

var
  GLinkGridToDataSourceColumnFactories: TList<TLinkGridToDataSourceColumnFactoryClass>;

procedure RegisterLinkGridToDataSourceColumnFactory(AFactories: array of TLinkGridToDataSourceColumnFactoryClass);
var
  LClass: TLinkGridToDataSourceColumnFactoryClass;
begin
  for LClass in AFactories do
    GLinkGridToDataSourceColumnFactories.Add(LClass);
end;

procedure UnregisterLinkGridToDataSourceColumnFactory(AFactories: array of TLinkGridToDataSourceColumnFactoryClass);
var
  LClass: TLinkGridToDataSourceColumnFactoryClass;
begin
  for LClass in AFactories do
      GLinkGridToDataSourceColumnFactories.Remove(LClass);
end;

function GetLinkGridToDataSourceColumnFactory(AGuid: TGuid; AGrid: TComponent): IInterface;
var
  LClass: TLinkGridToDataSourceColumnFactoryClass;
  LFactory: TLinkGridToDataSourceColumnFactory;
  I: Integer;
begin
  for I := GLinkGridToDataSourceColumnFactories.Count - 1 downto 0 do
  begin
    LClass := GLinkGridToDataSourceColumnFactories[I];
    LFactory := LClass.Create;
    try
      if LFactory.Supports(AGuid, AGrid) then
      begin
        Result := LFactory.CreateFactory(AGuid, AGrid);
        Exit;
      end;
    finally
      LFactory.Free;
    end;
  end;
  Result := nil;
end;

function GetIsLinkGridToDataSourceControl(AGrid: TComponent): Boolean;
var
  LClass: TLinkGridToDataSourceColumnFactoryClass;
  LFactory: TLinkGridToDataSourceColumnFactory;
  I: Integer;
begin
  Result := False;
  for I := GLinkGridToDataSourceColumnFactories.Count - 1 downto 0 do
  begin
    LClass := GLinkGridToDataSourceColumnFactories[I];
    LFactory := LClass.Create;
    try
      if LFactory.Supports(ILinkGridToDataSourceControlManager, AGrid) then
      begin
        Exit(True);
      end;
    finally
      LFactory.Free;
    end;
  end;
end;

function GetLinkGridToDataSourceControlUsesUnits(AGrid: TComponent): TArray<string>;
var
  LClass: TLinkGridToDataSourceColumnFactoryClass;
  LFactory: TLinkGridToDataSourceColumnFactory;
  I: Integer;
begin
  for I := GLinkGridToDataSourceColumnFactories.Count - 1 downto 0 do
  begin
    LClass := GLinkGridToDataSourceColumnFactories[I];
    LFactory := LClass.Create;
    try
      if LFactory.Supports(ILinkGridToDataSourceControlManager, AGrid) then
        Exit(LFactory.UsesUnits);
    finally
      LFactory.Free;
    end;
  end;

  SetLength(Result, 0);
end;

function GetLinkGridToDataSourceControlColumnStyles(AGrid: TComponent): TArray<string>;
var
  LClass: TLinkGridToDataSourceColumnFactoryClass;
  LFactory: TLinkGridToDataSourceColumnFactory;
  I: Integer;
begin
  for I := GLinkGridToDataSourceColumnFactories.Count - 1 downto 0 do
  begin
    LClass := GLinkGridToDataSourceColumnFactories[I];
    LFactory := LClass.Create;
    try
      if LFactory.Supports(ILinkGridToDataSourceControlManager, AGrid) then
        Exit(LFactory.GetColumnStyles);
    finally
      LFactory.Free;
    end;
  end;

  SetLength(Result, 0);
end;

function GetGridClasses(const AFrameworkExt: string): TArray<TComponentClass>;
var
  LClass: TLinkGridToDataSourceColumnFactoryClass;
  LFactory: TLinkGridToDataSourceColumnFactory;
  I: Integer;
  LList: TList<TComponentClass>;
  LComponentClass: TComponentClass;
begin
  LList := TList<TComponentClass>.Create;
  try
    for I := GLinkGridToDataSourceColumnFactories.Count - 1 downto 0 do
    begin
      LClass := GLinkGridToDataSourceColumnFactories[I];
      LFactory := LClass.Create;
      try
        if (AFrameworkExt = '') or SameText(AFrameworkExt, LFactory.FrameworkExt) then
          for LComponentClass in  LFactory.GridClasses do
            if not LList.Contains(LComponentClass) then
              LList.Add(LComponentClass);
      finally
        LFactory.Free;
      end;
    end;
    Result := LList.ToArray;
  finally
    LList.Free;
  end;
end;

{ TInternalBindGridLink }

function TInternalBindGridLink.CanActivate: Boolean;
begin
  Result := FBaseLinkToDataSource.CanActivate(Self);
end;

procedure TInternalBindGridLink.ClearGrid;
begin
  if (not Active) and (not FDeactivating) then
    Self.FBaseLinkToDataSource.GenerateExpressions(Self);
  inherited;
  if (not Active) and (not FDeactivating) then
    Self.FBaseLinkToDataSource.ClearGeneratedExpressions(Self);
end;

function TInternalBindGridLink.GetBindingsList: TCustomBindingsList;
begin
  Result := FBaseLinkToDataSource.BindingsList;
end;

function TInternalBindGridLink.GetListRefreshing: TNotifyEvent;
begin
  Result := FListRefreshing;
end;

procedure TInternalBindGridLink.BindLayoutChanged;
var
  LGrid: ILinkGridToDataSource;
begin
  if Supports(FBaseLinkToDataSource, ILinkGridToDataSource, LGrid) then
  begin
    if (csLoading in LGrid.ComponentState) then Exit;
    LGrid.LayoutChanged;
  end;
end;

function TInternalBindGridLink.Loading: Boolean;
begin
  Result := csLoading in FBaseLinkToDataSource.ComponentState;
end;

procedure TInternalBindGridLink.RefreshList;
begin
  ResetGrid;
end;

procedure TInternalBindGridLink.ResetGrid;
begin
  if Assigned(FListRefreshing) then
    FListRefreshing(Self);
  inherited;
end;

function TInternalBindGridLink.RefreshNeeded: Boolean;
var
  LEditor: IBindListEditor;
  LEnumerator: IScopeRecordEnumerator;
begin
  Result := False;
  if (ControlComponent <> nil)  then
    Supports(GetBindEditor(ControlComponent, IBindListEditor), IBindListEditor, LEditor)
  else
    LEditor := nil;
  if LEditor <> nil then
    LEnumerator := Data.Bind.Components.GetScopeRecordEnumerator(SourceComponent, True);
  if (LEditor <> nil) and (LEnumerator <> nil) then
    Result := LEditor.RefreshNeeded(LEnumerator);

end;

procedure TInternalBindGridLink.SetListRefreshing(AEvent: TNotifyEvent);
begin
  FListRefreshing := AEvent;
end;

constructor TInternalBindGridLink.Create(ABaseLinkToDataSource: TBaseLinkToDataSource);
begin
  inherited Create(nil);
  FBaseLinkToDataSource := ABaseLinkToDataSource;
end;

function TInternalBindGridLink.Designing: Boolean;
begin
  Result := csDesigning in FBaseLinkToDataSource.ComponentState;
end;

function TInternalBindGridLink.GetDisplayName: string;
begin
  Result := FBaseLinkToDataSource.Name;
end;

function TInternalBindGridLink.GetUseEvalShortcuts: Boolean;
begin
  Result := FBaseLinkToDataSource.GetUseEvalShortcuts;
end;

procedure TInternalBindGridLink.DoOnActivating;
begin
  FDeactivating := False;
  // Must generate expression when dataset is active in
  // order to retrieve fields
  FBaseLinkToDataSource.ClearGeneratedExpressions(Self);
  if FBaseLinkToDataSource.ColumnsHaveChanged then  // Columns may have changed when datasource is activated
    FBaseLinkToDataSource.UpdateColumns; 
  FBaseLinkToDataSource.GenerateExpressions(Self);
  inherited;
end;

procedure TInternalBindGridLink.DoOnDeactivated;
begin
  try
    FBaseLinkToDataSource.ClearGeneratedExpressions(Self);
    inherited;
  finally
    FDeactivating := False;
  end;
end;

procedure TInternalBindGridLink.DoOnDeactivating;
begin
  inherited;
  FDeactivating := True;
end;

procedure TInternalBindGridLink.FillGrid;
begin
  if not Active then
    Self.FBaseLinkToDataSource.GenerateExpressions(Self);
  try
    inherited;
  finally
    if not Active then
      Self.FBaseLinkToDataSource.ClearGeneratedExpressions(Self);
  end;
end;

procedure TInternalBindGridLink.ApplyComponents;
begin
  FBaseLinkToDataSource.UpdateColumns;
  inherited;
end;

procedure TInternalBindGridLink.MemberRenaming(AComponent: TComponent;
  const ACurMemberName, ANewMemberName: string);
begin
  FBaseLinkToDataSource.MemberRenaming(Self, AComponent, ACurMemberName, ANewMemberName);
end;

{ TBaseLinkGridToDataSource }

function TBaseLinkGridToDataSource.AcquireLayoutLock: Boolean;
begin
  Result := (FUpdateLock = 0) and (FLayoutLock = 0);
  if Result then BeginLayout;
end;

procedure TBaseLinkGridToDataSource.BeginLayout;
begin
  BeginUpdate;
  if FLayoutLock = 0 then GetColumns.BeginUpdate;
  Inc(FLayoutLock);
end;

procedure TBaseLinkGridToDataSource.BeginUpdate;
begin
  Inc(FUpdateLock);
end;

procedure TBaseLinkGridToDataSource.EndLayout;
begin
  if FLayoutLock > 0 then
  begin
    try
      try
        if FLayoutLock = 1 then
          InternalLayout;
      finally
        if FLayoutLock = 1 then
          GetColumns.EndUpdate;
      end;
    finally
      Dec(FLayoutLock);
      EndUpdate;
    end;
  end;
end;

procedure TBaseLinkGridToDataSource.EndUpdate;
begin
  if FUpdateLock > 0 then
    Dec(FUpdateLock);
end;

procedure TBaseLinkGridToDataSource.CancelLayout;
begin
  if FLayoutLock > 0 then
  begin
    if FLayoutLock = 1 then
      GetColumns.EndUpdate;
    Dec(FLayoutLock);
    EndUpdate;
  end;
end;

function TBaseLinkGridToDataSource.CanActivate(Sender: TComponent): Boolean;
begin
  Result := (GetControlComponent <> nil) and (DataSource <> nil);
end;

constructor TBaseLinkGridToDataSource.Create(AOwner: TComponent);
begin
  FBindGridLink := TInternalBindGridLink.Create(Self);
  FDefaultColumnWidth := 64;
  inherited;
end;

function TBaseLinkGridToDataSource.CreateColumns: TBaseLinkGridToDataSourceColumns;
begin
  Result := TBaseLinkGridToDataSourceColumns.Create(Self, TBaseLinkGridToDataSourceColumn);
end;

destructor TBaseLinkGridToDataSource.Destroy;
begin
  FBindGridLink.DisposeOf; // Scope component may be holding reference
  inherited;
end;

procedure TBaseLinkGridToDataSource.ClearColumns(
  AManager: ILinkGridToDataSourceControlManager);
begin
  AManager.ClearColumns;
end;

procedure TBaseLinkGridToDataSource.ClearGeneratedExpressions;
begin
  inherited;
  FBindGridLink.ColumnExpressions.Clear;
  FBindGridLink.FormatControlExpressions.Clear;
  FBindGridLink.ClearControlExpressions.Clear;
  FBindGridLink.PosSourceExpressions.Clear;
  FBindGridLink.PosControlExpressions.Clear;
end;

function TBaseLinkGridToDataSource.GetActive: Boolean;
begin
  Result := FBindGridLink.Active;
end;

function TBaseLinkGridToDataSource.GetGridColumnManagerFactory(AGuid: TGuid): IInterface;
begin
  if (ControlComponent <> nil) and not (csDestroying in ControlComponent.ComponentState) then
    Result := Data.Bind.Grid.GetLinkGridToDataSourceColumnFactory(AGuid, ControlComponent);
end;

function TBaseLinkGridToDataSource.GetMemberDisplayName(
  const AMemberName: string; out ADisplayName: string): Boolean;
begin
  Result := False;
end;

function TBaseLinkGridToDataSource.GetGridColumnManager: ILinkGridToDataSourceControlManager;
begin
  if Supports(GetGridColumnManagerFactory(ILinkGridToDataSourceControlManager), ILinkGridToDataSourceControlManager, Result) then
    Result.DefaultColumnWidth := DefaultColumnWidth;
end;

function TBaseLinkGridToDataSource.GetBufferCount: Integer;
begin
  Result := FBindGridLink.BufferCount;
end;

function TBaseLinkGridToDataSource.GetComponentState: TComponentState;
begin
  Result := Self.ComponentState;
end;

function TBaseLinkGridToDataSource.GetDataSource: TBaseLinkingBindSource;
begin
  Result := DataSource;
end;

function TBaseLinkGridToDataSource.GetDefaultMembers: Boolean;
begin
  Result := True;
end;

function TBaseLinkGridToDataSource.GetDelegates: TArray<TCommonBindComponent>;
begin
  Assert(FBindGridLink <> nil);
  Result := TArray<TCommonBindComponent>.Create(FBindGridLink);
end;

function TBaseLinkGridToDataSource.GetAutoActivate: Boolean;
begin
  Result := FBindGridLink.AutoActivate;
end;

function TBaseLinkGridToDataSource.GetReadOnly: Boolean;
begin
  Result := False;
end;

procedure TBaseLinkGridToDataSource.InvalidateColumn(AColumn: TBaseLinkGridToDataSourceColumn);
begin
   LayoutChanged;
end;

{ InternalLayout is called with layout locks and column locks in effect }
procedure TBaseLinkGridToDataSource.InternalLayout;

begin
  if ([csLoading, csDestroying] * ComponentState) <> [] then Exit;

  UpdateColumns;
  FBindGridLink.ResetColumns;

end;

procedure TBaseLinkGridToDataSource.LayoutChanged;
begin
  if AcquireLayoutLock then
    EndLayout;
end;

procedure TBaseLinkGridToDataSource.Loaded;
begin
  inherited;
  FBindGridLink.Loaded;
end;

procedure TBaseLinkGridToDataSource.SetActive(const Value: Boolean);
begin
  BindGridLink.Active := Value;
end;

procedure TBaseLinkGridToDataSource.SetAutoActivate(const Value: Boolean);
begin
  FBindGridLink.AutoActivate := Value;
end;

procedure TBaseLinkGridToDataSource.SetBufferCount(const Value: Integer);
begin
  FBindGridLink.BufferCount := Value;
end;

procedure TBaseLinkGridToDataSource.SetDefaultColumnWidth(const Value: Integer);
begin
  if FDefaultColumnWidth <> Value then
  begin
    FDefaultColumnWidth := Value;
    LayoutChanged;  // All columns
  end;
end;

{ TDBGridLinkColumnCollection }

constructor TBaseLinkGridToDataSourceColumns.Create(Grid: TComponent; ColumnClass: TBaseLinkGridToDataSourceColumnClass);
begin
  inherited Create(ColumnClass);
  FGrid := Grid;
end;

function TBaseLinkGridToDataSourceColumns.Add: TBaseLinkGridToDataSourceColumn;
begin
  Result := TBaseLinkGridToDataSourceColumn(inherited Add);
end;

function TBaseLinkGridToDataSourceColumns.GetColumn(Index: Integer): TBaseLinkGridToDataSourceColumn;
begin
  Result := TBaseLinkGridToDataSourceColumn(inherited Items[Index]);
end;

function TBaseLinkGridToDataSourceColumns.GetOwner: TPersistent;
begin
  Result := FGrid;
end;

procedure TBaseLinkGridToDataSourceColumns.LoadFromFile(const Filename: string);
var
  S: TFileStream;
begin
  S := TFileStream.Create(Filename, fmOpenRead);
  try
    LoadFromStream(S);
  finally
    S.Free;
  end;
end;

type
  TColumnsWrapper = class(TComponent)
  private
    FColumns: TBaseLinkGridToDataSourceColumns;
  published
    property Columns: TBaseLinkGridToDataSourceColumns read FColumns write FColumns;
  end;

procedure TBaseLinkGridToDataSourceColumns.LoadFromStream(S: TStream);
var
  Wrapper: TColumnsWrapper;
begin
  Wrapper := TColumnsWrapper.Create(nil);
  try
    Wrapper.Columns := (FGrid as ILinkGridToDataSource).CreateColumns;
    S.ReadComponent(Wrapper);
    Assign(Wrapper.Columns);
  finally
    {$IFNDEF NEXTGEN}
    Wrapper.Columns.Free;
    {$ENDIF}
    Wrapper.Free;
  end;
end;

procedure TBaseLinkGridToDataSourceColumns.RestoreDefaults;
var
  I: Integer;
begin
  BeginUpdate;
  try
    for I := 0 to Count-1 do
      BaseItems[I].RestoreDefaults;
  finally
    EndUpdate;
  end;
end;

function TBaseLinkGridToDataSourceColumns.GetDataSource: TBaseLinkingBindSource;
begin
  Result := (FGrid as ILinkGridToDataSource).DataSource;
end;

function TBaseLinkGridToDataSourceColumns.GetGridIntf: ILinkGridToDataSource;
begin
  Supports(Grid, ILinkGridToDataSource, Result)
end;

procedure TBaseLinkGridToDataSourceColumns.RebuildColumns;


  procedure AddFields(ANames: TArray<string>);
  var
    S: string;
  begin
    for S in ANames do
    begin
      Add.MemberName := S;
    end;
  end;

var
  LGrid: ILinkGridToDataSource;
begin
  LGrid := GetGridIntf;
  if GetDataSource <> nil then
  begin
    if LGrid <> nil then
      LGrid.BeginLayout;
    try
      Clear;
      AddFields(GetDataSourceMemberNames);
    finally
      if LGrid <> nil then
        LGrid.EndLayout;
    end
  end
  else
    Clear;
end;

function TBaseLinkGridToDataSourceColumns.GetDataSourceMemberNames: TArray<string>;
var
  LStrings: TStrings;
  LScopeMemberNames: IScopeMemberNames;
begin
  LStrings := TStringList.Create;
  try
    if Supports(GetDataSource, IScopeMemberNames, LScopeMemberNames)  then
      LScopeMemberNames.GetMemberNames(LStrings);
    Result := LStrings.ToStringArray;
  finally
    LStrings.Free;
  end;
end;

procedure TBaseLinkGridToDataSourceColumns.SaveToFile(const Filename: string);
var
  S: TStream;
begin
  S := TFileStream.Create(Filename, fmCreate);
  try
    SaveToStream(S);
  finally
    S.Free;
  end;
end;

procedure TBaseLinkGridToDataSourceColumns.SaveToStream(S: TStream);
var
  Wrapper: TColumnsWrapper;
begin
  Wrapper := TColumnsWrapper.Create(nil);
  try
    Wrapper.Columns := Self;
    S.WriteComponent(Wrapper);
  finally
    Wrapper.Free;
  end;
end;

procedure TBaseLinkGridToDataSourceColumns.SetColumn(Index: Integer; Value: TBaseLinkGridToDataSourceColumn);
begin
  Items[Index].Assign(Value);
end;

procedure TBaseLinkGridToDataSourceColumns.Update(Item: TCollectionItem);
var
  Grid: ILinkGridToDataSource;
begin
  Grid := GetGridIntf;
  if (FGrid = nil) or (csLoading in FGrid.ComponentState) then Exit;
  if Item = nil then
  begin
    Grid.LayoutChanged;
  end
  else
  begin
    Assert(Item is TBaseLinkGridToDataSourceColumn);
    Grid.InvalidateColumn(TBaseLinkGridToDataSourceColumn(Item));
  end;
end;

function TBaseLinkGridToDataSourceColumns.Updating: Boolean;
begin
  Result := Self.UpdateCount > 0;
end;

{ TDBGridLinkColumn }

constructor TBaseLinkGridToDataSourceColumn.Create(Collection: TCollection);
var
  Grid: ILinkGridToDataSource;
begin
  if Assigned(Collection) and (Collection is TBaseLinkGridToDataSourceColumns) then
    Grid := TBaseLinkGridToDataSourceColumns(Collection).GetGridIntf;
  if Assigned(Grid) then Grid.BeginLayout;
  try
    inherited Create(Collection);
    Initialize;
  finally
    if Assigned(Grid) then Grid.EndLayout;
  end;
end;

procedure TBaseLinkGridToDataSourceColumn.Initialize;
begin
//  FStored := True;
end;

procedure TBaseLinkGridToDataSourceColumn.Assign(Source: TPersistent);
begin
  if Source is TBaseLinkGridToDataSourceColumn then
  begin
    if Assigned(Collection) then Collection.BeginUpdate;
    try
      RestoreDefaults;
      MemberName := TBaseLinkGridToDataSourceColumn(Source).MemberName;
    finally
      if Assigned(Collection) then Collection.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

function TBaseLinkGridToDataSourceColumn.GetDataSource: TBaseLinkingBindSource;
var
  Grid: ILinkGridToDataSource;
begin    { Returns Nil if FieldName can't be found in dataset }
  Grid := GetGridIntf;
  if Grid <> nil then
    Result := Grid.DataSource
  else
    Result := nil;
end;

function TBaseLinkGridToDataSourceColumn.GetGrid: TComponent;
begin
  if Assigned(Collection) and (Collection is TBaseLinkGridToDataSourceColumns) then
    Result := TBaseLinkGridToDataSourceColumns(Collection).Grid
  else
    Result := nil;
end;

function TBaseLinkGridToDataSourceColumn.GetGridIntf: ILinkGridToDataSource;
begin
  if Assigned(Collection) and (Collection is TBaseLinkGridToDataSourceColumns) then
    Result := TBaseLinkGridToDataSourceColumns(Collection).GetGridIntf
  else
    Result := nil;
end;

function TBaseLinkGridToDataSourceColumn.GetDisplayName: string;
begin
  Result := FMemberName;
  if Result = '' then Result := inherited GetDisplayName;
end;

function TBaseLinkGridToDataSourceColumn.GetParentColumn: TBaseLinkGridToDataSourceColumn;
begin
  Result := nil;
end;


procedure TBaseLinkGridToDataSourceColumn.RestoreDefaults;
begin
end;

procedure TBaseLinkGridToDataSourceColumn.SetFieldName(const Value: string);
var
  Grid: ILinkGridToDataSource;
begin
  Grid := GetGridIntf;
  FMemberName := Value;
  Changed(True);  // True causes column to be recreated
end;

procedure TBaseLinkGridToDataSourceColumn.SetIndex(Value: Integer);
var
  LLayout: Boolean;
  Grid: ILinkGridToDataSource;
  I, OldIndex: Integer;
begin
  OldIndex := Index;
  Grid := GetGridIntf;

  LLayout := False;
  if  Assigned(Collection) and (Collection is TBaseLinkGridToDataSourceColumns) then
    if not TBaseLinkGridToDataSourceColumns(Collection).Updating then
    begin
      Grid.BeginLayout;
      LLayout := True;
    end;
  try
    I := OldIndex + 1;  // move child columns along with parent
    while (I < Collection.Count) and (TBaseLinkGridToDataSourceColumn(Collection.Items[I]).ParentColumn = Self) do
      Inc(I);
    Dec(I);
    if OldIndex > Value then   // column moving left
    begin
      while I > OldIndex do
      begin
        Collection.Items[I].Index := Value;
        Inc(OldIndex);
      end;
      inherited SetIndex(Value);
    end
    else
    begin
      inherited SetIndex(Value);
      while I > OldIndex do
      begin
        Collection.Items[OldIndex].Index := Value;
        Dec(I);
      end;
    end;
  finally
  if LLayout then

      Grid.EndLayout;
  end;
end;


{ TLinkGridColumnExpressionPair }

constructor TLinkGridColumnExpressionPair.Create(const AControlExpression,
  ASourceExpression: string; ACustom: Boolean);
begin
  FControlExpression := AControlExpression;
  FSourceExpression := ASourceExpression;
  FCustom := ACustom;
end;

{ TDBGridLinkColumnDescription }

constructor TLinkGridColumnDescription.Create(AColumnControl: TComponent; const AColumnName: string;
  AColumnIndex: Integer; const AControlMemberName, ASourceMemberName, AColumnStyle: string;
  AFormatColumnExpressions, AFormatCellExpressions,
  AParseCellExpression: TArray<TLinkGridColumnExpressionPair>);
begin
  FColumnControl := AColumnControl;
  FColumnName := AColumnName;
  FColumnIndex := AColumnIndex;
  FColumnStyle := AColumnStyle;
  FControlMemberName := AControlMemberName;
  FSourceMemberName := ASourceMemberName;
  FFormatColumnExpressions := AFormatColumnExpressions;
  FFormatCellExpressions := AFormatCellExpressions;
  FParseCellExpressions := AParseCellExpression;
end;

function TLinkGridColumnDescription.IsEqual(
  const ADescription: TLinkGridColumnDescription): Boolean;

  function SameExpressions(AExpr1, AExpr2: TArray<TLinkGridColumnExpressionPair>): Boolean;
  var
    I:Integer;
  begin
    Result := Length(AExpr1) = Length(AExpr2);
    if Result then
    begin
      for I := 0 to Length(AExpr1)-1 do
        if (AExpr1[I].FControlExpression = AExpr2[I].FControlExpression) and
         (AExpr1[I].FSourceExpression = AExpr2[I].FSourceExpression) then
        begin

        end
        else
          Exit(False);
    end;
  end;

begin
  Result := (Self.FColumnName = ADescription.FColumnName) and
    (Self.FColumnIndex = ADescription.FColumnIndex) and
    (Self.FSourceMemberName = ADescription.FSourceMemberName) and
    (Self.FControlMemberName = ADescription.FControlMemberName) and
    (Self.FColumnStyle = ADescription.FColumnStyle) and
    SameExpressions(Self.FFormatCellExpressions, ADescription.FFormatCellExpressions) and
    SameExpressions(Self.FFormatColumnExpressions, ADescription.FFormatColumnExpressions) and
    SameExpressions(Self.FParseCellExpressions, ADescription.FParseCellExpressions);

end;

{ TBaseBindDBControlLink }


function TBaseLinkToDataSource.GetControlComponent: TComponent;
begin
  Result := GetDelegates[0].ControlComponent;
end;

function TBaseLinkToDataSource.GetSourceControl: TBaseLinkingBindSource;
begin
  if GetDelegates[0].SourceComponent <> nil then
    Result := GetDelegates[0].SourceComponent as TBaseLinkingBindSource
  else
    Result := nil;
end;

function TBaseLinkToDataSource.GetSourceMember: string;
begin
  Result := GetDelegates[0].SourceMemberName;
end;

procedure TBaseLinkToDataSource.MemberRenaming(Sender: TComponent; AComponent: TComponent;
  const ACurMemberName, ANewMemberName: string);
begin
//
end;

procedure TBaseLinkToDataSource.SetControlComponent(const Value: TComponent);
begin
  GetDelegates[0].ControlComponent := Value;
end;

procedure TBaseLinkToDataSource.SetSourceControl(
  const Value: TBaseLinkingBindSource);
begin
  GetDelegates[0].SourceComponent := Value;
end;

procedure TBaseLinkToDataSource.SetSourceMember(const Value: string);
begin
  GetDelegates[0].SourceMemberName := Value;
end;

{ TCreateColumnDescription }

const
  sWildCard = '*';

constructor TCreateColumnDescription.Create(AColumn: TLinkGridToDataSourceColumn);
var
  LScopeMemberScripting: IScopeMemberScripting;
begin
  FDataSource := AColumn.DataSource;
  FHeader := AColumn.Header;
  if AColumn.MemberName <> sWildcard then
    FMemberName := AColumn.MemberName;
  FReadOnly := AColumn.ReadOnly;
  FVisible := AColumn.Visible;
  FWidth := AColumn.Width;
  if (FMemberName <> '') and Supports(FDataSource, IScopeMemberScripting, LScopeMemberScripting) then
  begin
    LScopeMemberScripting.GetMemberType(FMemberName, FMemberType);
    LScopeMemberScripting.GetMemberGetter(FMemberName, FMemberGetter);
    LScopeMemberScripting.GetMemberSetter(FMemberName, FMemberSetter);
  end;
  FCustomFormat := AColumn.CustomFormat;
  FCustomParse := AColumn.CustomParse;
  FColumnStyle := AColumn.ColumnStyle;
end;

constructor TCreateColumnDescription.Create(ADataSource: TBaseLinkingBindSource; const AMemberName: string);
var
  LScopeMemberScripting: IScopeMemberScripting;
  LScopeMemberDisplayNames: IScopeMemberDisplayNames;
  LDisplayName: string;
begin
  FHeader := AMemberName;
  if AMemberName <> sWildcard then
    FMemberName := AMemberName;
  FReadOnly := False;
  FVisible := True;
  FWidth := -1;  // Use default
  FDataSource := ADataSource;
  if (FMemberName <> '') and Supports(FDataSource, IScopeMemberScripting, LScopeMemberScripting) then
  begin
    LScopeMemberScripting.GetMemberType(FMemberName, FMemberType);
    LScopeMemberScripting.GetMemberGetter(FMemberName, FMemberGetter);
    LScopeMemberScripting.GetMemberSetter(FMemberName, FMemberSetter);

  end;
  if (FMemberName <> '') and Supports(FDataSource, IScopeMemberDisplayNames, LScopeMemberDisplayNames) then
  begin
    if LScopeMemberDisplayNames.GetMemberDisplayName(FMemberName, LDisplayName) then
      FHeader := LDisplayName;
  end;
end;

{ TLinkGridToDataSourceColumns }

function TLinkGridToDataSourceColumns.Add: TLinkGridToDataSourceColumn;
begin
  Result := TLinkGridToDataSourceColumn(inherited Add);
end;

function TLinkGridToDataSourceColumns.GetEnumerator: TLinkGridToDataSourceColumnsEnumerator;
begin
  Result := TLinkGridToDataSourceColumnsEnumerator.Create(Self);
end;

function TLinkGridToDataSourceColumns.GetItem(I: Integer): TLinkGridToDataSourceColumn;
begin
  Result := TLinkGridToDataSourceColumn(BaseItems[I]);
end;

procedure TLinkGridToDataSourceColumns.SetItem(I: Integer; const Value: TLinkGridToDataSourceColumn);
begin
  BaseItems[I] := Value;
end;

{ TLinkGridToDataSourceColumn }


function TLinkGridToDataSourceColumn.GetVisible: Boolean;
var
  Col: TBaseLinkGridToDataSourceColumn;
  LVisible: Boolean;
begin
  Result := FVisible;
  if Result then
  begin
    Col := ParentColumn;
    LVisible := (not (Col is TBaseLinkGridToDataSourceColumn)) or TLinkGridToDataSourceColumn(Col).Visible;
    Result := Result and LVisible;
  end;
end;

function TLinkGridToDataSourceColumn.GetWidth: Integer;
begin
  if not Showing then
    Result := -1
  else
  if cvWidth in FAssignedValues then
    Result := FWidth
  else
    Result := DefaultWidth;
end;

function TLinkGridToDataSourceColumn.GetReadOnly: Boolean;
begin
  Result := FReadOnly
end;

function TLinkGridToDataSourceColumn.IsHeaderStored: Boolean;
begin
  Result := (cvHeader in FAssignedValues) and (FHeader <> DefaultHeader);
end;

procedure TLinkGridToDataSourceColumn.Assign(Source: TPersistent);
begin
  if Source is TLinkGridToDataSourceColumn then
  begin
    if Assigned(Collection) then Collection.BeginUpdate;
    try
      RestoreDefaults;
      MemberName := TLinkGridToDataSourceColumn(Source).MemberName;
      ReadOnly := TLinkGridToDataSourceColumn(Source).ReadOnly;
      Header := TLinkGridToDataSourceColumn(Source).Header;
      Width := TLinkGridToDataSourceColumn(Source).Width;
      Visible := TLinkGridToDataSourceColumn(Source).Visible;
      ColumnStyle := TLinkGridToDataSourceColumn(Source).ColumnStyle;
      CustomParse := TLinkGridToDataSourceColumn(Source).CustomParse;
    finally
      if Assigned(Collection) then Collection.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

function TLinkGridToDataSourceColumn.DefaultHeader: string;
var
  LDisplayName: string;
begin
  Result := MemberName;
  if MemberName <> '' then
    if Collection is TBaseLinkGridToDataSourceColumns then
      if TBaseLinkGridToDataSourceColumns(Collection).Owner is TBaseLinkGridToDataSource then
      begin
        if TBaseLinkGridToDataSource(TBaseLinkGridToDataSourceColumns(Collection).Owner).GetMemberDisplayName(MemberName, LDisplayName) then
          Result := LDisplayName;
      end;

end;

function TLinkGridToDataSourceColumn.DefaultWidth: Integer;
begin
  Result := 0;
  if Collection is TBaseLinkGridToDataSourceColumns then
    if TBaseLinkGridToDataSourceColumns(Collection).Owner is TBaseLinkGridToDataSource then
      Result := TBaseLinkGridToDataSource(TBaseLinkGridToDataSourceColumns(Collection).Owner).DefaultColumnWidth;
  if Result <= 0 then
    Result := 64;
end;

function TLinkGridToDataSourceColumn.GetHeader: string;
begin
  if cvHeader in FAssignedValues then
    Result := FHeader
  else
    Result := DefaultHeader;
end;

function TLinkGridToDataSourceColumn.IsWidthStored: Boolean;
begin
  Result := (cvWidth in FAssignedValues) and (FWidth <> DefaultWidth);
end;

procedure TLinkGridToDataSourceColumn.SetHeader(const Value: string);
begin
  if (cvHeader in FAssignedValues) and (Value = FHeader) then Exit;
  FHeader := Value;
  Include(FAssignedValues, cvHeader);
  Changed(False);
end;


procedure TLinkGridToDataSourceColumn.SetColumnStyle(const Value: string);
var
  Grid: ILinkGridToDataSource;
begin
  if Value <> FColumnStyle then
  begin
    Grid := GetGridIntf;
    Grid.BeginLayout;
    try
      FColumnStyle := Value;
    finally
      Grid.EndLayout;
    end;
  end;
end;

procedure TLinkGridToDataSourceColumn.SetCustomFormat(const Value: string);
begin
  if Value <> FCustomFormat then
  begin
    FCustomFormat := Value;
    Changed(True);
  end;
end;

procedure TLinkGridToDataSourceColumn.SetCustomParse(const Value: string);
begin
  if Value <> FCustomParse then
  begin
    FCustomParse := Value;
    Changed(True);
  end;
end;

procedure TLinkGridToDataSourceColumn.SetReadOnly(const Value: Boolean);
begin
  if Value <> FReadOnly then
  begin
    FReadOnly := Value;
    Changed(True);
  end;
end;

procedure TLinkGridToDataSourceColumn.SetVisible(const Value: Boolean);
begin
  if Value <> FVisible then
  begin
    FVisible := Value;
    Changed(True);
  end;
end;

procedure TLinkGridToDataSourceColumn.Initialize;
begin
  inherited;
  FVisible := True;
end;

procedure TLinkGridToDataSourceColumn.RestoreDefaults;
begin
  FAssignedValues := [];
  Changed(False);
end;

procedure TLinkGridToDataSourceColumn.SetWidth(const Value: Integer);
begin
  if ((cvWidth in FAssignedValues) or (Value <> DefaultWidth))
    and (Value <> -1) then
  begin
    FWidth := Value;
    Include(FAssignedValues, cvWidth);
    Changed(False);
  end;
end;

function TLinkGridToDataSourceColumn.GetShowing: Boolean;
begin
  Result := Visible;
end;


{ TLinkGridColumnDescriptions }

procedure TLinkGridColumnDescriptions.Add(AItem: TLinkGridColumnDescription);
begin
  Assert(AItem <> nil);
  FList.Add(AItem);
end;

procedure TLinkGridColumnDescriptions.Clear;
begin
  FList.Clear;
end;

constructor TLinkGridColumnDescriptions.Create;
begin
  FList := TObjectList<TLinkGridColumnDescription>.Create;
end;

destructor TLinkGridColumnDescriptions.Destroy;
begin
  FList.Free;
  inherited;
end;

function TLinkGridColumnDescriptions.Extract(AIndex: Integer): TLinkGridColumnDescription;
begin
  Result := FList.Extract(FList[AIndex]);
end;

function TLinkGridColumnDescriptions.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TLinkGridColumnDescriptions.GetList: TArray<TLinkGridColumnDescription>;
begin
  Result := FList.ToArray;
end;

{ TCustomBindDBGridLink }

procedure TCustomLinkGridToDataSource.CreateGridColumns;
begin
  if Columns.Count = 0 then
    CreateDefaultGridColumns
  else
    CreateCollectionGridColumns;
end;

function TCustomLinkGridToDataSource.CreateGridColumnDescriptions: TLinkGridColumnDescriptions;
begin
  if Columns.Count = 0 then
    Result := CreateDefaultGridColumnDescriptions
  else
    Result := CreateCollectionGridColumnDescriptions;
end;

procedure TCustomLinkGridToDataSource.ClearGeneratedExpressions;
var
  LManager: ILinkGridToDataSourceControlManager;
begin
  inherited;
  if Columns.Count = 0 then
  begin
    // Clear default columns
    LManager := GetGridColumnManager;
    if LManager <> nil then
      ClearColumns(LManager);
  end;

  FLinkGridColumnDescriptions.Clear;
end;

function TCustomLinkGridToDataSource.ColumnsHaveChanged: Boolean;
var
  LDescriptions: TLinkGridColumnDescriptions;
  I: Integer;
  LLookupCount: Integer;
  LMemberKey: TMemberKey;
  LColumns: TList<TBaseLinkGridToDataSourceColumn>;
begin
  LColumns := nil;
  try
    LLookupCount := 0;
    for LMemberKey in FLinkGridColumnDescriptionsLookup.Keys do
      if LMemberKey.FColumn <> nil then
      begin
        Inc(LLookupCount);
        if LColumns = nil then
          LColumns := TList<TBaseLinkGridToDataSourceColumn>.Create;
        LColumns.Add(LMemberKey.FColumn);
      end;
    // Detect change to columns collection
    Result := LLookupCount <> FLinkGridToDataSourceColumns.Count;
    if (not Result) and (LColumns <> nil) then
      for I := 0 to FLinkGridToDataSourceColumns.Count - 1 do
        if not LColumns.Contains(FLinkGridToDataSourceColumns[I]) then
        begin
          Result := True;
          break;
        end;

    if not Result then
    begin
      LDescriptions := CreateGridColumnDescriptions;
      try
        Result := FLinkGridColumnDescriptions.Count <> LDescriptions.Count;
        if not Result then
        begin
          for I := 0 to FLinkGridColumnDescriptions.Count - 1 do
            if not FLinkGridColumnDescriptions.List[I].IsEqual(LDescriptions.List[I]) then
              Exit(True);
        end;
      finally
        LDescriptions.Free;
      end;
    end;
  finally
    LColumns.Free;
  end;
end;

procedure TCustomLinkGridToDataSource.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('AutoBufferCount', ReadBoolean, nil, False);
  Filer.DefineProperty('BufferCount', ReadInteger, nil, False);
end;

destructor TCustomLinkGridToDataSource.Destroy;
var
  LManager: ILinkGridToDataSourceControlManager;
begin
  LManager := GetGridColumnManager;
  if LManager <> nil then
    ClearColumns(LManager);
  Active := False;
  FLinkGridColumnDescriptionsLookup.Free;
  FLinkGridColumnDescriptions.Free;
  FLinkGridToDataSourceColumns.Free;
  inherited;
end;


constructor TCustomLinkGridToDataSource.Create(AOwner: TComponent);
var
  LListRefreshing: IBindListRefreshing;
begin
  inherited;
  FUseEvalShortcuts := True;
  if Supports(Self.BindGridLink, IBindListRefreshing, LListRefreshing) then
     LListRefreshing.OnListRefreshing := OnListRefreshing;
  FLinkGridColumnDescriptionsLookup := TDictionary<TMemberKey, Integer>.Create;
  FLinkGridColumnDescriptions := TLinkGridColumnDescriptions.Create;
  FLinkGridToDataSourceColumns := TLinkGridToDataSourceColumns.Create(Self, TLinkGridToDataSourceColumn);
end;

procedure TCustomLinkGridToDataSource.OnListRefreshing(Sender: TObject);
begin
  // Previously used to update buffer count
end;

procedure TCustomLinkGridToDataSource.ReadBoolean(Reader: TReader);
begin
  Reader.ReadBoolean;
end;

procedure TCustomLinkGridToDataSource.ReadInteger(Reader: TReader);
begin
  Reader.ReadInteger;
end;

procedure TCustomLinkGridToDataSource.CreateCollectionGridColumns;
var
  LManager: ILinkGridToDataSourceControlManager;
  I: Integer;
  LColumn: TLinkGridToDataSourceColumn;
  LIndex: Integer;
begin
  LManager := GetGridColumnManager;
  if LManager <> nil then
  begin
    LManager.BeginUpdate;
    try
      ClearColumns(LManager);
      LIndex := 0;
      for I := 0 to Columns.Count - 1 do
      begin
        LColumn := Columns[I];
        begin
          if LManager.CanAddColumn(LColumn) then
          begin
            LManager.AddColumn(LColumn);
            FLinkGridColumnDescriptionsLookup.Add(TMemberKey.CreateColumn(LColumn), LIndex);
            Inc(LIndex);
          end;
        end;
      end;
    finally
      LManager.EndUpdate;
    end;
  end;
end;

function TCustomLinkGridToDataSource.GetUseEvalShortcuts: Boolean;
begin
  Result := FUseEvalShortcuts;
end;

function TCustomLinkGridToDataSource.CreateCollectionGridColumnDescriptions: TLinkGridColumnDescriptions;
var
  LManager: ILinkGridToDataSourceControlManager;
  LColumnDescription: TLinkGridColumnDescription;
  I: Integer;
  LColumn: TLinkGridToDataSourceColumn;
  LList: TLinkGridColumnDescriptions;
begin
  LList := TLinkGridColumnDescriptions.Create;
  try
  LManager := GetGridColumnManager;
  if LManager <> nil then
  begin
      for I := 0 to Columns.Count - 1 do
      begin
        LColumn := Columns[I];
        if LManager.CanAddColumn(LColumn) then
        begin
          LColumnDescription := LManager.DescribeColumn(LList.Count, LColumn);
          Assert(LColumnDescription <> nil);
          LList.Add(LColumnDescription);
        end;
      end;
  end;
  Result := LList;
  except
    LList.Free;
    raise;
  end;
end;

function TCustomLinkGridToDataSource.CanSetControlComponent(
  Value: TComponent): Boolean;
begin
  Result := GetIsLinkGridToDataSourceControl(Value);
end;

procedure TCustomLinkGridToDataSource.ClearColumns(AManager:  ILinkGridToDataSourceControlManager);
begin
  inherited;
  FLinkGridColumnDescriptionsLookup.Clear;
  FLinkGridColumnDescriptions.Clear;
end;

function TCustomLinkGridToDataSource.GetDataSetFields: TArray<string>;
var
  LStrings: TStrings;
  LScopeMemberNames: IScopeMemberNames;
begin
  LStrings := TStringList.Create;
  try
    if Supports(GetDataSource, IScopeMemberNames, LScopeMemberNames)  then
      LScopeMemberNames.GetMemberNames(LStrings);
    Result := LStrings.ToStringArray;
  finally
    LStrings.Free;
  end;
end;

function TCustomLinkGridToDataSource.GetMemberDisplayName(const AMemberName: string; out ADisplayName: string): Boolean;
var
  LScopeMemberDisplayNames: IScopeMemberDisplayNames;
begin
  Result := Supports(GetDataSource, IScopeMemberDisplayNames, LScopeMemberDisplayNames);
  if Result then
    Result := LScopeMemberDisplayNames.GetMemberDisplayName(AMemberName, ADisplayName);
end;

procedure TCustomLinkGridToDataSource.CreateDefaultGridColumns;
var
  LDataSet: TBaseLinkingBindSource;
  LManager: ILinkGridToDataSourceControlManager;
  LIndex: Integer;
  S: string;
begin
  LManager := GetGridColumnManager;
  if LManager <> nil then
  begin
    LManager.BeginUpdate;
    try
      ClearColumns(LManager);
      LDataSet := GetDataSource;
      LIndex := 0;
      if LDataSet <> nil then
        for S in GetDataSetFields do
        begin
          if LManager.CanAddColumn(DataSource, S) then
          begin
            LManager.AddColumn(DataSource, S);
            FLinkGridColumnDescriptionsLookup.Add(TMemberKey.CreateMemberName(S), LIndex);
            Inc(LIndex);
          end;
        end;
    finally
      LManager.EndUpdate;
    end;
  end;
end;


function TCustomLinkGridToDataSource.CreateDefaultGridColumnDescriptions: TLinkGridColumnDescriptions;
var
  LDataSource: TBaseLinkingBindSource;
  LManager: ILinkGridToDataSourceControlManager;
  LColumnDescription: TLinkGridColumnDescription;
  LList: TLinkGridColumnDescriptions;
  S: string;
begin
  LList := TLinkGridColumnDescriptions.Create;
  try
  LManager := GetGridColumnManager;
  if LManager <> nil then
  begin
    LDataSource := GetDataSource;
    if LDataSource <> nil then
      for S in GetDataSetFields do
      begin
        if LManager.CanAddColumn(DataSource, S) then
        begin
          LColumnDescription := LManager.DescribeColumn(LList.Count, DataSource, S);
          LList.Add(LColumnDescription);
        end;
      end;
  end;
  Result := LList;
  except
    LList.Free;
    raise;
  end;
end;


procedure TCustomLinkGridToDataSource.UpdateColumns;
var
  LPair: TPair<TMemberKey, Integer>;
  LManager: ILinkGridToDataSourceControlManager;
begin
  if not (csDestroying in ComponentState) then
  begin

  if (FLinkGridColumnDescriptions.Count = 0) or ColumnsHaveChanged then
  begin
    LManager := GetGridColumnManager;
    if LManager <> nil then
      // Prevent painting of columns until expressions have been defined
      LManager.BeginUpdate;
    try

      ClearGeneratedExpressions(Self);
      CreateGridColumns;
      if Active then
      begin
        GenerateExpressions(Self);

      end;
    finally
      if LManager <> nil then
        LManager.EndUpdate;
    end;
  end
  else
  begin
    LManager := GetGridColumnManager;
    // Expressions haven't changed but column heading etc. may need updating
    if LManager <> nil then
      for LPair in FLinkGridColumnDescriptionsLookup do
      begin
        if LPair.Key.FColumn <> nil then
          LManager.UpdateColumn(LPair.Value, LPair.Key.FColumn)
        else
          LManager.UpdateColumn(LPair.Value, DataSource, LPair.Key.FMemberName);
      end;
  end;
  end;

end;


procedure TCustomLinkGridToDataSource.GenerateExpressions;
var
  LItem: TExpressionItem;
  LColumn: TLinkGridColumnDescription;
  LColumnExpressionItem: TColumnLinkExpressionItem;
  LPair: TLinkGridColumnExpressionPair;
  LDescriptions: TLinkGridColumnDescriptions;
  LScopeMemberScripting: IScopeMemberScripting;
  LGetter: string;
  LGetterBase: Integer;
  LSetter: string;
  LSetterBase: Integer;
  LEditor: IBindListEditorCommon;
const
  sMathMax = 'Math_Max';
begin

  if Columns.Count = 0 then
    if FLinkGridColumnDescriptionsLookup.Count = 0 then
      // Generate default columns
      CreateDefaultGridColumns;

  Assert(BindGridLink.ColumnExpressions.Count = 0);
  Assert(BindGridLink.FormatControlExpressions.Count = 0);
  Assert(BindGridLink.ClearControlExpressions.Count = 0);
  Assert(BindGridLink.PosSourceExpressions.Count = 0);
  Assert(BindGridLink.PosControlExpressions.Count = 0);

  LDescriptions := CreateGridColumnDescriptions;
  try
    Assert(FLinkGridColumnDescriptions.Count = 0);
    while LDescriptions.Count > 0 do
    begin
      LColumn := LDescriptions.Extract(0);
      FLinkGridColumnDescriptions.Add(LColumn);
      LColumnExpressionItem := BindGridLink.ColumnExpressions.AddExpression;
      LColumnExpressionItem.ColumnName := LColumn.ColumnName;
      LColumnExpressionItem.Name := ''; // is this needed?
      LColumnExpressionItem.ColumnIndex := LColumn.ColumnIndex;
      LColumnExpressionItem.SourceMemberName := LColumn.SourceMemberName;
      LColumnExpressionItem.ControlMemberName := LColumn.ControlMemberName;
      for LPair in LColumn.ParseCellExpression do
      begin
        LItem := LColumnExpressionItem.ParseCellExpressions.AddExpression;
        LItem.ControlExpression := LPair.ControlExpression;
        LItem.SourceExpression := LPair.SourceExpression;
      end;
      for LPair in LColumn.FormatCellExpressions do
      begin
        LItem := LColumnExpressionItem.FormatCellExpressions.AddExpression;
        LItem.ControlExpression := LPair.ControlExpression;
        LItem.SourceExpression := LPair.SourceExpression;
        LItem.Custom := LPair.Custom;
      end;

      for LPair in LColumn.FormatColumnExpressions do
      begin
        LItem := LColumnExpressionItem.FormatColumnExpressions.AddExpression;
        LItem.ControlExpression := LPair.ControlExpression;
        LItem.SourceExpression := LPair.SourceExpression;
        LItem.Custom := LPair.Custom;
      end;

    end
  finally
    FreeAndNil(LDescriptions);
  end;

  Assert(BindGridLink is TInternalBindGridLink);
  (BindGridLink as TInternalBindGridLink).TryGetBindListEditor(LEditor);
  if (LEditor <> nil) and (not IsUnidirectionalDataSource(Self.DataSource)) then
  begin
    if Supports(Self.DataSource,  IScopeMemberScripting, LScopeMemberScripting) then
    begin
      if LScopeMemberScripting.GetPositionGetter(LGetter, LGetterBase) and
        LEditor.GetPositionSetter(LSetter, LSetterBase) then
      begin
        LItem := BindGridLink.PosControlExpressions.AddExpression;
        LItem.ControlExpression := LSetter;
        if LGetterBase <> LSetterBase then
          LItem.SourceExpression := Format('%s(%d, %s + (%d))', [sMathMax, LSetterBase, LGetter, LSetterBase-LGetterBase])
        else
          LItem.SourceExpression := Format('%s(%d, %s)', [sMathMax, LSetterBase, LGetter]);
      end;

      if LScopeMemberScripting.GetPositionSetter(LSetter, LSetterBase) and
        LEditor.GetPositionGetter(LGetter, LGetterBase) then
      begin
        LItem := BindGridLink.PosSourceExpressions.AddExpression;
        LItem.SourceExpression := LSetter;
        if LGetterBase <> LSetterBase then
          LItem.ControlExpression := Format('%s(%d, %s + (%d))', [sMathMax, LSetterBase, LGetter, LSetterBase-LGetterBase])
        else
          LItem.ControlExpression := Format('%s(%d, %s)', [sMathMax, LSetterBase, LGetter]);
      end;
    end;
  end;

end;


function TCustomLinkGridToDataSource.GetColumns: TBaseLinkGridToDataSourceColumns;
begin
  Result := FLinkGridToDataSourceColumns;
end;

procedure TCustomLinkGridToDataSource.InvalidateColumn(
  AColumn: TBaseLinkGridToDataSourceColumn);
var
  LManager: ILinkGridToDataSourceControlManager;
  LIndex: Integer;
begin
  Assert(AColumn <> nil);
  if FLinkGridColumnDescriptionsLookup.TryGetValue(TMemberKey.CreateColumn(AColumn), LIndex) then
  begin
    LManager := GetGridColumnManager;
    if LManager <> nil then
      LManager.UpdateColumn(LIndex, AColumn)
    else
      inherited;
  end;

end;

procedure TCustomLinkGridToDataSource.SetColumns(Value: TLinkGridToDataSourceColumns);
begin
  FLinkGridToDataSourceColumns.Assign(Value);

end;

procedure TCustomLinkGridToDataSource.MemberRenaming(Sender: TComponent; AComponent: TComponent;
  const ACurMemberName, ANewMemberName: string);
var
  LItem: TLinkGridToDataSourceColumn;
begin
  if ACurMemberName <> '' then
    if AComponent = Self.DataSource then
      for LItem in  Self.Columns do
      begin
        if LItem.MemberName = ACurMemberName then
          // Set property so that column gets refreshed as design time
          LItem.MemberName := ANewMemberName;
      end;
end;


{ TBaseLinkGridComponentToDataSource }

function TCustomLinkGridToDataSource.GetControl: TComponent;
begin
  Result := BindGridLink.ControlComponent;
end;

procedure TCustomLinkGridToDataSource.SetControl(const Value: TComponent);
begin
  BindGridLink.ControlComponent := Value;
end;


{ TCustomLinkGridToDataSource.TMemberKey }


constructor TCustomLinkGridToDataSource.TMemberKey.CreateColumn(
  AColumn: TBaseLinkGridToDataSourceColumn);
begin
  FColumn := AColumn;
end;

constructor TCustomLinkGridToDataSource.TMemberKey.CreateMemberName(
  const AMemberName: string);
begin
  FMemberName := AMemberName;
end;



{ TLinkGridToDataSourceColumnsEnumerator }

function TLinkGridToDataSourceColumnsEnumerator.GetCurrent: TLinkGridToDataSourceColumn;
begin
  Result := inherited GetCurrent as  TLinkGridToDataSourceColumn;
end;

constructor TLinkGridToDataSourceColumnFactory.Create;
begin
//
end;

function TLinkGridToDataSourceColumnFactory.GetColumnStyles: TArray<string>;
begin
  Result := nil;
end;

function TLinkGridToDataSourceColumnFactory.FrameworkExt: string;
begin
  Result := '';
end;

function TLinkGridToDataSourceColumnFactory.GridClasses: TArray<TComponentClass>;
begin
  Result := nil;
end;

initialization
  GLinkGridToDataSourceColumnFactories := TList<TLinkGridToDataSourceColumnFactoryClass>.Create;

finalization
  GLinkGridToDataSourceColumnFactories.Free;

end.
