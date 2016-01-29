unit NSRCtoNSRCTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/Daily/NSRCtoNSRCTest.pas"
// �����: 19.11.2010 16:39
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::NSRCTests::NSRCtoNSRCTest
//
// ���� �������������� NSRC � NSRC
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
 TNSRCtoNSRCTest = {abstract} class(TNSRCWriterTest)
  {* ���� �������������� NSRC � NSRC }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 protected
 // protected methods
   function IsPlus: Boolean; virtual;
     {* NSRC+? }
 published
 // published methods
   procedure DoIt;
 end;//TNSRCtoNSRCTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TNSRCtoNSRCTest

procedure TNSRCtoNSRCTest.DoIt;
//#UC START# *4CE67DDC011B_4CE67D90013B_var*
//#UC END# *4CE67DDC011B_4CE67D90013B_var*
begin
//#UC START# *4CE67DDC011B_4CE67D90013B_impl*
 NSRCtoNSRC(KPage + '.nsr', IsPlus);
//#UC END# *4CE67DDC011B_4CE67D90013B_impl*
end;//TNSRCtoNSRCTest.DoIt

function TNSRCtoNSRCTest.IsPlus: Boolean;
//#UC START# *4CE67DED0192_4CE67D90013B_var*
//#UC END# *4CE67DED0192_4CE67D90013B_var*
begin
//#UC START# *4CE67DED0192_4CE67D90013B_impl*
 Result := true;
//#UC END# *4CE67DED0192_4CE67D90013B_impl*
end;//TNSRCtoNSRCTest.IsPlus

function TNSRCtoNSRCTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'NSRCTests';
end;//TNSRCtoNSRCTest.GetFolder

function TNSRCtoNSRCTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4CE67D90013B';
end;//TNSRCtoNSRCTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.