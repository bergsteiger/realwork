{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$HPPEMIT '#pragma link "Data.Bind.DBLinks"'}    {Do not Localize}
unit Data.Bind.DBLinks;

interface

uses System.SysUtils, System.Classes, Data.Bind.Components, Data.Bind.DBScope, System.Bindings.Outputs, Data.DB;

type

  TBaseBindDBControlLink = class(TBindComponentDelegate, IBindActivate)
  private
  protected
    { IBindActivate }
    procedure SetActive(AValue: Boolean); virtual;
    procedure SetSourceControl(const Value: TCustomBindSourceDB);
    function GetSourceControl: TCustomBindSourceDB;
    procedure SetSourceMember(const Value: string);
    function GetSourceMember: string;
    function GetControlComponent: TComponent; override;
    procedure SetControlComponent(const Value: TComponent);  override;
  public
    procedure UpdateColumns; virtual; abstract;
    property DataSource: TCustomBindSourceDB read GetSourceControl write SetSourceControl;
  end;

  TBaseBindDBFieldLink = class(TBaseBindDBControlLink)
  private
    FBindLink: TCustomBindLink;
    function GetAutoActivate: Boolean;
    procedure SetAutoActivate(const Value: Boolean);
  protected
    function GetActive: Boolean; override;
    procedure SetActive(Value: Boolean); override;
  public
    function GetDelegates: TArray<TCommonBindComponent>; override;
    function CanActivate(Sender: TComponent): Boolean; override;
    procedure ClearGeneratedExpressions(Sender: TComponent); override;
    function RequiresControlHandler: Boolean; override;
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property BindLink: TCustomBindLink read FBindLink;
    property FieldName: string read GetSourceMember write SetSourceMember;
    [Default(True)]
    property AutoActivate: Boolean read GetAutoActivate write SetAutoActivate default True;
    property Active: Boolean read GetActive write SetActive;
  end;



  TBaseDBGridLinkColumn = class;
  TBaseDBGridLinkColumns = class;

  ICustomDBGrid = interface
    ['{E14CC39A-D660-4801-9FFB-7CA7F2B6A99F}']
    function GetReadOnly: Boolean;
    function GetDataSet: TDataSet;
    function GetActive: Boolean;
    function GetDefaultFields: Boolean;
    function GetComponentState: TComponentState;
    function CreateColumns: TBaseDBGridLinkColumns;
    procedure BeginUpdate;
    procedure CancelLayout;
    procedure EndUpdate;
    procedure BeginLayout;
    procedure EndLayout;
    procedure LayoutChanged;
    procedure InvalidateColumn(AColumn: TBaseDBGridLinkColumn);
    procedure InvalidateField(AField: TField);
    function AcquireLayoutLock: Boolean;
    property ReadOnly: Boolean read GetReadOnly;
    property DataSet: TDataSet read GetDataSet;
    property Active: Boolean read GetActive;
    property DefaultFields: Boolean read GetDefaultFields;
    property ComponentState: TComponentState read GetComponentState;
  end;

  IBindDBGridLinkControlManager = interface;

  TBaseBindDBGridLink = class(TBaseBindDBControlLink, ICustomDBGrid)
  private
    FBindGridLink: TCustomBindGridLink;
    FUpdateLock: Byte;
    FLayoutLock: Byte;
    function GetAutoActivate: Boolean;
    procedure SetAutoActivate(const Value: Boolean);
    procedure InternalLayout;
    function GetBufferCount: Integer;
    procedure SetBufferCount(const Value: Integer);
  protected
    procedure SetActive(Value: Boolean); override;
    function GetColumns: TBaseDBGridLinkColumns; virtual; abstract;
    function GetBindDBColumnFactory(AGuid: TGuid): IInterface; virtual;
    function GetBindDBColumnManager: IBindDBGridLinkControlManager; virtual;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure ClearColumns(AManager: IBindDBGridLinkControlManager); virtual;
    { ICustomDBGrid }
    procedure BeginUpdate;
    procedure CancelLayout;
    procedure EndUpdate;
    function GetReadOnly: Boolean;
    function GetDataSet: TDataSet;
    function GetActive: Boolean; override;
    function GetDefaultFields: Boolean;
    function GetComponentState: TComponentState;
    function CreateColumns: TBaseDBGridLinkColumns;
    procedure BeginLayout;
    procedure EndLayout;
    function AcquireLayoutLock: Boolean;
    procedure LayoutChanged; 
    procedure InvalidateColumn(AColumn: TBaseDBGridLinkColumn); virtual;
    procedure InvalidateField(AField: TField); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function CanActivate(Sender: TComponent): Boolean; override;
    function GetDelegates: TArray<TCommonBindComponent>; override;
    procedure ClearGeneratedExpressions(Sender: TComponent); override;
    property BindGridLink: TCustomBindGridLink read FBindGridLink;
    property Active: Boolean read GetActive write SetActive;
    [Default(-1)]
    property BufferCount: Integer read GetBufferCount write SetBufferCount default -1;
    [Default(True)]
    property AutoActivate: Boolean read GetAutoActivate write SetAutoActivate default True;
  end;


  TBaseDBGridLinkColumn = class(TCollectionItem)
  private
    FField: TField;
    FFieldName: string;
    FStored: Boolean;
    function  GetField: TField;
    function  GetParentColumn: TBaseDBGridLinkColumn;
    procedure SetField(Value: TField); virtual;
    procedure SetFieldName(const Value: string);
  protected
    procedure Initialize; virtual;
    function GetGridIntf: ICustomDBGrid;
    function  GetGrid: TComponent;
    function GetDisplayName: string; override;
    procedure SetIndex(Value: Integer); override;
    [Default(True)]
    property IsStored: Boolean read FStored write FStored default True;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function  DefaultAlignment: TAlignment;
    procedure RestoreDefaults; virtual;
    property  Field: TField read GetField write SetField;
    property  ParentColumn: TBaseDBGridLinkColumn read GetParentColumn;
    property  FieldName: string read FFieldName write SetFieldName;
  end;

  TDBGridLinkColumnsState = (csDefault, csCustomized);
  TBaseDBGridLinkColumnClass = class of TBaseDBGridLinkColumn;
  TBaseDBGridLinkColumns = class(TCollection)
  private
    FGrid: TComponent;
    function GetColumn(Index: Integer): TBaseDBGridLinkColumn;
    procedure SetColumn(Index: Integer; Value: TBaseDBGridLinkColumn);
    procedure SetState(NewState: TDBGridLinkColumnsState);
    function GetState: TDBGridLinkColumnsState;
    function GetDataSet: TDataSet;
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
    function GetGridIntf: ICustomDBGrid;
  public
    constructor Create(Grid: TComponent; ColumnClass: TBaseDBGridLinkColumnClass); virtual;
    function Add: TBaseDBGridLinkColumn;
    function Updating: Boolean;
    procedure LoadFromFile(const Filename: string);
    procedure LoadFromStream(S: TStream);
    procedure RestoreDefaults;
    procedure RebuildColumns;
    procedure SaveToFile(const Filename: string);
    procedure SaveToStream(S: TStream);
    property State: TDBGridLinkColumnsState read GetState write SetState;
    property Grid: TComponent read FGrid;
    property BaseItems[Index: Integer]: TBaseDBGridLinkColumn read GetColumn write SetColumn;
  end;

  TDBGridLinkColumnExpressionPair = record
  private
    FControlExpression: string;
    FSourceExpression: string;
  public
    constructor Create(const AControlExpression, ASourceExpression: string);
    property ControlExpression: string read FControlExpression;
    property SourceExpression: string read FSourceExpression;
  end;

  TDBGridLinkColumnDescription = record
  private
    FColumnControl: TComponent;
    FColumnName: string;
    FColumnIndex: Integer;
    FSourceMemberName: string;
    FControlMemberName: string;
    FFormatCellExpressions: TArray<TDBGridLinkColumnExpressionPair>;
    FFormatColumnExpressions: TArray<TDBGridLinkColumnExpressionPair>;
    FParseCellExpressions: TArray<TDBGridLinkColumnExpressionPair>;
  public
    constructor Create(AColumnControl: TComponent; const AColumnName: string;
      AColumnIndex: Integer;
      const AControlMemberName, ASourceMemberName: string;
      AFormatColumnExpressions, AFormatCellExpressions, AParseCellExpression:
        TArray<TDBGridLinkColumnExpressionPair>);
    property ColumnControl: TComponent read FColumnControl;
    property ColumnName: string read FColumnName;
    property ColumnIndex: Integer read FColumnIndex;
    property SourceMemberName: string read FSourceMemberName;
    property ControlMemberName: string read FControlMemberName;
    property ParseCellExpression: TArray<TDBGridLinkColumnExpressionPair> read FParseCellExpressions;
    property FormatCellExpressions: TArray<TDBGridLinkColumnExpressionPair> read FFormatCellExpressions;
    property FormatColumnExpressions: TArray<TDBGridLinkColumnExpressionPair> read FFormatColumnExpressions;
    function IsEqual(const ADescription: TDBGridLinkColumnDescription): Boolean;
  end;

  IBindDBGridLinkControlManager = interface
    ['{F631C178-78F7-4164-A532-6F335760A26A}']
    procedure BeginUpdate;
    procedure EndUpdate;
    procedure ClearColumns;
    function CanAddColumn(AColumn: TBaseDBGridLinkColumn): Boolean; overload;
    function CanAddColumn(AField: TField): Boolean; overload;
    function AddColumn(AColumn: TBaseDBGridLinkColumn): Integer; overload;
    function AddColumn(AField: TField): Integer; overload;
    procedure UpdateColumn(AColumn: TBaseDBGridLinkColumn; const ADescription: TDBGridLinkColumnDescription); overload;
    procedure UpdateColumn(AField: TField; const ADescription: TDBGridLinkColumnDescription); overload;
    function DescribeColumn(AIndex: Integer; AColumn: TBaseDBGridLinkColumn): TDBGridLinkColumnDescription; overload;
    function DescribeColumn(AIndex: Integer; AField: TField): TDBGridLinkColumnDescription; overload;
  end;

  TBindDBColumnFactory = class
  public
    constructor Create; virtual;
    function Supports(AIntf: TGuid; AGrid: TComponent): Boolean; virtual; abstract;
    function CreateFactory(AIntf: TGuid;
     AGrid: TComponent): IInterface; virtual; abstract;
  end;


  TBindDBColumnFactoryClass = class of TBindDBColumnFactory;

