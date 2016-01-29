unit K235052965;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/K235052965.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.6::K235052965
//
// [$235052965]
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
  SelectColumnAndDelete
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK235052965 = class(TSelectColumnAndDelete)
  {* [$235052965] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function SelectColumn(var aColID: Integer): Boolean; override;
     {* �������� ������� aColID }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK235052965
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

// start class TK235052965

function TK235052965.GetFolder: AnsiString;
 {-}
begin
 Result := '7.6';
end;//TK235052965.GetFolder

function TK235052965.SelectColumn(var aColID: Integer): Boolean;
//#UC START# *4C9874060367_4C99A80900C4_var*
//#UC END# *4C9874060367_4C99A80900C4_var*
begin
//#UC START# *4C9874060367_4C99A80900C4_impl*
 Result := True;
 aColID := 2;
//#UC END# *4C9874060367_4C99A80900C4_impl*
end;//TK235052965.SelectColumn

function TK235052965.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C99A80900C4';
end;//TK235052965.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK235052965.Suite);

end.