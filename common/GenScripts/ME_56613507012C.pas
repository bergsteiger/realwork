unit pgFunctionFactory;

// Модуль: "w:\common\components\rtl\Garant\PG\pgFunctionFactory.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TpgFunctionFactory" MUID: (56613507012C)

{$Include w:\common\components\rtl\Garant\PG\pgDefine.inc}

interface

{$If Defined(UsePostgres)}
uses
 l3IntfUses
 , l3ProtoObject
 , pgConnection
 , daInterfaces
 , pgParamDecsriptionList
 , daTypes
;

type
 TTypeMapRec = record
  rName: AnsiString;
  rType: TdaDataType;
 end;//TTypeMapRec

 TpgFunctionFactory = class(Tl3ProtoObject)
  private
   f_Connection: TpgConnection;
   f_TypesQueryName: AnsiString;
   f_FunctionsQueryName: AnsiString;
   f_DataConverter: IdaDataConverter;
  private
   procedure FillParamDescriptions(aList: TpgParamDecsriptionList;
    const aFunctionName: AnsiString;
    const aSchemeName: AnsiString;
    out theIsRetCursor: Boolean);
   function ConvertType(const anOID: AnsiString): AnsiString;
   procedure InitTypesQuery;
   procedure DoneTypesQuery;
   procedure InitFuctionsQuery;
   procedure DoneFuctionsQuery;
   function ExtractDataType(const aDataType: AnsiString): TdaDataType;
   function ExtractParamType(const aParamType: AnsiString): TdaParamType;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aConnection: TpgConnection;
    const aDataConverter: IdaDataConverter); reintroduce;
   function MakeFunction(const aFunctionName: AnsiString;
    const aSchemeName: AnsiString = ''): IdaFunction;
 end;//TpgFunctionFactory
{$IfEnd} // Defined(UsePostgres)

implementation

{$If Defined(UsePostgres)}
uses
 l3ImplUses
 , LibPQ
 , SysUtils
 , daScheme
 , pgInterfaces
 , Classes
 , pgUtils
 , pgFunctionParamDescription
 , pgFunction
;

const
 cFunctionParamsCount = 2;
 cTypesParamsCount = 1;
 cTypeNameParamIndex = 0;
 cProcNameParamIndex = 0;
 cSchemaNameParamIndex = 1;

constructor TpgFunctionFactory.Create(aConnection: TpgConnection;
 const aDataConverter: IdaDataConverter);
//#UC START# *56653588036D_56613507012C_var*
//#UC END# *56653588036D_56613507012C_var*
begin
//#UC START# *56653588036D_56613507012C_impl*
 inherited Create;
 aConnection.SetRefTo(f_Connection);
 f_DataConverter := aDataConverter;
 InitTypesQuery;
 InitFuctionsQuery;
//#UC END# *56653588036D_56613507012C_impl*
end;//TpgFunctionFactory.Create

procedure TpgFunctionFactory.FillParamDescriptions(aList: TpgParamDecsriptionList;
 const aFunctionName: AnsiString;
 const aSchemeName: AnsiString;
 out theIsRetCursor: Boolean);
//#UC START# *56653EE801A9_56613507012C_var*
var
 l_Result: PPGresult;
 l_ArgsStr: String;
 l_ArgsList: TStringList;
 l_ModesStr: String;
 l_ModesList: TSTringList;
 l_IDX: Integer;
 l_NamesStr: String;
 l_NamesList: TSTringList;
 l_AllInput: Boolean;
 l_RetType: String;
 l_ParamsValue: array of AnsiString;
 l_ParamsValuePtr: TPQparamValues;
const
 cVariadicIDX = 0;
 cReturnSet = 1;
 cRetTypeIDX = 2;
 cAgrsIDX = 3;
 cAllAgrsIDX = 4;
 cModesIDX = 5;
 cParamsIDX = 6;

 function lp_RepairStr(const aStr: String): String;
 begin
  if Length(aStr) > 1 then
  begin
   Result := StringReplace(aStr, ' ', ',', [rfReplaceAll, rfIgnoreCase]);
   if Result[1] = '{' then
    Result := Copy(Result, 2, Length(l_ArgsStr) - 2);
  end
  else
   Result := aStr;
 end;

 function lp_MakeList(const aStr: String): TStringList;
 begin
  Result := TStringList.Create;
  Result.Delimiter := ',';
  Result.QuoteChar := '"';
  Result.DelimitedText := aStr;
 end;

