{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$HPPEMIT '#pragma link "Fmx.Bind.DBLinks"'}    {Do not Localize}
unit Fmx.Bind.DBLinks;

interface

uses System.SysUtils, System.Classes, Data.Bind.Components, Data.Bind.DBScope, FMX.Types, FMX.Edit, FMX.Controls,
  System.Bindings.Outputs, Data.Bind.DBLinks, Data.DB, FMX.Grid, Generics.Collections;

type

  TBaseBindDBFieldControlLink = class(TBaseBindDBFieldLink)
  protected
    function GetControlMemberName: string; virtual;
    function GetControl: TStyledControl;
    procedure SetControl(const Value: TStyledControl);
  public
    property ControlMemberName: string read GetControlMemberName;
  end;

  TCustomBindDBEditLink = class(TBaseBindDBFieldControlLink)
  protected
    function GetControlMemberName: string; override;
  public
    procedure GenerateExpressions(Sender: TComponent); override;
    property EditControl: TStyledControl read GetControl write SetControl;
  end;

  TBindDBEditLink = class(TCustomBindDBEditLink)
  published
    property DataSource;
    property FieldName;
    property EditControl;
    property AutoActivate;
    property OnAssignedValue;
    property OnAssigningValue;
    property OnEvalError;
    property OnActivating;
    property OnActivated;
  end;


  TCustomBindDBTextLink = class(TBaseBindDBFieldControlLink)
  protected
    function GetControlMemberName: string; override;
  public
    function RequiresControlHandler: Boolean; override;
    procedure GenerateExpressions(Sender: TComponent); override;
    property TextControl: TStyledControl read GetControl write SetControl;
  end;

  TBindDBTextLink = class(TCustomBindDBTextLink)
  published
    property DataSource;
    property FieldName;
    property TextControl;
    property AutoActivate;
    property OnAssignedValue;
    property OnAssigningValue;
    property OnEvalError;
    property OnActivating;
    property OnActivated;
  end;


  TCustomBindDBListLink = class(TBaseBindDBFieldControlLink)
  protected
    function GetControlMemberName: string; override;
  public
    procedure GenerateExpressions(Sender: TComponent); override;
    property ListControl: TStyledControl read GetControl write SetControl;
  end;

  TBindDBListLink = class(TCustomBindDBListLink)
  published
    property DataSource;
    property FieldName;
    property ListControl;
    property AutoActivate;
    property OnAssignedValue;
    property OnAssigningValue;
    property OnEvalError;
    property OnActivating;
    property OnActivated;
  end;


  TCustomBindDBImageLink = class(TBaseBindDBFieldControlLink)
  protected
    function GetControlMemberName: string; override;
  public
    procedure GenerateExpressions(Sender: TComponent); override;
    property ImageControl: TStyledControl read GetControl write SetControl;
  end;

  TBindDBImageLink = class(TCustomBindDBImageLink)
  published
    property DataSource;
    property FieldName;
    property ImageControl;
    property AutoActivate;
    property OnAssignedValue;
    property OnAssigningValue;
    property OnEvalError;
    property OnActivating;
    property OnActivated;
  end;

  TCustomBindDBMemoLink = class(TBaseBindDBFieldControlLink)
  protected
    function GetControlMemberName: string; override;
  public
    procedure GenerateExpressions(Sender: TComponent); override;
    property MemoControl: TStyledControl read GetControl write SetControl;
  end;

  TBindDBMemoLink = class(TCustomBindDBMemoLink)
  published
    property DataSource;
    property FieldName;
    property MemoControl;
    property AutoActivate;
    property OnAssignedValue;
    property OnAssigningValue;
    property OnEvalError;
    property OnActivating;
    property OnActivated;
  end;

  TCustomBindDBCheckLink = class(TBaseBindDBFieldControlLink)
  protected
    function GetControlMemberName: string; override;
  public
    procedure GenerateExpressions(Sender: TComponent); override;
    property CheckControl: TStyledControl read GetControl write SetControl;
  end;

  TBindDBCheckLink = class(TCustomBindDBCheckLink)
  published
    property DataSource;
    property FieldName;
    property CheckControl;
    property AutoActivate;
    property OnAssignedValue;
    property OnAssigningValue;
    property OnEvalError;
    property OnActivating;
    property OnActivated;
  end;


  TBaseBindDBGridControlLink = class(TBaseBindDBGridLink)
  protected
    function GetControl: TStyledControl;
    procedure SetControl(const Value: TStyledControl);
  end;

  TDBGridLinkColumn = class;

  TDBGridLinkColumnsEnumerator = class(TCollectionEnumerator)
  public
    function GetCurrent: TDBGridLinkColumn; inline;
    property Current: TDBGridLinkColumn read GetCurrent;
  end;


  TDBGridLinkColumns = class(TBaseDBGridLinkColumns)
  private
    function GetItem(I: Integer): TDBGridLinkColumn;
    procedure SetItem(I: Integer; const Value: TDBGridLinkColumn);
  public
    function GetEnumerator: TDBGridLinkColumnsEnumerator;
    property Items[I: Integer]: TDBGridLinkColumn read GetItem write SetItem; default;
  end;

  TDBGridLinkColumnValue = (cvWidth, cvReadOnly, cvHeader);
  TDBGridLinkColumnValues = set of TDBGridLinkColumnValue;

  TDBGridLinkColumn = class(TBaseDBGridLinkColumn)
  private
    FAssignedValues: TDBGridLinkColumnValues;
    FHeader: string;
    FVisible: Boolean;
    FReadOnly: Boolean;
    FWidth: Integer;
    FStyleLookup: string;
    function GetWidth: Integer;
    function GetShowing: Boolean;
    function GetReadOnly: Boolean;
    function GetVisible: Boolean;
    function IsHeaderStored: Boolean;
    function IsReadOnlyStored: Boolean;
    function IsWidthStored: Boolean;
    procedure SetHeader(const Value: string);
    procedure SetReadOnly(const Value: Boolean);
    procedure SetVisible(const Value: Boolean);
    procedure SetWidth(const Value: Integer);
    function DefaultHeader: string;
    function DefaultWidth: Integer;
    function GetHeader: string;
    function DefaultReadOnly: Boolean;
    procedure SetStyleLookup(const Value: string);
  protected
    procedure Initialize; override;
  public
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; override;
    property  AssignedValues: TDBGridLinkColumnValues read FAssignedValues;
    property Showing: Boolean read GetShowing;
  published
    property FieldName;
    [Stored('IsReadOnlyStored')]
    property  ReadOnly: Boolean read GetReadOnly write SetReadOnly stored IsReadOnlyStored;
    [Stored('IsHeaderStored')]
    property  Header: string read GetHeader write SetHeader stored IsHeaderStored;
    [Stored('IsWidthStored')]
    property  Width: Integer read GetWidth write SetWidth stored IsWidthStored;
    property  Visible: Boolean read GetVisible write SetVisible;
    property  StyleLookup: string read FStyleLookup write SetStyleLookup;
  end;

  TCustomBindDBGridLink = class(TBaseBindDBGridControlLink)
  private
    FColumnDescriptionsLookup: TDictionary<TObject, Integer>;
    FColumnDescriptions: TList<TDBGridLinkColumnDescription>;
    FColumns: TDBGridLinkColumns;
    FAutoBufferCount: Boolean;
    procedure CreateDefaultGridColumns;
    procedure CreateCollectionGridColumns;
     procedure SetColumns(Value: TDBGridLinkColumns);
    function ColumnsHaveChanged: Boolean;
    function CreateDefaultGridColumnDescriptions: TArray<TDBGridLinkColumnDescription>;
    function CreateCollectionGridColumnDescriptions: TArray<TDBGridLinkColumnDescription>;
    function CreateGridColumnDescriptions: TArray<TDBGridLinkColumnDescription>;
    procedure SetAutoBufferCount(const Value: Boolean);
    procedure OnListRefreshing(Sender: TObject);
    function UpdateBufferCount: Boolean;
  protected
    function GetColumns: TBaseDBGridLinkColumns; override;
    procedure InvalidateColumn(AColumn: TBaseDBGridLinkColumn); override;
    procedure InvalidateField(AField: TField); override;
    procedure ClearColumns(AManager: IBindDBGridLinkControlManager); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ClearGeneratedExpressions(Sender: TComponent); override;
    procedure GenerateExpressions(Sender: TComponent); override;
    procedure UpdateColumns; override;
    procedure CreateGridColumns;
    property GridControl: TStyledControl read GetControl write SetControl;
    property Columns: TDBGridLinkColumns read FColumns write SetColumns;
    property AutoBufferCount: Boolean read FAutoBufferCount write SetAutoBufferCount;
  end;

  TFMXDBGridLinkColumns = class(TDBGridLinkColumns)

  end;

  TBindDBGridLink = class(TCustomBindDBGridLink)
  published
    property DataSource;
    property GridControl;
    property AutoActivate;
    property BufferCount;
    property AutoBufferCount;
    property Columns;
    property OnAssignedValue;
    property OnAssigningValue;
    property OnEvalError;
    property OnActivating;
    property OnActivated;
  end;

  TBindDBStringGridColumnFactory = class(TBindDBColumnFactory)
  public
    constructor Create; override;
    function Supports(AIntf: TGuid; AGrid: TComponent): Boolean; override;
    function CreateFactory(AIntf: TGuid;
     AGrid: TComponent): IInterface; override;
  end;

  TCreateColumnDescription = record
  private
    FField: TField;
    FHeader: string;
    FReadOnly: Boolean;
    FFieldName: string;
    FVisible: Boolean;
    FWidth: Integer;
    FStyleLookup: string;
  public
    constructor Create(AField: TField); overload;
    constructor Create(AColumn: TDBGridLinkColumn); overload;
    property Field: TField read FField;
    property Header: string read FHeader;
    property FieldName: string read FFieldName;
    property Visible: Boolean read FVisible;
    property Width: Integer read FWidth;
    property StyleLookup: string read FStyleLookup;
    property ReadOnly: Boolean read FReadOnly;
  end;


  TBindDBStringGridColumnCreator = class(TInterfacedObject, IBindDBGridLinkControlManager)
  private
    FStringGrid: TStringGrid;
    function CreateColumnDescription(
      AIndex: Integer; ADescription: TCreateColumnDescription): TDBGridLinkColumnDescription;
    function AddColumn(
      const ADescription: TCreateColumnDescription): Integer; overload;
    procedure UpdateColumn(const ACreateDescription: TCreateColumnDescription; const ADescription: TDBGridLinkColumnDescription); overload;
    function DescribeColumn(
      AIndex: Integer; const ADescription: TCreateColumnDescription): TDBGridLinkColumnDescription; overload;
  public
    constructor Create(AGrid: TStringGrid);
    procedure BeginUpdate;
    procedure EndUpdate;
    function CanAddColumn(AField: TField): Boolean; overload;
    function CanAddColumn(AColumn: TBaseDBGridLinkColumn): Boolean; overload;
    procedure ClearColumns;
    function DescribeColumn(AIndex: Integer; AColumn: TBaseDBGridLinkColumn): TDBGridLinkColumnDescription; overload;
    function DescribeColumn(AIndex: Integer; AField: TField): TDBGridLinkColumnDescription; overload;
    function AddColumn(AColumn: TBaseDBGridLinkColumn): Integer; overload;
    function AddColumn(AField: TField): Integer; overload;
    procedure UpdateColumn(AColumn: TBaseDBGridLinkColumn; const ADescription: TDBGridLinkColumnDescription); overload;
    procedure UpdateColumn(AField: TField; const ADescription: TDBGridLinkColumnDescription); overload;
  end;

