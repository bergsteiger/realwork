{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcDBCtlReg;

interface
{.$I dc.inc}
{$I dcprod.inc}
uses
  Classes, db, typinfo {$IFDEF USEBDE},dbtables{$ENDIF}, dialogs, controls, sysutils, dbctrls,

  {$IFDEF USEOWNDSGNSTUFF}
  dcdsgnstuff,
  {$ELSE}
    {$IFDEF D6}
    DesignIntf,DesignEditors,VCLEditors,
    {$ELSE}
    dsgnintf,
    {$ENDIF}
  {$ENDIF}

  dcconsts, dcsystem, dcdbctl;

type
  TFieldNameProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
    function GetDataSource(instance : TComponent) : TDataSource; virtual; abstract;
  end;

  TDBStringProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValueList(List: TStrings); virtual; abstract;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TDataFieldProperty = class(TDBStringProperty)
  public
    function GetDataSourcePropName: string; virtual;
    procedure GetValueList(List: TStrings); override;
  end;

procedure Register;

implementation

type
  TDBLookupFieldProperty = class (TFieldNameProperty)
  public
    function GetDataSource(instance : TComponent) : TDataSource; override;
  end;

  TEditDataFieldProperty = class (TFieldNameProperty)
  protected
    function GetDataSource(instance : TComponent) : TDataSource; override;
  end;

  TEditLookupFieldProperty = class (TFieldNameProperty)
  protected
    function GetDataSource(instance : TComponent) : TDataSource; override;
  end;

  TDataSetProperty = class(TComponentProperty)
  private
    FCheckProc: TGetStrProc;
    procedure CheckComponent(const Value: string);
  public
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TLookupSourceProperty = class(TDBStringProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

  TLookupDestProperty = class(TDBStringProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

  TListFieldProperty = class(TDataFieldProperty)
  public
    function GetDataSourcePropName: string; override;
  end;

{$IFDEF USEBDE}
  TDataSourceProperty = class(TComponentProperty)
  private
    FCheckProc: TGetStrProc;
    procedure CheckComponent(const Value: string);
  public
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TSessionNameProperty = class(TDBStringProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

  TDatabaseNameProperty = class(TDBStringProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

  TAliasNameProperty = class(TDBStringProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

  TDriverNameProperty = class(TDBStringProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

  TDatabaseEditor = class(TDefaultEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  TBatchMoveEditor = class(TDefaultEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  TTableNameProperty = class(TDBStringProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

  TIndexNameProperty = class(TDBStringProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

  TProcedureNameProperty = class(TDBStringProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

  TIndexFieldNamesProperty = class(TDBStringProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;
{$ENDIF}

{------------------------------------------------------------------}

type
  T_PopupDBGrid = class(TPopupDBGrid)
  end;

function TEditDataFieldProperty.GetDataSource(instance : TComponent) : TDataSource;
begin
  result := T_PopupDBGrid(instance).DataSource;
end;

{------------------------------------------------------------------}

function TEditLookupFieldProperty.GetDataSource(instance : TComponent) : TDataSource;
begin
  result := TLookupFieldDataSource(instance).LookupSource;
end;

{******************************************************************}

function TFieldNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList];
end;

{------------------------------------------------------------------}

procedure TFieldNameProperty.GetValues(Proc: TGetStrProc);
var
  i        : integer;
  list     : TStringList;
  dsource  : TDataSource;
  Instance : TComponent;
begin
  list := TStringList.Create;
  try
    Instance := TComponent(GetComponent(0));
    dsource := GetDataSource(Instance);
    if (dsource <> nil) then
      with dSource do
        if DataSet <> nil then
          begin
            DataSet.GetFieldNames(list);
            for i := 0 to list.Count - 1 do
              Proc(list[I]);
          end;
  finally
    list.Free;
  end;
end;

{******************************************************************}

procedure TDataSetProperty.CheckComponent(const Value: string);
var
  J: Integer;
  Dataset: TDataset;
begin
  Dataset := TDataset(Designer.GetComponent(Value));
  for J := 0 to PropCount - 1 do
    if TDataSource(GetComponent(J)).IsLinkedTo(Dataset) then
      Exit;
  FCheckProc(Value);
end;

{------------------------------------------------------------------}

procedure TDataSetProperty.GetValues(Proc: TGetStrProc);
begin
  FCheckProc := Proc;
  inherited GetValues(CheckComponent);
end;

{------------------------------------------------------------------}

function TDBStringProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paMultiSelect];
end;

{------------------------------------------------------------------}

procedure TDBStringProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  Values: TStringList;
begin
  Values := TStringList.Create;
  try
    GetValueList(Values);
    for I := 0 to Values.Count - 1 do Proc(Values[I]);
  finally
    Values.Free;
  end;
end;

{------------------------------------------------------------------}

procedure TLookupSourceProperty.GetValueList(List: TStrings);
begin
  with GetComponent(0) as TField do
    if DataSet <> nil then DataSet.GetFieldNames(List);
end;

{******************************************************************}

procedure TLookupDestProperty.GetValueList(List: TStrings);
begin
  with GetComponent(0) as TField do
    if LookupDataSet <> nil then LookupDataSet.GetFieldNames(List);
end;

{------------------------------------------------------------------}

function TDataFieldProperty.GetDataSourcePropName: string;
begin
  Result := 'DataSource'; //don't resource
end;

{------------------------------------------------------------------}

procedure TDataFieldProperty.GetValueList(List: TStrings);
var
  Instance: TComponent;
  PropInfo: PPropInfo;
  DataSource: TDataSource;
begin
  Instance := TComponent(GetComponent(0));
  PropInfo := TypInfo.GetPropInfo(Instance.ClassInfo, GetDataSourcePropName);
  if (PropInfo <> nil) and (PropInfo^.PropType^.Kind = tkClass) then
  begin
    DataSource := TDataSource(GetOrdProp(Instance, PropInfo));
    if (DataSource <> nil) and (DataSource.DataSet<>nil)then
      DataSource.DataSet.GetFieldNames(List);
  end;
end;

{******************************************************************}

function TListFieldProperty.GetDataSourcePropName: string;
begin
  Result := 'ListSource';//don't resource
end;

{------------------------------------------------------------------}
{$IFDEF USEBDE}

procedure TDataSourceProperty.CheckComponent(const Value: string);
var
  J: Integer;
  DataSource: TDataSource;
begin
  DataSource := TDataSource(Designer.GetComponent(Value));
  for J := 0 to PropCount - 1 do
    if TDataSet(GetComponent(J)).IsLinkedTo(DataSource) then
      Exit;
  FCheckProc(Value);
end;

{------------------------------------------------------------------}

procedure TDataSourceProperty.GetValues(Proc: TGetStrProc);
begin
  FCheckProc := Proc;
  inherited GetValues(CheckComponent);
end;

{------------------------------------------------------------------}

procedure TSessionNameProperty.GetValueList(List: TStrings);
begin
  Sessions.GetSessionNames(List);
end;

{------------------------------------------------------------------}

procedure TDatabaseNameProperty.GetValueList(List: TStrings);
begin
  (GetComponent(0) as TDBDataSet).DBSession.GetDatabaseNames(List);
end;

{------------------------------------------------------------------}

procedure TAliasNameProperty.GetValueList(List: TStrings);
begin
  (GetComponent(0) as TDatabase).Session.GetAliasNames(List);
end;

{------------------------------------------------------------------}

procedure TDriverNameProperty.GetValueList(List: TStrings);
begin
  (GetComponent(0) as TDatabase).Session.GetDriverNames(List);
end;

{------------------------------------------------------------------}

function GetTableExtension(TableType:TTableType):String;
begin
  case TableType of
    ttParadox:
      Result:='*.DB';//don't resource
    ttDBase{$IFDEF CPB3},ttFoxPro{$ENDIF}:
      Result:='*.DBF';//don't resource
    ttASCII:
      Result:='*.TXT';//don't resource
  else
    Result:='';
  end;
end;

{------------------------------------------------------------------}

procedure TTableNameProperty.GetValueList(List: TStrings);
begin
  With GetComponent(0) as TTable do
    DBSession.GetTableNames(DatabaseName, GetTableExtension(TableType),
      TableType = ttDefault, False, List);
end;

{------------------------------------------------------------------}

procedure TIndexNameProperty.GetValueList(List: TStrings);
begin
  (GetComponent(0) as TTable).GetIndexNames(List);
end;

{------------------------------------------------------------------}

procedure TProcedureNameProperty.GetValueList(List: TStrings);
var
  DBDataSet: TDBDataSet;
begin
  DBDataSet := GetComponent(0) as TDBDataSet;
  DBDataSet.DBSession.GetStoredProcNames(DBDataSet.DatabaseName, List);
end;

{------------------------------------------------------------------}

procedure TIndexFieldNamesProperty.GetValueList(List: TStrings);
var
  I: Integer;
begin
  with GetComponent(0) as TTable do
  begin
    IndexDefs.Update;
    for I := 0 to IndexDefs.Count - 1 do
      with IndexDefs[I] do
        if not (ixExpression in Options) then List.Add(Fields);
  end;
end;

{------------------------------------------------------------------}

procedure TDatabaseEditor.ExecuteVerb(Index: Integer);
Var
  DB:TDatabase;
begin
  if index = 0 then
  begin
    If MessageDlg(SLoadDefault, mtConfirmation,[mbYes,mbNo],0)<>mrYes then
      exit;
    DB:=TDatabase(Component);
    if DB.AliasName <> '' then
      DB.Session.GetAliasParams(DB.AliasName, DB.Params)
    else
      if DB.DriverName <> '' then
        DB.Session.GetDriverParams(DB.DriverName, DB.Params)
    else
      raise Exception.Create(SErrNoAliasOrDriver);
  end;
end;

{------------------------------------------------------------------}

function TDatabaseEditor.GetVerb(Index: Integer): string;
begin
  result := SVerbLoadDefault;
end;

{------------------------------------------------------------------}

function TDatabaseEditor.GetVerbCount: Integer;
begin
  result := 1;
end;

{------------------------------------------------------------------}

function TBatchMoveEditor.GetVerbCount: Integer;
begin
  result := 1;
end;

{------------------------------------------------------------------}

function TBatchMoveEditor.GetVerb(Index: Integer): string;
begin
  result := SVerbExecute;
end;

{------------------------------------------------------------------}

procedure TBatchMoveEditor.ExecuteVerb(Index: Integer);
begin
  (Component as TBatchMove).Execute;
end;

{$ENDIF}

{-----------------------------------------------------------}

function TDBLookupFieldProperty.GetDataSource(instance : TComponent) : TDataSource;
begin
  result := TDCDBLookup(Instance).LookupSource;
end;

{------------------------------------------------------------------}

procedure _InstantRegister;
begin
//BeginSkipConst
  RegisterPropertyEditor(TypeInfo(TDataSet), TDataSource, 'DataSet', TDataSetProperty);
  {$IFDEF USEBDE}
  RegisterPropertyEditor(TypeInfo(TDataSource), TTable, 'MasterSource', TDataSourceProperty);
  RegisterPropertyEditor(TypeInfo(TDataSource), TQuery, 'DataSource', TDataSourceProperty);
  RegisterPropertyEditor(TypeInfo(string), TDatabase, 'AliasName', TAliasNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TDatabase, 'DriverName', TDriverNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TDatabase, 'SessionName', TSessionNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TDBDataSet, 'SessionName', TSessionNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TDBDataSet, 'DatabaseName', TDatabaseNameProperty);
  RegisterPropertyEditor(TypeInfo({$IFDEF CPB3}TFileName{$ELSE}string{$ENDIF}), TTable, 'TableName', TTableNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TTable, 'IndexName', TIndexNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TTable, 'IndexFieldNames', TIndexFieldNamesProperty);
  RegisterPropertyEditor(TypeInfo(string), TStoredProc, 'StoredProcName', TProcedureNameProperty);
  RegisterComponentEditor(TDatabase, TDatabaseEditor);
  RegisterComponentEditor(TBatchMove, TBatchMoveEditor);
  RegisterPropertyEditor(TypeInfo(TDataSetUpdateObject), TDataSet, 'UpdateObject', TComponentProperty);
  {$ENDIF}
  RegisterPropertyEditor(TypeInfo(string), TField, 'KeyFields', TLookupSourceProperty);
  RegisterPropertyEditor(TypeInfo(string), TField, 'LookupKeyFields', TLookupDestProperty);
  RegisterPropertyEditor(TypeInfo(string), TField, 'LookupResultField', TLookupDestProperty);
  RegisterPropertyEditor(TypeInfo(string), TComponent, 'DataField', TDataFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TDBLookupControl, 'KeyField', TListFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TDBLookupControl, 'ListField', TListFieldProperty);
//EndSkipConst
end;

{-----------------------------------------------------------}
//BeginSkipConst
procedure _Register;
begin
end;

//EndSkipConst

procedure RunRegister;
begin
  RegisterForInstant(_InstantRegister);
  RegisterForDelphi(_Register);
end;

{------------------------------------------------------------------}

procedure Register;
begin
  RegisterPropertyEditor(TypeInfo(string), TPopupDBGrid, 'DisplayField', TEditDataFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TLookupFieldDataSource, 'LookupField', TEditLookupFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TLookupFieldDataSource, 'KeyField', TEditLookupFieldProperty);

  RegisterPropertyEditor(TypeInfo(string), TDCDBLookup, 'LookupField', TDBLookupFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TDCDBLookup, 'KeyField', TDBLookupFieldProperty);
  RegisterClass(TFieldDataSource);
end;

initialization
  RunRegister;
end.