procedure RegisterBindDBColumnFactory(AFactories: array of TBindDBColumnFactoryClass);
procedure UnregisterBindDBColumnFactory(AFactories: array of TBindDBColumnFactoryClass);

implementation

uses Data.Bind.Consts, Generics.Collections, System.Bindings.Methods,
  System.Bindings.EvalProtocol, System.RTTI;

type
  TInternalBindLink = class(TCustomBindLink)
  private
    [weak] FBindDBControlLink: TBaseBindDBControlLink;
  protected
    procedure ApplyComponents; override;
    function GetBindingsList: TCustomBindingsList; override;
    function CanActivate: Boolean; override;
    function RequiresControlHandler: Boolean; override;
    function GetDisplayName: string; override;
    function Designing: Boolean; override;
    function Loading: Boolean; override;
    function CanDesignActivate: Boolean; override;
    procedure DoOnActivating; override;
    procedure DoOnDeactivated; override;
  public
    constructor Create(ABindDBControlLink: TBaseBindDBControlLink); reintroduce;
  end;

  TInternalBindGridLink = class(TCustomBindGridLink, IBindLayoutChanged,
    IBindListRefresh, IBindListRefreshing)
  private
    [weak] FBindDBControlLink: TBaseBindDBControlLink;
    FListRefreshing: TNotifyEvent;
  protected
    procedure ApplyComponents; override;
    function GetBindingsList: TCustomBindingsList; override;
    function CanActivate: Boolean; override;
    function GetDisplayName: string; override;
    function Designing: Boolean; override;
    function Loading: Boolean; override;
    function CanDesignActivate: Boolean; override;
    procedure DoOnActivating; override;
    procedure DoOnDeactivated; override;
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
    constructor Create(ABindDBControlLink: TBaseBindDBControlLink); reintroduce;
  end;

