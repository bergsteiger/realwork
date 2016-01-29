unit K251334429;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/K251334429.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.7::K251334429
//
// [$251334429]
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
  DrawTest,
  Types
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK251334429 = class(TDrawTest)
  {* [$251334429] }
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
 end;//TK251334429
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork,
  nevTools
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

// start class TK251334429

{$If defined(nsTest) AND not defined(NoVCM)}
function TK251334429.FormExtent: TPoint;
//#UC START# *4C08CF700318_4D42A997020E_var*
//#UC END# *4C08CF700318_4D42A997020E_var*
begin
//#UC START# *4C08CF700318_4D42A997020E_impl*
 Result.X := 1024;
 Result.Y := 710; 
//#UC END# *4C08CF700318_4D42A997020E_impl*
end;//TK251334429.FormExtent
{$IfEnd} //nsTest AND not NoVCM

function TK251334429.GetFolder: AnsiString;
 {-}
begin
 Result := '7.7';
end;//TK251334429.GetFolder

function TK251334429.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D42A997020E';
end;//TK251334429.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK251334429.Suite);

end.