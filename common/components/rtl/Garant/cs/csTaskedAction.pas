unit csTaskedAction;
 {* �������� �� ������� � ������������ ��������� � ������� }

// ������: "w:\common\components\rtl\Garant\cs\csTaskedAction.pas"
// ���������: "SimpleClass"
// ������� ������: "TcsTaskedAction" MUID: (5395CD170333)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csAction
;

type
 TcsTaskedAction = {abstract} class(TcsAction)
  {* �������� �� ������� � ������������ ��������� � ������� }
 end;//TcsTaskedAction
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 //#UC START# *5395CD170333impl_uses*
 //#UC END# *5395CD170333impl_uses*
;
{$IfEnd} // NOT Defined(Nemesis)

end.
