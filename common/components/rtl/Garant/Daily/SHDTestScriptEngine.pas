unit SHDTestScriptEngine;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/SHDTestScriptEngine.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Tests::DailyTest::ScriptSupport::TSHDTestScriptEngine
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Daily\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(InsiderTest) AND not defined(NoScripts)}
uses
  tfwScriptEngineEX
  ;
{$IfEnd} //nsTest AND not InsiderTest AND not NoScripts

{$If defined(nsTest) AND not defined(InsiderTest) AND not defined(NoScripts)}
type
 TSHDTestScriptEngine = class(TtfwScriptEngineEX)
 end;//TSHDTestScriptEngine
{$IfEnd} //nsTest AND not InsiderTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(InsiderTest) AND not defined(NoScripts)}
uses
  AutoTestsSuite
  {$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
  ,
  SupportKeyWords
  {$IfEnd} //nsTest AND not NoScripts AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not InsiderTest AND not NoScripts

{$If defined(nsTest) AND not defined(InsiderTest) AND not defined(NoScripts)}


{$IfEnd} //nsTest AND not InsiderTest AND not NoScripts
end.