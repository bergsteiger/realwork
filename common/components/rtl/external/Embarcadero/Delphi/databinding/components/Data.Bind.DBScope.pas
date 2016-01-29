{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$HPPEMIT '#pragma link "Data.Bind.DBScope"'}    {Do not Localize}
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
  TCustomBindSourceDB = class(TBaseLinkingBindSource, IScopeEditLink, IScopeRecordEnumerable,
    IScopeNavigator, IScopeActive, IScopeState, IScopeEditor, IScopeMemberNames, IScopeCurrentRecord,
    IScopeMemberScripting, IScopeGetRecord,
    IScopeLookup, IScopeNavigatorUpdates, IScopeBuffer, IScopeLocate, IScopeUnidirectional)
  private
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
    procedure OnActiveChanged(Sender: TObject);
    procedure OnDataSetChanged(Sender: TObject);
    procedure OnDataSetScrolled(Sender: TObject; ADistance: Integer);
    procedure OnEditingChanged(Sender: TObject);
    function GetDataSet: TDataSet;
    procedure SetDataSet(const Value: TDataSet);
    procedure GetRowMember(ARow: Integer; const AMemberName: string; ACallback: TProc<TObject>);
    function GetDataComponent: TComponent;
    procedure SetDataComponent(AComponent: TComponent);
    function CreateSubDataSource: TDataSource;
    procedure SetLinks(Value: TDatasource);
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
    function GetEnumerator(const AMemberName: string; ABufferCount: Integer): IScopeRecordEnumerator;
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
    function GetCanDelete: Boolean; overload; virtual;
    function GetCanInsert: Boolean; overload; virtual;
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
    property DataSet: TDataSet read GetDataSet write SetDataSet;
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
    IScopeRecordEnumeratorCount, IScopeRecordEnumeratorStatus)
  private
    FBindScope: TCustomBindSourceDB;
    FSaveActiveRecord: Integer;
    FMemberName: string;
    FNextRecord: Integer;
    FMultiRecordChange: Boolean;
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
      ABufferCount: Integer);
    destructor Destroy; override;
  end;

  // Reader with an anonymous method
  TValueReaderFunc<T> = class(TValueReader<T>)
  private
    FGetValue: TFunc<string, T>;
    FName: string;
  public
    constructor Create(const AName: string; AGetValue: TFunc<string, T>);
    function GetValue: T; override;
  end;

  // Writer with an anonymous method
  TValueWriterProc<T> = class(TValueWriter<T>)
  private
    FSetValue: TProc<string,T>;
    FName: string;
  public
    constructor Create(const AName: string; ASetValue: TProc<string, T>);
    procedure SetValue(const AValue: T); override;
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
  System.Bindings.ObjEval, System.Variants, System.TypInfo;