var
  FBindDBColumnFactories: TList<TBindDBColumnFactoryClass>;

procedure RegisterBindDBColumnFactory(AFactories: array of TBindDBColumnFactoryClass);
var
  LClass: TBindDBColumnFactoryClass;
begin
  for LClass in AFactories do
    FBindDBColumnFactories.Add(LClass);
end;

procedure UnregisterBindDBColumnFactory(AFactories: array of TBindDBColumnFactoryClass);
var
  LClass: TBindDBColumnFactoryClass;
begin
  for LClass in AFactories do
      FBindDBColumnFactories.Remove(LClass);
end;

function GetBindDBColumnFactory(AGuid: TGuid; AGrid: TComponent): IInterface;
var
  LClass: TBindDBColumnFactoryClass;
  LFactory: TBindDBColumnFactory;
  I: Integer;
begin
  for I := FBindDBColumnFactories.Count - 1 downto 0 do
  begin
    LClass := FBindDBColumnFactories[I];
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

{ TInternalBindLink }

function TInternalBindLink.CanActivate: Boolean;
begin
  Result := FBindDBControlLink.CanActivate(Self);
end;

function TInternalBindLink.CanDesignActivate: Boolean;
begin
  Result := True; // Can show data at design time
end;

function TInternalBindLink.GetBindingsList: TCustomBindingsList;
begin
  Result := FBindDBControlLink.BindingsList;
end;

function TInternalBindLink.Loading: Boolean;
begin
  Result := csLoading in FBindDBControlLink.ComponentState;
end;

function TInternalBindLink.RequiresControlHandler: Boolean;
begin
  Result := FBindDBControlLink.RequiresControlHandler;
end;

constructor TInternalBindLink.Create(ABindDBControlLink: TBaseBindDBControlLink);
begin
  inherited Create(nil);
  FBindDBControlLink := ABindDBControlLink;
end;

function TInternalBindLink.Designing: Boolean;
begin
  Result := csDesigning in FBindDBControlLink.ComponentState;
end;

