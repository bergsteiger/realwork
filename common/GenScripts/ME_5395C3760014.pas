unit csAction;
 {* �������� ������������ �������� � ����������� �� ������� }

// ������: "w:\common\components\rtl\Garant\cs\csAction.pas"
// ���������: "SimpleClass"

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
;
{$IfEnd} // NOT Defined(Nemesis)

end.
