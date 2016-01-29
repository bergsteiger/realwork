unit StyleCtoStyleJTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/StyleCtoStyleJTest.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::NSRCTests::TStyleCtoStyleJTest
//
// [$180060974]
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Daily\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  NSRCWriterTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TStyleCtoStyleJTest = class(TNSRCWriterTest)
  {* [$180060974] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 published
 // published methods
   procedure DoIt;
   procedure ToOldNSRC;
 end;//TStyleCtoStyleJTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TStyleCtoStyleJTest

procedure TStyleCtoStyleJTest.DoIt;
//#UC START# *4B59EDC70252_4B59EDA60116_var*
//#UC END# *4B59EDC70252_4B59EDA60116_var*
begin
//#UC START# *4B59EDC70252_4B59EDA60116_impl*
 NSRCtoNSRC('6.nsr', true);
//#UC END# *4B59EDC70252_4B59EDA60116_impl*
end;//TStyleCtoStyleJTest.DoIt

procedure TStyleCtoStyleJTest.ToOldNSRC;
//#UC START# *4B59F9D70110_4B59EDA60116_var*
//#UC END# *4B59F9D70110_4B59EDA60116_var*
begin
//#UC START# *4B59F9D70110_4B59EDA60116_impl*
 NSRCtoNSRC('6.nsr', false);
//#UC END# *4B59F9D70110_4B59EDA60116_impl*
end;//TStyleCtoStyleJTest.ToOldNSRC

function TStyleCtoStyleJTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'NSRCTests';
end;//TStyleCtoStyleJTest.GetFolder

function TStyleCtoStyleJTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4B59EDA60116';
end;//TStyleCtoStyleJTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TStyleCtoStyleJTest.Suite);

end.