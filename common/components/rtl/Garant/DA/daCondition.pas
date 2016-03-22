unit daCondition;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DA"
// Модуль: "w:/common/components/rtl/Garant/DA/daCondition.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::DA::Provider::TdaCondition
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
  daInterfaces
  ;

type
 TdaCondition = class(Tl3ProtoObject, IdaCondition)
 protected
 // realized methods
   function BuildSQLValue(const aHelper: IdaParamListHelper): AnsiString;
 public
 // realized methods
   {iterator} procedure Iterate(anAction: daConditionIterator_Iterate_Action); virtual;
   {iterator} procedure IterateF(anAction: daConditionIterator_Iterate_Action);
 protected
 // protected methods
   function DoBuildSQL(const aHelper: IdaParamListHelper): AnsiString; virtual; abstract;
 end;//TdaCondition

implementation

uses
  l3Base
  ;

// start class TdaCondition

function TdaCondition.BuildSQLValue(const aHelper: IdaParamListHelper): AnsiString;
//#UC START# *5608E5FE0355_56408DB303B7_var*
//#UC END# *5608E5FE0355_56408DB303B7_var*
begin
//#UC START# *5608E5FE0355_56408DB303B7_impl*
 Result := DoBuildSQL(aHelper);
//#UC END# *5608E5FE0355_56408DB303B7_impl*
end;//TdaCondition.BuildSQLValue

{iterator} procedure TdaCondition.Iterate(anAction: daConditionIterator_Iterate_Action);
//#UC START# *564089E3039B_56408DB303B7_var*
//#UC END# *564089E3039B_56408DB303B7_var*
begin
//#UC START# *564089E3039B_56408DB303B7_impl*
 anAction(Self);
//#UC END# *564089E3039B_56408DB303B7_impl*
end;//TdaCondition.Iterate

{iterator} procedure TdaCondition.IterateF(anAction: daConditionIterator_Iterate_Action);
var
 Hack : Pointer absolute anAction;
begin
 try
  Iterate(anAction);
 finally
  l3FreeLocalStub(Hack);
 end;//try..finally
end;

end.