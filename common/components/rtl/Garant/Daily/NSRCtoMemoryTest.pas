unit NSRCtoMemoryTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/NSRCtoMemoryTest.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::NSRCTests::NSRCtoMemoryTest
//
// ���� ������ NSRC � ������
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
 TNSRCtoMemoryTest = {abstract} class(TNSRCWriterTest)
  {* ���� ������ NSRC � ������ }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 published
 // published methods
   procedure DoIt;
 end;//TNSRCtoMemoryTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TNSRCtoMemoryTest

procedure TNSRCtoMemoryTest.DoIt;
//#UC START# *4B8547F30147_4B8549760232_var*
//#UC END# *4B8547F30147_4B8549760232_var*
begin
//#UC START# *4B8547F30147_4B8549760232_impl*
 NSRCtoMemory(KPage + '.nsr');
//#UC END# *4B8547F30147_4B8549760232_impl*
end;//TNSRCtoMemoryTest.DoIt

function TNSRCtoMemoryTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'NSRCTests';
end;//TNSRCtoMemoryTest.GetFolder

function TNSRCtoMemoryTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4B8549760232';
end;//TNSRCtoMemoryTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.