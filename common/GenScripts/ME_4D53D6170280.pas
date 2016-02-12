unit ColumnResizeByMousePrimTest;
 {* ���� ��������� ������� � ������� ���� }

// ������: "w:\common\components\rtl\Garant\Abstract_Tests\ColumnResizeByMousePrimTest.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , TextViaEditorProcessor
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
 , evCustomEditorWindow
 , Classes
 , nevTools
 , l3Units
 , nevGUIInterfaces
;

type
 _ColumnResizeByMouse_Parent_ = TTextViaEditorProcessor;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\ColumnResizeByMouse.imp.pas}
 TColumnResizeByMousePrimTest = {abstract} class(_ColumnResizeByMouse_)
  {* ���� ��������� ������� � ������� ���� }
  protected
   {$If NOT Defined(NoVCM)}
   procedure Process(aForm: TPrimTextLoadForm); override;
    {* ���������� ������� ��������� ������ }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TColumnResizeByMousePrimTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evConst
 , TestFrameWork
 , l3Base
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\ColumnResizeByMouse.imp.pas}

{$If NOT Defined(NoVCM)}
procedure TColumnResizeByMousePrimTest.Process(aForm: TPrimTextLoadForm);
 {* ���������� ������� ��������� ������ }
//#UC START# *4BE13147032C_4D53D6170280_var*
//#UC END# *4BE13147032C_4D53D6170280_var*
begin
//#UC START# *4BE13147032C_4D53D6170280_impl*
 aForm.Text.Repaint;
 SelectColumn(aForm.Text);
//#UC END# *4BE13147032C_4D53D6170280_impl*
end;//TColumnResizeByMousePrimTest.Process
{$IfEnd} // NOT Defined(NoVCM)

function TColumnResizeByMousePrimTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'EditorTests';
end;//TColumnResizeByMousePrimTest.GetFolder

function TColumnResizeByMousePrimTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4D53D6170280';
end;//TColumnResizeByMousePrimTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