implementation

uses Data.Bind.Consts;


{ TCustomBindDBEditLink }

procedure TCustomBindDBEditLink.GenerateExpressions;
var
  LItem: TExpressionItem;
begin
  Assert(BindLink.ParseExpressions.Count = 0);
  Assert(BindLink.FormatExpressions.Count = 0);
  Assert(BindLink.ClearExpressions.Count = 0);

  LItem := BindLink.ParseExpressions.AddExpression;
  LItem.ControlExpression := ControlMemberName;
  LItem.SourceExpression := 'Text';

  LItem := BindLink.FormatExpressions.AddExpression;
  LItem.ControlExpression := ControlMemberName;
  LItem.SourceExpression := 'DisplayText';

  LItem := BindLink.ClearExpressions.AddExpression;
  LItem.ControlExpression := ControlMemberName;
  LItem.SourceExpression := '""';
end;

function TCustomBindDBEditLink.GetControlMemberName: string;
begin
  Result := 'Text';
end;

{ TCustomBindDBTextLink }

function TCustomBindDBTextLink.GetControlMemberName: string;
begin
  Result := 'Text';
end;

function TCustomBindDBTextLink.RequiresControlHandler: Boolean;
begin
  Result := False;
end;

procedure TCustomBindDBTextLink.GenerateExpressions;
var
  LItem: TExpressionItem;