//#UC END# *56653EE801A9_56613507012C_var*
begin
//#UC START# *56653EE801A9_56613507012C_impl*
 aList.Clear;
 SetLength(l_ParamsValue, cFunctionParamsCount);
 SetLength(l_ParamsValuePtr, cFunctionParamsCount);
 l_ParamsValue[cProcNameParamIndex] := aFunctionName;
 l_ParamsValue[cSchemaNameParamIndex] := aSchemeName;
 for l_IDX := 0 to cFunctionParamsCount - 1 do
  l_ParamsValuePtr[l_IDX] := @l_ParamsValue[l_IDX][1];
 l_Result := PQexecPrepared(f_Connection.Handle, PAnsiChar(f_FunctionsQueryName), cFunctionParamsCount, l_ParamsValuePtr, nil, 0, 0);
 try
  if not (PQresultStatus(l_Result) in [PGRES_EMPTY_QUERY, PGRES_COMMAND_OK, PGRES_TUPLES_OK]) then
   raise EpgError.Create(PQresultErrorMessage(l_Result));
  Assert(PQntuples(l_Result) = 1);
  Assert(PQgetvalue(l_Result, 0, cVariadicIDX) = '0', 'Variadic not supported');
  theIsRetCursor := PQgetvalue(l_Result, 0, cReturnSet) = 't';
  l_ArgsStr := PQgetvalue(l_Result, 0, cAllAgrsIDX);
  if l_ArgsStr = '' then
   l_ArgsStr := PQgetvalue(l_Result, 0, cAgrsIDX);
  l_ArgsStr := lp_RepairStr(l_ArgsStr);
  l_ArgsList := lp_MakeList(l_ArgsStr);
  try
   for l_IDX := 0 to l_ArgsList.Count - 1 do
     l_ArgsList[l_IDX] := ConvertType(l_ArgsList[l_IDX]);
   l_ModesStr := lp_RepairStr(PQgetvalue(l_Result, 0, cModesIDX));
   l_ModesList := lp_MakeList(l_ModesStr);
   try
    while l_ModesList.Count < l_ArgsList.Count do
     l_ModesList.Add('i');
    l_NamesStr := lp_RepairStr(PQgetvalue(l_Result, 0, cParamsIDX));
    l_NamesList := lp_MakeList(l_NamesStr);
    try
     while l_NamesList.Count < l_ArgsList.Count do
      l_NamesList.Add('');
     for l_IDX := 0 to l_NamesList.Count - 1 do
      if l_NamesList[l_IDX] = '' then
       l_NamesList[l_IDX] := Format('$%d', [l_IDX + 1]);
     l_AllInput := True;
     for l_IDX := 0 to l_ModesList.Count - 1 do
      if l_ModesList[l_IDX] <> 'i' then
       l_AllInput := False;
     if l_AllInput then
     begin
      l_RetType := ConvertType(PQgetvalue(l_Result, 0, cRetTypeIDX));
      if not ANSISameText(l_RetType, 'void') then
      begin
       l_NamesList.Add(Format('%s.Result', [aFunctionName]));
       l_ModesList.Add('o');
       l_ArgsList.Add(l_RetType);
      end;
     end;
     Assert(l_NamesList.Count = l_ModesList.Count);
     Assert(l_NamesList.Count = l_ArgsList.Count);
     for l_IDX := 0 to l_NamesList.Count - 1 do
      aList.Add(TpgFunctionParamDescription.Make(l_NamesList[l_IDX], ExtractDataType(l_ArgsList[l_IDX]), 0, ExtractParamType(l_ModesList[l_IDX])));
    finally
     FreeAndNil(l_NamesList);
    end;
   finally
    FreeAndNil(l_ModesList);
   end;
  finally
   FreeAndNil(l_ArgsList);
  end;
 finally
  PQclear(l_Result);
 end;
//#UC END# *56653EE801A9_56613507012C_impl*
end;//TpgFunctionFactory.FillParamDescriptions

function TpgFunctionFactory.ConvertType(const anOID: AnsiString): AnsiString;
//#UC START# *566FFAAF03CB_56613507012C_var*
var
 l_ParamsValue: array of AnsiString;
 l_ParamsValuePtr: TPQparamValues;
 l_Result: PPGresult;
 l_IDX: Integer;
