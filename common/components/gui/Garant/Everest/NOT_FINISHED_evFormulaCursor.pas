unit NOT_FINISHED_evFormulaCursor;

// Модуль: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evFormulaCursor.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevFormulaCursor" MUID: (53D0F71C02D0)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , evTextParaCursor
;

type
 TevFormulaCursor = class(TevTextParaCursor)
 end;//TevFormulaCursor
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
 //#UC START# *53D0F71C02D0impl_uses*
 //#UC END# *53D0F71C02D0impl_uses*
;
{$IfEnd} // Defined(evUseVisibleCursors)

end.