begin
  Assert(BindLink.ParseExpressions.Count = 0);
  Assert(BindLink.FormatExpressions.Count = 0);
  Assert(BindLink.ClearExpressions.Count = 0);

  LItem := BindLink.FormatExpressions.AddExpression;
  LItem.ControlExpression := ControlMemberName;
  LItem.SourceExpression := 'DisplayText';  // Read only text

  LItem := BindLink.ClearExpressions.AddExpression;
  LItem.ControlExpression := ControlMemberName;;
  LItem.SourceExpression := '""';
end;


{ TCustomBindDBListLink }

procedure TCustomBindDBListLink.GenerateExpressions;
var
  LItem: TExpressionItem;
begin
  Assert(BindLink.ParseExpressions.Count = 0);
  Assert(BindLink.FormatExpressions.Count = 0);
  Assert(BindLink.ClearExpressions.Count = 0);

  LItem := BindLink.ParseExpressions.AddExpression;
  LItem.ControlExpression := ControlMemberName;
  LItem.SourceExpression := 'Text';

  LItem := BindLink.FormatExpressions.AddExpression;
  LItem.ControlExpression := ControlMemberName;
  LItem.SourceExpression := 'DisplayText';

  LItem := BindLink.ClearExpressions.AddExpression;
  LItem.ControlExpression := ControlMemberName;                                                                                     
  LItem.SourceExpression := 'nil';
end;

function TCustomBindDBListLink.GetControlMemberName: string;
begin
  Result := 'SelectedText(Self)';
end;

{ TCustomBindDBImageLink }


procedure TCustomBindDBImageLink.GenerateExpressions;
var
  LItem: TExpressionItem;
begin
  Assert(BindLink.ParseExpressions.Count = 0);
  Assert(BindLink.FormatExpressions.Count = 0);
  Assert(BindLink.ClearExpressions.Count = 0);

  LItem := BindLink.FormatExpressions.AddExpression;
  LItem.ControlExpression := ControlMemberName;
  LItem.SourceExpression := 'Self';

  LItem := BindLink.ParseExpressions.AddExpression;
  LItem.ControlExpression := ControlMemberName;
  LItem.SourceExpression := 'Self';

  LItem := BindLink.ClearExpressions.AddExpression;
  LItem.ControlExpression := ControlMemberName;
  LItem.SourceExpression := 'nil';
end;

function TCustomBindDBImageLink.GetControlMemberName: string;
begin
  Result := 'Bitmap';
end;

{ TCustomBindDBMemoLink }

procedure TCustomBindDBMemoLink.GenerateExpressions;
var
  LItem: TExpressionItem;
begin
  Assert(BindLink.ParseExpressions.Count = 0);
  Assert(BindLink.FormatExpressions.Count = 0);
  Assert(BindLink.ClearExpressions.Count = 0);

  LItem := BindLink.ParseExpressions.AddExpression;
  LItem.ControlExpression := 'Text';
  LItem.SourceExpression := 'Text';

  LItem := BindLink.FormatExpressions.AddExpression;
  LItem.ControlExpression := 'Text';
  LItem.SourceExpression := 'Value';

  LItem := BindLink.ClearExpressions.AddExpression;
  LItem.ControlExpression := 'Text';
  LItem.SourceExpression := 'nil';
end;

function TCustomBindDBMemoLink.GetControlMemberName: string;
begin
  Result := 'Text';
end;

{ TCustomBindDBCheckLink }

procedure TCustomBindDBCheckLink.GenerateExpressions;
var
  LItem: TExpressionItem;