type
  TScopeDataLink = class(TBaseDataLink)
  private
    [weak] FDBScopeComponent: TCustomBindSourceDB;
    FOnDataSetChanged: TNotifyEvent;
    FOnEditingChanged: TNotifyEvent;
    FOnActiveChanged: TNotifyEvent;
    FOnDataSetScrolled: TNotifyDistanceEvent;
  public
    constructor Create(ADBScopeComponent: TCustomBindSourceDB);
    procedure DataSetChanged; override;
    procedure ActiveChanged; override;
    procedure EditingChanged; override;
    procedure DataSetScrolled(Distance: Integer); override;
    property OnDataSetChanged: TNotifyEvent read FOnDataSetChanged write FOnDataSetChanged;
    property OnDataSetScrolled: TNotifyDistanceEvent read FOnDataSetScrolled write FOnDataSetScrolled;
    property OnActiveChanged: TNotifyEvent read FOnActiveChanged write FOnActiveChanged;
    property OnEditingChanged: TNotifyEvent read FOnEditingChanged write FOnEditingChanged;
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
    FOwner.ResetNeeded;
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
  LUpdated := False;
  if (FBindListUpdate <> nil) and Active and FBindListUpdate.Active then
  begin
    LRefreshed := False;
    if Supports(FBindListUpdate, IBindListRefresh, LBindListRefresh)  then
      if LBindListRefresh.RefreshNeeded or FRefreshNeeded then
      begin
        FRefreshNeeded := False;
        LBindListRefresh.RefreshList;
        LRefreshed := True;
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
  FDataLinks := TObjectDictionary<TBasicBindComponent, TBaseDataLink>.Create([doOwnsValues]);
  FActiveChanged := TBindEventList.Create;
  FDataSetChanged := TBindEventList.Create;
  FEditingChanged := TBindEventList.Create;
  FDataSetScrolled := TBindEventList1<Integer>.Create;
  FApplyMaxErrors := -1;
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
    begin
      ACallback(WrapObject(AObject));
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
  LEnumerator := TBindScopeDBEnumerator.Create(Self, AMemberName, ABufferCount);
  LEnumerator.FMultiRecordChange := FMultiRecordChange or FResetNeeded;
  FResetNeeded := False;
  Result := LEnumerator;
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
  cAsInteger = 'Text'; // Use Text, so get blank when nil
  cAsLargeInt = 'Text'; // Use Text, so get blank when nil
  cAsBoolean = 'DBUtils_BoolValue(Self)'; // supports localized values for "True" and "False", and also blank when nil
  cAsLongWord = 'Text'; // Use Text, so get blank when nil
  cAsFloat = 'Text'; // Use text, instead of AsFloat, so that we get proper formatting
  cAsExtended = 'Text'; // Use text, instead of AsExtended,  so that we get proper formatting
  cAsSingle = 'Text'; // Use text, instead of AsSingle,  so that we get proper formatting
  cAsVariant = 'Text'; // Use text, instead of AsVariant,  so that we get proper formatting
  cAsBCD = 'Text'; // Use text to get proper precision
  cAsDateTime = 'Text'; // Use text, instead of AsDate etc.,  so that we get proper formatting
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
    cSelf,  // TBytesField,               { ftBytes }
    cSelf,  // TVarBytesField,            { ftVarBytes }
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
    cSelf,  // TADTField,                 { ftADT }
    cSelf,  // TArrayField,               { ftArray }
    cSelf,  // TReferenceField,           { ftReference }
    cSelf,  // TDataSetField,             { ftDataSet }
    cSelf,  // TBlobField,                { ftOraBlob }
    cAsString,  // TMemoField,                { ftOraClob }
    cAsVariant,  // TVariantField,             { ftVariant }
    cSelf,  // TInterfaceField,           { ftInterface }
    cSelf,  // TIDispatchField,           { ftIDispatch }
    cSelf,  // TGuidField,                { ftGuid }
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
    mtObject,  // TBytesField,               { ftBytes }
    mtObject,  // TVarBytesField,            { ftVarBytes }
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
    mtObject,  // TADTField,                 { ftADT }
    mtObject,  // TArrayField,               { ftArray }
    mtObject,  // TReferenceField,           { ftReference }
    mtObject,  // TDataSetField,             { ftDataSet }
    mtObject,  // TBlobField,                { ftOraBlob }
    mtMemo,  // TMemoField,                { ftOraClob }
    mtVariant,  // TVariantField,             { ftVariant }
    mtObject,  // TInterfaceField,           { ftInterface }
    mtObject,  // TIDispatchField,           { ftIDispatch }
    mtObject,  // TGuidField,                { ftGuid }
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
      if (LField <> nil) then
        ASetter := DefaultMemberNames[LField.DataType];
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
begin
  inherited;
  if FDBScopeComponent.FEnumerating > 0 then  // Prevent reentry when using unidirectional datasets
    Exit;
  if Assigned(FOnActiveChanged) then
    FOnActiveChanged(Self);
  FDBScopeComponent.ActivateExpressions(Self.Active);

end;

