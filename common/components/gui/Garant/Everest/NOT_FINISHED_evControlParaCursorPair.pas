unit NOT_FINISHED_evControlParaCursorPair;

// Модуль: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evControlParaCursorPair.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevControlParaCursorPair" MUID: (53D64B7400B9)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , evTextCursorPair
;

type
 TevControlParaCursorPair = class(TevTextCursorPair)
 end;//TevControlParaCursorPair
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
 //#UC START# *53D64B7400B9impl_uses*
 //#UC END# *53D64B7400B9impl_uses*
;
{$IfEnd} // Defined(evUseVisibleCursors)

end.