begin
  Assert(BindLink.ParseExpressions.Count = 0);
  Assert(BindLink.FormatExpressions.Count = 0);
  Assert(BindLink.ClearExpressions.Count = 0);

  LItem := BindLink.ParseExpressions.AddExpression;
  LItem.ControlExpression := ControlMemberName;
  LItem.SourceExpression := 'Text';

  LItem := BindLink.FormatExpressions.AddExpression;
  LItem.ControlExpression := ControlMemberName;
  LItem.SourceExpression := 'DisplayText';

  LItem := BindLink.ClearExpressions.AddExpression;
  LItem.ControlExpression := ControlMemberName;
  LItem.SourceExpression := 'nil';
end;


function TCustomBindDBCheckLink.GetControlMemberName: string;
begin
  Result := 'CheckedState(Self)';
end;

{ TCustomBindDBGridLink }

procedure TCustomBindDBGridLink.CreateGridColumns;
begin
  if Columns.Count = 0 then
    CreateDefaultGridColumns
  else
    CreateCollectionGridColumns;
end;

function TCustomBindDBGridLink.CreateGridColumnDescriptions: TArray<TDBGridLinkColumnDescription>;
begin
  if Columns.Count = 0 then
    Result := CreateDefaultGridColumnDescriptions
  else
    Result := CreateCollectionGridColumnDescriptions;
end;

procedure TCustomBindDBGridLink.ClearGeneratedExpressions;
var
  LManager: IBindDBGridLinkControlManager;
begin
  inherited;
  if Columns.Count = 0 then
  begin
    // Clear default columns
    LManager := GetBindDBColumnManager;
    if LManager <> nil then
      ClearColumns(LManager);
  end;

  FColumnDescriptions.Clear;
end;

function TCustomBindDBGridLink.ColumnsHaveChanged: Boolean;
var
  LDescriptions: TArray<TDBGridLinkColumnDescription>;
  I: Integer;
begin
  LDescriptions := CreateGridColumnDescriptions;
  Result := FColumnDescriptions.Count <> Length(LDescriptions);
  if not Result then
  begin
    for I := 0 to FColumnDescriptions.Count - 1 do
      if not FColumnDescriptions[I].IsEqual(LDescriptions[I]) then
        Exit(True);
  end;
end;

destructor TCustomBindDBGridLink.Destroy;
var
  LManager: IBindDBGridLinkControlManager;
begin
  LManager := GetBindDBColumnManager;
  if LManager <> nil then
    ClearColumns(LManager);
  Active := False;
  FColumnDescriptionsLookup.Free;
  FColumnDescriptions.Free;
  FColumns.Free;
  inherited;
end;


constructor TCustomBindDBGridLink.Create(AOwner: TComponent);
var
  LListRefreshing: IBindListRefreshing;
begin
  inherited;
  if Supports(Self.BindGridLink, IBindListRefreshing, LListRefreshing) then
     LListRefreshing.OnListRefreshing := OnListRefreshing;
  FColumnDescriptionsLookup := TDictionary<TObject, Integer>.Create;
  FColumnDescriptions := TList<TDBGridLinkColumnDescription>.Create;
  FColumns := TDBGridLinkColumns.Create(Self, TDBGridLinkColumn);
end;

procedure TCustomBindDBGridLink.OnListRefreshing(Sender: TObject);
begin
  if FAutoBufferCount then
    UpdateBufferCount;
end;

procedure TCustomBindDBGridLink.CreateCollectionGridColumns;
var
  LManager: IBindDBGridLinkControlManager;
  I: Integer;
  LColumn: TDBGridLinkColumn;
  LIndex: Integer;
begin
  LManager := GetBindDBColumnManager;
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
          if ((LColumn.Field = nil) or LColumn.Field.Visible) and LManager.CanAddColumn(LColumn) then
          begin
            LManager.AddColumn(LColumn);
            FColumnDescriptionsLookup.Add(LColumn, LIndex);
            Inc(LIndex);
          end;
        end;
      end;
    finally
      LManager.EndUpdate;
    end;
  end;
end;

function TCustomBindDBGridLink.CreateCollectionGridColumnDescriptions: TArray<TDBGridLinkColumnDescription>;
var
  LManager: IBindDBGridLinkControlManager;
  LColumnDescription: TDBGridLinkColumnDescription;
  I: Integer;
  LColumn: TDBGridLinkColumn;
  LList: TList<TDBGridLinkColumnDescription>;
begin
  LList := TList< TDBGridLinkColumnDescription>.Create;
  try
  LManager := GetBindDBColumnManager;
  if LManager <> nil then
  begin
      for I := 0 to Columns.Count - 1 do
      begin
        LColumn := Columns[I];
        begin
          if ((LColumn.Field = nil) or LColumn.Field.Visible) and LManager.CanAddColumn(LColumn) then
          begin
            LColumnDescription := LManager.DescribeColumn(LList.Count, LColumn);
            LList.Add(LColumnDescription);
          end;
        end;
      end;
  end;
  Result := LList.ToArray;
  finally
    LList.Free;
  end;
end;

procedure TCustomBindDBGridLink.ClearColumns(AManager:  IBindDBGridLinkControlManager);
begin
  inherited;
  FColumnDescriptionsLookup.Clear;
end;

procedure TCustomBindDBGridLink.CreateDefaultGridColumns;
var
  LField: TField;
  LDataSet: TDataSet;
  LManager: IBindDBGridLinkControlManager;
  LIndex: Integer;
begin
  LManager := GetBindDBColumnManager;
  if LManager <> nil then
  begin
    LManager.BeginUpdate;
    try
      ClearColumns(LManager);
      LDataSet := GetDataSet;
      LIndex := 0;
      if LDataSet <> nil then
        for LField in LDataSet.Fields do
        begin
          if LField.Visible and LManager.CanAddColumn(LField) then
          begin
            LManager.AddColumn(LField);
            FColumnDescriptionsLookup.Add(LField, LIndex);
            Inc(LIndex);
          end;
        end;
    finally
      LManager.EndUpdate;
    end;
  end;
