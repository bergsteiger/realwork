unit NOT_FINISHED_GUITestRunner;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DUnit"
// ������: "w:/common/components/rtl/external/DUnit/src/NOT_FINISHED_GUITestRunner.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi Testing Framework::DUnit::Source::GUITestRunner
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

interface

{$If defined(nsTest)}
type
 TGUITestRunner = class
 end;//TGUITestRunner
procedure RunRegisteredTests;
   {* ��������� ������ RunRegisteredTests }
{$IfEnd} //nsTest

implementation

{$If defined(nsTest)}
uses
  vtComboBoxQS
  {$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwKeyWordsPack
  {$IfEnd} //nsTest AND not NoScripts AND not NoVCL
  
  ;

// unit methods

procedure RunRegisteredTests;
//#UC START# *4B2A0DAC0037_4B2A0D9401CC_var*
//#UC END# *4B2A0DAC0037_4B2A0D9401CC_var*
begin
//#UC START# *4B2A0DAC0037_4B2A0D9401CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B2A0DAC0037_4B2A0D9401CC_impl*
end;//RunRegisteredTests
{$IfEnd} //nsTest
end.