//#UC END# *566FFAAF03CB_56613507012C_var*
begin
//#UC START# *566FFAAF03CB_56613507012C_impl*
 SetLength(l_ParamsValue, cTypesParamsCount);
 SetLength(l_ParamsValuePtr, cTypesParamsCount);
 l_ParamsValue[cTypeNameParamIndex] := anOID;
 for l_IDX := 0 to cFunctionParamsCount - 1 do
  l_ParamsValuePtr[l_IDX] := @l_ParamsValue[l_IDX][1];
 l_Result := PQexecPrepared(f_Connection.Handle, PAnsiChar(f_TypesQueryName), cTypesParamsCount, l_ParamsValuePtr, nil, 0, 0);
 try
  if not (PQresultStatus(l_Result) in [PGRES_EMPTY_QUERY, PGRES_COMMAND_OK, PGRES_TUPLES_OK]) then
   raise EpgError.Create(PQresultErrorMessage(l_Result));
  Assert(PQntuples(l_Result) = 1);
  Result := PQgetvalue(l_Result, 0, 0);
 finally
  PQClear(l_Result);
 end;
//#UC END# *566FFAAF03CB_56613507012C_impl*
end;//TpgFunctionFactory.ConvertType

procedure TpgFunctionFactory.InitTypesQuery;
//#UC START# *566FFEC403B2_56613507012C_var*
var
 l_Result: PPGResult;
//#UC END# *566FFEC403B2_56613507012C_var*
begin
//#UC START# *566FFEC403B2_56613507012C_impl*
 f_TypesQueryName := Format('TypQry%p', [Pointer(Self)]);
 l_Result := PQprepare(f_Connection.Handle, PAnsiChar(f_TypesQueryName),  'select typname from pg_type where oid = $1', cTypesParamsCount, nil);
 try
  pgCheckStatus(l_Result);
 finally
  PQclear(l_Result);
 end;
//#UC END# *566FFEC403B2_56613507012C_impl*
end;//TpgFunctionFactory.InitTypesQuery

procedure TpgFunctionFactory.DoneTypesQuery;
//#UC START# *566FFECF0160_56613507012C_var*
var
 l_Result: PPGResult;
//#UC END# *566FFECF0160_56613507012C_var*
begin
//#UC START# *566FFECF0160_56613507012C_impl*
 l_Result := PQExec(f_Connection.Handle, PAnsiChar(Format('DEALLOCATE %s', [f_TypesQueryName])));
 try
  pgCheckStatus(l_Result);
  f_TypesQueryName := '';
 finally
  PQClear(l_Result);
 end;
//#UC END# *566FFECF0160_56613507012C_impl*
end;//TpgFunctionFactory.DoneTypesQuery

procedure TpgFunctionFactory.InitFuctionsQuery;
//#UC START# *567010DA02DE_56613507012C_var*
var
 l_Result: PPGResult;
//#UC END# *567010DA02DE_56613507012C_var*
begin
//#UC START# *567010DA02DE_56613507012C_impl*
 f_FunctionsQueryName := Format('FunQry%p', [Pointer(Self)]);
 l_Result := PQprepare(f_Connection.Handle, PAnsiChar(f_FunctionsQueryName),
   'select p.provariadic, p.proretset, p.prorettype, p.proargtypes, p.proallargtypes, p.proargmodes, p.proargnames '#13#10+
   'from pg_proc p JOIN pg_namespace ns ON (p.pronamespace = ns.oid) '#13#10+
   'where UPPER(p.proname) = UPPER($1) and UPPER(ns.nspname) = UPPER($2)', cFunctionParamsCount, nil);
 try
  pgCheckStatus(l_Result);
 finally
  PQclear(l_Result);
 end;
//#UC END# *567010DA02DE_56613507012C_impl*
end;//TpgFunctionFactory.InitFuctionsQuery

procedure TpgFunctionFactory.DoneFuctionsQuery;
//#UC START# *567010EB0006_56613507012C_var*
var
 l_Result: PPGResult;