function TInternalBindLink.GetDisplayName: string;
begin
  Result := FBindDBControlLink.Name;
end;

procedure TInternalBindLink.DoOnActivating;
begin
  // Must generate expression when dataset is active in
  // order to retrieve fields
  FBindDBControlLink.ClearGeneratedExpressions(Self);
  FBindDBControlLink.GenerateExpressions(Self);
  inherited;
end;

procedure TInternalBindLink.DoOnDeactivated;
begin
  FBindDBControlLink.ClearGeneratedExpressions(Self);
  inherited;
end;

procedure TInternalBindLink.ApplyComponents;
begin
  inherited;
end;
{ TInternalBindGridLink }

function TInternalBindGridLink.CanActivate: Boolean;
begin
  Result := FBindDBControlLink.CanActivate(Self);
end;

function TInternalBindGridLink.CanDesignActivate: Boolean;
begin
  Result := True;
end;

function TInternalBindGridLink.GetBindingsList: TCustomBindingsList;
begin
  Result := FBindDBControlLink.BindingsList;
end;

function TInternalBindGridLink.GetListRefreshing: TNotifyEvent;
begin
  Result := FListRefreshing;
end;

procedure TInternalBindGridLink.BindLayoutChanged;
var
  LGrid: ICustomDBGrid;
begin
  if Supports(FBindDBControlLink, ICustomDBGrid, LGrid) then
  begin
    if (csLoading in LGrid.ComponentState) then Exit;
    LGrid.LayoutChanged;
  end;
end;

function TInternalBindGridLink.Loading: Boolean;
begin
  Result := csLoading in FBindDBControlLink.ComponentState;
end;

procedure TInternalBindGridLink.RefreshList;
begin
  if Assigned(FListRefreshing) then
    FListRefreshing(Self);
  ResetGrid;
end;

function TInternalBindGridLink.RefreshNeeded: Boolean;
var
  LEditor: IBindListEditor;
  LIntf: IScopeRecordEnumerable;
  LEnumerator: IScopeRecordEnumerator;
begin
  Result := False;
  if (ControlComponent <> nil)  then
    Supports(GetBindEditor(ControlComponent, IBindListEditor), IBindListEditor, LEditor)
  else
    LEditor := nil;
  if LEditor <> nil then
    if Supports(SourceComponent, IScopeRecordEnumerable, LIntf) then
      LEnumerator := LIntf.GetEnumerator('', BufferCount)
    else
      LEnumerator := nil;
  if (LEditor <> nil) and (LEnumerator <> nil) then
    Result := LEditor.RefreshNeeded(LEnumerator);

end;

procedure TInternalBindGridLink.SetListRefreshing(AEvent: TNotifyEvent);
begin
  FListRefreshing := AEvent;
end;

constructor TInternalBindGridLink.Create(ABindDBControlLink: TBaseBindDBControlLink);
begin
  inherited Create(nil);
  FBindDBControlLink := ABindDBControlLink;
end;

function TInternalBindGridLink.Designing: Boolean;
begin
  Result := csDesigning in FBindDBControlLink.ComponentState;
end;

function TInternalBindGridLink.GetDisplayName: string;
begin
  Result := FBindDBControlLink.Name;
end;

procedure TInternalBindGridLink.DoOnActivating;
begin
  // Must generate expression when dataset is active in
  // order to retrieve fields
  FBindDBControlLink.ClearGeneratedExpressions(Self);
  FBindDBControlLink.GenerateExpressions(Self);
  inherited;
end;

procedure TInternalBindGridLink.DoOnDeactivated;
begin
  FBindDBControlLink.ClearGeneratedExpressions(Self);
  inherited;
end;

procedure TInternalBindGridLink.ApplyComponents;
begin
  FBindDBControlLink.UpdateColumns;
  inherited;
end;

{ TBindDBFieldLink }

function TBaseBindDBFieldLink.CanActivate(Sender: TComponent): Boolean;
begin
  Result := (GetControlComponent <> nil) and (DataSource <> nil) and (FieldName <> '');
end;

constructor TBaseBindDBFieldLink.Create(AOwner: TComponent);
begin
  inherited;
  FBindLink := TInternalBindLink.Create(Self);
end;


destructor TBaseBindDBFieldLink.Destroy;
begin
  FBindLink.DisposeOf; // Scope component may be holding reference
  inherited;
end;

procedure TBaseBindDBFieldLink.ClearGeneratedExpressions;
begin
  inherited;
  FBindLink.ParseExpressions.Clear;
  FBindLink.FormatExpressions.Clear;
  FBindLink.ClearExpressions.Clear;
end;

function TBaseBindDBFieldLink.GetActive: Boolean;
begin
  Result := BindLink.Active;
end;

function TBaseBindDBFieldLink.GetDelegates: TArray<TCommonBindComponent>;
begin
  Result := TArray<TCommonBindComponent>.Create(FBindLink);
