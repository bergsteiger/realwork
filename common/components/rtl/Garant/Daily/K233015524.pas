unit K233015524;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/K233015524.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.6::K233015524
//
// [$233015524]
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
  SplitTableTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK233015524 = class(TSplitTableTest)
  {* [$233015524] }
 protected
 // overridden protected methods
   function GetLineCount: Integer; override;
     {* ���������� ������� (������), �� ������� ����� ������� ������ ����� ����������� ������� �� ���. }
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK233015524
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork,
  evMsgCode,
  evOp
  {$If defined(k2ForEditor)}
  ,
  evCursorTools
  {$IfEnd} //k2ForEditor
  
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

// start class TK233015524

function TK233015524.GetLineCount: Integer;
//#UC START# *4C6CFAE20264_4C6CF445008D_var*
//#UC END# *4C6CFAE20264_4C6CF445008D_var*
begin
//#UC START# *4C6CFAE20264_4C6CF445008D_impl*
 Result := 7;
//#UC END# *4C6CFAE20264_4C6CF445008D_impl*
end;//TK233015524.GetLineCount

function TK233015524.GetFolder: AnsiString;
 {-}
begin
 Result := '7.6';
end;//TK233015524.GetFolder

function TK233015524.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C6CF445008D';
end;//TK233015524.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK233015524.Suite);

end.