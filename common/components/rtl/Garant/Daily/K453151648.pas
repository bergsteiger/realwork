unit K453151648;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/K453151648.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.8::K453151648
//
// {Requestlink:453151648}
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
  RTFtoEVDWriterTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK453151648 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:453151648] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK453151648
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK453151648

function TK453151648.GetFolder: AnsiString;
 {-}
begin
 Result := '7.8';
end;//TK453151648.GetFolder

function TK453151648.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '5187509D034E';
end;//TK453151648.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK453151648.Suite);

end.