end;


function TCustomBindDBGridLink.CreateDefaultGridColumnDescriptions: TArray<TDBGridLinkColumnDescription>;
var
  LField: TField;
  LDataSet: TDataSet;
  LManager: IBindDBGridLinkControlManager;
  LColumnDescription: TDBGridLinkColumnDescription;
  LList: TList<TDBGridLinkColumnDescription>;
begin
  LList := TList<TDBGridLinkColumnDescription>.Create;
  try
  LManager := GetBindDBColumnManager;
  if LManager <> nil then
  begin
      LDataSet := GetDataSet;
      if LDataSet <> nil then
        for LField in LDataSet.Fields do
        begin
          if LField.Visible and LManager.CanAddColumn(LField) then
          begin
            LColumnDescription := LManager.DescribeColumn(LList.Count, LField);
            LList.Add(LColumnDescription);
          end;
        end;
  end;
  Result := LList.ToArray;
  finally
    LList.Free;
  end;
end;


procedure TCustomBindDBGridLink.UpdateColumns;
var
  LPair: TPair<TObject, Integer>;
begin
  if (FColumnDescriptions.Count = 0) or ColumnsHaveChanged then
  begin
    CreateGridColumns;
    ClearGeneratedExpressions(Self);
    if Active then
      GenerateExpressions(Self);
  end
  else
  begin
    // Expressions haven't changed but column heading etc. may need updating
    for LPair in FColumnDescriptionsLookup do
      if LPair.Key is TField then
        InvalidateField(TField(LPair.Key))
      else if LPair.Key is TDBGridLinkColumn then
        InvalidateColumn(TDBGridLinkColumn(LPair.Key));
  end;

end;


procedure TCustomBindDBGridLink.GenerateExpressions;
var
  LItem: TExpressionItem;
  LColumn: TDBGridLinkColumnDescription;
  LColumnExpressionItem: TColumnLinkExpressionItem;
  LPair: TDBGridLinkColumnExpressionPair;
  LDescriptions: TArray<TDBGridLinkColumnDescription>;

begin

  if Columns.Count = 0 then
    if FColumnDescriptionsLookup.Count = 0 then
      // Generate default columns
      CreateDefaultGridColumns;

  Assert(BindGridLink.ColumnExpressions.Count = 0);
  Assert(BindGridLink.FormatControlExpressions.Count = 0);
  Assert(BindGridLink.ClearControlExpressions.Count = 0);
  Assert(BindGridLink.PosSourceExpressions.Count = 0);
  Assert(BindGridLink.PosControlExpressions.Count = 0);

  LDescriptions := CreateGridColumnDescriptions;
  Assert(FColumnDescriptions.Count = 0);
  for LColumn in LDescriptions do
  begin
    FColumnDescriptions.Add(LColumn);
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
    end;

    for LPair in LColumn.FormatColumnExpressions do
    begin
      LItem := LColumnExpressionItem.FormatColumnExpressions.AddExpression;
      LItem.ControlExpression := LPair.ControlExpression;
      LItem.SourceExpression := LPair.SourceExpression;
    end;

  end;

  LItem := BindGridLink.PosControlExpressions.AddExpression;
  LItem.ControlExpression := 'Selected';
  LItem.SourceExpression := 'Math_Max(0, DBUtils_ActiveRecord(Self))';

  LItem := BindGridLink.PosSourceExpressions.AddExpression;
  LItem.ControlExpression := 'Selected+1';
  // Use ValidRecNo to make sure that the assigned value is in range
  LItem.SourceExpression := 'DBUtils_ValidRecNo(Self)';

  if AutoBufferCount then
    UpdateBufferCount;

end;


function TCustomBindDBGridLink.GetColumns: TBaseDBGridLinkColumns;
begin
  Result := FColumns;
end;

procedure TCustomBindDBGridLink.InvalidateColumn(
  AColumn: TBaseDBGridLinkColumn);
var
  LManager: IBindDBGridLinkControlManager;
  LIndex: Integer;
  LDescription: TDBGridLinkColumnDescription;
  LColumnDescriptions: TList<TDBGridLinkColumnDescription>;
begin
  LColumnDescriptions := nil;
  try
    if FColumnDescriptionsLookup.TryGetValue(AColumn, LIndex) then
    begin
      if FColumnDescriptions.Count > LIndex then
        LColumnDescriptions := FColumnDescriptions
      else
      begin
        LColumnDescriptions := TList<TDBGridLinkColumnDescription>.Create;
        LColumnDescriptions.AddRange(CreateGridColumnDescriptions);
      end;
      if LColumnDescriptions.Count > LIndex then
      begin
        LDescription := LColumnDescriptions[LIndex];
        LManager := GetBindDBColumnManager;
        if LManager <> nil then
          LManager.UpdateColumn(AColumn, LDescription)
        else
          inherited;
      end;
    end;
  finally
    if LColumnDescriptions <> FColumnDescriptions then
      LColumnDescriptions.Free;
  end;

end;

procedure TCustomBindDBGridLink.InvalidateField(
  AField: TField);
var
  LManager: IBindDBGridLinkControlManager;
  LIndex: Integer;
  LDescription: TDBGridLinkColumnDescription;
begin
  if FColumnDescriptionsLookup.TryGetValue(AField, LIndex) then
  begin
    if FColumnDescriptions.Count > LIndex then
    begin
      LDescription := FColumnDescriptions[LIndex];
      LManager := GetBindDBColumnManager;
      if LManager <> nil then
        LManager.UpdateColumn(AField, LDescription)
      else
        inherited;
    end;
  end;

