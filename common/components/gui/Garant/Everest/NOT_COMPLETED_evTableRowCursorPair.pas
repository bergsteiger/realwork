unit NOT_COMPLETED_evTableRowCursorPair;

// ������: "w:\common\components\gui\Garant\Everest\NOT_COMPLETED_evTableRowCursorPair.pas"
// ���������: "SimpleClass"
// ������� ������: "TevTableRowCursorPair" MUID: (53D6758E0352)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , evParaListCursorPair
;

type
 TevTableRowCursorPair = class(TevParaListCursorPair)
 end;//TevTableRowCursorPair
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(evUseVisibleCursors)

end.
