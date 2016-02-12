unit ClickOnCommentTest;
 {* ������������ �������� ����� �� ��������� �����������. }

// ������: "w:\common\components\rtl\Garant\Abstract_Tests\ClickOnCommentTest.pas"
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
 , l3Units
 , nevTools
 , nevGUIInterfaces
;

type
 _ClickOnCommentHeader_Parent_ = TTextViaEditorProcessor;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\ClickOnCommentHeader.imp.pas}
 TClickOnCommentTest = {abstract} class(_ClickOnCommentHeader_)
  {* ������������ �������� ����� �� ��������� �����������. }
  protected
   {$If NOT Defined(NoVCM)}
   procedure Process(aForm: TPrimTextLoadForm); override;
    {* ���������� ������� ��������� ������ }
   {$IfEnd} // NOT Defined(NoVCM)
   function CheckCollapsed(aText: TevCustomEditorWindow): Boolean; override;
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TClickOnCommentTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
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

{$If not Declared(_FormClass_)}type _FormClass_ = TPrimTextLoadForm;{$IfEnd}

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\ClickOnCommentHeader.imp.pas}

{$If NOT Defined(NoVCM)}
procedure TClickOnCommentTest.Process(aForm: TPrimTextLoadForm);
 {* ���������� ������� ��������� ������ }
//#UC START# *4BE13147032C_4DDF6677000D_var*
//#UC END# *4BE13147032C_4DDF6677000D_var*
begin
//#UC START# *4BE13147032C_4DDF6677000D_impl*
 ClickOnPoint(aForm.Text, True);
 {$IfDef evNeedCollapsedVersionComments}
 Check(CheckCollapsed(aForm.Text));
 {$Else  evNeedCollapsedVersionComments}
 Check(not CheckCollapsed(aForm.Text));
 {$EndIf evNeedCollapsedVersionComments}
//#UC END# *4BE13147032C_4DDF6677000D_impl*
end;//TClickOnCommentTest.Process
{$IfEnd} // NOT Defined(NoVCM)

function TClickOnCommentTest.CheckCollapsed(aText: TevCustomEditorWindow): Boolean;
//#UC START# *4DE7456800BE_4DDF6677000D_var*
//#UC END# *4DE7456800BE_4DDF6677000D_var*
begin
//#UC START# *4DE7456800BE_4DDF6677000D_impl*
 {$IfDef evNeedCollapsedVersionComments}
 Result := aText.View.IsObjectCollapsed[GetInnerPara(aText.View, aText.Document)];
 {$Else  evNeedCollapsedVersionComments}
 Result := false;
 {$EndIf evNeedCollapsedVersionComments}
//#UC END# *4DE7456800BE_4DDF6677000D_impl*
end;//TClickOnCommentTest.CheckCollapsed

function TClickOnCommentTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'EditorTests';
end;//TClickOnCommentTest.GetFolder

function TClickOnCommentTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4DDF6677000D';
end;//TClickOnCommentTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
