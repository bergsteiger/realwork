unit NOT_FINISHED_evCommentParaCursorPair;

// ������: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evCommentParaCursorPair.pas"
// ���������: "SimpleClass"

{$Include evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , evDocumentPartCursorPair
;

type
 TevCommentParaCursorPair = class(TevDocumentPartCursorPair)
 end;//TevCommentParaCursorPair
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(evUseVisibleCursors)

end.