end;

function TCustomBindDBGridLink.UpdateBufferCount: Boolean;
var
  LNewBufferCount: Integer;
begin
  Result := False;
  if (DataSource <> nil) and
    (DataSource.DataSource <> nil) and
    (DataSource.DataSource.DataSet <> nil) and
    (DataSource.DataSource.DataSet.Active) then
  begin
      Result := True;
      LNewBufferCount := 2 + DataSource.DataSource.DataSet.RecordCount;
      if LNewBufferCount > BufferCount then
        BufferCount := LNewBufferCount;
  end;
end;

procedure TCustomBindDBGridLink.SetAutoBufferCount(const Value: Boolean);
begin
  if FAutoBufferCount <> Value then
  begin
    FAutoBufferCount := Value;
    // No need to update buffer count when designing since
    // row insert not supported at design time
    if not (csDesigning in ComponentState) then
    begin
      if Active and FAutoBufferCount then
      begin
        if not UpdateBufferCount then
          BufferCount := -1
      end
      else
        BufferCount := -1; // Restore default
    end;
  end;
end;

procedure TCustomBindDBGridLink.SetColumns(Value: TDBGridLinkColumns);
begin
  FColumns.Assign(Value);

end;

{ TBaseBindDBFieldControlLink }

function TBaseBindDBFieldControlLink.GetControl: TStyledControl;
begin
  if Assigned(BindLink.ControlComponent) and (BindLink.ControlComponent is TStyledControl) then
    Result := BindLink.ControlComponent as TStyledControl
  else
    Result := nil;
end;

function TBaseBindDBFieldControlLink.GetControlMemberName: string;
begin
  Result := '';
end;

procedure TBaseBindDBFieldControlLink.SetControl(const Value: TStyledControl);
begin
  BindLink.ControlComponent := Value;
end;

{ TBaseBindDBGridControlLink }

function TBaseBindDBGridControlLink.GetControl: TStyledControl;
begin
  if Assigned(BindGridLink.ControlComponent) and (BindGridLink.ControlComponent is TStyledControl) then
    Result := BindGridLink.ControlComponent as TStyledControl
  else
    Result := nil;
end;

procedure TBaseBindDBGridControlLink.SetControl(const Value: TStyledControl);
begin
  BindGridLink.ControlComponent := Value;
end;


{ TBindDBStringGridColumnFactory }

constructor TBindDBStringGridColumnFactory.Create;
begin
  inherited;

end;

function TBindDBStringGridColumnFactory.CreateFactory(AIntf: TGuid;
  AGrid: TComponent): IInterface;
begin
  Result := TBindDBStringGridColumnCreator.Create(TStringGrid(AGrid));
end;

function TBindDBStringGridColumnFactory.Supports(AIntf: TGuid;
  AGrid: TComponent): Boolean;
begin
  Result := False;
  if AIntf = IBindDBGridLinkControlManager then
    if AGrid.InheritsFrom(TStringGrid) then
      Result := True;
end;

{ TBindDBStringGridColumnCreator }

function TBindDBStringGridColumnCreator.AddColumn(
  AField: TField): Integer;
begin
  Result := AddColumn(TCreateColumnDescription.Create(AField));
end;

procedure TBindDBStringGridColumnCreator.BeginUpdate;
begin
  FStringGrid.BeginUpdate;
end;

function TBindDBStringGridColumnCreator.DescribeColumn(
  AIndex: Integer; AColumn: TBaseDBGridLinkColumn): TDBGridLinkColumnDescription;
begin
  Result := DescribeColumn(AIndex, TCreateColumnDescription.Create(AColumn as TDBGridLinkColumn));
end;

function TBindDBStringGridColumnCreator.DescribeColumn(
  AIndex: Integer; AField: TField): TDBGridLinkColumnDescription;
begin
  Result := DescribeColumn(AIndex, TCreateColumnDescription.Create(AField));
end;


function TBindDBStringGridColumnCreator.AddColumn(
  AColumn: TBaseDBGridLinkColumn): Integer;
begin
  Result := AddColumn(TCreateColumnDescription.Create(AColumn as TDBGridLinkColumn));
end;

procedure TBindDBStringGridColumnCreator.UpdateColumn(
  AField: TField; const ADescription: TDBGridLinkColumnDescription);
var
  AUpdateColumnDescription: TCreateColumnDescription;
begin
  AUpdateColumnDescription := TCreateColumnDescription.Create(AField);
  AUpdateColumnDescription.FWidth := -1; // Leave width unchanged
  UpdateColumn(AUpdateColumnDescription, ADescription);
end;

procedure TBindDBStringGridColumnCreator.UpdateColumn(
  AColumn: TBaseDBGridLinkColumn; const ADescription: TDBGridLinkColumnDescription);
begin
  UpdateColumn(TCreateColumnDescription.Create(AColumn as TDBGridLinkColumn),
    ADescription);
end;

function TBindDBStringGridColumnCreator.AddColumn(
  const ADescription: TCreateColumnDescription): Integer;
var
  LColumn: TColumn;
begin
  LColumn := TStringColumn.Create(FStringGrid);
  LColumn.Locked := True;
  LColumn.Stored := False;
  LColumn.Header := ADescription.Header;
  LColumn.Width := ADescription.Width;
  LColumn.Visible := ADescription.Visible;
  LColumn.ReadOnly := ADescription.ReadOnly;
  LColumn.StyleLookup := ADescription.StyleLookup;
  FStringGrid.AddObject(LColumn);
  Result := LColumn.Index;
end;

function TBindDBStringGridColumnCreator.DescribeColumn(
  AIndex: Integer; const ADescription: TCreateColumnDescription): TDBGridLinkColumnDescription;
