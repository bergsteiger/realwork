unit K537233020;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/K537233020.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.10::K537233020
//
// {Requestlink:537233020}
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
 TK537233020 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:537233020] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK537233020
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK537233020

function TK537233020.GetFolder: AnsiString;
 {-}
begin
 Result := '7.10';
end;//TK537233020.GetFolder

function TK537233020.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '537F13DD031D';
end;//TK537233020.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK537233020.Suite);

end.