unit DeleteColumnToolTest;
 {* ���� �������� ������� ����� �������� }

// ������: "w:\common\components\rtl\Garant\Daily\DeleteColumnToolTest.pas"
// ���������: "TestCase"
// ������� ������: "TDeleteColumnToolTest" MUID: (4CC6E92E0233)

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

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
;

type
 TDeleteColumnToolTest = {abstract} class(TTextViaEditorProcessor)
  {* ���� �������� ������� ����� �������� }
  protected
   {$If NOT Defined(NoVCM)}
   procedure Process(aForm: TPrimTextLoadForm); override;
    {* ���������� ������� ��������� ������ }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TDeleteColumnToolTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 {$If Defined(k2ForEditor)}
 , evCursorTools
 {$IfEnd} // Defined(k2ForEditor)
 , nevTools
 , TestFrameWork
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

{$If NOT Defined(NoVCM)}
procedure TDeleteColumnToolTest.Process(aForm: TPrimTextLoadForm);
 {* ���������� ������� ��������� ������ }
//#UC START# *4BE13147032C_4CC6E92E0233_var*
var
 l_Selection : InevSelection;
//#UC END# *4BE13147032C_4CC6E92E0233_var*
begin
//#UC START# *4BE13147032C_4CC6E92E0233_impl*
 l_Selection := aForm.Text.Selection;
 if (l_Selection <> nil) then
 begin
  evSelectTableColumn(l_Selection, aForm.Text.Document.Para[0].AsList, 2);
  aForm.Text.DeleteColumn;
 end; // if (l_Selection <> nil) then
//#UC END# *4BE13147032C_4CC6E92E0233_impl*
end;//TDeleteColumnToolTest.Process

function TDeleteColumnToolTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'EditorTests';
end;//TDeleteColumnToolTest.GetFolder

function TDeleteColumnToolTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4CC6E92E0233';
end;//TDeleteColumnToolTest.GetModelElementGUID
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
