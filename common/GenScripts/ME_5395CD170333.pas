unit csTaskedAction;
 {* �������� �� ������� � ������������ ��������� � ������� }

// ������: "w:\common\components\rtl\Garant\cs\csTaskedAction.pas"
// ���������: "SimpleClass"

{$Include CsDefine.inc}

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
;
{$IfEnd} // NOT Defined(Nemesis)

end.
