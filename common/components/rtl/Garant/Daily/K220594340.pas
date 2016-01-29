unit K220594340;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/K220594340.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.5::K220594340
//
// [$220594340]
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
  Classes
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  ScrollTest
  {$IfEnd} //nsTest AND not NoVCM
  ,
  Types
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK220594340 = class(TScrollTest)
  {* [$220594340] }
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
 end;//TK220594340
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

// start class TK220594340

{$If defined(nsTest) AND not defined(NoVCM)}
function TK220594340.FormExtent: TPoint;
//#UC START# *4C08CF700318_4C29A17903A9_var*
//#UC END# *4C08CF700318_4C29A17903A9_var*
begin
//#UC START# *4C08CF700318_4C29A17903A9_impl*
 Result.X := 1024;
 Result.Y := 600;
//#UC END# *4C08CF700318_4C29A17903A9_impl*
end;//TK220594340.FormExtent
{$IfEnd} //nsTest AND not NoVCM

function TK220594340.GetFolder: AnsiString;
 {-}
begin
 Result := '7.5';
end;//TK220594340.GetFolder

function TK220594340.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C29A17903A9';
end;//TK220594340.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK220594340.Suite);

end.