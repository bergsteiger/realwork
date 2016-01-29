unit K259893591;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/K259893591.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.7::K259893591
//
// [$259893591]
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
  WholeSelectionWithMouseTest,
  Types
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK259893591 = class(TWholeSelectionWithMouseTest)
  {* [$259893591] }
 protected
 // overridden protected methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   function FormExtent: TPoint; override;
     {* ������� ����� }
   {$IfEnd} //nsTest AND not NoVCM
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK259893591
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
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

// start class TK259893591

{$If defined(nsTest) AND not defined(NoVCM)}
function TK259893591.FormExtent: TPoint;
//#UC START# *4C08CF700318_4DA7CD6B0116_var*
//#UC END# *4C08CF700318_4DA7CD6B0116_var*
begin
//#UC START# *4C08CF700318_4DA7CD6B0116_impl*
 Result.X := 1000;
 Result.Y := 700;
//#UC END# *4C08CF700318_4DA7CD6B0116_impl*
end;//TK259893591.FormExtent
{$IfEnd} //nsTest AND not NoVCM

function TK259893591.GetFolder: AnsiString;
 {-}
begin
 Result := '7.7';
end;//TK259893591.GetFolder

function TK259893591.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4DA7CD6B0116';
end;//TK259893591.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK259893591.Suite);

end.