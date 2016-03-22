unit pgTableModifier;

// Модуль: "w:\common\components\rtl\Garant\PG\pgTableModifier.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TpgTableModifier" MUID: (564B212F02DA)

{$Include w:\common\components\rtl\Garant\PG\pgDefine.inc}

interface

{$If Defined(UsePostgres)}
uses
 l3IntfUses
 , l3ProtoObject
 , daParamList
 , daInterfaces
 , pgConnection
 , daTypes
;

type
 TpgTableModifier = class(Tl3ProtoObject)
  private
   f_Params: TdaParamList;
   f_DataConverter: IdaDataConverter;
   f_InsertName: AnsiString;
   f_Connection: TpgConnection;
   f_TableID: TdaTables;
  private
   procedure BuildSQLAndFillParams(aTableID: TdaTables;
    out anSQL: AnsiString;
    aParams: TdaParamList);
   procedure PrepareSQL(aTableID: TdaTables);
   procedure UnPrepareSQL;
  protected
   function pm_GetParams(const Name: AnsiString): IdaParam;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aTableID: TdaTables;
    aConnection: TpgConnection;
    const aDataConverter: IdaDataConverter); reintroduce;
   procedure Insert;
   function BeginTransaction: Boolean;
   procedure CommitTransaction;
   procedure RollBackTransaction;
  public
   property Params[const Name: AnsiString]: IdaParam
    read pm_GetParams;
 end;//TpgTableModifier
{$IfEnd} // Defined(UsePostgres)

implementation

{$If Defined(UsePostgres)}
uses
 l3ImplUses
 , SysUtils
 , LibPQ
 , pgUtils
 , pgInterfaces
 , daScheme
 , daParam
 , daFieldParamDescription
;

function TpgTableModifier.pm_GetParams(const Name: AnsiString): IdaParam;
//#UC START# *564C2778019B_564B212F02DAget_var*
var
 l_IDX: Integer;
//#UC END# *564C2778019B_564B212F02DAget_var*
begin
//#UC START# *564C2778019B_564B212F02DAget_impl*
 if f_Params.FindData(Name, l_IDX) then
  Result := f_Params[l_IDX]
 else
  Result := nil;
//#UC END# *564C2778019B_564B212F02DAget_impl*
end;//TpgTableModifier.pm_GetParams

constructor TpgTableModifier.Create(aTableID: TdaTables;
 aConnection: TpgConnection;
 const aDataConverter: IdaDataConverter);
//#UC START# *564C1BDD02FE_564B212F02DA_var*
//#UC END# *564C1BDD02FE_564B212F02DA_var*
begin
//#UC START# *564C1BDD02FE_564B212F02DA_impl*
 inherited Create;
 f_TableID := aTableID;
 f_Params := TdaParamList.Make;
 f_DataConverter := aDataConverter;
 aConnection.SetRefTo(f_Connection);
 PrepareSQL(aTableID);
//#UC END# *564C1BDD02FE_564B212F02DA_impl*
end;//TpgTableModifier.Create

procedure TpgTableModifier.BuildSQLAndFillParams(aTableID: TdaTables;
 out anSQL: AnsiString;
 aParams: TdaParamList);
//#UC START# *564C664702D3_564B212F02DA_var*
var
 l_Table: IdaTableDescription;
 l_Fields: AnsiString;
 l_Values: AnsiString;
 l_ParamIDX: Integer;

 function DoBuild(const anItem: IdaFieldDescription): Boolean;
 begin
  Result := True;
  if l_Fields <> '' then
   l_Fields := l_Fields + ', ';
  if l_Values <> '' then
   l_Values := l_Values + ', ';
  l_Fields := l_Fields + anItem.SQLName;
  l_Values := l_Values + Format('$%d', [l_ParamIDX]);
  Inc(l_ParamIDX);
  aParams.Add(TdaParam.Make(f_DataConverter, TdaFieldParamDescription.Make(anItem)));
 end;

