unit EVDtoHTMLTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/EVDtoHTMLTest.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::HTML::EVDtoHTMLTest
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
  EVDtoHTMLWriterTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TEVDtoHTMLTest = {abstract} class(TEVDtoHTMLWriterTest)
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 published
 // published methods
   procedure DoIt;
 end;//TEVDtoHTMLTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TEVDtoHTMLTest

procedure TEVDtoHTMLTest.DoIt;
//#UC START# *516E73710182_516E734901D3_var*
//#UC END# *516E73710182_516E734901D3_var*
begin
//#UC START# *516E73710182_516E734901D3_impl*
 EVDtoHTML(KPage + '.evd');
//#UC END# *516E73710182_516E734901D3_impl*
end;//TEVDtoHTMLTest.DoIt

function TEVDtoHTMLTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'HTML';
end;//TEVDtoHTMLTest.GetFolder

function TEVDtoHTMLTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '516E734901D3';
end;//TEVDtoHTMLTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.