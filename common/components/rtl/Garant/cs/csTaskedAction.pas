unit csTaskedAction;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "cs"
// ������: "w:/common/components/rtl/Garant/cs/csTaskedAction.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::Actions::TcsTaskedAction
//
// �������� �� ������� � ������������ ��������� � �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  csAction
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TcsTaskedAction = {abstract} class(TcsAction)
  {* �������� �� ������� � ������������ ��������� � ������� }
 end;//TcsTaskedAction
{$IfEnd} //not Nemesis

implementation

end.