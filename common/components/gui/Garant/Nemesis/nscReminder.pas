unit nscReminder;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Nemesis"
// ������: "w:/common/components/gui/Garant/Nemesis/nscReminder.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For F1::Nemesis::Reminders::nscReminder
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Nemesis\nscDefine.inc}

interface

{$If defined(Nemesis)}
uses
  Classes
  {$If not defined(NoVGScene)}
  ,
  vgReminderWithAction
  {$IfEnd} //not NoVGScene
  
  ;

type
 TnscReminder = vgReminderWithAction.TvgReminderWithAction;
{$IfEnd} //Nemesis

implementation

{$If defined(Nemesis)}
{$IfEnd} //Nemesis
end.