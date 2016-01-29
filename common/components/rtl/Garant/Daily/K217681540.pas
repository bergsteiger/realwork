unit K217681540;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/Daily/K217681540.pas"
// �����: 04.06.2010 18:54
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.5::K217681540
//
// {RequestLink:217681540}
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
 TK217681540 = class(TScrollTest)
  {* [RequestLink:217681540] }
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
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK217681540
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

// start class TK217681540

{$If defined(nsTest) AND not defined(NoVCM)}
function TK217681540.GetNormalFontSize: Integer;
//#UC START# *4C07AC6F036D_4C09139A00FE_var*
//#UC END# *4C07AC6F036D_4C09139A00FE_var*
begin
//#UC START# *4C07AC6F036D_4C09139A00FE_impl*
 Result := 14;
//#UC END# *4C07AC6F036D_4C09139A00FE_impl*
end;//TK217681540.GetNormalFontSize
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TK217681540.FormExtent: TPoint;
//#UC START# *4C08CF700318_4C09139A00FE_var*
//#UC END# *4C08CF700318_4C09139A00FE_var*
begin
//#UC START# *4C08CF700318_4C09139A00FE_impl*
 Result.X := 798;
 Result.Y := 465;
//#UC END# *4C08CF700318_4C09139A00FE_impl*
end;//TK217681540.FormExtent
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TK217681540.SendKey: Boolean;
//#UC START# *4C091B9A0305_4C09139A00FE_var*
//#UC END# *4C091B9A0305_4C09139A00FE_var*
begin
//#UC START# *4C091B9A0305_4C09139A00FE_impl*
 Result := true;
//#UC END# *4C091B9A0305_4C09139A00FE_impl*
end;//TK217681540.SendKey
{$IfEnd} //nsTest AND not NoVCM

function TK217681540.GetFolder: AnsiString;
 {-}
begin
 Result := '7.5';
end;//TK217681540.GetFolder

function TK217681540.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C09139A00FE';
end;//TK217681540.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK217681540.Suite);

end.