//#UC END# *564C664702D3_564B212F02DA_var*
begin
//#UC START# *564C664702D3_564B212F02DA_impl*
 aParams.Clear;
 l_Fields := '';
 l_Values := '';
 l_ParamIDX := 1;
 l_Table := TdaScheme.Instance.Table(aTableID);
 l_Table.IterateFieldsF(L2DaTableDescriptionIteratorIterateFieldsFAction(@DoBuild));
 anSQL := Format('INSERT INTO %s.%s (%s)'#13#10'VALUES'#13#10'(%s);', [TdaScheme.Instance.CheckScheme(l_Table.Scheme), l_Table.SQLName, l_Fields, l_Values])
//#UC END# *564C664702D3_564B212F02DA_impl*
end;//TpgTableModifier.BuildSQLAndFillParams

procedure TpgTableModifier.PrepareSQL(aTableID: TdaTables);
//#UC START# *564C66AF0221_564B212F02DA_var*
var
 l_Result: PPGResult;
 l_SQL: AnsiString;
//#UC END# *564C66AF0221_564B212F02DA_var*
begin
//#UC START# *564C66AF0221_564B212F02DA_impl*
 f_InsertName := Format('Ins%p', [Pointer(Self)]);
 BuildSQLAndFillParams(aTableID, l_SQL, f_Params);
 l_Result := PQprepare(f_Connection.Handle, PAnsiChar(f_InsertName),  PAnsiChar(l_SQL), f_Params.Count, nil);
 try
  pgCheckStatus(l_Result);
 finally
  PQclear(l_Result);
 end;
//#UC END# *564C66AF0221_564B212F02DA_impl*
end;//TpgTableModifier.PrepareSQL

procedure TpgTableModifier.UnPrepareSQL;
//#UC START# *564C66BE013F_564B212F02DA_var*
var
 l_Result: PPGResult;
//#UC END# *564C66BE013F_564B212F02DA_var*
begin
//#UC START# *564C66BE013F_564B212F02DA_impl*
 l_Result := PQExec(f_Connection.Handle, PAnsiChar(Format('DEALLOCATE PREPARED %s', [f_InsertName])));
 try
  f_InsertName := '';
  pgCheckStatus(l_Result);
 finally
  PQClear(l_Result);
 end;
//#UC END# *564C66BE013F_564B212F02DA_impl*
end;//TpgTableModifier.UnPrepareSQL

procedure TpgTableModifier.Insert;
//#UC START# *564C58CD016F_564B212F02DA_var*
var
 l_ParamsValue: array of AnsiString;
 l_ParamsValuePtr: TPQparamValues;
 l_Result: PPGResult;
 l_IDX: Integer;
//#UC END# *564C58CD016F_564B212F02DA_var*
begin
//#UC START# *564C58CD016F_564B212F02DA_impl*
 SetLength(l_ParamsValue, f_Params.Count);
 SetLength(l_ParamsValuePtr, f_Params.Count);
 for l_IDX := 0 to f_Params.Count - 1 do
 begin
  l_ParamsValue[l_IDX] := f_Params[l_IDX].AsString;
  l_ParamsValuePtr[l_IDX] := @l_ParamsValue[l_IDX][1];
 end;
 l_Result := PQexecPrepared(f_Connection.Handle, PAnsiChar(f_InsertName), f_Params.Count, l_ParamsValuePtr, nil, 0, 0);
 try
  if not (PQresultStatus(l_Result) in [PGRES_COMMAND_OK]) then
   raise EpgError.Create(PQresultErrorMessage(l_Result));
 finally
  PQclear(l_Result);
 end;
//#UC END# *564C58CD016F_564B212F02DA_impl*
end;//TpgTableModifier.Insert

function TpgTableModifier.BeginTransaction: Boolean;
//#UC START# *565C36A402A0_564B212F02DA_var*
//#UC END# *565C36A402A0_564B212F02DA_var*
begin
//#UC START# *565C36A402A0_564B212F02DA_impl*
 Result := f_Connection.BeginTransaction([f_TableID]);
//#UC END# *565C36A402A0_564B212F02DA_impl*
end;//TpgTableModifier.BeginTransaction

procedure TpgTableModifier.CommitTransaction;
//#UC START# *565C36BF0228_564B212F02DA_var*
//#UC END# *565C36BF0228_564B212F02DA_var*
begin
//#UC START# *565C36BF0228_564B212F02DA_impl*
 f_Connection.CommitTransaction;
//#UC END# *565C36BF0228_564B212F02DA_impl*
end;//TpgTableModifier.CommitTransaction

procedure TpgTableModifier.RollBackTransaction;
//#UC START# *565C36CE0339_564B212F02DA_var*
//#UC END# *565C36CE0339_564B212F02DA_var*
begin
//#UC START# *565C36CE0339_564B212F02DA_impl*
 f_Connection.RollBackTransaction;
//#UC END# *565C36CE0339_564B212F02DA_impl*
end;//TpgTableModifier.RollBackTransaction

procedure TpgTableModifier.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_564B212F02DA_var*
//#UC END# *479731C50290_564B212F02DA_var*
begin
//#UC START# *479731C50290_564B212F02DA_impl*
 UnPrepareSQL;
 FreeAndNil(f_Params);
 f_DataConverter := nil;
 FreeAndNil(f_Connection);
 inherited;
//#UC END# *479731C50290_564B212F02DA_impl*
end;//TpgTableModifier.Cleanup
{$IfEnd} // Defined(UsePostgres)

end.
