unit nevRangePrim;
 {* ���������� ����� ������� }

// ������: "w:\common\components\gui\Garant\Everest\nevRangePrim.pas"
// ���������: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , evLocation
 , nevTools
;

type
 TnevRangePrim = class(TevLocation, InevRangePrim)
  {* ���������� ����� ������� }
 end;//TnevRangePrim
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
 , evSelection
 , nevFacade
;
{$IfEnd} // Defined(evUseVisibleCursors)

end.
