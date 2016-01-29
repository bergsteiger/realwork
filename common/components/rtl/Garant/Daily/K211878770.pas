unit K211878770;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/Daily/K211878770.pas"
// �����: 11.05.2010 13:37
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.5::K211878770
//
// {RequestLink:211878770}
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
  EVDtoNSRCOldWriterTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK211878770 = class(TEVDtoNSRCOldWriterTest)
  {* [RequestLink:211878770] }
 protected
 // overridden protected methods
   function NSRCCodePage: Integer; override;
     {* ��������� ��� ������� � NSRC }
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK211878770
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  l3Chars,
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK211878770

function TK211878770.NSRCCodePage: Integer;
//#UC START# *4BEBCEA00177_4BEBC83C00A2_var*
//#UC END# *4BEBCEA00177_4BEBC83C00A2_var*
begin
//#UC START# *4BEBCEA00177_4BEBC83C00A2_impl*
 Result := CP_OEM;
//#UC END# *4BEBCEA00177_4BEBC83C00A2_impl*
end;//TK211878770.NSRCCodePage

function TK211878770.GetFolder: AnsiString;
 {-}
begin
 Result := '7.5';
end;//TK211878770.GetFolder

function TK211878770.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4BEBC83C00A2';
end;//TK211878770.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK211878770.Suite);

end.