unit nscTaskPanelInterfaces;
 {* ���������� ��� ������ ����� }

// ������: "w:\common\components\gui\Garant\Nemesis\nscTaskPanelInterfaces.pas"
// ���������: "Interfaces"

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmTaskPanelInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 InscOperationNode = interface
  {* ���� �������� ������ ����� }
  ['{6B165312-3701-4BB0-A2B2-9E73321E893C}']
  function pm_GetOp: IvcmCustOpsGroupOperation;
  procedure CaptionChanged;
   {* ���������� �������� �������� }
  property Op: IvcmCustOpsGroupOperation
   read pm_GetOp;
 end;//InscOperationNode
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(Nemesis)

end.