begin
  Result := CreateColumnDescription(AIndex, ADescription);
end;

procedure TBindDBStringGridColumnCreator.UpdateColumn(
  const ACreateDescription: TCreateColumnDescription; const ADescription: TDBGridLinkColumnDescription);

var
  LColumn: TColumn;
begin
  LColumn := ADescription.ColumnControl as TColumn;
  if LColumn <> nil then
  begin
    LColumn.Header := ACreateDescription.Header;
    if ACreateDescription.Width <> -1 then
      LColumn.Width := ACreateDescription.Width;
    LColumn.Visible := ACreateDescription.Visible;
    LColumn.ReadOnly := ACreateDescription.ReadOnly;
  end;
end;

function TBindDBStringGridColumnCreator.CreateColumnDescription(
  AIndex: Integer; ADescription: TCreateColumnDescription): TDBGridLinkColumnDescription;
var
  LColumn: TDBGridLinkColumnDescription;
  FPairsList: TList<TDBGridLinkColumnExpressionPair>;
  LPair: TDBGridLinkColumnExpressionPair;
  LFormatColumnExpressions: TArray<TDBGridLinkColumnExpressionPair>;
  LFormatCellExpressions: TArray<TDBGridLinkColumnExpressionPair>;
  LParseCellExpressions: TArray<TDBGridLinkColumnExpressionPair>;
  LCellExpression: String;
  LField: TField;
begin
  LField := ADescription.Field;
  FPairsList := TList<TDBGridLinkColumnExpressionPair>.Create;
  try
    FPairsList.Clear;
    LFormatColumnExpressions := FPairsList.ToArray;

    if LField = nil then
      LCellExpression := ''
    else if LField.IsBlob then
      LCellExpression := '''(blob)'''
    else
      LCellExpression := 'DisplayText';
    FPairsList.Clear;
    if LCellExpression <> '' then
    begin
      LPair := TDBGridLinkColumnExpressionPair.Create(
        Format('Cells[%d]', [AIndex]), LCellExpression);
      FPairsList.Add(LPair);
      LFormatCellExpressions := FPairsList.ToArray;
    end;

    if LField = nil then
      LCellExpression := ''
    else if LField.IsBlob then
      LCellExpression := ''
    else
      LCellExpression := 'Text';
    FPairsList.Clear;
    if LCellExpression <> '' then
    begin
      LPair := TDBGridLinkColumnExpressionPair.Create(
      'SelectedText(Self)', LCellExpression);
      FPairsList.Add(LPair);
    end;
    LParseCellExpressions := FPairsList.ToArray;

    LColumn := TDBGridLinkColumnDescription.Create(FStringGrid.Columns[AIndex], '',
     AIndex, '', ADescription.FieldName,
     LFormatColumnExpressions, LFormatCellExpressions, LParseCellExpressions);


    Result := LColumn;
  finally
    FPairsList.Free;
  end;

end;

procedure TBindDBStringGridColumnCreator.EndUpdate;
begin
  FStringGrid.EndUpdate;
end;

function TBindDBStringGridColumnCreator.CanAddColumn(AField: TField): Boolean;
begin
  Result := True;
end;

function TBindDBStringGridColumnCreator.CanAddColumn(
  AColumn: TBaseDBGridLinkColumn): Boolean;
begin
  Result := True;
end;

procedure TBindDBStringGridColumnCreator.ClearColumns;
var
  I: Integer;
begin
  FStringGrid.BeginUpdate;
  try
    for I := FStringGrid.ColumnCount - 1 downto 0 do
      FStringGrid.Columns[I].DisposeOf;
  finally
    FStringGrid.EndUpdate;
  end;
end;

constructor TBindDBStringGridColumnCreator.Create(AGrid: TStringGrid);
begin
  FStringGrid := AGrid;
end;

{ TCreateColumnDescription }

constructor TCreateColumnDescription.Create(AField: TField);
begin
  FField := AField;
  FHeader := FField.DisplayName;
  FFieldName := FField.FieldName;
  FVisible := FField.Visible;
  FWidth := 64;
end;

constructor TCreateColumnDescription.Create(AColumn: TDBGridLinkColumn);
begin
  FField := AColumn.Field;
  FHeader := AColumn.Header;
  FFieldName := AColumn.FieldName;
  FReadOnly := AColumn.ReadOnly;
  FVisible := AColumn.Visible;
  FWidth := AColumn.Width;
  FStyleLookup := AColumn.StyleLookup;
end;


{ TDBGridLinkColumns }

function TDBGridLinkColumns.GetEnumerator: TDBGridLinkColumnsEnumerator;
begin
  Result := TDBGridLinkColumnsEnumerator.Create(Self);
end;

function TDBGridLinkColumns.GetItem(I: Integer): TDBGridLinkColumn;
begin
  Result := TDBGridLinkColumn(BaseItems[I]);
end;

procedure TDBGridLinkColumns.SetItem(I: Integer; const Value: TDBGridLinkColumn);
begin
  BaseItems[I] := Value;
end;

{ TDBGridLinkColumn }


function TDBGridLinkColumn.GetVisible: Boolean;
var
  Col: TBaseDBGridLinkColumn;
  LVisible: Boolean;
begin
  Result := FVisible;
  if Result then
  begin
    Col := ParentColumn;
    LVisible := (not (Col is TBaseDBGridLinkColumn)) or TDBGridLinkColumn(Col).Visible;
    Result := Result and LVisible;
  end;
end;

function TDBGridLinkColumn.GetWidth: Integer;
begin
  if not Showing then
    Result := -1
  else
  if cvWidth in FAssignedValues then
    Result := FWidth
  else
    Result := DefaultWidth;
