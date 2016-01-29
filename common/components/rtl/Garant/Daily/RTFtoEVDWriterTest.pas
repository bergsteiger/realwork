unit RTFtoEVDWriterTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/Daily/RTFtoEVDWriterTest.pas"
// �����: 20.09.2010 12:32
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::RTF::RTFtoEVDWriterTest
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
  RTFReaderTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TRTFtoEVDWriterTest = {abstract} class(TRTFReaderTest)
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 published
 // published methods
   procedure DoIt;
 end;//TRTFtoEVDWriterTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TRTFtoEVDWriterTest

procedure TRTFtoEVDWriterTest.DoIt;
//#UC START# *4C971C540358_4C971C2203DD_var*
//#UC END# *4C971C540358_4C971C2203DD_var*
begin
//#UC START# *4C971C540358_4C971C2203DD_impl*
 RTFtoEVD(KPage + '.rtf');
//#UC END# *4C971C540358_4C971C2203DD_impl*
end;//TRTFtoEVDWriterTest.DoIt

function TRTFtoEVDWriterTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'RTF';
end;//TRTFtoEVDWriterTest.GetFolder

function TRTFtoEVDWriterTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C971C2203DD';
end;//TRTFtoEVDWriterTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.