end;

function TBaseBindDBFieldLink.GetAutoActivate: Boolean;
begin
  Result := FBindLink.AutoActivate;
end;

procedure TBaseBindDBFieldLink.Loaded;
begin
  inherited;
  FBindLink.Loaded;
end;

function TBaseBindDBFieldLink.RequiresControlHandler: Boolean;
begin
  Result := True;
end;

procedure TBaseBindDBFieldLink.SetActive(Value: Boolean);
begin
  BindLink.Active := Value;
end;

procedure TBaseBindDBFieldLink.SetAutoActivate(const Value: Boolean);
begin
  FBindLink.AutoActivate := Value;
end;

{ TBaseBindDBGridLink }

function TBaseBindDBGridLink.AcquireLayoutLock: Boolean;
begin
  Result := (FUpdateLock = 0) and (FLayoutLock = 0);
  if Result then BeginLayout;
end;

procedure TBaseBindDBGridLink.BeginLayout;
begin
  BeginUpdate;
  if FLayoutLock = 0 then GetColumns.BeginUpdate;
  Inc(FLayoutLock);
end;

procedure TBaseBindDBGridLink.BeginUpdate;
begin
  Inc(FUpdateLock);
end;

procedure TBaseBindDBGridLink.EndLayout;
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

procedure TBaseBindDBGridLink.EndUpdate;
begin
  if FUpdateLock > 0 then
    Dec(FUpdateLock);
end;

procedure TBaseBindDBGridLink.CancelLayout;
begin
  if FLayoutLock > 0 then
  begin
    if FLayoutLock = 1 then
      GetColumns.EndUpdate;
    Dec(FLayoutLock);
    EndUpdate;
  end;
end;

function TBaseBindDBGridLink.CanActivate(Sender: TComponent): Boolean;
begin
  Result := (GetControlComponent <> nil) and (DataSource <> nil);
end;

constructor TBaseBindDBGridLink.Create(AOwner: TComponent);
begin
  inherited;
  FBindGridLink := TInternalBindGridLink.Create(Self);
end;

function TBaseBindDBGridLink.CreateColumns: TBaseDBGridLinkColumns;
begin
  Result := TBaseDBGridLinkColumns.Create(Self, TBaseDBGridLinkColumn);
end;

destructor TBaseBindDBGridLink.Destroy;
begin
  FBindGridLink.DisposeOf; // Scope component may be holding reference
  inherited;
end;

procedure TBaseBindDBGridLink.ClearColumns(
  AManager: IBindDBGridLinkControlManager);
begin
  AManager.ClearColumns;
end;

procedure TBaseBindDBGridLink.ClearGeneratedExpressions;
begin
  inherited;
  FBindGridLink.ColumnExpressions.Clear;
  FBindGridLink.FormatControlExpressions.Clear;
  FBindGridLink.ClearControlExpressions.Clear;
  FBindGridLink.PosSourceExpressions.Clear;
  FBindGridLink.PosControlExpressions.Clear;
end;

function TBaseBindDBGridLink.GetActive: Boolean;
begin
  Result := FBindGridLink.Active;
end;

function TBaseBindDBGridLink.GetBindDBColumnFactory(AGuid: TGuid): IInterface;
begin
  if ControlComponent <> nil then
    Result := Data.Bind.DBLinks.GetBindDBColumnFactory(AGuid, ControlComponent);
end;

function TBaseBindDBGridLink.GetBindDBColumnManager: IBindDBGridLinkControlManager;
begin
  Supports(GetBindDBColumnFactory(IBindDBGridLinkControlManager), IBindDBGridLinkControlManager, Result);
end;

function TBaseBindDBGridLink.GetBufferCount: Integer;
begin
  Result := FBindGridLink.BufferCount;
end;

function TBaseBindDBGridLink.GetComponentState: TComponentState;
begin
  Result := Self.ComponentState;
end;

function TBaseBindDBGridLink.GetDataSet: TDataSet;
begin
  Result := nil;
  if DataSource <> nil then
    if DataSource.DataSource <> nil then
      Result := DataSource.DataSource.DataSet;
end;

function TBaseBindDBGridLink.GetDefaultFields: Boolean;
begin
  Result := True;
  if GetDataSet <> nil then Result := GetDataSet.DefaultFields;
end;

function TBaseBindDBGridLink.GetDelegates: TArray<TCommonBindComponent>;
begin
  Result := TArray<TCommonBindComponent>.Create(FBindGridLink);
end;

function TBaseBindDBGridLink.GetAutoActivate: Boolean;
begin
  Result := FBindGridLink.AutoActivate;
end;

function TBaseBindDBGridLink.GetReadOnly: Boolean;
begin
  Result := False;
end;

