unit NOT_FINISHED_nscComboBox;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Nemesis"
// ������: "w:/common/components/gui/Garant/Nemesis/NOT_FINISHED_nscComboBox.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi For F1::Nemesis::Editor::TnscComboBox
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include ..\Nemesis\nscDefine.inc}

interface

{$If defined(Nemesis)}
uses
  vtComboTree
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}
type
 TnscEdit = class(TnscComboBox)
 end;//TnscEdit

 TnscEditWithoutPlusMinusShortcut = class(TnscEdit)
 end;//TnscEditWithoutPlusMinusShortcut

 TnscComboBoxWithPwdChar = class(TnscEdit)
 end;//TnscComboBoxWithPwdChar

 TnscComboBox = class(TvtComboTree)
 end;//TnscComboBox
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
// ����������� TnscEdit
 TtfwClassRef.Register(TnscEdit);
{$IfEnd} //Nemesis AND not NoScripts
{$If defined(Nemesis) AND not defined(NoScripts)}
// ����������� TnscEditWithoutPlusMinusShortcut
 TtfwClassRef.Register(TnscEditWithoutPlusMinusShortcut);
{$IfEnd} //Nemesis AND not NoScripts
{$If defined(Nemesis) AND not defined(NoScripts)}
// ����������� TnscComboBoxWithPwdChar
 TtfwClassRef.Register(TnscComboBoxWithPwdChar);
{$IfEnd} //Nemesis AND not NoScripts
{$If defined(Nemesis) AND not defined(NoScripts)}
// ����������� TnscComboBox
 TtfwClassRef.Register(TnscComboBox);
{$IfEnd} //Nemesis AND not NoScripts

end.