unit evBreakParaCursor;

// Модуль: "w:\common\components\gui\Garant\Everest\evBreakParaCursor.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevBreakParaCursor" MUID: (4B1D20D500C2)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , evSolidParaCursor
 , nevTools
;

type
 _nevBreakParaAnchorModify_Parent_ = TevSolidParaCursor;
 {$Include w:\common\components\gui\Garant\Everest\nevBreakParaAnchorModify.imp.pas}
 TevBreakParaCursor = class(_nevBreakParaAnchorModify_)
 end;//TevBreakParaCursor
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
 //#UC START# *4B1D20D500C2impl_uses*
 //#UC END# *4B1D20D500C2impl_uses*
;

{$Include w:\common\components\gui\Garant\Everest\nevBreakParaAnchorModify.imp.pas}
{$IfEnd} // Defined(evUseVisibleCursors)

end.
