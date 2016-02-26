unit NOT_FINISHED_evFormulaCursor;

// Модуль: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evFormulaCursor.pas"
// Стереотип: "SimpleClass"

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
;
{$IfEnd} // Defined(evUseVisibleCursors)

end.
