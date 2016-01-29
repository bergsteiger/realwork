{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{ Copyright(c) 2012-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Data.Bind.DBXScope;

interface

uses
  System.Classes, System.SysUtils, System.TypInfo, Data.DB, Data.Bind.Components,
  System.Bindings.Helper, System.Generics.Collections, System.Bindings.CustomScope,
  System.Bindings.CustomWrapper, System.Bindings.Factories, System.Bindings.EvalProtocol,
  Data.Bind.DBScope, Data.Bind.ObjectScope, Data.SQLExpr, Datasnap.DBClient,
  Datasnap.Provider;

type
  TCustomParamsAdapter = class(TBaseRemoteAdapter)
  private
    FCustomSQLDataSet: TCustomSQLDataSet;
    FDeferActivate: Boolean;
    FBeforeExecute: TAdapterNotifyEvent;
    FAfterExecute: TAdapterNotifyEvent;
    procedure SetCustomSQLDataSet(const Value: TCustomSQLDataSet);
    procedure SetSQLDataSet(const Value: TSQLDataSet);
    function GetSQLDataSet: TSQLDataSet;
    procedure SetSQLQuery(const Value: TSQLQuery);
    function GetSQLQuery: TSQLQuery;
    procedure MakeParamField<T>(AParam: TParam);
    procedure AddFields;
    function GetParams: TParams; virtual;
    function GetSQLServerMethod: TSQLServerMethod;
    function GetSQLStoredProc: TSQLStoredProc;
    procedure SetSQLServerMethod(const Value: TSQLServerMethod);
    procedure SetSQLStoredProc(const Value: TSQLStoredProc);
  protected
    procedure SetActive(AValue: Boolean); override;
    procedure Loaded; override;
    function GetCanModify: Boolean; override;
    procedure OnActiveChanged(Sender: TObject);
    procedure DoBeforeOpen; override;
    procedure DoAfterOpen; override;
    procedure DoAfterClose; override;
    function GetCanActivate: Boolean; override;
    function GetCount: Integer;  override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DoAfterExecute; virtual;
    procedure DoExecute; virtual;
    procedure DoBeforeExecute; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Execute; virtual;
    property SQLDataSet: TSQLDataSet read GetSQLDataSet write SetSQLDataSet;
    property SQLQuery: TSQLQuery read GetSQLQuery write SetSQLQuery;
    property SQLServerMethod: TSQLServerMethod read GetSQLServerMethod write SetSQLServerMethod;
    property SQLStoredProc: TSQLStoredProc read GetSQLStoredProc write SetSQLStoredProc;
    property BeforeExecute: TAdapterNotifyEvent read FBeforeExecute write FBeforeExecute;
    property AfterExecute: TAdapterNotifyEvent read FAfterExecute write FAfterExecute;
  end;

  TParamsAdapter = class(TCustomParamsAdapter)
  published
    property SQLQuery;
    property SQLDataSet;
    property SQLStoredProc;
    property SQLServerMethod;
    property Active;
    property AutoPost;
    property BeforeExecute;
    property AfterExecute;
  end;

  TCustomBindSourceDBX = class;

  TSubDataSetProvider = class(TDataSetProvider)
  private
    procedure SetDataSet(ADataSet: TDataSet);
  public
    destructor Destroy; override;
  private
    function GetDataSet: TDataSet;
  public
  published
    [Stored(False)]
    property DataSet: TDataSet read GetDataSet stored False;
  end;

  // publish all properties
  TSubSQLDataSet = class(TSQLDataSet)
  private
    procedure SetSQLConnection(AConnection: TSQLConnection);
    function GetSQLConnection: TSQLConnection;
  public
    destructor Destroy; override;
  published
    property SQLConnection: TSQLConnection read GetSQLConnection;
  end;

  // publish all properties
  TSubClientDataSet = class(TClientDataSet)
  private
    FReconcileError: string;
    procedure SetProviderName(const AName: string);
    function GetBindScope: TCustomBindSourceDBX;
    function GetProviderName: string;
    procedure DefaultOnReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure AutoApplyUpdates;
  protected
    procedure DoAfterPost; override;
    procedure DoAfterDelete; override;
  published
    [Stored(False)]
    property ProviderName: string read GetProviderName stored False;
  end;

  TCustomBindSourceDBX = class(TCustomBindSourceDB, ISubDataSet)
  private
    FClientDataSet: TSubClientDataSet;
    FProvider: TSubDataSetProvider;
    FSQLDataSet: TSubSQLDataSet;
    FAutoApply: Boolean;
    procedure AllocSQLDataSet;
    procedure AllocClientDataSet;
    procedure AllocProvider;
    procedure SetActive(const Value: Boolean);
   function GetCommandText: string;
    function GetCommandType: TSQLCommandType;
    function GetDbxCommandType: string;
    function GetMaxBlobSize: Integer;
    function GetParamCheck: Boolean;
    function GetParams: TParams;
    function GetSortFieldNames: string;
    function GetSqlConnection: TSQLConnection;
    procedure SetCommandText(const Value: string);
    procedure SetCommandType(const Value: TSQLCommandType);
    procedure SetDbxCommandType(const Value: string);
    procedure SetMaxBlobSize(const Value: Integer);
    procedure SetParamCheck(const Value: Boolean);
    procedure SetParams(const Value: TParams);
    procedure SetSortFieldNames(const Value: string);
    procedure SetSqlConnection(const Value: TSQLConnection);
    function GetSubDataSource: TSubDataSource;
    function GetMasterFields: string;
    function GetMasterSource: TCustomBindSourceDBX;
    procedure SetMasterDataSource(const Value: TCustomBindSourceDBX);
    procedure SetMasterFields(const Value: string);
    function GetIndexFieldNames: string;
    procedure SetIndexFieldNames(const Value: string);
    procedure Reactivate;
    function GetSchemaName: string;
    procedure SetSchemaName(const Value: string);
  protected
    function GetActive: Boolean; override;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    { ISubDataSet }
    function GetSubDataSet: TDataSet;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property SubSQLDataSet: TSubSQLDataSet read FSQLDataSet;
    property SubDataSource: TSubDataSource read GetSubDataSource;
    property SubClientDataSet: TSubClientDataSet read FClientDataSet;
    property SubProvider: TSubDataSetProvider read FProvider;
    property Active: Boolean read GetActive write SetActive;
    property CommandText: string read GetCommandText write SetCommandText;
    property CommandType: TSQLCommandType read GetCommandType write SetCommandType;
    property DbxCommandType: string read GetDbxCommandType write SetDbxCommandType;
    property MaxBlobSize: Integer  read GetMaxBlobSize write SetMaxBlobSize;
    property ParamCheck: Boolean  read GetParamCheck write SetParamCheck;
    property Params: TParams  read GetParams write SetParams;
    property SortFieldNames: string read GetSortFieldNames write SetSortFieldNames;
    property SQLConnection: TSQLConnection read GetSqlConnection write SetSqlConnection;
    [Default(True)]
    property AutoApply: Boolean read FAutoApply write FAutoApply default True;
    property MasterSource: TCustomBindSourceDBX read GetMasterSource write SetMasterDataSource;
    property MasterFields: string read GetMasterFields write SetMasterFields;
    property IndexFieldNames: string read GetIndexFieldNames write SetIndexFieldNames;
    property SchemaName: string read GetSchemaName write SetSchemaName;
  end;

  TBindSourceDBX = class(TCustomBindSourceDBX)
  published
    property SubSQLDataSet;
    property SubDataSource;
    property SubClientDataSet;
    property SubProvider;
    [Stored(False)]
    property Active stored False;
    [Stored(False)]
    property CommandText stored False;
    [Stored(False)]
    property CommandType stored False;
    [Stored(False)]
    property DbxCommandType stored False;
    [Stored(False)]
    property MaxBlobSize stored False;
    [Stored(False)]
    property ParamCheck stored False;
    [Stored(False)]
    property Params stored False;
    [Stored(False)]
    property SortFieldNames stored False;
    property SQLConnection;
    property AutoApply;
    property ApplyMaxErrors;
    property ScopeMappings;
    property MasterFields;
    property MasterSource;
    property IndexFieldNames;
    property SchemaName;
  end;

implementation

uses
  System.Rtti;

type
  // Utilities to create adapter fields
  TFieldUtils = class
  public
    class function CreateField<T>(AAdapter: TBindSourceAdapter;
      const AName: string; AType: TScopeMemberType;
      AValueReader: TValueReader<T>): TBindSourceAdapterField; overload; static;

    class function CreateField<T>(AAdapter: TBindSourceAdapter;
      const AName: string; AType: TScopeMemberType;
      AValueReader: TValueReader<T>;
      AValueWriter: TValueWriter<T>): TBindSourceAdapterField; overload; static;
  end;

{ TFieldUtils }

class function TFieldUtils.CreateField<T>(AAdapter: TBindSourceAdapter;
  const AName: string; AType: TScopeMemberType;
  AValueReader: TValueReader<T>): TBindSourceAdapterField;
var
  LGetMemberObject: IGetMemberObject;
  LTypeInfo: PTypeInfo;
begin
  LGetMemberObject := TBindSourceAdapterGetMemberObject.Create(AAdapter);
  LTypeInfo := System.TypeInfo(T);
  Result := TBindSourceAdapterReadField<T>.Create(AAdapter, AName,
    TBindSourceAdapterFieldType.Create(LTypeInfo.NameFld.ToString,
    LTypeInfo.Kind),
    LGetMemberObject,
      AValueReader, AType);
end;

class function TFieldUtils.CreateField<T>(AAdapter: TBindSourceAdapter;
  const AName: string; AType: TScopeMemberType;
  AValueReader: TValueReader<T>;
  AValueWriter: TValueWriter<T>): TBindSourceAdapterField;
var
  LGetMemberObject: IGetMemberObject;
  LTypeInfo: PTypeInfo;
begin
  LGetMemberObject := TBindSourceAdapterGetMemberObject.Create(AAdapter);
  LTypeInfo := System.TypeInfo(T);
  Result := TBindSourceAdapterReadWriteField<T>.Create(AAdapter, AName,
    TBindSourceAdapterFieldType.Create(LTypeInfo.NameFld.ToString,
    LTypeInfo.Kind),
    LGetMemberObject,
      AValueReader, AValueWriter, AType);
end;

{ TCustomBindSourceDBX }

constructor TCustomBindSourceDBX.Create(AOwner: TComponent);
begin
  inherited;
  FAutoApply := True;
  AllocSQLDataSet;
  AllocProvider;
  FProvider.SetDataSet(FSQLDataSet);
  AllocClientDataSet;
  FClientDataSet.SetProviderName(FProvider.Name);
end;

destructor TCustomBindSourceDBX.Destroy;
begin

  inherited;
end;

function TCustomBindSourceDBX.GetActive: Boolean;
begin
  Result := FClientDataSet.Active
end;

procedure TCustomBindSourceDBX.GetChildren(Proc: TGetChildProc;
  Root: TComponent);
begin
  SubClientDataSet.GetChildren(Proc, Root);
end;

function TCustomBindSourceDBX.GetCommandText: string;
begin
  Result := FSQLDataSet.CommandText;
end;

function TCustomBindSourceDBX.GetCommandType: TSQLCommandType;
begin
  Result := FSQLDataSet.CommandType;
end;

function TCustomBindSourceDBX.GetDbxCommandType: string;
begin
  Result := FSQLDataSet.DbxCommandType;
end;

function TCustomBindSourceDBX.GetIndexFieldNames: string;
begin
  Result := FClientDataSet.IndexFieldNames;
end;

function TCustomBindSourceDBX.GetSubDataSet: TDataSet;
begin
  Result := SubClientDataSet;
end;

function TCustomBindSourceDBX.GetSubDataSource: TSubDataSource;
begin
  Result := Self.DataSource as TSubDataSource;
end;

function TCustomBindSourceDBX.GetMasterFields: string;
begin
  Result := FClientDataSet.MasterFields;
end;

function TCustomBindSourceDBX.GetMasterSource: TCustomBindSourceDBX;
var
  LDataSource: TDataSource;
begin
  Result := nil;
  LDataSource := FClientDataSet.MasterSource;
  if LDataSource <> nil then
    if LDataSource.Owner is TCustomBindSourceDBX then
    begin
      Result := TCustomBindSourceDBX(LDataSource.Owner);
    end;

end;

function TCustomBindSourceDBX.GetMaxBlobSize: Integer;
begin
  Result := FSQLDataSet.MaxBlobSize;
end;

function TCustomBindSourceDBX.GetParamCheck: Boolean;
begin
  Result := FSQLDataSet.ParamCheck;
end;

function TCustomBindSourceDBX.GetParams: TParams;
begin
  Result := FSQLDataSet.Params;
end;

function TCustomBindSourceDBX.GetSchemaName: string;
begin
  Result := FSQLDataSet.SchemaName;
end;

function TCustomBindSourceDBX.GetSortFieldNames: string;
begin
  Result := FSQLDataSet.SortFieldNames;
end;

function TCustomBindSourceDBX.GetSqlConnection: TSQLConnection;
begin
  Result := FSQLDataSet.SQLConnection;
end;

procedure TCustomBindSourceDBX.SetActive(const Value: Boolean);
begin
  FClientDataSet.Active := Value;
end;

procedure TCustomBindSourceDBX.Reactivate;
begin
  if Active then
  begin
    Active := False;
    Active := True;
  end;
end;

procedure TCustomBindSourceDBX.SetCommandText(const Value: string);
begin
  if FSQLDataSet.CommandText <> Value then
  begin
    FSQLDataSet.CommandText := Value;
    Reactivate;
  end;
end;

procedure TCustomBindSourceDBX.SetCommandType(
  const Value: TSQLCommandType);
begin
  if FSQLDataSet.CommandType <> Value then
  begin
    FSQLDataSet.CommandType := Value;
    Active := False;
  end;
end;

procedure TCustomBindSourceDBX.SetDbxCommandType(const Value: string);
begin
  if FSQLDataSet.DbxCommandType <> Value then
  begin
    FSQLDataSet.DbxCommandType := Value;
    Active := False;
  end;
end;

procedure TCustomBindSourceDBX.SetIndexFieldNames(const Value: string);
begin
  FClientDataSet.IndexFieldNames := Value;
end;

procedure TCustomBindSourceDBX.SetMasterDataSource(
  const Value: TCustomBindSourceDBX);
begin
  if Value = nil then
    FClientDataSet.MasterSource := nil
  else
    FClientDataSet.MasterSource := Value.SubDataSource;
end;

procedure TCustomBindSourceDBX.SetMasterFields(const Value: string);
begin
  FClientDataSet.MasterFields := Value;
end;

procedure TCustomBindSourceDBX.SetMaxBlobSize(const Value: Integer);
begin
  FSQLDataSet.MaxBlobSize := Value;
end;

procedure TCustomBindSourceDBX.SetParamCheck(const Value: Boolean);
begin
  FSQLDataSet.ParamCheck := Value;
end;

procedure TCustomBindSourceDBX.SetParams(const Value: TParams);
begin
  FSQLDataSet.Params := Value;
end;

procedure TCustomBindSourceDBX.SetSchemaName(const Value: string);
begin
  if FSQLDataSet.SchemaName <> Value then
  begin
    FSQLDataSet.SchemaName := Value;
    Active := False;
  end;
end;

procedure TCustomBindSourceDBX.SetSortFieldNames(const Value: string);
begin
  if FSQLDataSet.SortFieldNames <> Value then
  begin
    FSQLDataSet.SortFieldNames := Value;
    Reactivate;
  end;
end;

procedure TCustomBindSourceDBX.SetSqlConnection(
  const Value: TSQLConnection);
begin
  FSQLDataSet.SetSQLConnection(Value);
end;

procedure TCustomBindSourceDBX.AllocSQLDataSet;
begin
  FSQLDataSet := TSubSQLDataSet.Create(Self);
  FSQLDataSet.Name := 'SubSQLDataSet';                   { Do not localize }
  FSQLDataSet.SetSubComponent(True);
end;

procedure TCustomBindSourceDBX.AllocClientDataSet;
begin
  FClientDataSet := TSubClientDataSet.Create(Self);
  FClientDataSet.Name := 'SubClientDataSet';                   { Do not localize }
  FClientDataSet.SetSubComponent(True);
  Self.DataComponent := FClientDataSet;
end;

procedure TCustomBindSourceDBX.AllocProvider;
begin
  FProvider := TSubDataSetProvider.Create(Self);
  FProvider.Name := 'SubProvider';                 { Do not localize }
  FProvider.SetSubComponent(True);
end;

{ TSubClientDataSet }

procedure TSubClientDataSet.DefaultOnReconcileError(DataSet: TCustomClientDataSet; E: EReconcileError;
    UpdateKind: TUpdateKind; var Action: TReconcileAction);
begin
  FReconcileError := E.Message;
end;

procedure TSubClientDataSet.AutoApplyUpdates;
var
  LHaveOnReconcileError: Boolean;
begin
  if GetBindScope.AutoApply then
  begin
    LHaveOnReconcileError := Assigned(OnReconcileError);
    if not LHaveOnReconcileError then
      OnReconcileError := DefaultOnReconcileError;
    try
      FReconcileError := '';
      // Ignore max errors when auto apply
      ApplyUpdates(1);
      if FReconcileError <> '' then
      begin
        raise EBindCompError.Create(FReconcileError);
      end;
    finally
      if not LHaveOnReconcileError then
        OnReconcileError := nil;
    end;
  end;
end;

procedure TSubClientDataSet.DoAfterDelete;
begin
  AutoApplyUpdates;
  inherited;
end;

procedure TSubClientDataSet.DoAfterPost;
begin
  AutoApplyUpdates;
  inherited;
end;

function TSubClientDataSet.GetBindScope: TCustomBindSourceDBX;
begin
  Result := Owner as TCustomBindSourceDBX;
end;

function TSubClientDataSet.GetProviderName: string;
begin
  Result := inherited ProviderName;
end;

procedure TSubClientDataSet.SetProviderName(const AName: string);
begin
  inherited ProviderName := AName;
end;


{ TSubSQLDataSet }

destructor TSubSQLDataSet.Destroy;
begin

  inherited;
end;

function TSubSQLDataSet.GetSQLConnection: TSQLConnection;
begin
  Result := inherited SQLConnection;
end;

procedure TSubSQLDataSet.SetSQLConnection(AConnection: TSQLConnection);
begin
  inherited SQLConnection := AConnection;
end;

{ TIntDataSetProvider }

destructor TSubDataSetProvider.Destroy;
begin

  inherited;
end;

function TSubDataSetProvider.GetDataSet: TDataSet;
begin
  Result := inherited DataSet;
end;

procedure TSubDataSetProvider.SetDataSet(ADataSet: TDataSet);
begin
  inherited DataSet := ADataSet;
end;

{ TCustomSQLParamsAdapter }

constructor TCustomParamsAdapter.Create(AOwner: TComponent);
begin
  inherited;
end;

procedure TCustomParamsAdapter.DoAfterOpen;
begin

end;

procedure TCustomParamsAdapter.DoBeforeExecute;
begin
  if Assigned(FBeforeExecute) then FBeforeExecute(Self);
end;

procedure TCustomParamsAdapter.DoBeforeOpen;
begin
  inherited;

  if FCustomSQLDataSet is TSQLStoredProc then
  begin
    TSQLStoredProc(FCustomSQLDataSet).Prepared := True;
  end;
  AddFields;
end;

procedure TCustomParamsAdapter.DoAfterClose;
begin
  inherited;
  //ClearFields;
end;

procedure TCustomParamsAdapter.DoAfterExecute;
begin
  if Assigned(FAfterExecute) then FAfterExecute(Self);
end;

function TCustomParamsAdapter.GetCanModify: Boolean;
begin
  Result := True;
end;

destructor TCustomParamsAdapter.Destroy;
begin
  inherited;
end;

procedure TCustomParamsAdapter.DoExecute;
begin
  if FCustomSQLDataSet <> nil then
  begin
    if FCustomSQLDataSet is TSQLStoredProc then
      TSQLStoredProc(FCustomSQLDataSet).ExecProc
    else if FCustomSQLDataSet is TSQLQuery then
    begin
      // check if sql is a query or executed statement
      if TSQLQuery(FCustomSQLDataSet).SQL.Text.Trim.ToUpper.IndexOf('SELECT') = 0 then
      begin
        if FCustomSQLDataSet.Active then
          FCustomSQLDataSet.Close;
        FCustomSQLDataSet.Open;
      end
      else
        TSQLQuery(FCustomSQLDataSet).ExecSQL;
    end
    else if (FCustomSQLDataSet is TSQLDataSet) and (TSQLDataSet(FCustomSQLDataSet).CommandType = ctQuery) then
    begin
      if TSQLDataSet(FCustomSQLDataSet).CommandText.Trim.ToUpper.IndexOf('SELECT') = 0 then
      begin
        if FCustomSQLDataSet.Active then
          FCustomSQLDataSet.Close;
        FCustomSQLDataSet.Open;
      end
      else
        TSQLDataSet(FCustomSQLDataSet).ExecSQL;      
    end
    else // all else - just query
    begin
      if FCustomSQLDataSet.Active then
        FCustomSQLDataSet.Close;
      FCustomSQLDataSet.Open;
    end;
  end;

  Self.DataSetChanged;
end;

procedure TCustomParamsAdapter.Execute;
begin
  Active := True;
  if Self.State in [TBindSourceAdapterState.seEdit, TBindSourceAdapterState.seInsert] then
    Post;

  DoBeforeExecute;
  DoExecute;
  DoAfterExecute;
end;

function TCustomParamsAdapter.GetCount: Integer;
begin
  Result := 1;
end;

function TCustomParamsAdapter.GetSQLDataSet: TSQLDataSet;
begin
  if FCustomSQLDataSet is TSQLDataSet then
    Result := FCustomSQLDataSet as TSQLDataSet
  else
    Result := nil;
end;

function TCustomParamsAdapter.GetParams: TParams;
begin
  if FCustomSQLDataSet is TSQLDataSet then
    Result := TSQLDataSet(FCustomSQLDataSet).Params
  else if FCustomSQLDataSet is TSQLQuery then
    Result := TSQLQuery(FCustomSQLDataSet).Params
  else if FCustomSQLDataSet is TSQLStoredProc then
    Result := TSQLStoredProc(FCustomSQLDataSet).Params
  else
    Result := nil;
end;

function TCustomParamsAdapter.GetSQLQuery: TSQLQuery;
begin
  if FCustomSQLDataSet is TSQLQuery then
    Result := FCustomSQLDataSet as TSQLQuery
  else
    Result := nil;
end;

function TCustomParamsAdapter.GetSQLServerMethod: TSQLServerMethod;
begin
  if FCustomSQLDataSet is TSqlServerMethod then
    Result := FCustomSQLDataSet as TSQLServerMethod
  else
    Result := nil;
end;

function TCustomParamsAdapter.GetSQLStoredProc: TSQLStoredProc;
begin
  if FCustomSQLDataSet is TSQLStoredProc then
    Result := FCustomSQLDataSet as TSQLStoredProc
  else
    Result := nil;
end;

procedure TCustomParamsAdapter.Loaded;
begin
  inherited;
  if FDeferActivate then
    try
      Active := True;
    except
      // Ignore exception during load
    end;
end;

procedure TCustomParamsAdapter.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation = TOperation.opRemove then
  begin
    if AComponent = FCustomSQLDataSet then
      FCustomSQLDataSet := nil;
  end;
end;

procedure TCustomParamsAdapter.OnActiveChanged(Sender: TObject);
begin
  if FCustomSQLDataSet <> nil then
  begin
    if FCustomSQLDataSet.Active then
      AddFields
//    else
//      ClearFields;
  end;
end;

procedure TCustomParamsAdapter.SetActive(AValue: Boolean);
begin
  if csLoading in ComponentState then
  begin
    if AValue then
    begin
      FDeferActivate := True;
      Exit;
    end;
  end;
  inherited;
end;

procedure TCustomParamsAdapter.SetCustomSQLDataSet(
  const Value: TCustomSQLDataSet);
begin
  if FCustomSQLDataSet <> Value then
    if FCustomSQLDataSet <> nil then
      FCustomSQLDataSet.RemoveFreeNotification(Self);
  FCustomSQLDataSet := Value;
  if FCustomSQLDataSet <> nil then
    FCustomSQLDataSet.FreeNotification(Self);
end;

procedure TCustomParamsAdapter.SetSQLDataSet(const Value: TSQLDataSet);
begin
  SetCustomSQLDataSet(Value);
end;

procedure TCustomParamsAdapter.SetSQLQuery(const Value: TSQLQuery);
begin
  SetCustomSQLDataSet(Value);
end;

procedure TCustomParamsAdapter.SetSQLServerMethod(
  const Value: TSQLServerMethod);
begin
  SetCustomSQLDataSet(Value);
end;

procedure TCustomParamsAdapter.SetSQLStoredProc(const Value: TSQLStoredProc);
begin
  SetCustomSQLDataSet(Value);
end;

procedure TCustomParamsAdapter.MakeParamField<T>(AParam: TParam);
var
  LField: TBindSourceAdapterField;
  LParamReader: TValueReader<T>;
  LParamWriter: TValueWriter<T>;
  LTypeName: string;
  LTypeKind: TTypeKind;
begin
  LParamWriter := nil;
  LParamReader := nil;
  LTypeName := PTypeInfo(TypeInfo(T)).NameFld.ToString;
  LTypeKind := PTypeInfo(TypeInfo(T)).Kind;
  case AParam.ParamType of
    //ptUnknown: ;
    ptInput,
    ptOutput,
    ptInputOutput,
    ptResult:
    begin
      // Note that a param name rather than TParam is stored to make adapter fields less sensitive to destruction of TParam by the command.
      // Two reasons.  1) can't tell when a TParam is destroyed.  2) LiveBindings designer shows fields even if the command is closed.
      if AParam.ParamType in [ptInput, ptInputOutput] then
        LParamWriter := TValueWriterProc<T>.Create(AParam.Name,
            procedure(AName: string; AValue: T)
            var
              LParam: TParam;
            begin
              if FCustomSQLDataSet <> nil then
              begin
                LParam := FCustomSQLDataSet.ParamByName(AName); //raises exception if not found
                //LParam.Value := TValue.From<T>(AValue).ToString;
                case LTypeKind of
                  //tkUnknown,tkClassRef,tkPointer,tkProcedure,tkSet,tkClass,tkMethod,tkArray,tkRecord,tkInterface,tkDynArray,
                  tkEnumeration:
                    if SameText('boolean', LTypeName) then
                      LParam.AsBoolean := TValue.From<T>(AValue).AsType<Boolean>
                    else
                      raise Exception.CreateFmt('Unsupported ParamType "%s" %s to %s',
                        [LParam.Name, GetEnumName(TypeInfo(TParamType), Integer(LParam.ParamType)), LTypeName]);
                  tkInteger:
                    LParam.AsInteger := TValue.From<T>(AValue).AsType<Integer>;
                  tkInt64:
                    LParam.AsLargeInt := TValue.From<T>(AValue).AsType<Int64>;
                  tkFloat:
                    LParam.AsFloat := TValue.From<T>(AValue).AsType<Extended>;
                  tkLString,tkWString,tkUString,tkString,tkWChar,tkChar:
                    LParam.AsString := TValue.From<T>(AValue).AsType<string>;
                  tkVariant:
                    LParam.Value := TValue.From<T>(AValue).AsType<Variant>;
                  else
                    raise Exception.CreateFmt('Unsupported ParamType "%s" %s to %s',
                      [LParam.Name, GetEnumName(TypeInfo(TParamType), Integer(AParam.ParamType)), LTypeName]);
                end;
              end;                              
            end);
      LParamReader := TValueReaderFunc<T>.Create(AParam.Name,
          function(AName: string): T
          var
            LParam: TParam;
          begin
            if FCustomSQLDataSet <> nil then
            begin
              LParam := FCustomSQLDataSet.ParamByName(AName);  //raises exception if not found
              if LParam.IsNull then
              begin
                case LTypeKind of
                  //tkUnknown,tkClassRef,tkPointer,tkProcedure,tkSet,tkClass,tkMethod,tkArray,tkRecord,tkInterface,tkDynArray,
                  tkEnumeration:
                    if SameText('boolean', LTypeName) then
                      Result := TValue.From<Boolean>(False).AsType<T>
                    else
                      raise Exception.CreateFmt('Unsupported ParamType "%s" %s to %s',
                        [LParam.Name, GetEnumName(TypeInfo(TParamType), Integer(LParam.ParamType)), LTypeName]);
                  tkInteger:
                    Result := TValue.From<Integer>(0).AsType<T>;
                  tkInt64:
                    Result := TValue.From<Int64>(0).AsType<T>;
                  tkFloat:
                    Result := TValue.From<Extended>(0).AsType<T>;
                  tkLString,tkWString,tkUString,tkString,tkWChar,tkChar:
                    Result := TValue.From<string>('').AsType<T>;
                  tkVariant:
                    Result := TValue.From<Variant>(0).AsType<T>; // might not be supported anyhow
                  else
                    raise Exception.CreateFmt('Unsupported ParamType "%s" %s to %s',
                      [LParam.Name, GetEnumName(TypeInfo(TParamType), Integer(AParam.ParamType)), LTypeName]);
                end;
              end
              else
              begin
                case LTypeKind of
                  //tkUnknown,tkClassRef,tkPointer,tkProcedure,tkSet,tkClass,tkMethod,tkArray,tkRecord,tkInterface,tkDynArray,
                  tkEnumeration:
                    if SameText('boolean', LTypeName) then
                      Result := TValue.From<Boolean>(LParam.AsBoolean).AsType<T>
                    else
                      raise Exception.CreateFmt('Unsupported ParamType "%s" %s to %s',
                        [LParam.Name, GetEnumName(TypeInfo(TParamType), Integer(LParam.ParamType)), LTypeName]);
                  tkInteger:
                    Result := TValue.From<Integer>(LParam.AsInteger).AsType<T>;
                  tkInt64:
                    Result := TValue.From<Int64>(LParam.AsLargeInt).AsType<T>;
                  tkFloat:
                    Result := TValue.From<Extended>(LParam.AsFloat).AsType<T>;
                  tkLString,tkWString,tkUString,tkString,tkWChar,tkChar:
                    Result := TValue.From<string>(LParam.AsString).AsType<T>;
                  tkVariant:
                    Result := TValue.From<Variant>(LParam.Value).AsType<T>; // might not be supported anyhow
                  else
                    raise Exception.CreateFmt('Unsupported ParamType "%s" %s to %s',
                      [LParam.Name, GetEnumName(TypeInfo(TParamType), Integer(AParam.ParamType)), LTypeName]);
                end;
              end;
            end
            else
              raise Exception.Create('FCustomSQLDataSet was nil!');
          end);

      if LParamWriter <> nil then
        LField := TFieldUtils.CreateField<T>(Self, AParam.Name,
          TScopeMemberType.mtText,
          LParamReader,
          LParamWriter)
      else
        LField := TFieldUtils.CreateField<T>(Self, AParam.Name,
          TScopeMemberType.mtText,
          LParamReader);
      Self.AddField(LField);
    end;
  else
    raise Exception.CreateFmt('Unsupported ParamType "%s" %s', [AParam.Name, GetEnumName(TypeInfo(TParamType), Integer(AParam.ParamType))]);
  end;
end;

procedure TCustomParamsAdapter.AddFields;
var
  I: Integer;
  LParams: TParams;
  LParam: TParam;
begin
  ClearFields;
  if FCustomSQLDataSet <> nil then
  begin
    LParams := GetParams;
    for I := 0 to LParams.Count - 1 do
    begin
      LParam := LParams[I];
      case LParam.DataType of
        //ftUnknown,ftBCD,ftTime,ftDateTime,ftDate,
        //ftBytes,ftVarBytes,ftAutoInc,ftBlob,ftGraphic,ftFmtMemo,ftParadoxOle,ftDBaseOle,ftTypedBinary,ftCursor,ftADT,
        //ftArray,ftReference,ftDataSet,ftOraBlob,ftOraClob,ftInterface,ftIDispatch,ftGuid,ftTimeStamp,ftFMTBcd,
        //ftOraTimeStamp,ftOraInterval,ftExtended,ftConnection,ftParams,ftStream,ftTimeStampOffset,ftObject,
        TFieldType.ftWord: MakeParamField<Word>(LParam);
        TFieldType.ftByte: MakeParamField<Byte>(LParam);
        TFieldType.ftLongWord: MakeParamField<LongWord>(LParam);
        TFieldType.ftSmallint,TFieldType.ftShortint,TFieldType.ftInteger: MakeParamField<Integer>(LParam);
        TFieldType.ftLargeint: MakeParamField<Int64>(LParam);
        TFieldType.ftSingle: MakeParamField<Single>(LParam);
        TFieldType.ftFloat: MakeParamField<Extended>(LParam);
        TFieldType.ftCurrency: MakeParamField<Currency>(LParam);
        TFieldType.ftBoolean: MakeParamField<Boolean>(LParam);
        TFieldType.ftMemo,TFieldType.ftWideMemo,TFieldType.ftFixedWideChar,
        TFieldType.ftString,TFieldType.ftFixedChar,
        TFieldType.ftWideString: MakeParamField<string>(LParam);
        TFieldType.ftVariant: MakeParamField<Variant>(LParam);
      else
        raise Exception.CreateFmt('Unsupported param "%s" %s', [LParam.Name, GetEnumName(TypeInfo(TFieldType), Integer(LParam.DataType))]);
      end;
    end;
  end;
end;

function TCustomParamsAdapter.GetCanActivate: Boolean;
begin
  Result := (FCustomSQLDataSet <> nil);
end;

end.
