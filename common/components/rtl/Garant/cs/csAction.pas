unit csAction;
 {* �������� ������������ �������� � ����������� �� ������� }

// ������: "w:\common\components\rtl\Garant\cs\csAction.pas"
// ���������: "SimpleClass"
// ������� ������: "TcsAction" MUID: (5395C3760014)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , CsObject
;

type
 TcsAction = {abstract} class(TCsObject)
  {* �������� ������������ �������� � ����������� �� ������� }
 end;//TcsAction
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 //#UC START# *5395C3760014impl_uses*
 //#UC END# *5395C3760014impl_uses*
;
{$IfEnd} // NOT Defined(Nemesis)

end.