constructor TScopeDataLink.Create(ADBScopeComponent: TCustomBindSourceDB);
begin
  inherited Create;
  FDBScopeComponent := ADBScopeComponent;
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
  FBindScope := ABindScope;
  Assert(FBindScope.FEnumerating = 0);
  Inc(FBindScope.FEnumerating);
  FMemberName := AMemberName;
  FSaveActiveRecord := FBindScope.FDataLink.ActiveRecord;
  FNextRecord := FSaveActiveRecord;
  if FBindScope.DataSet.IsUniDirectional then
  begin
    FBindScope.FDataLink.BufferCount := 1;
    // Get first now, otherwise fields may be destroyed when call first
    if not FBindScope.DataSet.BOF then
      FBindScope.DataSet.First;
  end
  else
  begin
    if ABufferCount > 0 then
      FBindScope.FDataLink.BufferCount := ABufferCount
    else
      FBindScope.FDataLink.BufferCount := 200;  // default to max 200 records in buffer
  end;
end;

destructor TBindScopeDBEnumerator.Destroy;
begin
  inherited;
  Dec(FBindScope.FEnumerating);
  FBindScope.FDataLink.ActiveRecord := FSaveActiveRecord;
end;

procedure TBindScopeDBEnumerator.First;
begin
  FSaveActiveRecord := FBindScope.FDataLink.ActiveRecord;
  FNextRecord := 0;
  if FBindScope.DataSet.IsUnidirectional then
  begin
    if not FBindScope.DataSet.BOF then
      FBindScope.DataSet.First;
  end
  else // bidirectional
  begin
    if FBindScope.FDataLink.DataSet <> nil then
    begin
      if FBindScope.FDataLink.ActiveRecord < FBindScope.FDataLink.BufferCount then
        FBindScope.FDataLink.ActiveRecord := 0
      else if not FBindScope.FDataLink.BOF then
      begin
        FBindScope.FDataLink.DataSet.First;
        FSaveActiveRecord := FBindScope.FDataLink.ActiveRecord;
      end;
      FNextRecord := FBindScope.FDataLink.ActiveRecord;
    end;
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
  Result := FBindScope.FDataLink.RecordCount;
  Assert(not ((dsInsert = FBindScope.DataSet.State) and (Result = 0)));
end;

function TBindScopeDBEnumerator.MoveNext: Boolean;
begin
  if FBindScope.DataSet.IsUnidirectional then
  begin
    if FBindScope.DataSet.EOF then
      Result := False
    else
    begin
      Result := True;
      if FNextRecord <> 0 then
      begin
        FBindScope.DataSet.Next;
        if FBindScope.DataSet.EOF then
          Result := False;
      end;
      FNextRecord := FNextRecord + 1;
    end;
  end
  else // bidirectional
    if FNextRecord < FBindScope.FDataLink.RecordCount then
    begin
      FBindScope.FDataLink.ActiveRecord := FNextRecord;
      FNextRecord := FNextRecord + 1;
      Result := True;
    end
    else
      Result := False;
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


{ TValueReaderFunc<T> }

constructor TValueReaderFunc<T>.Create(const AName: string; AGetValue: TFunc<string, T>);
begin
  FGetValue := AGetValue;
  FName := AName;
end;

function TValueReaderFunc<T>.GetValue: T;
begin
  Result := FGetValue(FName);
end;

{ TValueWriteProc<T> }

constructor TValueWriterProc<T>.Create(const AName: string; ASetValue: TProc<string, T>);
begin
  FSetValue := ASetValue;
  FName := AName;
end;

procedure TValueWriterProc<T>.SetValue(const AValue: T);
begin
  FSetValue(FName, AValue);
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
          if (LRecNo > 0) and (LRecNo <> LDataSet.RecNo) then
          begin
            // Must be carefull when set RecNo because this ends editing
            LDataSet.RecNo := LRecNo;
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
  sThisUnit = 'Data.Bind.DBScope';

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

initialization
  TBindingScopeFactory.RegisterScope(TDataSet, TBindDataSetScope);
  RegisterMethods;
finalization
  TBindingScopeFactory.UnregisterScope(TBindDataSetScope);
  UnregisterMethods;

end.
