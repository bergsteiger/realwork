unit NOT_COMPLETED_evLeafParaCursorPair;

// ������: "w:\common\components\gui\Garant\Everest\NOT_COMPLETED_evLeafParaCursorPair.pas"
// ���������: "SimpleClass"
// ������� ������: "TevLeafParaCursorPair" MUID: (53D26C1A026F)

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
;
{$IfEnd} // Defined(evUseVisibleCursors)

end.