//#UC END# *567010EB0006_56613507012C_var*
begin
//#UC START# *567010EB0006_56613507012C_impl*
 l_Result := PQExec(f_Connection.Handle, PAnsiChar(Format('DEALLOCATE %s', [f_FunctionsQueryName])));
 try
  pgCheckStatus(l_Result);
  f_FunctionsQueryName := '';
 finally
  PQClear(l_Result);
 end;
//#UC END# *567010EB0006_56613507012C_impl*
end;//TpgFunctionFactory.DoneFuctionsQuery

function TpgFunctionFactory.ExtractDataType(const aDataType: AnsiString): TdaDataType;
//#UC START# *56728B5D00CA_56613507012C_var*
const
 cTypeCount = 8;
 cMap: array [1..cTypeCount] of TTypeMapRec = (
  (rName: 'VARCHAR'; rType: da_dtChar),
  (rName: 'SMALLINT'; rType: da_dtByte),
//  (rName: ''; rType: da_dtDate),
//  (rName: ''; rType: da_dtTime),
  (rName: 'INT4'; rType: da_dtDWord),
  (rName: 'INT2'; rType: da_dtWord),
  (rName: 'INTEGER'; rType: da_dtInteger),
  (rName: 'BOOL'; rType: da_dtBoolean),
  (rName: 'INT8'; rType: da_dtQWord),
  (rName: 'BIGINT'; rType: da_dtQWord)
 );

(*
++   da_dtChar
 , da_dtByte
 , da_dtDate
 , da_dtTime
++ , da_dtDWord
++ , da_dtWord
 , da_dtInteger
++ , da_dtBoolean
++ , da_dtQWord
*)

var
 l_IDX: Integer;
//#UC END# *56728B5D00CA_56613507012C_var*
begin
//#UC START# *56728B5D00CA_56613507012C_impl*
 for l_IDX := Low(cMap) to High(cMap) do
  if AnsiSameText(aDataType, cMap[l_IDX].rName) then
  begin
   Result := cMap[l_IDX].rType;
   Exit;
  end;
 Assert(False, Format('Prepare stored proc - unknown data type: %s', [aDataType]));
//#UC END# *56728B5D00CA_56613507012C_impl*
end;//TpgFunctionFactory.ExtractDataType

function TpgFunctionFactory.ExtractParamType(const aParamType: AnsiString): TdaParamType;
//#UC START# *56728B7E02D7_56613507012C_var*
//#UC END# *56728B7E02D7_56613507012C_var*
begin
//#UC START# *56728B7E02D7_56613507012C_impl*
 Assert(Length(aParamType) = 1);
 case UpCase(aParamType[1]) of
  'I': Result := da_ptInput;
  'O': Result := da_ptOutput;
  'B': Result := da_ptInOut;
 else
  Assert(False);
 end;
//#UC END# *56728B7E02D7_56613507012C_impl*
end;//TpgFunctionFactory.ExtractParamType

function TpgFunctionFactory.MakeFunction(const aFunctionName: AnsiString;
 const aSchemeName: AnsiString = ''): IdaFunction;
//#UC START# *56616E9800EA_56613507012C_var*
var
 l_ParamsDescription: TpgParamDecsriptionList;
 l_IsRetCursor: Boolean;
//#UC END# *56616E9800EA_56613507012C_var*
begin
//#UC START# *56616E9800EA_56613507012C_impl*
 l_ParamsDescription := TpgParamDecsriptionList.Make;
 try
  FillParamDescriptions(l_ParamsDescription, aFunctionName, aSchemeName, l_IsRetCursor);
  Result := TpgFunction.Make(f_Connection, f_DataConverter, aSchemeName, aFunctionName, l_ParamsDescription, l_IsRetCursor);
 finally
  FreeAndNil(l_ParamsDescription);
 end;
//#UC END# *56616E9800EA_56613507012C_impl*
end;//TpgFunctionFactory.MakeFunction

procedure TpgFunctionFactory.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_56613507012C_var*
//#UC END# *479731C50290_56613507012C_var*
begin
//#UC START# *479731C50290_56613507012C_impl*
 DoneTypesQuery;
 DoneFuctionsQuery;
 f_DataConverter := nil;
 FreeAndNil(f_Connection);
 inherited;
//#UC END# *479731C50290_56613507012C_impl*
end;//TpgFunctionFactory.Cleanup
{$IfEnd} // Defined(UsePostgres)

end.
