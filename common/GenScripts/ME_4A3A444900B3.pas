unit evParaListCursor;
 {* Курсор для списка параграфов }

// Модуль: "w:\common\components\gui\Garant\Everest\evParaListCursor.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , evParaListCursorDeletable
;

type
 TevParaListCursor = class(TevParaListCursorDeletable)
  {* Курсор для списка параграфов }
 end;//TevParaListCursor
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(evUseVisibleCursors)

end.
