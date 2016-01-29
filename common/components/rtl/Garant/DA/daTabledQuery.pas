unit daTabledQuery;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DA"
// Модуль: "w:/common/components/rtl/Garant/DA/daTabledQuery.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::DA::Provider::TdaTabledQuery
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\DA\daDefine.inc}

interface

uses
  l3ProtoObject,
  daInterfaces,
  daParamList,
  daFromTableList,
  daSelectFieldList
  ;

type
 TdaTabledQuery = class(Tl3ProtoObject, IdaQuery)
 private
 // private fields
   f_DataConverter : IdaDataConverter;
    {* Поле для свойства DataConverter}
   f_Prepared : Boolean;
    {* Поле для свойства Prepared}
   f_SelectFields : TdaSelectFieldList;
    {* Поле для свойства SelectFields}
   f_WhereCondition : IdaCondition;
    {* Поле для свойства WhereCondition}
   f_Tables : TdaFromTableList;
    {* Поле для свойства Tables}
   f_Params : TdaParamList;
    {* Поле для свойства Params}
 private
 // private methods
   procedure AddParam(const aParamDesc: IdaParamDescription);
 protected
 // property methods
   procedure pm_SetWhereCondition(const aValue: IdaCondition); virtual;
 protected
 // realized methods
   function OpenResultSet(Unidirectional: Boolean = True): IdaResultSet;
   procedure Prepare;
   function Get_Param(const aName: AnsiString): IdaParam;
   procedure AddSelectField(const aField: IdaSelectField);
   procedure AddFromTable(const aTable: IdaFromTable);
   procedure UnPrepare;
   function Get_WhereCondition: IdaCondition;
   procedure Set_WhereCondition(const aValue: IdaCondition);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure BeforeRelease; override;
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 protected
 // protected methods
   function MakeFromTable(const aTable: IdaTableDescription;
     const anAlias: AnsiString = ''): IdaFromTable; virtual; abstract;
   function MakeResultSet(Unidirectional: Boolean): IdaResultSet; virtual; abstract;
   procedure PrepareTables; virtual; abstract;
     {* Сигнатура метода PrepareTables }
   procedure UnprepareTables; virtual; abstract;
     {* Сигнатура метода UnprepareTables }
   function MakeParamList: TdaParamList; virtual;
 public
 // public methods
   constructor Create(const aDataConverter: IdaDataConverter;
     const aTable: IdaTableDescription;
     const anAlias: AnsiString = ''); reintroduce;
 protected
 // protected properties
   property DataConverter: IdaDataConverter
     read f_DataConverter;
   property Prepared: Boolean
     read f_Prepared
     write f_Prepared;
   property SelectFields: TdaSelectFieldList
     read f_SelectFields;
   property WhereCondition: IdaCondition
     read f_WhereCondition
     write pm_SetWhereCondition;
   property Tables: TdaFromTableList
     read f_Tables;
   property Params: TdaParamList
     read f_Params;
 end;//TdaTabledQuery

implementation

uses
  daTypes,
  SysUtils,
  daParam
  ;

// start class TdaTabledQuery

procedure TdaTabledQuery.AddParam(const aParamDesc: IdaParamDescription);
//#UC START# *55FFDEC4037F_5600FA2301B9_var*
var
 l_Param: IdaParam;
//#UC END# *55FFDEC4037F_5600FA2301B9_var*
begin
//#UC START# *55FFDEC4037F_5600FA2301B9_impl*
 l_Param := Get_Param(aParamDesc.Name);
 if Assigned(l_Param) then
 begin
  if not l_Param.IsSameType(aParamDesc) then
   raise EdaError.CreateFmt('Не совпадают типы данных для параметра %s', [aParamDesc.Name]);
 end
 else
  f_Params.Add(TdaParam.Make(f_DataConverter, aParamDesc));
