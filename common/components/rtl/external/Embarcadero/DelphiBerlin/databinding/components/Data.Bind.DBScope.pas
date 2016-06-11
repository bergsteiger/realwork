{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{$HPPEMIT LINKUNIT}
unit Data.Bind.DBScope;

interface

uses
  System.Classes, System.SysUtils, Data.DB, Data.Bind.Components,
  System.Bindings.Helper, System.Generics.Collections, System.Bindings.CustomScope,
  System.Bindings.CustomWrapper, System.Bindings.Factories, System.Bindings.EvalProtocol,
  System.Rtti, Data.Bind.ObjectScope;

type
  TBindDataSetScope = class(TCustomScope)
  protected
    function DoLookup(const Name: String): IInterface; override;
  end;

  TBaseDataLink = class;

  TSubDataSource = class;

  // DataSource.DataSet defines the object scope
  TCustomBindSourceDB = class(TBaseLinkingBindSource, IScopeEditLink, IScopeRecordEnumerable, IScopeRecordEnumerableBuffered,
    IScopeNavigator, IScopeActive, IScopeState, IScopeEditor, IScopeMemberNames, IScopeCurrentRecord,
    IScopeMemberScripting, IScopeGetRecord,
    IScopeLookup, IScopeNavigatorUpdates, IScopeBuffer, IScopeLocate, IScopeUnidirectional,
    IScopeMemberDisplayNames)
  private
    FCalcBufferCount: Boolean;
    FUnusedDataSource: TDataSource;
    FEnumerating: Integer;
    FMultiRecordChange: Boolean;
    FDataLink: TBaseDataLink;
    FDataSource: TDataSource;
    FDataLinks: TDictionary<TBasicBindComponent, TBaseDataLink>;
    FActiveChanged: TBindEventList;
    FDataSetChanged: TBindEventList;
    FEditingChanged: TBindEventList;
    FDataSetScrolled: TBindEventList1<Integer>;
    FApplyMaxErrors: Integer;
    FResetNeeded: Boolean;
    function CheckDataSet: Boolean;
    procedure OnMasterChanged(Sender: TObject);
    procedure OnMasterDisabled(Sender: TObject);
    procedure OnActiveChanged(Sender: TObject);
    procedure OnDataSetChanged(Sender: TObject);
    procedure OnDataSetScrolled(Sender: TObject; ADistance: Integer);
    procedure OnEditingChanged(Sender: TObject);
    procedure OnIndexFieldChanged(Sender: TObject);
    function GetDataSet: TDataSet;
    procedure SetDataSet(const Value: TDataSet);
    procedure GetRowMember(ARow: Integer; const AMemberName: string; ACallback: TProc<TObject>);
    function GetDataComponent: TComponent;
    procedure SetDataComponent(AComponent: TComponent);
    function CreateSubDataSource: TDataSource;
    procedure SetLinks(Value: TDatasource);
    function IsDataSetStored: Boolean;
  protected
    procedure Loaded; override;
    procedure SetDataSource(const Value: TDataSource);
    function GetDataSource: TDataSource;
    function GetValue: TObject; override;
    function GetMember(const AMemberName: string): TObject; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure AddExpression(AExpression: TBasicBindComponent); override;
    procedure RemoveExpression(AExpression: TBasicBindComponent); override;
    { IScopeLocate }
    function Locate(const KeyFields: string; const KeyValues: TValue): Boolean;
    { IScopeLookup }
    function Lookup(const KeyFields: string; const KeyValues: TValue;
      const ResultFields: string): TValue;
    procedure GetLookupMemberNames(AList: TStrings);
    { IScopeEditLink }
    function Edit(ABindComp: TBasicBindComponent): Boolean;overload;  virtual;
    function GetIsEditing(ABindComp: TBasicBindComponent): Boolean; virtual;
    procedure SetModified(ABindComp: TBasicBindComponent); virtual;
    function GetIsModified(ABindComp: TBasicBindComponent): Boolean; virtual;
    function GetCanModify(ABindComp: TBasicBindComponent): Boolean; overload; virtual;
    procedure UpdateRecord(ABindComp: TBasicBindComponent); virtual;
    procedure Reset(ABindComp: TBasicBindComponent); virtual;
    procedure SetReadOnly(ABindComp: TBasicBindComponent; const Value: Boolean); virtual;
    procedure SetField(ABindComp: TBasicBindComponent; const FieldName: string); virtual;
    procedure ClearModified(ABindComp: TBasicBindComponent); virtual;
    procedure PosChanging(ABindComp: TBasicBindComponent); virtual;
    { IScopeRecordEnumerable }
    function GetEnumerator(const AMemberName: string; ABufferCount: Integer): IScopeRecordEnumerator; overload;
    { IScopeRecordEnumerableBuffered }
    function GetEnumerator(const AMemberName: string; ABuffered: Boolean): IScopeRecordEnumerator; overload;
    { IScopeNavigator }
    function GetBOF: Boolean; virtual;
    function GetEOF: Boolean; virtual;
    function GetSelected: Boolean; virtual;
    procedure Next; virtual;
    procedure Prior; virtual;
    procedure First; virtual;
    procedure Last; virtual;
    { IScopeNavigatorUpdates }
    procedure ApplyUpdates; virtual;
    function GetCanApplyUpdates: Boolean; virtual;
    function GetCanCancelUpdates: Boolean; virtual;
    procedure CancelUpdates; virtual;
    { IScopeBuffer }
    function GetBufferCount(out ABufferCount: Integer): Boolean;
    { IScopeActive }
    function GetActive: Boolean; virtual;
    { IScopeState }
    function GetCanModify: Boolean; overload; virtual;
    function GetCanDelete: Boolean; virtual;
    function GetCanInsert: Boolean; virtual;
    function GetCanRefresh: Boolean; virtual;
    function GetEditing: Boolean; virtual;
    procedure AddActiveChanged(LNotify: TNotifyEvent); virtual;
    procedure RemoveActiveChanged(LNotify: TNotifyEvent); virtual;
    procedure AddEditingChanged(LNotify: TNotifyEvent); virtual;
    procedure RemoveEditingChanged(LNotify: TNotifyEvent); virtual;
    procedure AddDataSetScrolled(LNotify: TNotifyDistanceEvent); virtual;
    procedure RemoveDataSetScrolled(LNotify: TNotifyDistanceEvent); virtual;
    procedure AddDataSetChanged(LNotify: TNotifyEvent); virtual;
    procedure RemoveDataSetChanged(LNotify: TNotifyEvent); virtual;
    { IScopeEditor }
    procedure Insert; virtual;
    procedure Delete; virtual;
    procedure Cancel; virtual;
    procedure Post; virtual;
    procedure Edit; overload; virtual;
    procedure Refresh; virtual;
    function IsValidChar(const AFieldName: string; const AChar: Char): Boolean;
    function IsRequired(const AFieldName: string): Boolean;
    { IScopeMemberNames }
    procedure GetMemberNames(AList: TStrings); virtual;
    { IScopeMemberDisplayNames }
    function GetMemberDisplayName(const AMemberName: string; out ADisplayName: string): Boolean;
    { IScopeCurrentRecord }
    function GetCurrentRecord(const AMemberName: string): IScope;
    { IScopeMemberScripting }
    function GetMemberGetter(const AMemberName: string; var AGetter: string): Boolean;
    function GetMemberSetter(const AMemberName: string; var ASetter: string): Boolean;
    function GetMemberType(const AMemberName: string; var AType: TScopeMemberType): Boolean;
    function GetPositionGetter(
      var AGetter: string; var ABase: Integer): Boolean;
    function GetPositionSetter(
      var ASetter: string; var ABase: Integer): Boolean;
    { IScopeGetRecord }
    procedure GetRecord(ARow: Integer; const AMemberName: string; ACallback: TProc<IScope>);
    { IScopeUnidirectionl }
    function GetIsUnidirectional: Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function IsDataComponent(AComponent: TComponent): Boolean; static;
    // Cause linked control to reset on next data change
    procedure ResetNeeded;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DataSet: TDataSet read GetDataSet write SetDataSet stored IsDataSetStored;
    property DataComponent: TComponent read GetDataComponent write SetDataComponent;
    [Default(-1)]
    property ApplyMaxErrors: Integer read FApplyMaxErrors write FApplyMaxErrors default -1;
  end;

  TCustomBindScopeDB = TCustomBindSourceDB; // for backward compatability
  TBindScopeDB = class(TCustomBindSourceDB)
  private
    procedure ReadPosition(Reader: TReader);
  protected
    // Backward compatability
    procedure DefineProperties(Filer: TFiler); override;
  published
    property DataSource;
    property DataSet;
    property ScopeMappings;
  end;

  TBindSourceDB = class(TCustomBindSourceDB)
  published
    property DataSource;
    property DataSet;
    property ScopeMappings;
  end;

  // publish all properties for now
  TSubDataSource = class(TDataSource)
  private
    function GetDataSet: TDataSet;
  public
    destructor Destroy; override;
  published
    [Stored(False)]
    property DataSet: TDataSet read GetDataSet stored False;
  end;

  TBaseDataLink = class(TDataLink)
  protected
    function Edit: Boolean; virtual;
  end;

  TBindScopeDBEnumerator = class(TInterfacedObject, IScopeRecordEnumerator,
    IScopeRecordEnumeratorCount, IScopeRecordEnumeratorStatus, IScopeRecordEnumeratorEvalShortcut)
  private
    FBuffered: Boolean;
    FMemberName: string;
    FCalcBuffer: Boolean;
    FBindScope: TCustomBindSourceDB;
    FFetchCount: Integer;
    FSaveFetchRecNo: Integer;
    FSaveActiveRecord: Integer;
    FNextActiveRecord: Integer;
    FMultiRecordChange: Boolean;
    FMaxRecordCount: Integer;
    { IScopeRecordEnumeratorEvalShortcut }
    procedure GetMemberValue(const AMemberName: string;  const AType: TScopeMemberType;
      const ACallback: TValueCallback);  overload;
    function GetMemberValue(const AMemberName: string;  const ATypes: array of TScopeMemberType; out AValue: TValue): Boolean; overload;
    function CanGetMemberValue(const AMemberName: string; AType: TScopeMemberType): Boolean;
    function GetSupportedTypes(AFieldType: TFieldType): TScopeMemberTypes;
  protected
    function GetMultiRecordChange: Boolean;
    procedure First;
    function GetCurrent: IScope;
    function GetRecordCount: Integer;
    function GetMemberCurrent(const AMemberName: string): IScope;
    function MoveNext: Boolean;
    property Current: IScope read GetCurrent;
  public
    constructor Create(ABindScope: TCustomBindSourceDB; const AMemberName: string;
      ABufferCount: Integer); overload;
    constructor Create(ABindScope: TCustomBindSourceDB; const AMemberName: string;
      ABuffered: Boolean); overload;
    destructor Destroy; override;
  end;

  TBaseRemoteAdapter = class(TBindSourceAdapter)
  private
  protected
    function SupportsNestedFields: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure AddField(AField: TBindSourceAdapterField);
  end;

implementation

uses System.Bindings.Outputs, System.Bindings.Methods, Data.Bind.Consts,
  System.Bindings.ObjEval, System.Variants, System.TypInfo, System.Math;

type
  TScopeDataLink = class(TBaseDataLink)
  private
    FMasterDataLink: TMasterDataLink;
    [weak] FDBScopeComponent: TCustomBindSourceDB;
    FOnDataSetChanged: TNotifyEvent;
    FOnEditingChanged: TNotifyEvent;
    FOnActiveChanged: TNotifyEvent;
    FOnDataSetScrolled: TNotifyDistanceEvent;
    FOnMasterChanged: TNotifyEvent;
    FOnMasterDisabled: TNotifyEvent;
    FOnIndexFieldChanged: TNotifyEvent;
    procedure MasterChanged(Sender: TObject);
    procedure MasterDisabled(Sender: TObject);
  protected
    procedure RecordChanged(Field: TField); override;
  public
    constructor Create(ADBScopeComponent: TCustomBindSourceDB);
    destructor Destroy; override;
    procedure DataSetChanged; override;
    procedure ActiveChanged; override;
    procedure EditingChanged; override;
    procedure DataSetScrolled(Distance: Integer); override;
    property OnDataSetChanged: TNotifyEvent read FOnDataSetChanged write FOnDataSetChanged;
    property OnDataSetScrolled: TNotifyDistanceEvent read FOnDataSetScrolled write FOnDataSetScrolled;
    property OnActiveChanged: TNotifyEvent read FOnActiveChanged write FOnActiveChanged;
    property OnEditingChanged: TNotifyEvent read FOnEditingChanged write FOnEditingChanged;
    property OnMasterChanged: TNotifyEvent read FOnMasterChanged write FOnMasterChanged;
    property OnMasterDisabled: TNotifyEvent read FOnMasterDisabled write FOnMasterDisabled;
    property OnIndexFieldChanged: TNotifyEvent read FOnIndexFieldChanged write FOnIndexFieldChanged;
  end;

  TScopeMasterDataLink = class(TMasterDataLink)
  protected
    procedure CheckBrowseMode; override;
  end;

  TBindLinkDataLink = class(TBaseDataLink)
  strict private
    [weak] FOwner: TCustomBindSourceDB;
    FBindLink: IBindLink;
    FBindLayoutChanged: IBindLayoutChanged;
    FBindPosition: IBindPosition;
    FBindListUpdate: IBindListUpdate;
    FEditing: Boolean;
    FField: TField;
    FFieldName: string;
    FModified: Boolean;
    FRefreshNeeded: Boolean;
    function GetCanModify: Boolean;
  private
    function GetField: TField;
    procedure SetEditing(Value: Boolean);
    function GetFieldName: string;
    procedure SetField(Value: TField);
    procedure SetFieldName(Value: string);
    procedure UpdateField;
    procedure ChangeApplied(Field: TField);
  protected
    procedure RecordChanged(Field: TField); override;
    procedure DataEvent(Event: TDataEvent; Info: NativeInt); override;
    procedure DataSetChanged; override;
    procedure DataSetScrolled(ADistance: Integer); override;
    procedure LayoutChanged; override;
    procedure ActiveChanged; override;
    procedure EditingChanged; override;
    procedure UpdateData; override;
    function Edit: Boolean; override;
  public
    constructor Create(AOwner: TCustomBindSourceDB; ABindLink: IBindLink); overload;
    constructor Create(AOwner: TCustomBindSourceDB; ABindPosition: IBindPosition); overload;
    constructor Create(AOwner: TCustomBindSourceDB; ABindListUpdate: IBindListUpdate); overload;
    procedure Modified;
    function IsModified: Boolean;
    procedure ClearModified;
    procedure RefreshNeeded;
    procedure Reset;
    property CanModify: Boolean read GetCanModify;
    property Editing: Boolean read FEditing;
    property Field: TField read GetField;
  end;

constructor TBindLinkDataLink.Create(AOwner: TCustomBindSourceDB; ABindLink: IBindLink);
begin
  inherited Create;
  FOwner := AOwner;
  FBindLink := ABindLink;
  FFieldName := '';
  Supports(FBindLink, IBindPosition, FBindPosition);
  Supports(FBindLink, IBindListUpdate, FBindListUpdate);
  Supports(FBindLink, IBindLayoutChanged, FBindLayoutChanged);
end;

constructor TBindLinkDataLink.Create(AOwner: TCustomBindSourceDB; ABindPosition: IBindPosition);
begin
  inherited Create;
  FOwner := AOwner;
  FBindPosition := ABindPosition;
  FFieldName := '';
  Supports(FBindPosition, IBindLink, FBindLink);
  Supports(FBindPosition, IBindListUpdate, FBindListUpdate);
  Supports(FBindPosition, IBindLayoutChanged, FBindLayoutChanged);
end;

procedure TBindLinkDataLink.ClearModified;
begin
  FModified := False;
end;

constructor TBindLinkDataLink.Create(AOwner: TCustomBindSourceDB; ABindListUpdate: IBindListUpdate);
begin
  inherited Create;
  FOwner := AOwner;
  FBindListUpdate := ABindListUpdate;
  FFieldName := '';
  Supports(FBindListUpdate, IBindLink, FBindLink);
  Supports(FBindListUpdate, IBindPosition, FBindPosition);
  Supports(FBindListUpdate, IBindLayoutChanged, FBindLayoutChanged);
end;

procedure TBindLinkDataLink.SetField(Value: TField);
begin
  if FField <> Value then
  begin
    FField := Value;
    EditingChanged;
    RecordChanged(nil);
    //UpdateRightToLeft;
  end;
end;

procedure TBindLinkDataLink.SetFieldName(Value: string);
begin
  FFieldName := Value;
  UpdateField;
end;

procedure TBindLinkDataLink.ActiveChanged;
begin
  if FOwner.FEnumerating > 0 then  // Prevent reentry when using unidirectional datasets
    Exit;
  try
    UpdateField;
  except
    on E: Exception do
      // Don't raise exception while destroying
      if not ((DataSource <> nil) and (csDestroying in DataSource.ComponentState)) then
        raise;
  end;
end;

procedure TBindLinkDataLink.LayoutChanged;
begin
  if FBindLayoutChanged <> nil then
    FBindLayoutChanged.LayoutChanged;
  UpdateField;
end;

procedure TBindLinkDataLink.DataEvent(Event: TDataEvent; Info: NativeInt);
begin
  inherited;
  if Event = deFieldChange then
  begin
    if Boolean(Info) then
      UpdateField
    else
      FField := nil;
  end
  else if (Event = deDisabledStateChange) then
  begin
    if Boolean(Info) then
      UpdateField
    else
      FField := nil;
  end
  else if (Event = deParentScroll) then
  begin
    RefreshNeeded;
    DataSetChanged;
  end;

end;

procedure TBindLinkDataLink.DataSetChanged;
var
  LBindListRefresh: IBindListRefresh;
  LRefreshed: Boolean;
  LUpdated: Boolean;
begin
  if DataSet.IsUniDirectional then
    Exit;
  if FOwner.FEnumerating > 0 then // Prevent reentrancy
    Exit;
  LUpdated := False;
  if (FBindListUpdate <> nil) and Active and FBindListUpdate.Active then
  begin
    LRefreshed := False;
    if Supports(FBindListUpdate, IBindListRefresh, LBindListRefresh)  then
      // Don't refresh if we are setting the active record
      if LBindListRefresh.RefreshNeeded or FRefreshNeeded then
      begin
        FRefreshNeeded := False;
        LRefreshed := True;
        if not FOwner.GetPosLock then
        begin
          LBindListRefresh.RefreshList;
        end;
      end;
    if not LRefreshed then
    begin
      if (FBindPosition <> nil) and FBindPosition.Active then
      begin
        if Self.DataSource.DataSet.RecNo > 0 then
           FBindPosition.EvaluatePosControl;  // Needed
      end;
      FBindListUpdate.UpdateList;
      if (FBindPosition <> nil) and FBindPosition.Active then
      begin
        // Make sure new row is selected
        if Self.DataSource.DataSet.State = dsInsert then
           FBindPosition.EvaluatePosControl;  // Needed
      end;
    end;
    LUpdated := True;
  end
  else if (FBindPosition <> nil) and Active and FBindPosition.Active then
  begin
      if Self.DataSource.DataSet.RecNo > 0 then
        FBindPosition.EvaluatePosControl; // Needed
  end;
  if not LUpdated then
    RecordChanged(nil)
  else
    ChangeApplied(nil);
end;

procedure TBindLinkDataLink.DataSetScrolled(ADistance: Integer);
var
  LDataLink: TBindLinkDataLink;
begin
  LDataLink := Self;
  if Active then
    if FBindLink <> nil then
    begin
      if (FBindPosition <> nil) and (FBindPosition.Active) then
      begin
        // Must position grid to current record
        if LDataLink.DataSource.DataSet.RecNo > 0 then
          FBindPosition.EvaluatePosControl;
      end
      else
        RecordChanged(nil);
    end
    else if (FBindPosition <> nil) and (FBindPosition.Active) then
      if Active then
        if LDataLink.DataSource.DataSet.RecNo > 0 then
          FBindPosition.EvaluatePosControl;
end;

procedure TBindLinkDataLink.UpdateField;
var
  LFieldName: string;
begin
  LFieldName := GetFieldName;
  if (LFieldName = '') and (FField = nil) then
  begin
//    // No field name
//    RecordChanged(nil);
  end
  else
  begin
    if Active and (LFieldName <> '') then
    begin
      FField := nil;
      SetField(DataSource.DataSet.FindField(LFieldName));
    end
    else
      SetField(nil);
  end;
end;

function TBindLinkDataLink.GetFieldName: string;
begin
  if FBindLink <> nil then
    Result := FBindLink.SourceMemberName
  else if FBindPosition <> nil then
    Result := FBindPosition.SourceMemberName;
  if Result = '' then
    Result := FFieldName;
end;

function TBindLinkDataLink.IsModified: Boolean;
begin
  Result := FModified;
end;

function TBindLinkDataLink.Edit: Boolean;
begin
  if CanModify then inherited Edit;
  Result := FEditing;
end;

function TBindLinkDataLink.GetCanModify: Boolean;
begin
  Result := not ReadOnly and ((Field = nil) or Field.CanModify);
end;

function TBindLinkDataLink.GetField: TField;
begin
  Result := FField;
end;

procedure TBindLinkDataLink.Modified;
begin
  FModified := True;
end;

procedure TBindLinkDataLink.EditingChanged;
begin
  SetEditing(inherited Editing and CanModify);
end;

procedure TBindLinkDataLink.UpdateData;
begin
  if FBindLink <> nil then
    if not FBindLink.Updating then
    begin
      FBindLink.BeginUpdate;
      try
        if FModified then
        begin
         FBindLink.EvaluateParse('');
          FModified := False;
        end;
      finally
        FBindLink.EndUpdate;
      end;
    end;
end;

procedure TBindLinkDataLink.RecordChanged(Field: TField);

  procedure DoDataChange(Sender: TObject; AChangedField: TField);
  var
    LMemberName: string;
  begin
    if AChangedField <> nil then
      LMemberName := AChangedField.FieldName;
    if FBindLink <> nil then
    begin
     if (not FBindLink.Updating) or (FField = nil) then
      begin
        FBindLink.BeginUpdate;
        try
          if Active and (RecordCount > 0) then
            FBindLink.EvaluateFormat(LMemberName)
          else
            FBindLink.EvaluateClear(LMemberName)
        finally
          FBindLink.EndUpdate;
        end;
      end;
    end
  end;

begin
  if (Field = nil) or (Field = FField) then
    DoDataChange(Self, Field)
  else if FField = nil then
    DoDataChange(Self, nil);
  ChangeApplied(Field);
end;

procedure TBindLinkDataLink.ChangeApplied(Field: TField);
begin
  if (Field = nil) or (Field = FField) then
    FModified := False
  else if FField = nil then
    FModified := False;
end;

procedure TBindLinkDataLink.Reset;
begin
  RecordChanged(nil);
end;


procedure TBindLinkDataLink.RefreshNeeded;
begin
  FRefreshNeeded := True;
end;

procedure TBindLinkDataLink.SetEditing(Value: Boolean);
begin
  if FEditing <> Value then
  begin
    FEditing := Value;
    FModified := False;
  end;
end;

procedure TCustomBindSourceDB.AddActiveChanged(LNotify: TNotifyEvent);
begin
  FActiveChanged.Add(LNotify);
end;

procedure TCustomBindSourceDB.AddDataSetChanged(LNotify: TNotifyEvent);
begin
  FDataSetChanged.Add(LNotify);
end;

procedure TCustomBindSourceDB.AddDataSetScrolled(LNotify: TNotifyDistanceEvent);
begin
  FDataSetScrolled.Add(LNotify);
end;

procedure TCustomBindSourceDB.AddEditingChanged(LNotify: TNotifyEvent);
begin
  FEditingChanged.Add(LNotify);
end;

procedure TCustomBindSourceDB.AddExpression(AExpression: TBasicBindComponent);
var
  LBindLinkDataLink: TBindLinkDataLink;
  LBindLink: IBindLink;
  LBindPosition: IBindPosition;
begin
  inherited;
  if Supports(AExpression, IBindLink, LBindLink) then
  begin
    LBindLinkDataLink := TBindLinkDataLink.Create(Self, LBindLink);
    FDataLinks.AddOrSetValue(AExpression,
      LBindLinkDataLink);
    if Self.DataSource <> nil then
      LBindLinkDataLink.DataSource := Self.DataSource;
  end
  else if Supports(AExpression, IBindPosition, LBindPosition) then
  begin
    LBindLinkDataLink := TBindLinkDataLink.Create(Self, LBindPosition);
    FDataLinks.AddOrSetValue(AExpression,
      LBindLinkDataLink);
    if Self.DataSource <> nil then
      LBindLinkDataLink.DataSource := Self.DataSource;
  end;

end;

constructor TCustomBindSourceDB.Create(AOwner: TComponent);
var
  LDataLink: TScopeDataLink;
begin
  inherited;
  LDataLink := TScopeDataLink.Create(Self);
  FDataLink := LDataLink;
  LDataLink.OnActiveChanged := OnActiveChanged;
  LDataLink.OnDataSetChanged := OnDataSetChanged;
  LDataLink.OnDataSetScrolled := OnDataSetScrolled;
  LDataLink.OnActiveChanged := OnActiveChanged;
  LDataLink.OnEditingChanged := OnEditingChanged;
  LDataLink.OnMasterChanged := OnMasterChanged;
  LDataLink.OnMasterDisabled := OnMasterDisabled;
  LDataLink.OnIndexFieldChanged := OnIndexFieldChanged;
  FDataLinks := TObjectDictionary<TBasicBindComponent, TBaseDataLink>.Create([doOwnsValues]);
  FActiveChanged := TBindEventList.Create;
  FDataSetChanged := TBindEventList.Create;
  FEditingChanged := TBindEventList.Create;
  FDataSetScrolled := TBindEventList1<Integer>.Create;
  FApplyMaxErrors := -1;
  FCalcBufferCount := True;
  FDatasource := CreateSubDataSource; // Needed for loading properties

end;

procedure TCustomBindSourceDB.Delete;
begin
  if CheckDataSet then
    FDataSource.DataSet.Delete;
end;

destructor TCustomBindSourceDB.Destroy;
begin
  inherited; // Send Notification before free objects
  FreeAndNil(FDataLink);
  FreeAndNil(FDataLinks);
  FreeAndNil(FActiveChanged);
  FreeAndNil(FDataSetChanged);
  FreeAndNil(FEditingChanged);
  FreeAndNil(FDataSetScrolled);
end;

procedure TCustomBindSourceDB.Edit;
begin
  if CheckDataSet then
    FDataSource.DataSet.Edit;
end;

procedure TCustomBindSourceDB.OnEditingChanged(Sender: TObject);
begin
  FEditingChanged.Send(Self);
end;

procedure TCustomBindSourceDB.OnMasterChanged(Sender: TObject);
begin
  // When master is changed, refresh detail
  ResetNeeded;
end;

procedure TCustomBindSourceDB.OnMasterDisabled(Sender: TObject);
begin
  // When master is changed, refresh detail
  ResetNeeded;
end;

procedure TCustomBindSourceDB.OnIndexFieldChanged(Sender: TObject);
begin
  // When index field is changed, refresh because row order can change
  ResetNeeded;
end;

procedure TCustomBindSourceDB.OnActiveChanged(Sender: TObject);
begin
  FActiveChanged.Send(Self);
end;

procedure TCustomBindSourceDB.OnDataSetChanged(Sender: TObject);
begin
  FDataSetChanged.Send(Self);
end;

procedure TCustomBindSourceDB.OnDataSetScrolled(Sender: TObject; ADistance: Integer);
begin
  FDataSetScrolled.Send(Self, ADistance);
end;

function TCustomBindSourceDB.Edit(ABindComp: TBasicBindComponent): Boolean;
var
  LDataLink: TBaseDataLink;
begin
  if (FDataLinks <> nil) and FDataLinks.TryGetValue(ABindComp, LDataLink) then
  begin
    Assert(LDataLink <> nil);
    Result := LDataLink.Edit
  end
  else
    Result := False;
end;

function TCustomBindSourceDB.CheckDataSet: Boolean;
begin
  Result := (FDataSource <> nil) and (FDataSource.DataSet <> nil);
end;

procedure TCustomBindSourceDB.First;
begin
  if CheckDataSet then
    FDataSource.DataSet.First;
end;

procedure TCustomBindSourceDB.UpdateRecord(ABindComp: TBasicBindComponent);
var
  LDataLink: TBaseDataLink;
begin
  if (FDataLinks <> nil) and FDataLinks.TryGetValue(ABindComp, LDataLink) then
  begin
    Assert(LDataLink <> nil);
    LDataLink.UpdateRecord;
  end
end;

procedure TCustomBindSourceDB.Reset(ABindComp: TBasicBindComponent);
var
  LDataLink: TBaseDataLink;
begin
  if (FDataLinks <> nil) and FDataLinks.TryGetValue(ABindComp, LDataLink) then
  begin
    Assert(LDataLink <> nil);
    if LDataLink is TBindLinkDataLink then
      TBindLinkDataLink(LDataLink).Reset
  end
end;

procedure TCustomBindSourceDB.ResetNeeded;
var
  LDataLink: TBaseDataLink;
begin
  //FResetNeeded := True;
  if FDataLinks <> nil then
    for LDataLink in FDataLinks.Values do
      if LDataLink is TBindLinkDataLink then
         TBindLinkDataLink(LDataLink).RefreshNeeded;
end;

procedure TCustomBindSourceDB.SetModified(ABindComp: TBasicBindComponent);
var
  LDataLink: TBaseDataLink;
begin
  if (FDataLinks <> nil) and FDataLinks.TryGetValue(ABindComp, LDataLink) then
  begin
    Assert(LDataLink <> nil);
    if LDataLink is TBindLinkDataLink then
      TBindLinkDataLink(LDataLink).Modified
  end
end;

procedure TCustomBindSourceDB.ClearModified(ABindComp: TBasicBindComponent);
var
  LDataLink: TBaseDataLink;
begin
  if (FDataLinks <> nil) and FDataLinks.TryGetValue(ABindComp, LDataLink) then
  begin
    Assert(LDataLink <> nil);
    if LDataLink is TBindLinkDataLink then
      TBindLinkDataLink(LDataLink).ClearModified;
  end
end;

procedure TCustomBindSourceDB.SetReadOnly(ABindComp: TBasicBindComponent; const Value: Boolean);
var
  LDataLink: TBaseDataLink;
begin
  if (FDataLinks <> nil) and FDataLinks.TryGetValue(ABindComp, LDataLink) then
  begin
    Assert(LDataLink <> nil);
    if LDataLink is TBindLinkDataLink then
      TBindLinkDataLink(LDataLink).ReadOnly := Value;
  end
end;

function TCustomBindSourceDB.GetIsModified(ABindComp: TBasicBindComponent): Boolean;
var
  LDataLink: TBaseDataLink;
begin
  Result := False;
  if (FDataLinks <> nil) and FDataLinks.TryGetValue(ABindComp, LDataLink) then
  begin
    Assert(LDataLink <> nil);
    if LDataLink is TBindLinkDataLink then
      Result := TBindLinkDataLink(LDataLink).IsModified
  end
end;

function TCustomBindSourceDB.GetIsUnidirectional: Boolean;
begin
  Result := (DataSet <> nil) and (DataSet.IsUniDirectional);
end;

procedure TCustomBindSourceDB.GetLookupMemberNames(AList: TStrings);
begin
                                   
  GetMemberNames(AList);
end;

function TCustomBindSourceDB.GetIsEditing(ABindComp: TBasicBindComponent): Boolean;
var
  LDataLink: TBaseDataLink;
begin
  Result := False;
  if FDataLinks.TryGetValue(ABindComp, LDataLink) then
  begin
    Assert(LDataLink <> nil);
    if LDataLink is TBindLinkDataLink then
      Result := TBindLinkDataLink(LDataLink).Editing;
  end
end;

procedure TCustomBindSourceDB.Cancel;
begin
  if CheckDataSet then
    FDataSource.DataSet.Cancel;
end;

function TCustomBindSourceDB.GetCanModify(ABindComp: TBasicBindComponent): Boolean;
var
  LDataLink: TBaseDataLink;
begin
  Result := False;
  if (FDataLinks <> nil) and FDataLinks.TryGetValue(ABindComp, LDataLink) then
  begin
    Assert(LDataLink <> nil);
    if LDataLink is TBindLinkDataLink then
      Result := TBindLinkDataLink(LDataLink).CanModify
  end
end;

function TCustomBindSourceDB.GetActive: Boolean;
begin
  if Assigned(FDataSource) and Assigned(FDataSource.DataSet) then
    Result := FDataSource.DataSet.Active and FDataLink.Active
  else
    Result := FDataLink.Active;
end;

function TCustomBindSourceDB.GetBOF: Boolean;
begin
  if CheckDataSet then
    Result := FDataSource.DataSet.Bof
  else
    Result := True;

end;

function TCustomBindSourceDB.GetBufferCount(out ABufferCount: Integer): Boolean;
begin
  Result := False;
  if FDataSource <> nil then
    if FDataSource.DataSet <> nil then
      if FDataSource.DataSet.Active then
      begin
        Result := True;
        if not FDataSource.DataSet.IsUniDirectional then
          // Note.  RecordCount indicate the number of records that the DataSet has fetched.
          // Some datasets, like TClientDataSet, RecordCount = result row count.
          // For some datasets, like TFDQuery, RecordCount = fetched row count.  Use Last to fetch all records.
          // Add extra to that new row can be added
          ABufferCount := FDataSource.DataSet.RecordCount + 2;
      end;
end;

function TCustomBindSourceDB.GetCanModify: Boolean;
begin
  Result := False;
  if FDataSource <> nil then
    if FDataSource.DataSet <> nil then
      Result := FDataSource.DataSet.CanModify;
end;

function TCustomBindSourceDB.GetCanInsert: Boolean;
begin
  Result := GetCanModify;
end;

function TCustomBindSourceDB.GetCanDelete: Boolean;
begin
  Result := GetCanModify;
end;

function TCustomBindSourceDB.GetCanRefresh: Boolean;
begin
  Result := False;
  if FDataSource <> nil then
    if FDataSource.DataSet <> nil then
      Result := FDataSource.DataSet.CanRefresh;
end;

function TCustomBindSourceDB.GetCurrentRecord(const AMemberName: string): IScope;
begin
  if AMemberName <> '' then
    Result := GetMemberScope(AMemberName)
  else
    Result := GetScope;
end;

procedure TCustomBindSourceDB.GetRecord(ARow: Integer; const AMemberName: string; ACallback: TProc<IScope>);
begin
  GetRowMember(ARow, AMemberName,
    procedure(AObject: TObject)
    var
      LScope: IScope;
    begin
      LScope := WrapObject(AObject);
      LScope := AddScopeMappings(LScope);
      ACallback(LScope);
    end);
end;

function TCustomBindSourceDB.GetDataComponent: TComponent;
begin
  if (FDataSource <> nil) then
    if (not (csSubComponent in FDataSource.ComponentStyle)) then
      Exit(FDataSource)
    else
      Exit(FDataSource.DataSet);
  Result := nil;
end;

function TCustomBindSourceDB.GetDataSet: TDataSet;
begin
  if FDataSource <> nil then
    Result := FDataSource.DataSet
  else
    Result := nil;
end;

function TCustomBindSourceDB.GetDataSource: TDataSource;
begin
  Result := FDataSource;
end;

function TCustomBindSourceDB.GetEditing: Boolean;
begin
  Result := FDataLink.Editing;
end;

function TCustomBindSourceDB.GetEnumerator(
  const AMemberName: string; ABufferCount: Integer): IScopeRecordEnumerator;
var
  LEnumerator: TBindScopeDBEnumerator;
begin
  Assert(ABufferCount = -1); // expect all components to use -1
  LEnumerator := TBindScopeDBEnumerator.Create(Self, AMemberName, True (* Buffered *)); 
  LEnumerator.FMultiRecordChange := FMultiRecordChange or FResetNeeded;
  FResetNeeded := False;
  Result := LEnumerator;
end;

function TCustomBindSourceDB.GetEnumerator(
  const AMemberName: string; ABuffered: Boolean): IScopeRecordEnumerator;
var
  LEnumerator: TBindScopeDBEnumerator;
begin
  if FEnumerating > 0 then
    Result := nil  // prevent re-entrance
  else
  begin
    LEnumerator := TBindScopeDBEnumerator.Create(Self, AMemberName, ABuffered);
    LEnumerator.FMultiRecordChange := FMultiRecordChange or FResetNeeded;
    FResetNeeded := False;
    Result := LEnumerator;
  end;
end;

function TCustomBindSourceDB.GetEOF: Boolean;
begin
  if CheckDataSet then
    Result := FDataSource.DataSet.Eof
  else
    Result := True;
end;

function TCustomBindSourceDB.GetSelected: Boolean;
begin
  if CheckDataSet then
    Result := not (FDataSource.DataSet.Eof and FDataSource.DataSet.Bof)
  else
    Result := True;
end;

function TCustomBindSourceDB.GetMember(const AMemberName: string): TObject;
begin
  Result := nil;
  Assert(FDataSource <> nil);
  if FDataSource <> nil then
  begin
    Assert(FDataSource.DataSet <> nil);
    if FDataSource.DataSet.Active then
      // Raise exception if not found
      Result := FDataSource.DataSet.FieldByName(AMemberName);
  end;
end;

procedure TCustomBindSourceDB.GetRowMember(ARow: Integer; const AMemberName: string; ACallback: TProc<TObject>);
var
  LSaveActive: Integer;
  LObject: TObject;
begin
  LObject := nil;
  Assert(FDataSource <> nil);;
  if FDataSource <> nil then
  begin
    Assert(FDataSource.DataSet <> nil);
    if FDataSource.DataSet.Active then
    begin
      LSaveActive := FDataLink.ActiveRecord;
      FDataLink.ActiveRecord := ARow;
      try
        Assert(FDataSource.DataSet <> nil);
        if FDataSource.DataSet.Active then
          // Raise exception if not found
          LObject := FDataSource.DataSet.FieldByName(AMemberName);
        ACallback(LObject);
      finally
                                        
        FDataLink.ActiveRecord := LSaveActive;
      end;
    end;
  end;
end;

procedure TCustomBindSourceDB.ApplyUpdates;
var
  Intf: IDataSetCommandSupport;
begin
  if Supports(Self.DataSet, IDataSetCommandSupport, Intf) then
    Intf.ExecuteCommand(sApplyUpdatesDataSetCommand, [ApplyMaxErrors])
end;

function TCustomBindSourceDB.GetCanApplyUpdates: Boolean;
var
  Intf: IDataSetCommandSupport;
begin
  if Supports(Self.DataSet, IDataSetCommandSupport, Intf) then
    Result := dcEnabled in Intf.GetCommandStates(sApplyUpdatesDataSetCommand)
  else
    Result := False;
end;

procedure TCustomBindSourceDB.CancelUpdates;
var
  Intf: IDataSetCommandSupport;
begin
  if Supports(Self.DataSet, IDataSetCommandSupport, Intf) then
  begin
    Assert(not FMultiRecordChange);
    FMultiRecordChange := True;
    try
      Intf.ExecuteCommand(sCancelUpdatesDataSetCommand, [ApplyMaxErrors])
    finally
      FMultiRecordChange := False;
    end;
  end;
end;

function TCustomBindSourceDB.GetCanCancelUpdates: Boolean;
var
  Intf: IDataSetCommandSupport;
begin
  if Supports(Self.DataSet, IDataSetCommandSupport, Intf) then
    Result := dcEnabled in Intf.GetCommandStates(sCancelUpdatesDataSetCommand)
  else
    Result := False;
end;

const
  cSelf = 'Self';
  cText = 'Text';
  cAsInteger = cText; // Use Text, so get blank when nil
  cAsLargeInt = cText; // Use Text, so get blank when nil
  cAsBoolean = 'DBUtils_BoolValue(Self)'; // supports localized values for "True" and "False", and also blank when nil
  cAsLongWord = cText; // Use Text, so get blank when nil
  cAsFloat = cText; // Use text, instead of AsFloat, so that we get proper formatting
  cAsExtended = cText; // Use text, instead of AsExtended,  so that we get proper formatting
  cAsSingle = cText; // Use text, instead of AsSingle,  so that we get proper formatting
  cAsVariant = cText; // Use text, instead of AsVariant,  so that we get proper formatting
  cAsBCD = cText; // Use text to get proper precision
  cAsDateTime = cText; // Use text, instead of AsDate etc.,  so that we get proper formatting
  cAsString = 'AsString';

const
  DefaultMemberNames: array[TFieldType] of string = (
    cText, // nil,                       { ftUnknown }
    cText,  // TStringField,              { ftString }
    cAsInteger,  // TSmallintField,            { ftSmallint }
    cAsInteger,  // TIntegerField,             { ftInteger }
    cAsLongWord,  // TWordField,                { ftWord }
    cAsBoolean,  // TBooleanField,             { ftBoolean }
    cAsFloat,  // TFloatField,               { ftFloat }
    cAsFloat,  // TCurrencyField,            { ftCurrency }
    cAsBCD,  // TBCDField,                 { ftBCD }
    cAsDateTime,  // TDateField,                { ftDate }
    cAsDateTime,  // TTimeField,                { ftTime }
    cAsDateTime,  // TDateTimeField,            { ftDateTime }
    cText,  // TBytesField,               { ftBytes }
    cText,  // TVarBytesField,            { ftVarBytes }
    cAsLargeInt,  // TAutoIncField,             { ftAutoInc }
    cSelf,  // TBlobField,                { ftBlob }
    cAsString,  // TMemoField,                { ftMemo }
    cSelf,  // TGraphicField,             { ftGraphic }
    cAsString,  // TBlobField,                { ftFmtMemo }
    cSelf,  // TBlobField,                { ftParadoxOle }
    cSelf,  // TBlobField,                { ftDBaseOle }
    cSelf,  // TBlobField,                { ftTypedBinary }
    cSelf,  // nil,                       { ftCursor }
    cText,  // TStringField,              { ftFixedChar }
    cText,  // TWideStringField,          { ftWideString }
    cAsLargeInt,  // TLargeIntField,            { ftLargeInt }
    cText,  // TADTField,                 { ftADT }
    cText,  // TArrayField,               { ftArray }
    cSelf,  // TReferenceField,           { ftReference }
    cSelf,  // TDataSetField,             { ftDataSet }
    cSelf,  // TBlobField,                { ftOraBlob }
    cAsString,  // TMemoField,                { ftOraClob }
    cAsVariant,  // TVariantField,             { ftVariant }
    cSelf,  // TInterfaceField,           { ftInterface }
    cSelf,  // TIDispatchField,           { ftIDispatch }
    cText,  // TGuidField,                { ftGuid }
    cAsDateTime,  // TSQLTimeStampField,        { ftTimeStamp }
    cAsBCD,  // TFMTBcdField,              { ftFMTBcd }
    cText,  // TWideStringField,          { ftFixedWideChar }
    cAsString,  // TWideMemoField,            { ftWideMemo }
    cAsDateTime,  // TSQLTimeStampField,        { ftOraTimeStamp }
    cText,  // TStringField,              { ftOraInterval }
    cAsLongWord,  // TLongWordField,            { ftLongWord }
    cAsInteger,  // TShortintField,            { ftShortint }
    cAsLongWord,  // TByteField,                { ftByte }
    cAsExtended,  // TExtendedField,
    cSelf,  // nil,                       { ftConnection }
    cSelf,  // nil,                       { ftParams }
    cSelf,  // nil,                       { ftStream }
    cAsDateTime,  // TSQLTimeStampOffsetField,  { ftTimeStampOffset }
    cSelf,  // nil,                       { ftObject }
    cAsSingle  // TSingleField               { ftSingle }
    );

  DefaultMemberType: array[TFieldType] of TScopeMemberType = (
    mtUnknown, // nil,                       { ftUnknown }
    mtText,  // TStringField,              { ftString }
    mtInteger,  // TSmallintField,            { ftSmallint }
    mtInteger,  // TIntegerField,             { ftInteger }
    mtUInteger,  // TWordField,                { ftWord }
    mtBoolean,  // TBooleanField,             { ftBoolean }
    mtFloat,  // TFloatField,               { ftFloat }
    mtCurrency,  // TCurrencyField,            { ftCurrency }
    mtBCD,  // TBCDField,                 { ftBCD }
    mtDate,  // TDateField,                { ftDate }
    mtTime,  // TTimeField,                { ftTime }
    mtDateTime,  // TDateTimeField,            { ftDateTime }
    mtUnknown,  // TBytesField,               { ftBytes }
    mtUnknown,  // TVarBytesField,            { ftVarBytes }
    mtInteger,  // TAutoIncField,             { ftAutoInc }
    mtObject,  // TBlobField,                { ftBlob }
    mtMemo,  // TMemoField,                { ftMemo }
    mtBitmap,  // TGraphicField,             { ftGraphic }
    mtObject,  // TBlobField,                { ftFmtMemo }
    mtObject,  // TBlobField,                { ftParadoxOle }
    mtObject,  // TBlobField,                { ftDBaseOle }
    mtObject,  // TBlobField,                { ftTypedBinary }
    mtObject,  // nil,                       { ftCursor }
    mtText,  // TStringField,              { ftFixedChar }
    mtText,  // TWideStringField,          { ftWideString }
    mtInteger,  // TLargeIntField,            { ftLargeInt }
    mtText,  // TADTField,                 { ftADT } // Read only text
    mtObject,  // TArrayField,               { ftArray }
    mtObject,  // TReferenceField,           { ftReference }
    mtObject,  // TDataSetField,             { ftDataSet }
    mtObject,  // TBlobField,                { ftOraBlob }
    mtMemo,  // TMemoField,                { ftOraClob }
    mtVariant,  // TVariantField,             { ftVariant }
    mtObject,  // TInterfaceField,           { ftInterface }
    mtObject,  // TIDispatchField,           { ftIDispatch }
    mtText,  // TGuidField,                { ftGuid }
    mtDateTime,  // TSQLTimeStampField,        { ftTimeStamp }
    mtBCD,  // TFMTBcdField,              { ftFMTBcd }
    mtText,  // TWideStringField,          { ftFixedWideChar }
    mtMemo,  // TWideMemoField,            { ftWideMemo }
    mtDateTime,  // TSQLTimeStampField,        { ftOraTimeStamp }
    mtText,  // TStringField,              { ftOraInterval }
    mtUInteger,  // TLongWordField,            { ftLongWord }
    mtInteger,  // TShortintField,            { ftShortint }
    mtUInteger,  // TByteField,                { ftByte }
    mtFloat,  // TExtendedField,
    mtObject,  // nil,                       { ftConnection }
    mtObject,  // nil,                       { ftParams }
    mtObject,  // nil,                       { ftStream }
    mtDateTime,  // TSQLTimeStampOffsetField,  { ftTimeStampOffset }
    mtObject,  // nil,                       { ftObject }
    mtFloat  // TSingleField               { ftSingle }
    );

function TCustomBindSourceDB.GetMemberGetter(const AMemberName: string;
  var AGetter: string): Boolean;
var
  LField: TField;
begin
  Result := True;
  AGetter := cText; // do not localize
  if (FDataSource <> nil) and (FDataSource.DataSet <> nil) then
    if FDataSource.DataSet.Active then
    begin
                                                
      LField := FDataSource.DataSet.FindField(AMemberName);
      if (LField <> nil) then
        AGetter := DefaultMemberNames[LField.DataType];
    end;
end;

function TCustomBindSourceDB.GetMemberSetter(const AMemberName: string;
  var ASetter: string): Boolean;
var
  LField: TField;
begin
  Result := True;
  ASetter := cText; // do not localize
  if (FDataSource <> nil) and (FDataSource.DataSet <> nil) then
    if FDataSource.DataSet.Active then
    begin
      LField := FDataSource.DataSet.FindField(AMemberName);
      if LField <> nil then
        case LField.DataType of
          TFieldType.ftADT: // read only text field
            ASetter := '';
        else
          ASetter := DefaultMemberNames[LField.DataType];
        end;
    end;
end;

function TCustomBindSourceDB.GetMemberType(const AMemberName: string;
  var AType: TScopeMemberType): Boolean;
var
  LField: TField;
begin
  Result := True;
  AType := mtUnknown;

  if (FDataSource <> nil) and (FDataSource.DataSet <> nil) then
    if FDataSource.DataSet.Active then
    begin
      LField := FDataSource.DataSet.FindField(AMemberName);
      if (LField <> nil) then
        AType := DefaultMemberType[LField.DataType];
    end;
end;

function TCustomBindSourceDB.GetMemberDisplayName(const AMemberName: string; out ADisplayName: string): Boolean;
var
  LField: TField;
begin
  Result := False;
  if FDataSource.DataSet <> nil then
  begin
    if FDataSource.DataSet.Fields.Count > 0 then
    begin
      LField := DataSource.DataSet.FindField(AMemberName);
      if LField <> nil then
      begin
        if LField.DisplayName <> '' then
        begin
          Result := True;
          ADisplayName := LField.DisplayName;
        end;
      end;
    end;
    if (not Result) and (DataSource.DataSet.AggFields.Count > 0) then
    begin
      LField := DataSource.DataSet.AggFields.FindField(AMemberName);
      if LField.DisplayName <> '' then
      begin
        Result := True;
        ADisplayName := LField.DisplayName;
      end;
    end;
  end;
end;

procedure TCustomBindSourceDB.GetMemberNames(AList: TStrings);
var
  LField: TField;
begin
  if (FDataSource <> nil) and (FDataSource.DataSet <> nil) then
  begin
    try

      if not FDataSource.DataSet.Active then
      begin
        if FDataSource.DataSet.Fields.Count > 0 then
        begin
          for LField in DataSource.DataSet.Fields do
            if LField.FieldName <> '' then
              AList.AddObject(LField.FieldName, LField);
        end
        else
          AList.Assign(FDataSource.DataSet.FieldDefList)
      end
      else
        // Attempts to activate the dataset which can cause performance problems and exceptions when server is not available
        FDataSource.DataSet.GetFieldNames(AList);
      if DataSource.DataSet.AggFields.Count > 0 then
      begin
        for LField in DataSource.DataSet.AggFields do
          if LField.FieldName <> '' then
            AList.AddObject(LField.FieldName, LField);
      end;
    except
        // Ignore unconfigured dataset
        AList.Clear;
    end;
  end
  else
    AList.Clear;
end;

function TCustomBindSourceDB.GetPositionGetter(
  var AGetter: string; var ABase: Integer): Boolean;
begin
  AGetter := 'DBUtils_ActiveRecord(Self)';  // Do not localize
  ABase := 0;
  Exit(True);
end;

function TCustomBindSourceDB.GetPositionSetter(
  var ASetter: string; var ABase: Integer): Boolean;
begin
  ASetter := 'DBUtils_ValidRecNo(Self)';  // Do not localize
  ABase := 1;
  Exit(True);
end;

function TCustomBindSourceDB.GetValue: TObject;
begin
  Assert(FDataSource <> nil);
  if FDataSource <> nil then
  begin
    Result := FDataSource.DataSet;
  end
  else
    Result := nil;
end;


procedure TCustomBindSourceDB.Insert;
begin
  if CheckDataSet then
    FDataSource.DataSet.Insert;
end;

class function TCustomBindSourceDB.IsDataComponent(
  AComponent: TComponent): Boolean;
begin
  Result := (AComponent is TDataSet) or
    (AComponent is TDataSource);
end;

function TCustomBindSourceDB.IsDataSetStored: Boolean;
begin
  // DataSet property is not stored if referencing a TDataSource
  Result := GetDataComponent = DataSet;
end;

function TCustomBindSourceDB.IsRequired(const AFieldName: string): Boolean;
var
  LField: TField;
begin
  Result := False;
  if CheckDataSet then
  begin
    LField := FDataSource.DataSet.FindField(AFieldName);
    if Assigned(LField) then
      Result := LField.Required;
  end;
end;

function TCustomBindSourceDB.IsValidChar(const AFieldName: string;
  const AChar: Char): Boolean;
var
  LField: TField;
begin
  Result := False;
  if CheckDataSet then
  begin
    LField := FDataSource.DataSet.FindField(AFieldName);
    if Assigned(LField) then
    begin
      if AChar = #0 then
        // Special case to test if field is read only
        Result := LField.CanModify
      else
        Result := LField.IsValidChar(AChar);
    end
  end;
end;

procedure TCustomBindSourceDB.Last;
begin
  if CheckDataSet then
    FDataSource.DataSet.Last;
end;

procedure TCustomBindSourceDB.Loaded;
begin
  inherited;
  FreeAndNil(FUnusedDataSource);
end;

function TCustomBindSourceDB.Lookup(const KeyFields: string;
  const KeyValues: TValue; const ResultFields: string): TValue;
var
  LResult: Variant;
begin
  Result := TValue.Empty;
  if CheckDataSet then
  begin
    LResult := FDataSource.DataSet.Lookup(KeyFields, KeyValues.AsVariant, ResultFields);
    Result := TValue.FromVariant(LResult);
  end;
end;

function TCustomBindSourceDB.Locate(const KeyFields: string;
  const KeyValues: TValue): Boolean;
begin
  Result := False;
  if CheckDataSet then
  begin
    Result := FDataSource.DataSet.Locate(KeyFields, KeyValues.AsVariant, []);
  end;
end;

procedure TCustomBindSourceDB.Next;
begin
  if CheckDataSet then
    FDataSource.DataSet.Next;
end;

procedure TCustomBindSourceDB.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation = TOperation.opRemove then
  begin
    if AComponent = FDataSource then
        DataSource := nil;
    if AComponent is TBasicBindComponent then
      if FDataLinks.ContainsKey(TBasicBindComponent(AComponent)) then
        FDataLinks.Remove(TBasicBindComponent(AComponent));

  end;
end;

procedure TCustomBindSourceDB.PosChanging(ABindComp: TBasicBindComponent);
begin
  if CheckDataSet then
    if (FDataSource.DataSet.State in dsEditModes) then
      Post;
end;

procedure TCustomBindSourceDB.Post;
begin
  if CheckDataSet then
    FDataSource.DataSet.Post;
end;

procedure TCustomBindSourceDB.Refresh;
begin
  if CheckDataSet then
  begin
    ResetNeeded; // Need to refresh grids
    FDataSource.DataSet.Refresh;
  end;
end;

procedure TCustomBindSourceDB.Prior;
begin
  if CheckDataSet then
    FDataSource.DataSet.Prior;
end;

procedure TCustomBindSourceDB.RemoveActiveChanged(LNotify: TNotifyEvent);
begin
  if Assigned(FActiveChanged) then
    FActiveChanged.Remove(LNotify);
end;

procedure TCustomBindSourceDB.RemoveDataSetChanged(LNotify: TNotifyEvent);
begin
  if Assigned(FDataSetChanged) then
    FDataSetChanged.Remove(LNotify);
end;

procedure TCustomBindSourceDB.RemoveDataSetScrolled(LNotify: TNotifyDistanceEvent);
begin
  if Assigned(FDataSetScrolled) then
    FDataSetScrolled.Remove(LNotify);
end;

procedure TCustomBindSourceDB.RemoveEditingChanged(LNotify: TNotifyEvent);
begin
  if Assigned(FEditingChanged) then
    FEditingChanged.Remove(LNotify);
end;

procedure TCustomBindSourceDB.RemoveExpression(AExpression: TBasicBindComponent);
begin
  inherited;
  if FDataLinks <> nil then
    FDataLinks.Remove(AExpression);

end;

procedure TCustomBindSourceDB.SetDataComponent(AComponent: TComponent);
begin
  if IsDataComponent(AComponent) then
  begin
    if AComponent is TDataSet then
      Self.DataSet := TDataSet(AComponent)
    else if AComponent is TDataSource then
      Self.DataSource := TDataSource(AComponent)
    else
      Assert(False);
  end;
end;

function TCustomBindSourceDB.CreateSubDataSource: TDataSource;
begin
  Result := TSubDataSource.Create(Self);
  Result.Name := 'SubDataSource'; // Do not localize
  Result.SetSubComponent(True);
end;

procedure TCustomBindSourceDB.SetDataSet(const Value: TDataSet);
var
  LDataSource: TDataSource;
begin
  if Value <> DataSet then
  begin
    if Value <> nil then
    begin
      if (FDataSource = nil) or (not (csSubComponent in FDataSource.ComponentStyle)) then
      begin
        LDataSource := CreateSubDataSource;
        LDataSource.DataSet := Value;
        Self.DataSource := LDataSource;
      end;
    end
    else
      DataSource := nil;
    if FDataSource <> nil then
    begin
      FDataSource.DataSet := Value;
      SetLinks(FDataSource);
    end;
  end;
end;

procedure TCustomBindSourceDB.SetLinks(Value: TDatasource);
var
  LLink: TBaseDataLink;
begin
  if FDataLink.DataSource <> Value then
  begin
    FDataLink.DataSource := Value;
    for LLink in FDataLinks.Values do
      LLink.DataSource := Value;
  end;
end;

procedure TCustomBindSourceDB.SetDataSource(const Value: TDataSource);
begin
  if Value <> FDataSource then
  begin
    if FDataSource <> nil then
      FDataSource.RemoveFreeNotification(Self);
    if (FDataSource <> nil) and (csSubComponent in FDataSource.ComponentStyle) then
      if not (csDestroying in FDataSource.ComponentState) then
        if not (csLoading in FDataSource.ComponentState) then
          FDataSource.Free
        else
        begin
          Assert(FUnusedDataSource = nil);
          FUnusedDataSource := FDataSource;
          FUnusedDataSource.Name := '';
        end;
    FDataSource := Value;
    if FDataSource <> nil then
      FDataSource.FreeNotification(Self);
    SetLinks(Value);
  end;
end;

procedure TCustomBindSourceDB.SetField(ABindComp: TBasicBindComponent;
  const FieldName: string);
var
  LDataLink: TBaseDataLink;
begin
  if (FDataLinks <> nil) and FDataLinks.TryGetValue(ABindComp, LDataLink) then
  begin
    Assert(LDataLink <> nil);
    if LDataLink is TBindLinkDataLink then
      TBindLinkDataLink(LDataLink).SetFieldName(FieldName);
  end
end;

{ TScopeDataLink }

procedure TScopeDataLink.ActiveChanged;

  function GetMasterFieldNames(const ADataSet: TDataSet): string;
  var
    LDetailFields, LMasterFields: TList<TField>;
    LMasterField: TField;
    LFieldNames: string;
  begin
    LDetailFields := nil;
    LMasterFields := nil;
    try
      LDetailFields := TList<TField>.Create;
      LMasterFields := TList<TField>.Create;
      ADataSet.GetDetailLinkFields(LMasterFields, LDetailFields);
      for LMasterField in LMasterFields do
      begin
        if LMasterField.FieldName <> '' then
        begin
          if LFieldNames <> '' then
            LFieldNames := LFieldNames + ';';
          LFieldNames := LFieldNames + LMasterField.FieldName;
        end;
      end;
    finally
      LDetailFields.Free;
      LMasterFields.Free;
    end;
    Result := LFieldNames;
  end;

begin
  inherited;
  if FDBScopeComponent.FEnumerating > 0 then  // Prevent reentry when using unidirectional datasets
    Exit;
  if Self.Active then
    // Recalculate buffer count
    FDBScopeComponent.FCalcBufferCount := True;
  if Assigned(FOnActiveChanged) then
    FOnActiveChanged(Self);
  if Self.Active then
  begin
    FMasterDataLink := TScopeMasterDataLink.Create(Self.DataSet);
    FMasterDataLink.DataSource := Self.DataSet.DataSource;
    if FMasterDataLink.DataSource <> nil then
      FMasterDataLink.FieldNames := GetMasterFieldNames(Self.DataSet);

    FMasterDataLink.OnMasterChange := MasterChanged;
    FMasterDataLink.OnMasterDisable := MasterDisabled;
  end
  else
    FreeAndNil(FMasterDataLink);
  FDBScopeComponent.ActivateExpressions(Self.Active);
end;

constructor TScopeDataLink.Create(ADBScopeComponent: TCustomBindSourceDB);
begin
  inherited Create;
  FDBScopeComponent := ADBScopeComponent;
end;

procedure TScopeDataLink.MasterChanged(Sender: TObject);
begin
  if Assigned(FOnMasterChanged) then
    FOnMasterChanged(Self);
end;

procedure TScopeDataLink.MasterDisabled(Sender: TObject);
begin
  if Assigned(FOnMasterDisabled) then
    FOnMasterDisabled(Self);
end;

procedure TScopeDataLink.RecordChanged(Field: TField);
begin
  if (Field <> nil) and (Field.IsIndexField) then
    if Assigned(FOnIndexFieldChanged) then
      FOnIndexFieldChanged(Self);
end;

procedure TScopeDataLink.DataSetChanged;
begin
  inherited;
  if Assigned(FOnDataSetChanged) then
    FOnDataSetChanged(Self);
end;

procedure TScopeDataLink.DataSetScrolled(Distance: Integer);
begin
  if Assigned(FOnDataSetScrolled) then
    FOnDataSetScrolled(Self, Distance);


end;

destructor TScopeDataLink.Destroy;
begin
  FreeAndNil(FMasterDataLink);
  inherited;
end;

procedure TScopeDataLink.EditingChanged;
begin
  inherited;
  if Assigned(FOnEditingChanged) then
    FOnEditingChanged(Self);
end;

{ TBaseDataLink }

function TBaseDataLink.Edit: Boolean;
begin
  Result := inherited Edit;
end;

{ TBindScopeDBEnumerator }

constructor TBindScopeDBEnumerator.Create(ABindScope: TCustomBindSourceDB;
  const AMemberName: string; ABufferCount: Integer);
begin
  // ABufferCount no longer used, so should always be -1
  Assert(ABufferCount = -1);
  Create(ABindScope, AMemberName, True); // Assume buffered
end;

constructor TBindScopeDBEnumerator.Create(ABindScope: TCustomBindSourceDB;
  const AMemberName: string; ABuffered: Boolean);
begin
  FBindScope := ABindScope;
  if ABindScope.DataSet = nil then
    raise TBindCompException.CreateFmt(sNoDataSet, [ABindScope.Name]);
  Assert(FBindScope.FEnumerating = 0);
  Inc(FBindScope.FEnumerating);
  if csDesigning in FBindScope.ComponentState then
    FMaxRecordCount := 300  // Don't want to hang while filling at design time
  else
    FMaxRecordCount := -1;

  FMemberName := AMemberName;
  FBuffered := ABuffered and not FBindScope.DataSet.IsUniDirectional;
  FCalcBuffer := FBuffered and FBindScope.FCalcBufferCount;
  if FBindScope.DataSet.State in dsEditModes then
    // Can't call DataSet.First, so turn off FCalcBuffer
    FCalcBuffer := False;

  if (not FBuffered) or FCalcBuffer then
  begin
    FFetchCount := 0;
    if not (FBindScope.DataSet.BOF and FBindScope.DataSet.EOF) then
      FSaveFetchRecNo := FBindScope.DataSet.RecNo
    else
      FSaveFetchRecNo := 0;
    FBindScope.DataSet.DisableControls;
    // Get first now, otherwise fields may be destroyed when call first
    if not FBindScope.DataSet.BOF then
    begin
      FBindScope.DataSet.First;
      if FSaveFetchRecNo > 1 then
        // Restore current record
        while (FFetchCount + 1 < FSaveFetchRecNo) do
          if not MoveNext then
            break;
    end;
  end
  else
  begin
    FBindScope.FDataLink.BufferCount := Max(FBindScope.DataSet.RecordCount + 2, FBindScope.FDataLink.BufferCount);
    FSaveActiveRecord := FBindScope.FDataLink.ActiveRecord;
    FNextActiveRecord := FSaveActiveRecord;
  end;
end;

destructor TBindScopeDBEnumerator.Destroy;
begin
  inherited;
  if FBindScope.DataSet <> nil then
  begin
    try
      if (not FBuffered) or FCalcBuffer then
      begin
        if FSaveFetchRecNo <> FBindScope.DataSet.RecNo then
        begin
          if FSaveFetchRecNo = 1 then
            FBindScope.DataSet.First
          else if FSaveFetchRecNo > 0 then
            if FBindScope.DataSet.RecNo >= 1 then
              FBindScope.DataSet.MoveBy(FSaveFetchRecNo - FBindScope.DataSet.RecNo)
        end;
      end
      else
         FBindScope.FDataLink.ActiveRecord := FSaveActiveRecord;
      if (not FBuffered) or FCalcBuffer then
        FBindScope.DataSet.EnableControls;
    finally
      Dec(FBindScope.FEnumerating);
    end;
  end;
end;

procedure TBindScopeDBEnumerator.First;
begin
  Assert(FBindScope.FDataLink.DataSet <> nil);
  if (not FBuffered) or (FCalcBuffer) then
  begin
    if (not FBindScope.DataSet.BOF) or FBindScope.DataSet.EOF then
      FBindScope.DataSet.First;
    FFetchCount := 0;
  end
  else // bidirectional
  begin
    if FBindScope.FDataLink.ActiveRecord < FBindScope.FDataLink.BufferCount then
      FBindScope.FDataLink.ActiveRecord := 0;
    FNextActiveRecord := FBindScope.FDataLink.ActiveRecord;
  end;
end;

function TBindScopeDBEnumerator.GetCurrent: IScope;
begin
  if FMemberName <> '' then
    Result := FBindScope.GetMemberScope(FMemberName)
  else
    Result := FBindScope.GetScope;
end;

function TBindScopeDBEnumerator.GetMemberCurrent(const AMemberName: string): IScope;
begin
  if AMemberName <> '' then
    Result := FBindScope.GetMemberScope(AMemberName)
  else
    Result := GetCurrent;
end;

procedure TBindScopeDBEnumerator.GetMemberValue(const AMemberName: string; const AType: TScopeMemberType;
  const ACallback: TValueCallback);
const
  LObjectTypes: TFieldTypes = [TFieldType.ftBlob, TFieldType.ftGraphic, TFieldType.ftStream, TFieldType.ftTypedBinary,
    TFieldType.ftOraBlob, TFieldType.ftOraClob, TFieldType.ftObject];

var
  LMember: TObject;
  LType: TScopeMemberType;
  LValue: TValue;
begin
  LMember := FBindScope.GetMember(AMemberName);
  if LMember is TField then
  begin
    case AType of
      mtUnknown: Assert(False);
      mtText:
      begin
        if TField(LMember).DataType = TFieldType.ftBoolean then
          // Don't use LField.Text because values for True and False are localized and inconsistent with SysUtils.StrToBool
          if TField(LMember).IsNull then
            ACallback('', AType)
          else
          begin
            TConverterUtils.BoolToString(TField(LMember).AsBoolean, LValue);
            ACallback(LValue, AType)
          end
        else
          if DefaultMemberNames[TField(LMember).DataType] = cText then
            ACallback(TField(LMember).Text, AType)
          else if DefaultMemberNames[TField(LMember).DataType] = cSelf then // Object
          begin
            TConverterUtils.PersistentToString(LMember, LValue);
            ACallback(LValue, AType)
          end
          else
          begin
            Assert(DefaultMemberNames[TField(LMember).DataType] = cAsString);
            ACallback(TField(LMember).AsString, AType);
          end;
      end;
      mtInteger:
        ACallback(TField(LMember).AsInteger, AType);
      mtFloat:
        ACallback(TField(LMember).AsExtended, AType);
      mtBitmap:
        ACallback(TField(LMember), AType);
      mtDate:
        ACallback(TField(LMember).AsDateTime, AType);
      mtTime:
        ACallback(TField(LMember).AsDateTime, AType);
      mtDateTime:
        ACallback(TField(LMember).AsDateTime, AType);
      mtBoolean:
        ACallback(TField(LMember).AsBoolean, AType);
      mtTValue:
      begin
        // Look for objects first.  Other types (like mtInteger) can be converted from string.
        for LType in TArray<TScopeMemberType>.Create(mtBitmap, mtObject, mtText) do
        begin
          if (LType = TScopeMemberType.mtText) or (LType in GetSupportedTypes(TField(LMember).DataType)) then
          begin
            // Recursive
            GetMemberValue(AMemberName, LType, ACallback);
            break;
          end;
        end;
      end;
      mtBCD:
        ACallback(TField(LMember).AsString, AType);
      mtCurrency:
        ACallback(TField(LMember).AsCurrency, AType);
      mtObject:
        ACallback(TField(LMember), AType);
      mtChar:
        ACallback(TField(LMember).AsWideString, AType);
      mtUInteger:
        ACallback(TField(LMember).AsLongWord, AType);
      mtVariant:
        ACallback(TField(LMember).AsString, AType);
    else
      Assert(False);
    end;
  end;
end;

const
  ScopeIntegerTypes: TScopeMemberTypes = [TScopeMemberType.mtInteger, TScopeMemberType.mtUInteger];
  ScopeFloatTypes: TScopeMemberTypes = [TScopeMemberType.mtFloat, TScopeMemberType.mtBCD, TScopeMemberType.mtCurrency];
  ScopeDateTypes: TScopeMemberTypes = [TScopeMemberType.mtTime, TScopeMemberType.mtDate, TScopeMemberType.mtDateTime];
  ScopeStringTypes: TScopeMemberTypes = [TScopeMemberType.mtText, TScopeMemberType.mtMemo, TScopeMemberType.mtChar];
  ScopeBooleanTypes: TScopeMemberTypes = [TScopeMemberType.mtBoolean];
  ScopeBitmapTypes: TScopeMemberTypes = [TScopeMemberType.mtBitmap];
  DBStringTypes: TFieldTypes = [TFieldType.ftString, TFieldType.ftMemo, TFieldType.ftFmtMemo, TFieldType.ftFixedChar, TFieldType.ftWideString];
  ScopeFromStringTypes: TScopeMemberTypes = [TScopeMemberType.mtInteger, TScopeMemberType.mtFloat, TScopeMemberType.mtBoolean, TScopeMemberType.mtUInteger,
   TScopeMemberType.mtDateTime, TScopeMemberType.mtCurrency, TScopeMemberType.mtDate, TScopeMemberType.mtTime, TScopeMemberType.mtChar];

function TBindScopeDBEnumerator.GetMemberValue(const AMemberName: string; const ATypes: array of TScopeMemberType; out AValue: TValue): Boolean;
var
  LMember: TObject;
  LType: TScopeMemberType;
  LValue: TValue;
begin
  LMember := FBindScope.GetMember(AMemberName);
  Result := LMember is TField;
  if Result then
  begin
    for LType in ATypes do
    begin
      Result := (LType = TScopeMemberType.mtText) or (LType in GetSupportedTypes(TField(LMember).DataType));
      if Result then
      begin
        GetMemberValue(AMemberName, LType,
          procedure(const AValue: TValue; AType: TScopeMemberType)
          begin
            LValue := AValue;
          end);
        AValue := LValue;
        break;
      end;
    end;
  end;
end;

function TBindScopeDBEnumerator.GetSupportedTypes(AFieldType: TFieldType): TScopeMemberTypes;
begin
  Result := [];
  case AFieldType of
    ftUnknown: ;
    TFieldType.ftString:   Result := ScopeStringTypes;
    TFieldType.ftSmallint: Result := ScopeIntegerTypes;
    TFieldType.ftInteger:  Result := ScopeIntegerTypes;
    TFieldType.ftWord:     Result := ScopeIntegerTypes;
    TFieldType.ftBoolean:  Result := ScopeBooleanTypes;
    TFieldType.ftFloat:    Result := ScopeFloatTypes + ScopeIntegerTypes;
    TFieldType.ftCurrency: Result := ScopeFloatTypes + ScopeIntegerTypes;
    TFieldType.ftBCD:      Result := ScopeFloatTypes + ScopeIntegerTypes;
    TFieldType.ftDate:     Result := ScopeDateTypes;
    TFieldType.ftTime:     Result := ScopeDateTypes;
    TFieldType.ftDateTime: Result := ScopeDateTypes;
    TFieldType.ftBytes:    Result := ScopeStringTypes;
    TFieldType.ftVarBytes: Result := ScopeStringTypes;
    TFieldType.ftAutoInc:  Result := ScopeIntegerTypes;
    TFieldType.ftBlob:     Result := ScopeBitmapTypes;
    TFieldType.ftMemo:     Result := ScopeStringTypes;
    TFieldType.ftGraphic:  Result := ScopeBitmapTypes;
    TFieldType.ftFmtMemo:  Result := ScopeStringTypes;
    TFieldType.ftParadoxOle: ;
    TFieldType.ftDBaseOle:   ;
    TFieldType.ftTypedBinary: Result := ScopeBitmapTypes;
    TFieldType.ftCursor:     ;
    TFieldType.ftFixedChar:  Result := ScopeStringTypes;
    TFieldType.ftWideString: Result := ScopeStringTypes;
    TFieldType.ftLargeint:   Result := ScopeIntegerTypes;
    TFieldType.ftADT:        ;
    TFieldType.ftArray:      ;
    TFieldType.ftReference:  ;
    TFieldType.ftDataSet:    ;
    TFieldType.ftOraBlob:    ;
    TFieldType.ftOraClob:    ;
    TFieldType.ftVariant:    Result := ScopeStringTypes;
    TFieldType.ftInterface:  ;
    TFieldType.ftIDispatch:  ;
    TFieldType.ftGuid:       Result := ScopeStringTypes;
    TFieldType.ftTimeStamp:  Result := ScopeStringTypes;
    TFieldType.ftFMTBcd:     Result := ScopeFloatTypes + ScopeIntegerTypes;
    TFieldType.ftFixedWideChar: Result := ScopeStringTypes;
    TFieldType.ftWideMemo:   Result := ScopeStringTypes;
    TFieldType.ftOraTimeStamp: Result := ScopeStringTypes;
    TFieldType.ftOraInterval: Result := ScopeStringTypes;
    TFieldType.ftLongWord:    Result := ScopeIntegerTypes;
    TFieldType.ftShortint:    Result := ScopeIntegerTypes;
    TFieldType.ftByte:        Result := ScopeIntegerTypes;
    TFieldType.ftExtended:    Result := ScopeFloatTypes + ScopeIntegerTypes;
    TFieldType.ftConnection:  ;
    TFieldType.ftParams:      ;
    TFieldType.ftStream:      ;
    TFieldType.ftTimeStampOffset: Result := ScopeStringTypes;
    TFieldType.ftObject:      ;
    TFieldType.ftSingle:      Result := ScopeFloatTypes + ScopeIntegerTypes;
  else
    Assert(False);
  end;
end;

function TBindScopeDBEnumerator.CanGetMemberValue(const AMemberName: string; AType: TScopeMemberType): Boolean;
var
  LMember: TObject;
begin
  LMember := FBindScope.GetMember(AMemberName);
  Result := LMember is TField;
  if Result then
  begin
    Result := (AType = mtText) or (AType = mtTValue) or (AType in GetSupportedTypes(TField(LMember).DataType)) or
      ((TField(LMember).DataType in DBStringTypes) and (AType in ScopeFromStringTypes));
  end;
end;

function TBindScopeDBEnumerator.GetMultiRecordChange: Boolean;
begin
  Result := FMultiRecordChange;
  if not Result then
    // Check for appending
    if (dsInsert = FBindScope.DataSet.State) and
      (FBindScope.FDataLink.ActiveRecord = FBindScope.FDataLink.RecordCount - 1) then
        //  Need to behave as if multiple records changed, because activerecord may be out of synch with control selection (e.g.; TListBox.ItemIndex)
        Result := True;
end;

function TBindScopeDBEnumerator.GetRecordCount: Integer;
begin
  if FCalcBuffer then
  begin
    while MoveNext do;
    First;
    if FSaveFetchRecNo > 1 then
      // Restore current record
      while (FFetchCount + 1 < FSaveFetchRecNo) do
        if not MoveNext then
          break;
  end;
  Result := FBindScope.FDataLink.RecordCount;
  Assert(not ((dsInsert = FBindScope.DataSet.State) and (Result = 0)));
end;

function TBindScopeDBEnumerator.MoveNext: Boolean;
var
  LBufferCount: Integer;
begin
  if (not FBuffered) or FCalcBuffer then
  begin
    if FBindScope.DataSet.EOF then
      Result := False
    else
    begin
      Result := True;
      if FFetchCount <> 0 then
      begin
        Inc(FFetchCount);
        if FCalcBuffer then
        begin
          LBufferCount := FFetchCount + 2;
          if FMaxRecordCount > 0 then
            LBufferCount := Min(FMaxRecordCount, LBufferCount);
          FBindScope.FDataLink.BufferCount := Max(LBufferCount, FBindScope.FDataLink.BufferCount);
        end;
        FBindScope.DataSet.Next;
        if FBindScope.DataSet.EOF then
          Result := False

      end
      else
        FFetchCount := 1;
      if (FMaxRecordCount > 0) and (FFetchCount > FMaxRecordCount) then
      begin
        Result := False;
      end;
      if Result = False then
        if FCalcBuffer then
          // At EOF, counting is complete
          FBindScope.FCalcBufferCount := False;
    end;
  end
  else // bidirectional
  begin
    if FNextActiveRecord >= FBindScope.FDataLink.RecordCount then
      Result := False
    else
    begin
      FBindScope.FDataLink.ActiveRecord := FNextActiveRecord;
      FNextActiveRecord := FNextActiveRecord + 1;
      Result := True;
    end;
  end;
end;

{ TBindDataSetScope }

function TBindDataSetScope.DoLookup(const Name: String): IInterface;
var
  DataSet: TDataSet;
begin
  Result := nil;
  if MappedObject is TDataSet then
  begin
    DataSet := TDataSet(MappedObject);
    if DataSet.FindField(Name) <> nil then
      Result := TCustomWrapper.Create(DataSet, DataSet.ClassType, Name, cwtProperty,
        function (ParentObject: TObject; const MemberName: String; Args: TArray<TValue>): TValue
        begin
          Result := TDataSet(ParentObject).FindField(MemberName);
        end);
  end;
end;

{ TSubDataSource }

destructor TSubDataSource.Destroy;
begin

  inherited;
end;

function TSubDataSource.GetDataSet: TDataSet;
begin
  Result := inherited DataSet;
end;

type
  TDataSetCracker = class(TDataSet)
  end;

{ TBindScopeDB }

procedure TBindScopeDB.DefineProperties(Filer: TFiler);
begin
  inherited;
    // For backwards compatibility
  Filer.DefineProperty('Top', ReadPosition, nil, False);
  Filer.DefineProperty('Left', ReadPosition, nil, False);
end;

procedure TBindScopeDB.ReadPosition(Reader: TReader);
begin
  Reader.ReadInteger;
end;

{ TBaseRemoteAdapter }

procedure TBaseRemoteAdapter.AddField(
  AField: TBindSourceAdapterField);
begin
  Fields.Add(AField);
end;

constructor TBaseRemoteAdapter.Create(AOwner: TComponent);
begin
  inherited;
end;

function TBaseRemoteAdapter.SupportsNestedFields: Boolean;
begin
  Result := False; // No special handling of fields with '.' in name
end;

function GetBoolValue(AObject: TObject): TValue;
var
  LField: TField;
begin
  Result := '';
  if AObject.InheritsFrom(TField) then
  begin
    LField := TField(AObject);
    // Don't use LField.Text because values for True and False are localized and inconsistent with SysUtils.StrToBool
    if not LField.IsNull then
      Result := BoolToStr(LField.AsBoolean, True)
  end;
end;

procedure SetBoolValue(AObject: TObject; const AValue: TValue);
var
  LField: TField;
  S: string;
  B: Boolean;
  LNull: Boolean;
  LSet: Boolean;
begin
  if AObject.InheritsFrom(TField) then
  begin
    LNull := False;
    B := False;
    LSet := False;
    LField := TField(AObject);
    if AValue.IsEmpty then
      LNull := True
    else if AValue.TryAsType<Boolean>(B) then
    begin
      // B has value
    end
    else if AValue.TryAsType<string>(S) then
    begin
      if S = '' then
        LNull := True
      else if System.SysUtils.TryStrToBool(S, B) then
      begin
        // B has value
      end
      else
      begin
        LSet := True;
        LField.Text := S;  // In case LField accepts other values for true/false
      end;
    end;
    if not LSet then
      if not LField.Required then
        if LNull then
          LField.Value := System.Variants.Null
        else
          LField.AsBoolean := B
      else
        LField.AsBoolean := B and (not LNull);
  end;
end;


// Bidi method to get and set a boolean field value
function MakeBoolValue: IInvokable;
begin
  Result := MakeInvokable(function(Args: TArray<IValue>): IValue
  var
    v: IValue;
  begin
    if Length(Args) <> 1 then
      raise EEvaluatorError.Create(sArgCount);
    v := Args[0];
    Result := MakeLocation(TypeInfo(TValue),
      function: TValue
      begin
        if v.GetValue.IsEmpty then
          Result := TValue.Empty
        else
          Result := GetBoolValue(v.GetValue.AsObject);
      end,
      procedure(x: TValue)
      begin
        SetBoolValue(v.GetValue.AsObject, x);
      end);
  end);
end;


// Bidi method to constrain a integer value to a valid row number
// RValue uses: ValidRecNo(dataset, integer)
// LValue usage: ValidRecNo(dataset)
function MakeValidRecNo: IInvokable;
begin
  Result := MakeInvokable(function(Args: TArray<IValue>): IValue
  var
    LDataSetValue: IValue;
  begin
    if Length(Args) < 1 then
      raise EEvaluatorError.Create(sArgCount);
    LDataSetValue := Args[0];
    Result := MakeLocation(TypeInfo(Integer),
      function: TValue
      var
        LRecNo: Integer;
        LDataSet: TDataSet;
        LRecNoValue: IValue;
      begin
        if Length(Args) <> 2 then
          raise EEvaluatorError.Create(sArgCount);
       LRecNo := -1;
       if LDataSetValue.GetValue.IsInstanceOf(TDataSet) then
        begin
          LRecNoValue := Args[1];
          LDataSet := TDataSet(LDataSetValue.GetValue.AsObject);
          LRecNo := LRecNoValue.GetValue.AsInteger;
          // Clip RecNo within valid range
          if LRecNo >  LDataSet.RecordCount then
            LRecNo := LDataSet.RecordCount;
          if LRecNo <= 0 then
            if LDataSet.RecordCount > 0 then
              LRecNo := 1
            else
              LRecNo := -1;
        end;
        Result := LRecNo;
      end,
      procedure(x: TValue)
      var
        LRecNo: Integer;
        LDataSet: TDataSet;
        LActiveRecord: Integer;
      begin
        if Length(Args) <> 1 then
          raise EEvaluatorError.Create(sArgCount);
        if LDataSetValue.GetValue.IsInstanceOf(TDataSet) then
        begin
          LDataSet := TDataSet(LDataSetValue.GetValue.AsObject);
          LRecNo := x.AsInteger;
          if LRecNo > 0 then
          begin
            LActiveRecord := TDataSetCracker(LDataSet).ActiveRecord;
            if LDataSet.RecNo = -1 then
              if LRecNo = LActiveRecord + 1 then
                // Don't set
                Exit;
          end;
          // Set RecNo within valid range if possible
          if LRecNo >  LDataSet.RecordCount then
            LRecNo := LDataSet.RecordCount;
          if LRecNo <= 0 then
            if LDataSet.RecordCount > 0 then
              LRecNo := 1;
          if LDataSet.IsSequenced and (LRecNo > 0) and (LRecNo <> LDataSet.RecNo) then
          begin
            if LDataSet.RecNo >= 1 then
              // Use MoveBy instead of RecNo. Works better with FireDAC
              LDataSet.MoveBy(LRecNo - LDataSet.RecNo);
          end;
        end
      end);
  end);
end;


function MakeActiveRecord: IInvokable;
begin
  Result := MakeInvokable(function(Args: TArray<IValue>): IValue
  var
    LDataSetValue: IValue;
    LDataSet: TDataSet;
  begin
    if Length(Args) <> 1 then
      raise EEvaluatorError.Create(string.Format(sArgCount, [1, Length(Args)]));
    LDataSetValue := Args[0];
    if LDataSetValue.GetValue.IsInstanceOf(TDataSet) then
    begin
      LDataSet := TDataSet(LDataSetValue.GetValue.AsObject);
      Exit(
        TValueWrapper.Create(TDataSetCracker(LDataSet).ActiveRecord));
    end
    else
      Exit(TValueWrapper.Create(TValue.Empty));
  end);
end;

const
  sValidRecNo = 'DBUtils_ValidRecNo';
  sActiveRecord = 'DBUtils_ActiveRecord';
  sBoolValue = 'DBUtils_BoolValue';
  // Leave unit name blank so this unit will not be autmatically added to uses list (because we don't want a database dependency).
  sThisUnit = ''; // 'Data.Bind.DBScope';

procedure RegisterMethods;
begin
    TBindingMethodsFactory.RegisterMethod(
      TMethodDescription.Create(
        MakeValidRecNo,
        sValidRecNo,
        sValidRecNo,
        sThisUnit,
        True,
        '', nil)
    );
    TBindingMethodsFactory.RegisterMethod(
      TMethodDescription.Create(
        MakeActiveRecord,
        sActiveRecord,
        sActiveRecord,
        sThisUnit,
        True,
        '', nil)
    );
    TBindingMethodsFactory.RegisterMethod(
      TMethodDescription.Create(
        MakeBoolValue,
        sBoolValue,
        sBoolValue,
        sThisUnit,
        True,
        '', nil)
    );
end;

procedure UnregisterMethods;
begin
  TBindingMethodsFactory.UnRegisterMethod(sValidRecNo);
  TBindingMethodsFactory.UnRegisterMethod(sActiveRecord);
  TBindingMethodsFactory.UnRegisterMethod(sBoolValue);
end;

{ TScopeMasterDataLink }

procedure TScopeMasterDataLink.CheckBrowseMode;
begin
  // do nothing

end;

initialization
  TBindingScopeFactory.RegisterScope(TDataSet, TBindDataSetScope);
  RegisterMethods;
finalization
  TBindingScopeFactory.UnregisterScope(TBindDataSetScope);
  UnregisterMethods;

end.
