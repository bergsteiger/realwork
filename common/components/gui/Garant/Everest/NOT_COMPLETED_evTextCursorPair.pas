unit NOT_COMPLETED_evTextCursorPair;

// ������: "w:\common\components\gui\Garant\Everest\NOT_COMPLETED_evTextCursorPair.pas"
// ���������: "SimpleClass"
// ������� ������: "TevTextCursorPair" MUID: (53D64B570304)

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
;
{$IfEnd} // Defined(evUseVisibleCursors)

end.
