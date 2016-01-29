unit NSRCtoEVDTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/NSRCtoEVDTest.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::NSRCTests::NSRCtoEVDTest
//
// ���� �������������� NSRC � EVD
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
 TNSRCtoEVDTest = {abstract} class(TNSRCWriterTest)
  {* ���� �������������� NSRC � EVD }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 published
 // published methods
   procedure DoIt;
 end;//TNSRCtoEVDTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TNSRCtoEVDTest

procedure TNSRCtoEVDTest.DoIt;
//#UC START# *4BED4080012C_4BED405E0256_var*
//#UC END# *4BED4080012C_4BED405E0256_var*
begin
//#UC START# *4BED4080012C_4BED405E0256_impl*
 NSRCtoEVD(KPage + '.nsr');
//#UC END# *4BED4080012C_4BED405E0256_impl*
end;//TNSRCtoEVDTest.DoIt

function TNSRCtoEVDTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'NSRCTests';
end;//TNSRCtoEVDTest.GetFolder

function TNSRCtoEVDTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4BED405E0256';
end;//TNSRCtoEVDTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.