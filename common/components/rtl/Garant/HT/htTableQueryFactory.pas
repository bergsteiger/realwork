unit htTableQueryFactory;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "HT"
// Модуль: "w:/common/components/rtl/Garant/HT/htTableQueryFactory.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::HT::Provider::ThtTableQueryFactory
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\HT\htDefineDA.inc}

interface

uses
  l3ProtoObject,
  daInterfaces,
  htInterfaces,
  daTypes
  ;

type
 ThtTableQueryFactory = class(Tl3ProtoObject, IdaTableQueryFactory)
 private
 // private fields
   f_DataConverter : IhtDataConverter;
   f_Helper : IhtDataSchemeHelper;
 protected
 // realized methods
   function MakeTabledQuery(const aTable: IdaTableDescription;
    const anAlias: AnsiString = ''): IdaTabledQuery;
   function MakeSelectField(const aTableAlias: AnsiString;
    const aField: IdaFieldDescription;
    const anAlias: AnsiString = ''): IdaSelectField;
   function MakeParamsCondition(const aTableAlias: AnsiString;
    const aField: IdaFieldDescription;
    anOperation: TdaCompareOperation;
    const aParamName: AnsiString): IdaCondition;
   function GetUserNameStr(anUserID: LargeInt): AnsiString;
   function Get_DataConverter: IdaDataConverter;
   function MakeLogicCondition(const aLeft: IdaCondition;
    anOperation: TdaLogicOperation;
    const aRight: IdaCondition): IdaCondition;
   function MakeSubQueryCondition(const aTableAlias: AnsiString;
    const aField: IdaFieldDescription;
    const aQuery: IdaTabledQuery): IdaCondition;
   function MakeSortField(const aSelectField: IdaSelectField;
    aSortOrder: TdaSortOrder = da_soAscending): IdaSortField;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(const aDataConverter: IhtDataConverter;
     const aHelper: IhtDataSchemeHelper); reintroduce;
   class function Make(const aDataConverter: IhtDataConverter;
     const aHelper: IhtDataSchemeHelper): IdaTableQueryFactory; reintroduce;
     {* Сигнатура фабрики ThtTableQueryFactory.Make }
 end;//ThtTableQueryFactory

implementation

uses
  htTabledQuery,
  daParamsCondition,
  daSelectField
  {$If not defined(Nemesis)}
  ,
  dt_User
  {$IfEnd} //not Nemesis
  ,
  daLogicCondition,
  daSubQueryCondition,
  daSortField
  ;

// start class ThtTableQueryFactory

constructor ThtTableQueryFactory.Create(const aDataConverter: IhtDataConverter;
  const aHelper: IhtDataSchemeHelper);
//#UC START# *554C8017020C_554C7FE80228_var*
//#UC END# *554C8017020C_554C7FE80228_var*
begin
//#UC START# *554C8017020C_554C7FE80228_impl*
 inherited Create;
 f_DataConverter := aDataConverter;
 f_Helper := aHelper;
//#UC END# *554C8017020C_554C7FE80228_impl*
end;//ThtTableQueryFactory.Create

class function ThtTableQueryFactory.Make(const aDataConverter: IhtDataConverter;
  const aHelper: IhtDataSchemeHelper): IdaTableQueryFactory;
var
 l_Inst : ThtTableQueryFactory;
begin
 l_Inst := Create(aDataConverter, aHelper);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function ThtTableQueryFactory.MakeTabledQuery(const aTable: IdaTableDescription;
  const anAlias: AnsiString = ''): IdaTabledQuery;
//#UC START# *5549C65D038D_554C7FE80228_var*
//#UC END# *5549C65D038D_554C7FE80228_var*
begin
//#UC START# *5549C65D038D_554C7FE80228_impl*
 Result := ThtTabledQuery.Make(f_DataConverter, f_Helper, aTable, anAlias);
//#UC END# *5549C65D038D_554C7FE80228_impl*
end;//ThtTableQueryFactory.MakeTabledQuery

function ThtTableQueryFactory.MakeSelectField(const aTableAlias: AnsiString;
  const aField: IdaFieldDescription;
  const anAlias: AnsiString = ''): IdaSelectField;
