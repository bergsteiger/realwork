unit ColumnResizeWithCtrl;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/ColumnResizeWithCtrl.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::EditorTests::TColumnResizeWithCtrl
//
// ��������� ������� ������� � ������� Ctrl
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
  ColumnResizeByMousePrimTest,
  Classes
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TColumnResizeWithCtrl = {abstract} class(TColumnResizeByMousePrimTest)
  {* ��������� ������� ������� � ������� Ctrl }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
   function GetKeys: TShiftState; override;
 end;//TColumnResizeWithCtrl
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

// start class TColumnResizeWithCtrl

function TColumnResizeWithCtrl.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TColumnResizeWithCtrl.GetFolder

function TColumnResizeWithCtrl.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D53D6AA0038';
end;//TColumnResizeWithCtrl.GetModelElementGUID

function TColumnResizeWithCtrl.GetKeys: TShiftState;
//#UC START# *4E32CA120170_4D53D6AA0038_var*
//#UC END# *4E32CA120170_4D53D6AA0038_var*
begin
//#UC START# *4E32CA120170_4D53D6AA0038_impl*
 Result := [ssCtrl];
//#UC END# *4E32CA120170_4D53D6AA0038_impl*
end;//TColumnResizeWithCtrl.GetKeys

{$IfEnd} //nsTest AND not NoScripts

end.