unit K264902374;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/K264902374.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.7::K264902374
//
// [$264902374]
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
  SelectCommentAndDelete
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK264902374 = class(TSelectCommentAndDelete)
  {* [$264902374] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK264902374
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork,
  evTypes
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3Base
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK264902374

function TK264902374.GetFolder: AnsiString;
 {-}
begin
 Result := '7.7';
end;//TK264902374.GetFolder

function TK264902374.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4DD6003B0093';
end;//TK264902374.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK264902374.Suite);

end.