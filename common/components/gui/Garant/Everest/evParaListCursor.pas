unit evParaListCursor;
 {* ������ ��� ������ ���������� }

// ������: "w:\common\components\gui\Garant\Everest\evParaListCursor.pas"
// ���������: "SimpleClass"
// ������� ������: "TevParaListCursor" MUID: (4A3A444900B3)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

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
 //#UC START# *4A3A444900B3impl_uses*
 //#UC END# *4A3A444900B3impl_uses*
;
{$IfEnd} // Defined(evUseVisibleCursors)

end.
