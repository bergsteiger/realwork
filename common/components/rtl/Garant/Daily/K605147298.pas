unit K605147298;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/K605147298.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.11::K605147298
//
// {Requestlink:605147298}
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
 TK605147298 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:605147298] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK605147298
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK605147298

function TK605147298.GetFolder: AnsiString;
 {-}
begin
 Result := '7.11';
end;//TK605147298.GetFolder

function TK605147298.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '55CC6F620202';
end;//TK605147298.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK605147298.Suite);

end.