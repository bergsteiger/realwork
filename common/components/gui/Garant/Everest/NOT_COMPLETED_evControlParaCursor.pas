unit NOT_COMPLETED_evControlParaCursor;

// ������: "w:\common\components\gui\Garant\Everest\NOT_COMPLETED_evControlParaCursor.pas"
// ���������: "SimpleClass"
// ������� ������: "TevControlParaCursor" MUID: (53D64AF60152)

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
;
{$IfEnd} // Defined(evUseVisibleCursors)

end.
