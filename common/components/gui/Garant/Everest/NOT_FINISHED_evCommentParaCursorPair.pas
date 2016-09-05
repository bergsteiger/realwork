unit NOT_FINISHED_evCommentParaCursorPair;

// Модуль: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evCommentParaCursorPair.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevCommentParaCursorPair" MUID: (53D245DF0285)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

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
 //#UC START# *53D245DF0285impl_uses*
 //#UC END# *53D245DF0285impl_uses*
;
{$IfEnd} // Defined(evUseVisibleCursors)

end.
