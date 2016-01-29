unit K217691824;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/K217691824.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.5::K217691824
//
// [$217691824]
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
 TK217691824 = class(TScrollTest)
  {* [$217691824] }
 protected
 // overridden protected methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   function GetNormalFontSize: Integer; override;
     {* ���������� ������ ������ ����� "����������". 0 - ��-��������� }
   {$IfEnd} //nsTest AND not NoVCM
   {$If defined(nsTest) AND not defined(NoVCM)}
   function FormExtent: TPoint; override;
     {* ������� ����� }
   {$IfEnd} //nsTest AND not NoVCM
   {$If defined(nsTest) AND not defined(NoVCM)}
   function SendKey: Boolean; override;
     {* ��������� �� ����� �������� ���������� ������� ������, � �� ������ ������� ��������� }
   {$IfEnd} //nsTest AND not NoVCM
   {$If defined(nsTest) AND not defined(NoVCM)}
   function MaxHeight: Integer; override;
     {* ���� ������������ �� 0, �� ����� ����������� ���� ������� ������ �� FormExtent.Y �� MaxHeight }
   {$IfEnd} //nsTest AND not NoVCM
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK217691824
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

// start class TK217691824

{$If defined(nsTest) AND not defined(NoVCM)}
function TK217691824.GetNormalFontSize: Integer;
//#UC START# *4C07AC6F036D_4C19B3FC026E_var*
//#UC END# *4C07AC6F036D_4C19B3FC026E_var*
begin
//#UC START# *4C07AC6F036D_4C19B3FC026E_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4C19B3FC026E_impl*
end;//TK217691824.GetNormalFontSize
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TK217691824.FormExtent: TPoint;
//#UC START# *4C08CF700318_4C19B3FC026E_var*
//#UC END# *4C08CF700318_4C19B3FC026E_var*
begin
//#UC START# *4C08CF700318_4C19B3FC026E_impl*
 Result.X := 1024;
 Result.Y := 603;
//#UC END# *4C08CF700318_4C19B3FC026E_impl*
end;//TK217691824.FormExtent
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TK217691824.SendKey: Boolean;
//#UC START# *4C091B9A0305_4C19B3FC026E_var*
//#UC END# *4C091B9A0305_4C19B3FC026E_var*
begin
//#UC START# *4C091B9A0305_4C19B3FC026E_impl*
 Result := True;
//#UC END# *4C091B9A0305_4C19B3FC026E_impl*
end;//TK217691824.SendKey
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TK217691824.MaxHeight: Integer;
//#UC START# *4C0E56F000A4_4C19B3FC026E_var*
//#UC END# *4C0E56F000A4_4C19B3FC026E_var*
begin
//#UC START# *4C0E56F000A4_4C19B3FC026E_impl*
 Result := 0{768};
//#UC END# *4C0E56F000A4_4C19B3FC026E_impl*
end;//TK217691824.MaxHeight
{$IfEnd} //nsTest AND not NoVCM

function TK217691824.GetFolder: AnsiString;
 {-}
begin
 Result := '7.5';
end;//TK217691824.GetFolder

function TK217691824.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C19B3FC026E';
end;//TK217691824.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK217691824.Suite);

end.