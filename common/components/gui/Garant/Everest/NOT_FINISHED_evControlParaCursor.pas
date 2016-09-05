unit NOT_FINISHED_evControlParaCursor;

// Модуль: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evControlParaCursor.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevControlParaCursor" MUID: (53D64AF60152)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , evTextParaCursor
;

type
 TevControlParaCursor = class(TevTextParaCursor)
 end;//TevControlParaCursor
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
 //#UC START# *53D64AF60152impl_uses*
 //#UC END# *53D64AF60152impl_uses*
;
{$IfEnd} // Defined(evUseVisibleCursors)

end.
