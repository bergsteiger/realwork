unit EVDtoBothNSRCWriterTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/EVDtoBothNSRCWriterTest.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::NSRCTests::TEVDtoBothNSRCWriterTest
//
// ���� ������ � NSRC+ � NSRC
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
  EVDtoNSRCPlusWriterTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TEVDtoBothNSRCWriterTest = {abstract} class(TEVDtoNSRCPlusWriterTest)
  {* ���� ������ � NSRC+ � NSRC }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 published
 // published methods
   procedure ToOldNSRC;
 end;//TEVDtoBothNSRCWriterTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TEVDtoBothNSRCWriterTest

procedure TEVDtoBothNSRCWriterTest.ToOldNSRC;
//#UC START# *4B8543040166_4B8542C302E3_var*
//#UC END# *4B8543040166_4B8542C302E3_var*
begin
//#UC START# *4B8543040166_4B8542C302E3_impl*
 EVDtoNSRC(KPage + '.evd', false);
//#UC END# *4B8543040166_4B8542C302E3_impl*
end;//TEVDtoBothNSRCWriterTest.ToOldNSRC

function TEVDtoBothNSRCWriterTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'NSRCTests';
end;//TEVDtoBothNSRCWriterTest.GetFolder

function TEVDtoBothNSRCWriterTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4B8542C302E3';
end;//TEVDtoBothNSRCWriterTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.