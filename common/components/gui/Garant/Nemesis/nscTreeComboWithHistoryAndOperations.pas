unit nscTreeComboWithHistoryAndOperations;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Nemesis"
// �����: �������� �.�.
// ������: "w:/common/components/gui/Garant/Nemesis/nscTreeComboWithHistoryAndOperations.pas"
// �����: 2008/06/26 06:14:46
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi For F1::Nemesis::Editor::TnscTreeComboWithHistoryAndOperations
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
  nscTreeComboWithHistory
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}
type
 TnscTreeComboWithHistoryAndOperations = class(TnscTreeComboWithHistory)
 end;//TnscTreeComboWithHistoryAndOperations
{$IfEnd} //Nemesis

implementation

{$If defined(Nemesis)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}


{$IfEnd} //Nemesis

initialization
{$If defined(Nemesis) AND not defined(NoScripts)}
// ����������� TnscTreeComboWithHistoryAndOperations
 TtfwClassRef.Register(TnscTreeComboWithHistoryAndOperations);
{$IfEnd} //Nemesis AND not NoScripts

end.