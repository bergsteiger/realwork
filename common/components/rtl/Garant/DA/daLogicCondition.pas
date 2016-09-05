unit daLogicCondition;

// Модуль: "w:\common\components\rtl\Garant\DA\daLogicCondition.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdaLogicCondition" MUID: (5640598000F0)

{$Include w:\common\components\rtl\Garant\DA\daDefine.inc}

interface

uses
 l3IntfUses
 , daCondition
 , daInterfaces
 , daTypes
;

type
 TdaLogicCondition = class(TdaCondition)
  private
   f_Left: IdaCondition;
   f_Right: IdaCondition;
   f_Operation: TdaLogicOperation;
  protected
   function DoBuildSQL(const aHelper: IdaParamListHelper): AnsiString; override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aLeft: IdaCondition;
    anOperation: TdaLogicOperation;
    const aRight: IdaCondition); reintroduce;
   class function Make(const aLeft: IdaCondition;
    anOperation: TdaLogicOperation;
    const aRight: IdaCondition): IdaCondition; reintroduce;
   procedure Iterate(anAction: daConditionIterator_Iterate_Action); override;
 end;//TdaLogicCondition

implementation

uses
 l3ImplUses
 , SysUtils
 //#UC START# *5640598000F0impl_uses*
 //#UC END# *5640598000F0impl_uses*
;

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
end;//TdaLogicCondition.Make

procedure TdaLogicCondition.Iterate(anAction: daConditionIterator_Iterate_Action);
//#UC START# *564089E3039B_5640598000F0_var*

var
 l_Continue: Boolean;

 function DoIt(const anItem: IdaCondition): Boolean;
 begin
  Result := anAction(anItem);
  if not Result then
   l_Continue := False;
 end;

//#UC END# *564089E3039B_5640598000F0_var*
begin
//#UC START# *564089E3039B_5640598000F0_impl*
 inherited;
 l_Continue := True;
 f_Left.IterateF(L2daConditionIteratorIterateAction(@DoIt));
 if l_Continue then
  f_Right.IterateF(L2daConditionIteratorIterateAction(@DoIt));
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
 Result := Format('(%s) %s (%s)', [f_Left.BuildSQLValue(aHelper), cMap[f_Operation], f_Right.BuildSQLValue(aHelper)]);
//#UC END# *56408E7F01A1_5640598000F0_impl*
end;//TdaLogicCondition.DoBuildSQL

procedure TdaLogicCondition.Cleanup;
 {* Функция очистки полей объекта. }
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
