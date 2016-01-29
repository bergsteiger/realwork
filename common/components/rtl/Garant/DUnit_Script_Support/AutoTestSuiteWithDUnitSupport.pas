unit AutoTestSuiteWithDUnitSupport;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DUnit Script Support"
// ������: "w:/common/components/rtl/Garant/DUnit_Script_Support/AutoTestSuiteWithDUnitSupport.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Testing Framework::DUnit Script Support::DUnitKeyWordsSupport::TAutoTestSuiteWithDUnitSupport
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\DUnit_Script_Support\dsDefine.inc}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  CustomAutoTestsSuite
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TAutoTestSuiteWithDUnitSupport = class(TCustomAutoTestSuite)
 end;//TAutoTestSuiteWithDUnitSupport
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  Classes
  {$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwKeyWordsPack
  {$IfEnd} //nsTest AND not NoScripts AND not NoVCL
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}


{$IfEnd} //nsTest AND not NoScripts
end.