//#UC END# *55FFDEC4037F_5600FA2301B9_impl*
end;//TdaTabledQuery.AddParam

constructor TdaTabledQuery.Create(const aDataConverter: IdaDataConverter;
  const aTable: IdaTableDescription;
  const anAlias: AnsiString = '');
//#UC START# *5600FB3903DE_5600FA2301B9_var*
//#UC END# *5600FB3903DE_5600FA2301B9_var*
begin
//#UC START# *5600FB3903DE_5600FA2301B9_impl*
 inherited Create;
 f_Tables := TdaFromTableList.Make;
 AddFromTable(MakeFromTable(aTable, anAlias));
 f_SelectFields := TdaSelectFieldList.Make;
 f_Params := MakeParamList;
 f_DataConverter := aDataConverter;
//#UC END# *5600FB3903DE_5600FA2301B9_impl*
end;//TdaTabledQuery.Create

function TdaTabledQuery.MakeParamList: TdaParamList;
//#UC START# *560B861302E9_5600FA2301B9_var*
//#UC END# *560B861302E9_5600FA2301B9_var*
begin
//#UC START# *560B861302E9_5600FA2301B9_impl*
 Result := TdaParamList.Make;
//#UC END# *560B861302E9_5600FA2301B9_impl*
end;//TdaTabledQuery.MakeParamList

procedure TdaTabledQuery.pm_SetWhereCondition(const aValue: IdaCondition);
//#UC START# *5600FAC103DE_5600FA2301B9set_var*
//#UC END# *5600FAC103DE_5600FA2301B9set_var*
begin
//#UC START# *5600FAC103DE_5600FA2301B9set_impl*
 f_WhereCondition := aValue;
 UnPrepare;
//#UC END# *5600FAC103DE_5600FA2301B9set_impl*
end;//TdaTabledQuery.pm_SetWhereCondition

function TdaTabledQuery.OpenResultSet(Unidirectional: Boolean = True): IdaResultSet;
//#UC START# *5549C42400DA_5600FA2301B9_var*
//#UC END# *5549C42400DA_5600FA2301B9_var*
begin
//#UC START# *5549C42400DA_5600FA2301B9_impl*
 Result := MakeResultSet(Unidirectional);
//#UC END# *5549C42400DA_5600FA2301B9_impl*
end;//TdaTabledQuery.OpenResultSet

procedure TdaTabledQuery.Prepare;
//#UC START# *5551BB340256_5600FA2301B9_var*
var
 l_Field: IdaFieldFromTable;
 l_ParamDescription: IdaParamDescription;
 l_IDX: Integer;
//#UC END# *5551BB340256_5600FA2301B9_var*
begin
//#UC START# *5551BB340256_5600FA2301B9_impl*
 if not f_Prepared then
 begin
  Assert(f_Tables.Count = 1);
  Assert(f_SelectFields.Count > 0);
  for l_IDX := 0 to f_SelectFields.Count - 1 do
   if Supports(f_SelectFields[l_IDX], IdaFieldFromTable, l_Field) then
    Assert(l_Field.Field.Table = f_Tables[0].Table);
  if Supports(f_WhereCondition, IdaFieldFromTable, l_Field) then
   Assert(l_Field.Field.Table = f_Tables[0].Table);
  if Supports(f_WhereCondition, IdaParamDescription, l_ParamDescription) then
   AddParam(l_ParamDescription);
  PrepareTables;
  f_Prepared := True;
 end;
//#UC END# *5551BB340256_5600FA2301B9_impl*
end;//TdaTabledQuery.Prepare

function TdaTabledQuery.Get_Param(const aName: AnsiString): IdaParam;
//#UC START# *5551BEA500AE_5600FA2301B9get_var*
var
 l_IDX: Integer;
//#UC END# *5551BEA500AE_5600FA2301B9get_var*
begin
//#UC START# *5551BEA500AE_5600FA2301B9get_impl*
 if f_Params.FindData(aName, l_IDX) then
  Result := f_Params[l_IDX]
 else
  Result := nil;
