unit NOT_COMPLETED_evSolidParaCursorPair;

// Модуль: "w:\common\components\gui\Garant\Everest\NOT_COMPLETED_evSolidParaCursorPair.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevSolidParaCursorPair" MUID: (53D26C750089)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , evLeafParaCursorPair
;

type
 TevSolidParaCursorPair = class(TevLeafParaCursorPair)
 end;//TevSolidParaCursorPair
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(evUseVisibleCursors)

end.
