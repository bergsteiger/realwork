unit eeDocumentCursor;

// ������: "w:\common\components\gui\Garant\Everest_Engine\eeDocumentCursor.pas"
// ���������: "SimpleClass"

{$Include eeDefine.inc}

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

end.