procedure TBaseBindDBGridLink.InvalidateColumn(AColumn: TBaseDBGridLinkColumn);
begin
   LayoutChanged;
end;

procedure TBaseBindDBGridLink.InvalidateField(AField: TField);
begin
   LayoutChanged;
end;

{ InternalLayout is called with layout locks and column locks in effect }
procedure TBaseBindDBGridLink.InternalLayout;

begin
  if ([csLoading, csDestroying] * ComponentState) <> [] then Exit;

  UpdateColumns;
  FBindGridLink.ResetColumns;

end;

procedure TBaseBindDBGridLink.LayoutChanged;
begin
  if AcquireLayoutLock then
    EndLayout;
end;

procedure TBaseBindDBGridLink.Loaded;
begin
  inherited;
  FBindGridLink.Loaded;
end;

procedure TBaseBindDBGridLink.Notification(AComponent: TComponent;
  Operation: TOperation);
var
  NeedLayout: Boolean;
  I: Integer;
  LDataSet: TDataSet;
  LBaseDBGridLinkColumn: TBaseDBGridLinkColumn;
begin
  inherited;
  if (Operation = opRemove) then
  begin
      if (AComponent is TField) then
      begin
        LDataSet := GetDataSet;
        NeedLayout := (LDataSet <> nil) and (not (csDestroying in LDataSet.ComponentState));
        if NeedLayout then
          BeginLayout;
        try
          for I := 0 to GetColumns.Count-1 do
          begin
            LBaseDBGridLinkColumn := GetColumns.BaseItems[I];
            if LBaseDBGridLinkColumn.Field = AComponent then
              LBaseDBGridLinkColumn.Field := nil;
          end;
        finally
          if NeedLayout then
            EndLayout
        end;
      end;
  end;
end;

procedure TBaseBindDBGridLink.SetActive(Value: Boolean);
begin
  BindGridLink.Active := Value;
end;

procedure TBaseBindDBGridLink.SetAutoActivate(const Value: Boolean);
begin
  FBindGridLink.AutoActivate := Value;
end;

procedure TBaseBindDBGridLink.SetBufferCount(const Value: Integer);
begin
  FBindGridLink.BufferCount := Value;
end;

{ TDBGridLinkColumnCollection }

constructor TBaseDBGridLinkColumns.Create(Grid: TComponent; ColumnClass: TBaseDBGridLinkColumnClass);
begin
  inherited Create(ColumnClass);
  FGrid := Grid;
end;

function TBaseDBGridLinkColumns.Add: TBaseDBGridLinkColumn;
begin
  Result := TBaseDBGridLinkColumn(inherited Add);
end;

function TBaseDBGridLinkColumns.GetColumn(Index: Integer): TBaseDBGridLinkColumn;
begin
  Result := TBaseDBGridLinkColumn(inherited Items[Index]);
end;

function TBaseDBGridLinkColumns.GetOwner: TPersistent;
begin
  Result := FGrid;
end;

procedure TBaseDBGridLinkColumns.LoadFromFile(const Filename: string);
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
    FColumns: TBaseDBGridLinkColumns;
  published
    property Columns: TBaseDBGridLinkColumns read FColumns write FColumns;
  end;

procedure TBaseDBGridLinkColumns.LoadFromStream(S: TStream);
var
  Wrapper: TColumnsWrapper;
begin
  Wrapper := TColumnsWrapper.Create(nil);
  try
    Wrapper.Columns := (FGrid as ICustomDBGrid).CreateColumns;
    S.ReadComponent(Wrapper);
    Assign(Wrapper.Columns);
  finally
    {$IFNDEF NEXTGEN}
    Wrapper.Columns.Free;
    {$ENDIF}
    Wrapper.Free;
  end;
end;

procedure TBaseDBGridLinkColumns.RestoreDefaults;
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

function TBaseDBGridLinkColumns.GetDataSet: TDataSet;
begin
  Result := (FGrid as ICustomDBGrid).DataSet;
end;

function TBaseDBGridLinkColumns.GetGridIntf: ICustomDBGrid;
begin
  Supports(Grid, ICustomDBGrid, Result)
end;

procedure TBaseDBGridLinkColumns.RebuildColumns;

  procedure AddFields(Fields: TFields; Depth: Integer);
  var
    I: Integer;
  begin
    Inc(Depth);
    for I := 0 to Fields.Count-1 do
    begin
      Add.FieldName := Fields[I].FullName;
      if Fields[I].DataType in [ftADT, ftArray] then
        AddFields((Fields[I] as TObjectField).Fields, Depth);
    end;
  end;

begin
  if GetDataSet <> nil then
  begin
    //FGrid.BeginLayout;
    try
      Clear;
      AddFields(GetDataSet.Fields, 0);
    finally
      //FGrid.EndLayout;
    end
  end
  else
    Clear;
end;

