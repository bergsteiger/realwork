unit NOT_FINISHED_vcmMainMenuBuilder;
 {* ������, ��������������� ��� ����������� ������� � ���������
� ���������� �������� ���� � ����� ������ ������ �������. }

// ������: "w:\common\components\gui\Garant\VCM\implementation\Visual\NOT_FINISHED_vcmMainMenuBuilder.pas"
// ���������: "SimpleClass"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
;

type
 TvcmMainMenuBuilder = class
  {* ������, ��������������� ��� ����������� ������� � ���������
� ���������� �������� ���� � ����� ������ ������ �������. }
 end;//TvcmMainMenuBuilder
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , vcmEntityDefList
 , vcmModuleDefList
;
{$IfEnd} // NOT Defined(NoVCM)

end.
