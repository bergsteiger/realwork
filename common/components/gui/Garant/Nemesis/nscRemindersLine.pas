unit nscRemindersLine;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Nemesis"
// ������: "w:/common/components/gui/Garant/Nemesis/nscRemindersLine.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For F1::Nemesis::Reminders::nscRemindersLine
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
  vgRemindersLineWithState
  {$IfEnd} //not NoVGScene
  
  ;

type
 TnscRemindersLine = vgRemindersLineWithState.TvgRemindersLineWithState;
{$IfEnd} //Nemesis

implementation

{$If defined(Nemesis)}
{$IfEnd} //Nemesis
end.