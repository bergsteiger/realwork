unit NOT_FINISHED_evLeafParaCursorPair;

// ������: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evLeafParaCursorPair.pas"
// ���������: "SimpleClass"

{$Include evDefine.inc}

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
