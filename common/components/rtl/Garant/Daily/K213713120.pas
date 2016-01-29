unit K213713120;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/Daily/K213713120.pas"
// �����: 04.06.2010 11:20
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.5::K213713120
//
// {RequestLink:213713120}
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
 TK213713120 = class(TScrollTest)
  {* [RequestLink:213713120] }
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
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK213713120
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

// start class TK213713120

{$If defined(nsTest) AND not defined(NoVCM)}
function TK213713120.GetNormalFontSize: Integer;
//#UC START# *4C07AC6F036D_4C08A9F20321_var*
//#UC END# *4C07AC6F036D_4C08A9F20321_var*
begin
//#UC START# *4C07AC6F036D_4C08A9F20321_impl*
 Result := 14;
//#UC END# *4C07AC6F036D_4C08A9F20321_impl*
end;//TK213713120.GetNormalFontSize
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TK213713120.FormExtent: TPoint;
//#UC START# *4C08CF700318_4C08A9F20321_var*
//#UC END# *4C08CF700318_4C08A9F20321_var*
begin
//#UC START# *4C08CF700318_4C08A9F20321_impl*
 Result.X := 798;
 Result.Y := 440;
//#UC END# *4C08CF700318_4C08A9F20321_impl*
end;//TK213713120.FormExtent
{$IfEnd} //nsTest AND not NoVCM

function TK213713120.GetFolder: AnsiString;
 {-}
begin
 Result := '7.5';
end;//TK213713120.GetFolder

function TK213713120.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C08A9F20321';
end;//TK213713120.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK213713120.Suite);

end.