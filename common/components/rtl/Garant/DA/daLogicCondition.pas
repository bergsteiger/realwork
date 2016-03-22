unit daLogicCondition;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DA"
// Модуль: "w:/common/components/rtl/Garant/DA/daLogicCondition.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::DA::Provider::TdaLogicCondition
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\DA\daDefine.inc}

interface

uses
  daTypes,
  daInterfaces,
  daCondition
  ;

type
 TdaLogicCondition = class(TdaCondition)
 private
 // private fields
   f_Left : IdaCondition;
   f_Right : IdaCondition;
   f_Operation : TdaLogicOperation;
 protected
 // realized methods
   function DoBuildSQL(const aHelper: IdaParamListHelper): AnsiString; override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(const aLeft: IdaCondition;
     anOperation: TdaLogicOperation;
     const aRight: IdaCondition); reintroduce;
   class function Make(const aLeft: IdaCondition;
     anOperation: TdaLogicOperation;
     const aRight: IdaCondition): IdaCondition; reintroduce;
     {* Сигнатура фабрики TdaLogicCondition.Make }
   {iterator} procedure Iterate(anAction: daConditionIterator_Iterate_Action); override;
 end;//TdaLogicCondition

implementation

uses
  l3Base,
  SysUtils
  ;

// start class TdaLogicCondition

constructor TdaLogicCondition.Create(const aLeft: IdaCondition;
  anOperation: TdaLogicOperation;
  const aRight: IdaCondition);
//#UC START# *564059E50042_5640598000F0_var*
//#UC END# *564059E50042_5640598000F0_var*
begin
//#UC START# *564059E50042_5640598000F0_impl*
 inherited Create;
 f_Left := aLeft;
 f_Right := aRight;
 f_Operation := anOperation;
//#UC END# *564059E50042_5640598000F0_impl*
end;//TdaLogicCondition.Create

class function TdaLogicCondition.Make(const aLeft: IdaCondition;
  anOperation: TdaLogicOperation;
  const aRight: IdaCondition): IdaCondition;
var
 l_Inst : TdaLogicCondition;
begin
 l_Inst := Create(aLeft, anOperation, aRight);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

{iterator} procedure TdaLogicCondition.Iterate(anAction: daConditionIterator_Iterate_Action);
//#UC START# *564089E3039B_5640598000F0_var*
//#UC END# *564089E3039B_5640598000F0_var*
begin
//#UC START# *564089E3039B_5640598000F0_impl*
 inherited;
 anAction(f_Left);
 anAction(f_Right);
//#UC END# *564089E3039B_5640598000F0_impl*
end;//TdaLogicCondition.Iterate

function TdaLogicCondition.DoBuildSQL(const aHelper: IdaParamListHelper): AnsiString;
//#UC START# *56408E7F01A1_5640598000F0_var*
const
 cMap: array [TdaLogicOperation] of String = (
  'AND', // da_loAnd
  'OR'   // da_loOr
 );
//#UC END# *56408E7F01A1_5640598000F0_var*
begin
//#UC START# *56408E7F01A1_5640598000F0_impl*
 Result := Format('(&s) &s (%s)', [f_Left.BuildSQLValue(aHelper), cMap[f_Operation], f_Right.BuildSQLValue(aHelper)]);
//#UC END# *56408E7F01A1_5640598000F0_impl*
end;//TdaLogicCondition.DoBuildSQL

procedure TdaLogicCondition.Cleanup;
//#UC START# *479731C50290_5640598000F0_var*
//#UC END# *479731C50290_5640598000F0_var*
begin
//#UC START# *479731C50290_5640598000F0_impl*
 f_Left := nil;
 f_Right := nil;
 inherited;
//#UC END# *479731C50290_5640598000F0_impl*
end;//TdaLogicCondition.Cleanup

end.