//#UC START# *559B80BD00A8_554C7FE80228_var*
//#UC END# *559B80BD00A8_554C7FE80228_var*
begin
//#UC START# *559B80BD00A8_554C7FE80228_impl*
 Result := TdaSelectField.Make(aTableAlias, aField, anAlias);
//#UC END# *559B80BD00A8_554C7FE80228_impl*
end;//ThtTableQueryFactory.MakeSelectField

function ThtTableQueryFactory.MakeParamsCondition(const aTableAlias: AnsiString;
  const aField: IdaFieldDescription;
  anOperation: TdaCompareOperation;
  const aParamName: AnsiString): IdaCondition;
//#UC START# *559B810003CF_554C7FE80228_var*
//#UC END# *559B810003CF_554C7FE80228_var*
begin
//#UC START# *559B810003CF_554C7FE80228_impl*
 Result := TdaParamsCondition.Make(aTableAlias, aField, anOperation, aParamName);
//#UC END# *559B810003CF_554C7FE80228_impl*
end;//ThtTableQueryFactory.MakeParamsCondition

function ThtTableQueryFactory.GetUserNameStr(anUserID: LargeInt): AnsiString;
//#UC START# *559BAF4401C8_554C7FE80228_var*
//#UC END# *559BAF4401C8_554C7FE80228_var*
begin
//#UC START# *559BAF4401C8_554C7FE80228_impl*
 Result := UserManager.UserTbl.GetNameStr(anUserID);
//#UC END# *559BAF4401C8_554C7FE80228_impl*
end;//ThtTableQueryFactory.GetUserNameStr

function ThtTableQueryFactory.Get_DataConverter: IdaDataConverter;
//#UC START# *55C1BFA402E3_554C7FE80228get_var*
//#UC END# *55C1BFA402E3_554C7FE80228get_var*
begin
//#UC START# *55C1BFA402E3_554C7FE80228get_impl*
 Result := f_DataConverter;
//#UC END# *55C1BFA402E3_554C7FE80228get_impl*
end;//ThtTableQueryFactory.Get_DataConverter

function ThtTableQueryFactory.MakeLogicCondition(const aLeft: IdaCondition;
  anOperation: TdaLogicOperation;
  const aRight: IdaCondition): IdaCondition;
//#UC START# *56405475021D_554C7FE80228_var*
//#UC END# *56405475021D_554C7FE80228_var*
begin
//#UC START# *56405475021D_554C7FE80228_impl*
 Result := TdaLogicCondition.Make(aLeft, anOperation, aRight);
//#UC END# *56405475021D_554C7FE80228_impl*
end;//ThtTableQueryFactory.MakeLogicCondition

function ThtTableQueryFactory.MakeSubQueryCondition(const aTableAlias: AnsiString;
  const aField: IdaFieldDescription;
  const aQuery: IdaTabledQuery): IdaCondition;
//#UC START# *5641E5DB02C3_554C7FE80228_var*
//#UC END# *5641E5DB02C3_554C7FE80228_var*
begin
//#UC START# *5641E5DB02C3_554C7FE80228_impl*
 Result := TdaSubQueryCondition.Make(aTableALias, aField, aQuery);
//#UC END# *5641E5DB02C3_554C7FE80228_impl*
end;//ThtTableQueryFactory.MakeSubQueryCondition

function ThtTableQueryFactory.MakeSortField(const aSelectField: IdaSelectField;
  aSortOrder: TdaSortOrder = da_soAscending): IdaSortField;
//#UC START# *56811844032C_554C7FE80228_var*
//#UC END# *56811844032C_554C7FE80228_var*
begin
//#UC START# *56811844032C_554C7FE80228_impl*
 Result := TdaSortField.Make(aSelectField, aSortOrder);
//#UC END# *56811844032C_554C7FE80228_impl*
end;//ThtTableQueryFactory.MakeSortField

procedure ThtTableQueryFactory.Cleanup;
//#UC START# *479731C50290_554C7FE80228_var*
//#UC END# *479731C50290_554C7FE80228_var*
begin
//#UC START# *479731C50290_554C7FE80228_impl*
 f_DataConverter := nil;
 f_Helper := nil;
 inherited;
//#UC END# *479731C50290_554C7FE80228_impl*
end;//ThtTableQueryFactory.Cleanup

end.