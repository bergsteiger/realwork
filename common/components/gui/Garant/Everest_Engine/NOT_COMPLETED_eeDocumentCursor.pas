unit NOT_COMPLETED_eeDocumentCursor;

// ������: "w:\common\components\gui\Garant\Everest_Engine\NOT_COMPLETED_eeDocumentCursor.pas"
// ���������: "SimpleClass"
// ������� ������: "TeeDocumentCursor" MUID: (54BE50B902CB)

{$Include w:\common\components\gui\Garant\Everest_Engine\eeDefine.inc}

interface

uses
 l3IntfUses
 {$If Defined(evUseVisibleCursors)}
 , evDocumentCursor
 {$IfEnd} // Defined(evUseVisibleCursors)
;

type
 TeeDocumentCursor = class(TevDocumentCursor)
 end;//TeeDocumentCursor

implementation

uses
 l3ImplUses
;

{$If Defined(evUseVisibleCursors)}
{$IfEnd} // Defined(evUseVisibleCursors)
end.