//#UC END# *5551BEA500AE_5600FA2301B9get_impl*
end;//TdaTabledQuery.Get_Param

procedure TdaTabledQuery.AddSelectField(const aField: IdaSelectField);
//#UC START# *5551DC42038C_5600FA2301B9_var*
//#UC END# *5551DC42038C_5600FA2301B9_var*
begin
//#UC START# *5551DC42038C_5600FA2301B9_impl*
 f_SelectFields.Add(aField);
 UnPrepare;
//#UC END# *5551DC42038C_5600FA2301B9_impl*
end;//TdaTabledQuery.AddSelectField

procedure TdaTabledQuery.AddFromTable(const aTable: IdaFromTable);
//#UC START# *5553039D016A_5600FA2301B9_var*
//#UC END# *5553039D016A_5600FA2301B9_var*
begin
//#UC START# *5553039D016A_5600FA2301B9_impl*
 f_Tables.Add(aTable);
 UnPrepare;
//#UC END# *5553039D016A_5600FA2301B9_impl*
end;//TdaTabledQuery.AddFromTable

procedure TdaTabledQuery.UnPrepare;
//#UC START# *555334DD023B_5600FA2301B9_var*
//#UC END# *555334DD023B_5600FA2301B9_var*
begin
//#UC START# *555334DD023B_5600FA2301B9_impl*
 if f_Prepared then
 begin
  UnPrepareTables;
  f_Params.Clear;
// !!! Needs to be implemented !!!
  f_Prepared := False;
 end;
//#UC END# *555334DD023B_5600FA2301B9_impl*
end;//TdaTabledQuery.UnPrepare

function TdaTabledQuery.Get_WhereCondition: IdaCondition;
//#UC START# *563B18FB0212_5600FA2301B9get_var*
//#UC END# *563B18FB0212_5600FA2301B9get_var*
begin
//#UC START# *563B18FB0212_5600FA2301B9get_impl*
 Result := f_WhereCondition;
//#UC END# *563B18FB0212_5600FA2301B9get_impl*
end;//TdaTabledQuery.Get_WhereCondition

procedure TdaTabledQuery.Set_WhereCondition(const aValue: IdaCondition);
//#UC START# *563B18FB0212_5600FA2301B9set_var*
//#UC END# *563B18FB0212_5600FA2301B9set_var*
begin
//#UC START# *563B18FB0212_5600FA2301B9set_impl*
 WhereCondition := aValue;
//#UC END# *563B18FB0212_5600FA2301B9set_impl*
end;//TdaTabledQuery.Set_WhereCondition

procedure TdaTabledQuery.Cleanup;
//#UC START# *479731C50290_5600FA2301B9_var*
//#UC END# *479731C50290_5600FA2301B9_var*
begin
//#UC START# *479731C50290_5600FA2301B9_impl*
 FreeAndNil(f_Tables);
 f_WhereCondition := nil;
 FreeAndNil(f_SelectFields);
 FreeAndNil(f_Params);
 f_DataConverter := nil;
 inherited;
//#UC END# *479731C50290_5600FA2301B9_impl*
end;//TdaTabledQuery.Cleanup

procedure TdaTabledQuery.BeforeRelease;
//#UC START# *49BFC98902FF_5600FA2301B9_var*
//#UC END# *49BFC98902FF_5600FA2301B9_var*
begin
//#UC START# *49BFC98902FF_5600FA2301B9_impl*
 UnPrepareTables;
 inherited;
//#UC END# *49BFC98902FF_5600FA2301B9_impl*
end;//TdaTabledQuery.BeforeRelease

procedure TdaTabledQuery.ClearFields;
 {-}
begin
 f_DataConverter := nil;
 WhereCondition := nil;
 inherited;
end;//TdaTabledQuery.ClearFields

end.