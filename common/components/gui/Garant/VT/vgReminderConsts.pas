unit vgReminderConsts;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VT$Rem"
// ������: "w:/common/components/gui/Garant/VT/vgReminderConsts.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VT$Rem::NewReminders::vgReminderConsts
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\VT\vtDefine.inc}

interface

{$If not defined(NoVGScene)}
const
  { New Reminder Consts }
 c_ReminderDistance = 0;
  { ���������� ����� �������� � ����� }
 c_FlashInterval = 400;
  { ���������� ������� ������ }
 c_DefaultReminderOpacity = 0.7;
  { ������������ ������ �� ��������� }
 c_FlashingReminderOpacity = 0.4;
  { ������������ ������ ��� ������� }
 c_ReminderTextHIndent = 7;
  { ������ ������ �� ����������� � ������ � ������� }
 c_ReminderTextVIndent = 5;
  { ������ ������ �� ��������� � ������ � ������� }
{$IfEnd} //not NoVGScene

implementation

{$If not defined(NoVGScene)}
{$IfEnd} //not NoVGScene
end.