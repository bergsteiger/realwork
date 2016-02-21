unit vgReminderConsts;

// ������: "w:\common\components\gui\Garant\VT\vgReminderConsts.pas"
// ���������: "UtilityPack"

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

{$If NOT Defined(NoVGScene)}
uses
 l3IntfUses
;

const
 c_ReminderDistance = 0;
  {* ���������� ����� �������� � ����� }
 c_FlashInterval = 400;
  {* ���������� ������� ������ }
 c_DefaultReminderOpacity = 0.7;
  {* ������������ ������ �� ��������� }
 c_FlashingReminderOpacity = 0.4;
  {* ������������ ������ ��� ������� }
 c_ReminderTextHIndent = 7;
  {* ������ ������ �� ����������� � ������ � ������� }
 c_ReminderTextVIndent = 5;
  {* ������ ������ �� ��������� � ������ � ������� }
{$IfEnd} // NOT Defined(NoVGScene)

implementation

{$If NOT Defined(NoVGScene)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(NoVGScene)

end.
