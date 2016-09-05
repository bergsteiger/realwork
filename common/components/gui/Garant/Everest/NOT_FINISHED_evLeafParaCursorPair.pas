unit NOT_FINISHED_evLeafParaCursorPair;

// Модуль: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evLeafParaCursorPair.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevLeafParaCursorPair" MUID: (53D26C1A026F)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , evCursorPair
;

type
 TevLeafParaCursorPair = class(TevCursorPair)
 end;//TevLeafParaCursorPair
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
 //#UC START# *53D26C1A026Fimpl_uses*
 //#UC END# *53D26C1A026Fimpl_uses*
;
{$IfEnd} // Defined(evUseVisibleCursors)

end.
