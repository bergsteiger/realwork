unit NOT_FINISHED_evTextCursorPair;

// Модуль: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evTextCursorPair.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevTextCursorPair" MUID: (53D64B570304)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , evLeafParaCursorPair
;

type
 TevTextCursorPair = class(TevLeafParaCursorPair)
 end;//TevTextCursorPair
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
 //#UC START# *53D64B570304impl_uses*
 //#UC END# *53D64B570304impl_uses*
;
{$IfEnd} // Defined(evUseVisibleCursors)

end.
