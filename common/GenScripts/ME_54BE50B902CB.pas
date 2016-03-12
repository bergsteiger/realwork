unit eeDocumentCursor;

// Модуль: "w:\common\components\gui\Garant\Everest_Engine\eeDocumentCursor.pas"
// Стереотип: "SimpleClass"

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