procedure TBaseDBGridLinkColumns.SaveToFile(const Filename: string);
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

procedure TBaseDBGridLinkColumns.SaveToStream(S: TStream);
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

procedure TBaseDBGridLinkColumns.SetColumn(Index: Integer; Value: TBaseDBGridLinkColumn);
begin
  Items[Index].Assign(Value);
end;

procedure TBaseDBGridLinkColumns.SetState(NewState: TDBGridLinkColumnsState);
begin
  if NewState = State then Exit;
  if NewState = csDefault then
    Clear
  else
    RebuildColumns;
end;

procedure TBaseDBGridLinkColumns.Update(Item: TCollectionItem);
var
  Grid: ICustomDBGrid;
begin
  Grid := GetGridIntf;
  if (FGrid = nil) or (csLoading in FGrid.ComponentState) then Exit;
  if Item = nil then
  begin
    Grid.LayoutChanged;
  end
  else
  begin
    Grid.InvalidateColumn(TBaseDBGridLinkColumn(Item));
  end;
end;

function TBaseDBGridLinkColumns.Updating: Boolean;
begin
  Result := Self.UpdateCount > 0;
end;

function TBaseDBGridLinkColumns.GetState: TDBGridLinkColumnsState;
begin
  Result := TDBGridLinkColumnsState((Count > 0) and BaseItems[0].IsStored);
end;


{ TDBGridLinkColumn }

constructor TBaseDBGridLinkColumn.Create(Collection: TCollection);
var
  Grid: ICustomDBGrid;
begin
  if Assigned(Collection) and (Collection is TBaseDBGridLinkColumns) then
    Grid := TBaseDBGridLinkColumns(Collection).GetGridIntf;
  if Assigned(Grid) then Grid.BeginLayout;
  try
    inherited Create(Collection);
    Initialize;
  finally
    if Assigned(Grid) then Grid.EndLayout;
  end;
end;

destructor TBaseDBGridLinkColumn.Destroy;
begin
  inherited Destroy;
end;

procedure TBaseDBGridLinkColumn.Initialize;
begin
  FStored := True;
end;

procedure TBaseDBGridLinkColumn.Assign(Source: TPersistent);
begin
  if Source is TBaseDBGridLinkColumn then
  begin
    if Assigned(Collection) then Collection.BeginUpdate;
    try
      RestoreDefaults;
      FieldName := TBaseDBGridLinkColumn(Source).FieldName;
    finally
      if Assigned(Collection) then Collection.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

function TBaseDBGridLinkColumn.DefaultAlignment: TAlignment;
begin
  if Assigned(Field) then
    Result := FField.Alignment
  else
    Result := taLeftJustify;
end;

function TBaseDBGridLinkColumn.GetField: TField;
var
  Grid: ICustomDBGrid;
