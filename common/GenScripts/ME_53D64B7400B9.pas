unit NOT_FINISHED_evControlParaCursorPair;

// ������: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evControlParaCursorPair.pas"
// ���������: "SimpleClass"

{$Include evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , evTextCursorPair
;

type
 TevControlParaCursorPair = class(TevTextCursorPair)
 end;//TevControlParaCursorPair
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(evUseVisibleCursors)

end.
