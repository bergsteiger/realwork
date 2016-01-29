unit K585129079_NSRC_ANSI;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/K585129079_NSRC_ANSI.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.11::K585129079_NSRC_ANSI
//
// {RequestLink:585129079}
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
  EVDtoBothNSRCWriterTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK585129079_NSRC_ANSI = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:585129079] }
 protected
 // overridden protected methods
   function NSRCCodePage: Integer; override;
     {* ��������� ��� ������� � NSRC }
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK585129079_NSRC_ANSI
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  l3Chars,
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK585129079_NSRC_ANSI

function TK585129079_NSRC_ANSI.NSRCCodePage: Integer;
//#UC START# *4BEBCEA00177_5491ABF802C6_var*
//#UC END# *4BEBCEA00177_5491ABF802C6_var*
begin
//#UC START# *4BEBCEA00177_5491ABF802C6_impl*
 Result := CP_ANSI;
//#UC END# *4BEBCEA00177_5491ABF802C6_impl*
end;//TK585129079_NSRC_ANSI.NSRCCodePage

function TK585129079_NSRC_ANSI.GetFolder: AnsiString;
 {-}
begin
 Result := '7.11';
end;//TK585129079_NSRC_ANSI.GetFolder

function TK585129079_NSRC_ANSI.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '5491ABF802C6';
end;//TK585129079_NSRC_ANSI.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK585129079_NSRC_ANSI.Suite);

end.