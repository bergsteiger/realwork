unit K565842263;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/K565842263.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::NSRCTests::K565842263
//
// {Requestlink:565842263}
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
  NSRCtoEVDTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK565842263 = class(TNSRCtoEVDTest)
  {* [Requestlink:565842263] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK565842263
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK565842263

function TK565842263.GetFolder: AnsiString;
 {-}
begin
 Result := 'NSRCTests';
end;//TK565842263.GetFolder

function TK565842263.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '542BF156004C';
end;//TK565842263.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK565842263.Suite);

end.