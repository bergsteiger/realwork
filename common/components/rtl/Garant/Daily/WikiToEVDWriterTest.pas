unit WikiToEVDWriterTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/WikiToEVDWriterTest.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::Wiki::WikiToEVDWriterTest
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
  WikiReaderTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TWikiToEVDWriterTest = {abstract} class(TWikiReaderTest)
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 published
 // published methods
   procedure DoIt;
 end;//TWikiToEVDWriterTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TWikiToEVDWriterTest

procedure TWikiToEVDWriterTest.DoIt;
//#UC START# *4D6BE7160392_4D6BE6F801DF_var*
//#UC END# *4D6BE7160392_4D6BE6F801DF_var*
begin
//#UC START# *4D6BE7160392_4D6BE6F801DF_impl*
 WikiToEVD(KPage + '.wiki');
//#UC END# *4D6BE7160392_4D6BE6F801DF_impl*
end;//TWikiToEVDWriterTest.DoIt

function TWikiToEVDWriterTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'Wiki';
end;//TWikiToEVDWriterTest.GetFolder

function TWikiToEVDWriterTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D6BE6F801DF';
end;//TWikiToEVDWriterTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.