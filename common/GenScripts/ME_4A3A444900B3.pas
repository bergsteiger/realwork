unit evParaListCursor;
 {* ������ ��� ������ ���������� }

// ������: "w:\common\components\gui\Garant\Everest\evParaListCursor.pas"
// ���������: "SimpleClass"

{$Include evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , evParaListCursorDeletable
;

type
 TevParaListCursor = class(TevParaListCursorDeletable)
  {* ������ ��� ������ ���������� }
 end;//TevParaListCursor
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(evUseVisibleCursors)

end.
