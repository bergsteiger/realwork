unit eeDocumentCursor;

// Модуль: "w:\common\components\gui\Garant\Everest_Engine\eeDocumentCursor.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TeeDocumentCursor" MUID: (54BE50B902CB)

{$Include w:\common\components\gui\Garant\Everest_Engine\eeDefine.inc}

interface

uses
 l3IntfUses
 {$If Defined(evUseVisibleCursors)}
 , evDocumentCursor
 {$IfEnd} // Defined(evUseVisibleCursors)
;

type
 TeeDocumentCursor = class({$If Defined(evUseVisibleCursors)}
 TevDocumentCursor
 {$IfEnd} // Defined(evUseVisibleCursors)
 )
 end;//TeeDocumentCursor

implementation

uses
 l3ImplUses
 //#UC START# *54BE50B902CBimpl_uses*
 //#UC END# *54BE50B902CBimpl_uses*
;

{$If Defined(evUseVisibleCursors)}
{$IfEnd} // Defined(evUseVisibleCursors)
end.
