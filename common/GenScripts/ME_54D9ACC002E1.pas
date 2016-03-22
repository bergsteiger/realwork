unit ddFormulaSegment;

// Модуль: "w:\common\components\rtl\Garant\dd\ddFormulaSegment.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddFormulaSegment" MUID: (54D9ACC002E1)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , ddObjectSegment
 , ddTextSegment
;

type
 TddFormulaSegment = class(TddObjectSegment)
  public
   function Clone: TddTextSegment; override;
 end;//TddFormulaSegment

implementation

uses
 l3ImplUses
;

function TddFormulaSegment.Clone: TddTextSegment;
//#UC START# *54DC46B50110_54D9ACC002E1_var*
//#UC END# *54DC46B50110_54D9ACC002E1_var*
begin
//#UC START# *54DC46B50110_54D9ACC002E1_impl*
 Result := TddFormulaSegment.Create;
 Result.Assign(Self);
//#UC END# *54DC46B50110_54D9ACC002E1_impl*
end;//TddFormulaSegment.Clone

end.
