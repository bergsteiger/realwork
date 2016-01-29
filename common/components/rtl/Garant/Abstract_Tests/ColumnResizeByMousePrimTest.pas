unit ColumnResizeByMousePrimTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Abstract Tests"
// ������: "w:/common/components/rtl/Garant/Abstract_Tests/ColumnResizeByMousePrimTest.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::Abstract Tests::EditorTests::TColumnResizeByMousePrimTest
//
// ���� ��������� ������� � ������� ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Abstract_Tests\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  Classes
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  TextViaEditorProcessor
  {$IfEnd} //nsTest AND not NoVCM
  ,
  evCustomEditorWindow,
  l3Units,
  nevTools,
  nevGUIInterfaces
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PrimTextLoad_Form
  {$IfEnd} //nsTest AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 _ColumnResizeByMouse_Parent_ = TTextViaEditorProcessor;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\ColumnResizeByMouse.imp.pas}
 TColumnResizeByMousePrimTest = {abstract} class(_ColumnResizeByMouse_)
  {* ���� ��������� ������� � ������� ���� }
 protected
 // realized methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure Process(aForm: TPrimTextLoadForm); override;
     {* ���������� ������� ��������� ������ }
   {$IfEnd} //nsTest AND not NoVCM
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TColumnResizeByMousePrimTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  evConst,
  TestFrameWork,
  l3Base
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
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\ColumnResizeByMouse.imp.pas}

// start class TColumnResizeByMousePrimTest

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TColumnResizeByMousePrimTest.Process(aForm: TPrimTextLoadForm);
//#UC START# *4BE13147032C_4D53D6170280_var*
//#UC END# *4BE13147032C_4D53D6170280_var*
begin
//#UC START# *4BE13147032C_4D53D6170280_impl*
 aForm.Text.Repaint;
 SelectColumn(aForm.Text);
//#UC END# *4BE13147032C_4D53D6170280_impl*
end;//TColumnResizeByMousePrimTest.Process
{$IfEnd} //nsTest AND not NoVCM

function TColumnResizeByMousePrimTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TColumnResizeByMousePrimTest.GetFolder

function TColumnResizeByMousePrimTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D53D6170280';
end;//TColumnResizeByMousePrimTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.