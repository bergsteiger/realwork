unit NOT_FINISHED_evSolidParaCursorPair;

// ������: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evSolidParaCursorPair.pas"
// ���������: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , evLeafParaCursorPair
;

type
 TevSolidParaCursorPair = class(TevLeafParaCursorPair)
 end;//TevSolidParaCursorPair
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(evUseVisibleCursors)

end.