end;

function TDBGridLinkColumn.GetReadOnly: Boolean;
begin
  if cvReadOnly in FAssignedValues then
    Result := FReadOnly
  else
    Result := DefaultReadOnly;
end;

function TDBGridLinkColumn.IsHeaderStored: Boolean;
begin
  Result := (cvHeader in FAssignedValues) and (FHeader <> DefaultHeader);
end;

procedure TDBGridLinkColumn.Assign(Source: TPersistent);
begin
  if Source is TDBGridLinkColumn then
  begin
    if Assigned(Collection) then Collection.BeginUpdate;
    try
      RestoreDefaults;
      FieldName := TDBGridLinkColumn(Source).FieldName;
      ReadOnly := TDBGridLinkColumn(Source).ReadOnly;
      Header := TDBGridLinkColumn(Source).Header;
      Width := TDBGridLinkColumn(Source).Width;
      Visible := TDBGridLinkColumn(Source).Visible;
      StyleLookup := TDBGridLinkColumn(Source).StyleLookup;
    finally
      if Assigned(Collection) then Collection.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

function TDBGridLinkColumn.DefaultHeader: string;
begin
  if Assigned(Field) then
    Result := Field.DisplayName
  else
    Result := FieldName;
end;

function TDBGridLinkColumn.DefaultWidth: Integer;
begin
  Result := 64;
end;

function TDBGridLinkColumn.DefaultReadOnly: Boolean;
var
  Grid: ICustomDBGrid;
begin
  Grid := GetGridIntf;
  Result := (Assigned(Grid) and Grid.ReadOnly) or
    (Assigned(Field) and Field.ReadOnly);
end;

function TDBGridLinkColumn.GetHeader: string;
begin
  if cvHeader in FAssignedValues then
    Result := FHeader
  else
    Result := DefaultHeader;
end;

function TDBGridLinkColumn.IsReadOnlyStored: Boolean;
begin
  Result := (cvReadOnly in FAssignedValues) and (FReadOnly <> DefaultReadOnly);
end;

function TDBGridLinkColumn.IsWidthStored: Boolean;
begin
  Result := (cvWidth in FAssignedValues) and (FWidth <> DefaultWidth);
end;

procedure TDBGridLinkColumn.SetHeader(const Value: string);
var
  Grid: ICustomDBGrid;
begin
  if IsStored then
  begin
    if (cvHeader in FAssignedValues) and (Value = FHeader) then Exit;
    FHeader := Value;
    Include(FAssignedValues, cvHeader);
    Changed(False);
  end
  else
  begin
    Grid := GetGridIntf;
    if Assigned(Grid) and (Grid.Active) and Assigned(Field) then
      Field.DisplayLabel := Value;
  end;
end;

procedure TDBGridLinkColumn.SetReadOnly(const Value: Boolean);
var
  Grid: ICustomDBGrid;
begin
  Grid := GetGridIntf;
  if not IsStored and Assigned(Grid) and Grid.Active and Assigned(Field) then
    Field.ReadOnly := Value
  else
  begin
    if (cvReadOnly in FAssignedValues) and (Value = FReadOnly) then Exit;
    FReadOnly := Value;
    Include(FAssignedValues, cvReadOnly);
    Changed(False);
  end;
end;

procedure TDBGridLinkColumn.SetStyleLookup(const Value: string);
begin
  if Value <> FStyleLookup then
  begin
    FStyleLookup := Value;
    Changed(True);
  end;
end;

procedure TDBGridLinkColumn.SetVisible(const Value: Boolean);
begin
  if Value <> FVisible then
  begin
    FVisible := Value;
    Changed(True);
  end;
end;


procedure TDBGridLinkColumn.Initialize;
begin
  inherited;
  FVisible := True;
end;

procedure TDBGridLinkColumn.RestoreDefaults;
begin
  FAssignedValues := [];
  Changed(False);
end;

procedure TDBGridLinkColumn.SetWidth(const Value: Integer);
var
  Grid: ICustomDBGrid;
//  TM: TTextMetric;
  DoSetWidth: Boolean;
begin
  DoSetWidth := IsStored;
  if not DoSetWidth then
  begin
    Grid := GetGridIntf;
    if Assigned(Grid) then
    begin
//
//      if Grid.HandleAllocated and Assigned(Field) and Grid.FUpdateFields then
//      with Grid do
//      begin
//        Canvas.Font := Self.Font;
//        GetTextMetrics(Canvas.Handle, TM);
//        Field.DisplayWidth := (Value + (TM.tmAveCharWidth div 2) - TM.tmOverhang - 3)
//          div TM.tmAveCharWidth;
//      end;
//      if (not Grid.FLayoutFromDataset) or (cvWidth in FAssignedValues) then
//        DoSetWidth := True;
    end
    else
      DoSetWidth := True;
  end;
  if DoSetWidth then
  begin
    if ((cvWidth in FAssignedValues) or (Value <> DefaultWidth))
      and (Value <> -1) then
    begin
      FWidth := Value;
      Include(FAssignedValues, cvWidth);
    end;
    Changed(False);
  end;
end;

function TDBGridLinkColumn.GetShowing: Boolean;
begin
  Result := Visible;
end;

{ TDBGridLinkColumnsEnumerator }

function TDBGridLinkColumnsEnumerator.GetCurrent: TDBGridLinkColumn;
begin
  Result := inherited GetCurrent as TDBGridLinkColumn;
end;

initialization
  RegisterBindDBColumnFactory([TBindDBStringGridColumnFactory]);
finalization
  UnRegisterBindDBColumnFactory([TBindDBStringGridColumnFactory]);
end.
