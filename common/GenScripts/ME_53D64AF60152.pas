unit NOT_FINISHED_evControlParaCursor;

// Модуль: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evControlParaCursor.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

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
;
{$IfEnd} // Defined(evUseVisibleCursors)

end.