begin    { Returns Nil if FieldName can't be found in dataset }
  Grid := GetGridIntf;
  if (FField = nil) and (FFieldName.Length > 0) and Assigned(Grid) and
    Assigned(Grid.DataSet) then
    if Grid.Dataset.Active or (not Grid.Dataset.DefaultFields) then
      SetField(Grid.Dataset.FindField(FieldName));
  Result := FField;
end;

function TBaseDBGridLinkColumn.GetGrid: TComponent;
begin
  if Assigned(Collection) and (Collection is TBaseDBGridLinkColumns) then
    Result := TBaseDBGridLinkColumns(Collection).Grid
  else
    Result := nil;
end;

function TBaseDBGridLinkColumn.GetGridIntf: ICustomDBGrid;
begin
  if Assigned(Collection) and (Collection is TBaseDBGridLinkColumns) then
    Result := TBaseDBGridLinkColumns(Collection).GetGridIntf
  else
    Result := nil;
end;

function TBaseDBGridLinkColumn.GetDisplayName: string;
begin
  Result := FFieldName;
  if Result = '' then Result := inherited GetDisplayName;
end;

function TBaseDBGridLinkColumn.GetParentColumn: TBaseDBGridLinkColumn;
var
  Col: TBaseDBGridLinkColumn;
  Fld: TField;
  I: Integer;
begin
  Result := nil;
  Fld := Field;
  if (Fld <> nil) and (Fld.ParentField <> nil) and (Collection <> nil) then
    for I := Index - 1 downto 0 do
    begin
      Col := TBaseDBGridLinkColumn(Collection.Items[I]);
      if Fld.ParentField = Col.Field then
      begin
        Result := Col;
        Exit;
      end;
    end;
end;


procedure TBaseDBGridLinkColumn.RestoreDefaults;
begin
end;

procedure TBaseDBGridLinkColumn.SetField(Value: TField);
begin
  if FField = Value then Exit;
  if Assigned(FField) and (GetGrid <> nil) then
    FField.RemoveFreeNotification(GetGrid);
  if Assigned(Value) and (csDestroying in Value.ComponentState) then
    Value := nil;    // don't acquire references to fields being destroyed
  FField := Value;
  if Assigned(Value) then
  begin
    if GetGrid <> nil then
      FField.FreeNotification(GetGrid);
    FFieldName := Value.FullName;
  end;
  if not IsStored then
  begin
    if Value = nil then
      FFieldName := '';
    RestoreDefaults;
  end;
  Changed(False);
end;

procedure TBaseDBGridLinkColumn.SetFieldName(const Value: string);
var
  AField: TField;
  Grid: ICustomDBGrid;
begin
  AField := nil;
  Grid := GetGridIntf;
  if Assigned(Grid) and Assigned(Grid.DataSet) and
    not (csLoading in Grid.ComponentState) and (Value.Length > 0) then
      AField := Grid.DataSet.FindField(Value); { no exceptions }
  FFieldName := Value;
  SetField(AField);
  Changed(False);
end;

procedure TBaseDBGridLinkColumn.SetIndex(Value: Integer);
var
  LLayout: Boolean;
  Grid: ICustomDBGrid;
  I, OldIndex: Integer;
begin
  OldIndex := Index;
  Grid := GetGridIntf;

  if IsStored then
  begin
    LLayout := False;
    if  Assigned(Collection) and (Collection is TBaseDBGridLinkColumns) then
      if not TBaseDBGridLinkColumns(Collection).Updating then
      begin
        Grid.BeginLayout;
        LLayout := True;
      end;
    try
      I := OldIndex + 1;  // move child columns along with parent
      while (I < Collection.Count) and (TBaseDBGridLinkColumn(Collection.Items[I]).ParentColumn = Self) do
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
  end
  else
    Assert(False);
end;


{ TBindDBColumnFactory }

constructor TBindDBColumnFactory.Create;
begin
//
end;

{ TDBGridLinkColumnExpressionPair }

constructor TDBGridLinkColumnExpressionPair.Create(const AControlExpression,
  ASourceExpression: string);
begin
  FControlExpression := AControlExpression;
  FSourceExpression := ASourceExpression;
end;

{ TDBGridLinkColumnDescription }

constructor TDBGridLinkColumnDescription.Create(AColumnControl: TComponent; const AColumnName: string;
  AColumnIndex: Integer; const AControlMemberName, ASourceMemberName: string;
  AFormatColumnExpressions, AFormatCellExpressions,
  AParseCellExpression: TArray<TDBGridLinkColumnExpressionPair>);
begin
  FColumnControl := AColumnControl;
  FColumnName := AColumnName;
  FColumnIndex := AColumnIndex;
  FControlMemberName := AControlMemberName;
  FSourceMemberName := ASourceMemberName;
  FFormatColumnExpressions := AFormatColumnExpressions;
  FFormatCellExpressions := AFormatCellExpressions;
  FParseCellExpressions := AParseCellExpression;
end;

function TDBGridLinkColumnDescription.IsEqual(
  const ADescription: TDBGridLinkColumnDescription): Boolean;

  function SameExpressions(AExpr1, AExpr2: TArray<TDBGridLinkColumnExpressionPair>): Boolean;
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
    SameExpressions(Self.FFormatCellExpressions, ADescription.FFormatCellExpressions) and
    SameExpressions(Self.FFormatColumnExpressions, ADescription.FFormatColumnExpressions) and
    SameExpressions(Self.FParseCellExpressions, ADescription.FParseCellExpressions);

end;

{ TBaseBindDBControlLink }


function TBaseBindDBControlLink.GetControlComponent: TComponent;
begin
  if GetDelegates[0] = nil then
    Result := nil
  else
    Result := GetDelegates[0].ControlComponent;
end;

function TBaseBindDBControlLink.GetSourceControl: TCustomBindSourceDB;
begin
  if GetDelegates[0].SourceComponent <> nil then
    Result := GetDelegates[0].SourceComponent as TCustomBindSourceDB
  else
    Result := nil;
end;

function TBaseBindDBControlLink.GetSourceMember: string;
begin
  Result := GetDelegates[0].SourceMemberName;
end;

procedure TBaseBindDBControlLink.SetActive(AValue: Boolean);
begin
 //
end;

procedure TBaseBindDBControlLink.SetControlComponent(const Value: TComponent);
begin
  GetDelegates[0].ControlComponent := Value;
end;

procedure TBaseBindDBControlLink.SetSourceControl(
  const Value: TCustomBindSourceDB);
begin
  GetDelegates[0].SourceComponent := Value;
end;

procedure TBaseBindDBControlLink.SetSourceMember(const Value: string);
begin
  GetDelegates[0].SourceMemberName := Value;
end;

initialization
  FBindDBColumnFactories := TList<TBindDBColumnFactoryClass>.Create;

finalization
  FBindDBColumnFactories.Free;

end.
