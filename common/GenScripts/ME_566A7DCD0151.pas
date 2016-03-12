unit daQuery;

// Модуль: "w:\common\components\rtl\Garant\DA\daQuery.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\DA\daDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , daParamList
;

type
 TdaQuery = class(Tl3ProtoObject, IdaQuery, IdaComboAccessQueryHelper)
  private
   f_DataConverter: IdaDataConverter;
    {* Поле для свойства DataConverter }
   f_Params: TdaParamList;
    {* Поле для свойства Params }
   f_Prepared: Boolean;
    {* Поле для свойства Prepared }
  protected
   procedure PrepareQuery; virtual; abstract;
   procedure UnprepareQuery; virtual; abstract;
   function MakeParamList: TdaParamList; virtual;
   function MakeResultSet(Unidirectional: Boolean): IdaResultSet; virtual; abstract;
   function DoBuildSQLValue(const aHelper: IdaParamListHelper): AnsiString; virtual; abstract;
   function DoMakeParam(const aParamDesc: IdaParamDescription): IdaParam; virtual;
   function OpenResultSet(Unidirectional: Boolean = True): IdaResultSet;
   procedure Prepare;
   function Get_Param(const aName: AnsiString): IdaParam;
   procedure UnPrepare;
   function BuildSQLValue(const aHelper: IdaParamListHelper): AnsiString;
   function AddParam(const aParamDesc: IdaParamDescription): IdaParam;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure BeforeRelease; override;
  public
   constructor Create(const aDataConverter: IdaDataConverter); reintroduce;
  protected
   property DataConverter: IdaDataConverter
    read f_DataConverter;
   property Params: TdaParamList
    read f_Params;
   property Prepared: Boolean
    read f_Prepared
    write f_Prepared;
 end;//TdaQuery

implementation

uses
 l3ImplUses
 , SysUtils
 , daParam
 , daTypes
;

function TdaQuery.MakeParamList: TdaParamList;
//#UC START# *560B861302E9_566A7DCD0151_var*
//#UC END# *560B861302E9_566A7DCD0151_var*
begin
//#UC START# *560B861302E9_566A7DCD0151_impl*
 Result := TdaParamList.Make;
//#UC END# *560B861302E9_566A7DCD0151_impl*
end;//TdaQuery.MakeParamList

constructor TdaQuery.Create(const aDataConverter: IdaDataConverter);
//#UC START# *566A7F3C01D9_566A7DCD0151_var*
//#UC END# *566A7F3C01D9_566A7DCD0151_var*
begin
//#UC START# *566A7F3C01D9_566A7DCD0151_impl*
 inherited Create;
 f_Params := MakeParamList;
 f_DataConverter := aDataConverter;
//#UC END# *566A7F3C01D9_566A7DCD0151_impl*
end;//TdaQuery.Create

function TdaQuery.DoMakeParam(const aParamDesc: IdaParamDescription): IdaParam;
//#UC START# *56E120F00095_566A7DCD0151_var*
//#UC END# *56E120F00095_566A7DCD0151_var*
begin
//#UC START# *56E120F00095_566A7DCD0151_impl*
 Result := TdaParam.Make(f_DataConverter, aParamDesc);
//#UC END# *56E120F00095_566A7DCD0151_impl*
end;//TdaQuery.DoMakeParam

function TdaQuery.OpenResultSet(Unidirectional: Boolean = True): IdaResultSet;
//#UC START# *5549C42400DA_566A7DCD0151_var*
//#UC END# *5549C42400DA_566A7DCD0151_var*
begin
//#UC START# *5549C42400DA_566A7DCD0151_impl*
 Result := MakeResultSet(Unidirectional);
//#UC END# *5549C42400DA_566A7DCD0151_impl*
end;//TdaQuery.OpenResultSet

procedure TdaQuery.Prepare;
//#UC START# *5551BB340256_566A7DCD0151_var*
//#UC END# *5551BB340256_566A7DCD0151_var*
begin
//#UC START# *5551BB340256_566A7DCD0151_impl*
 if not f_Prepared then
 begin
  PrepareQuery;
  f_Prepared := True;
 end;
//#UC END# *5551BB340256_566A7DCD0151_impl*
end;//TdaQuery.Prepare

function TdaQuery.Get_Param(const aName: AnsiString): IdaParam;
//#UC START# *5551BEA500AE_566A7DCD0151get_var*
var
 l_IDX: Integer;
//#UC END# *5551BEA500AE_566A7DCD0151get_var*
begin
//#UC START# *5551BEA500AE_566A7DCD0151get_impl*
 if f_Params.FindData(aName, l_IDX) then
  Result := f_Params[l_IDX]
 else
  Result := nil;
//#UC END# *5551BEA500AE_566A7DCD0151get_impl*
end;//TdaQuery.Get_Param

procedure TdaQuery.UnPrepare;
//#UC START# *555334DD023B_566A7DCD0151_var*
//#UC END# *555334DD023B_566A7DCD0151_var*
begin
//#UC START# *555334DD023B_566A7DCD0151_impl*
 if f_Prepared then
 begin
  UnPrepareQuery;
  f_Params.Clear;
  f_Prepared := False;
 end;
//#UC END# *555334DD023B_566A7DCD0151_impl*
end;//TdaQuery.UnPrepare

function TdaQuery.BuildSQLValue(const aHelper: IdaParamListHelper): AnsiString;
//#UC START# *564318160268_566A7DCD0151_var*
//#UC END# *564318160268_566A7DCD0151_var*
begin
//#UC START# *564318160268_566A7DCD0151_impl*
 Result := DoBuildSQLValue(aHelper);
//#UC END# *564318160268_566A7DCD0151_impl*
end;//TdaQuery.BuildSQLValue

function TdaQuery.AddParam(const aParamDesc: IdaParamDescription): IdaParam;
//#UC START# *56E152F4011D_566A7DCD0151_var*
var
 l_Param: IdaParam;
//#UC END# *56E152F4011D_566A7DCD0151_var*
begin
//#UC START# *56E152F4011D_566A7DCD0151_impl*
 l_Param := Get_Param(aParamDesc.Name);
 if Assigned(l_Param) then
 begin
  if not l_Param.IsSameType(aParamDesc) then
   raise EdaError.CreateFmt('Не совпадают типы данных для параметра %s', [aParamDesc.Name]);
 end
 else
 begin
  l_Param := DoMakeParam(aParamDesc);
  f_Params.Add(l_Param);
 end;
 Result := l_Param;
//#UC END# *56E152F4011D_566A7DCD0151_impl*
end;//TdaQuery.AddParam

procedure TdaQuery.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_566A7DCD0151_var*
//#UC END# *479731C50290_566A7DCD0151_var*
begin
//#UC START# *479731C50290_566A7DCD0151_impl*
 FreeAndNil(f_Params);
 f_DataConverter := nil;
 inherited;
//#UC END# *479731C50290_566A7DCD0151_impl*
end;//TdaQuery.Cleanup

procedure TdaQuery.BeforeRelease;
//#UC START# *49BFC98902FF_566A7DCD0151_var*
//#UC END# *49BFC98902FF_566A7DCD0151_var*
begin
//#UC START# *49BFC98902FF_566A7DCD0151_impl*
 Unprepare;
 inherited;
//#UC END# *49BFC98902FF_566A7DCD0151_impl*
end;//TdaQuery.BeforeRelease

end.
