unit TextMericsAfterDeleteTest;
 {* �������� ������ ����� ��������. }

// ������: "w:\common\components\rtl\Garant\Daily\TextMericsAfterDeleteTest.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , TextMetricsTest
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
 , nevTools
 , evCustomEditorWindow
;

type
 _SelectTablePart_Parent_ = TTextMetricsTest;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\SelectTablePart.imp.pas}
 TTextMericsAfterDeleteTest = {abstract} class(_SelectTablePart_)
  {* �������� ������ ����� ��������. }
  protected
   {$If NOT Defined(NoVCM)}
   procedure Process(aForm: TPrimTextLoadForm); override;
    {* ���������� ������� ��������� ������ }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function NeedSelection: Boolean; override;
    {* ����� �� ����-������ ��������. }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TTextMericsAfterDeleteTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , evOp
 {$If Defined(k2ForEditor)}
 , evCursorTools
 {$IfEnd} // Defined(k2ForEditor)
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

{$Include w:\common\components\rtl\Garant\ScriptEngine\SelectTablePart.imp.pas}

{$If NOT Defined(NoVCM)}
procedure TTextMericsAfterDeleteTest.Process(aForm: TPrimTextLoadForm);
 {* ���������� ������� ��������� ������ }
//#UC START# *4BE13147032C_4D1B16D302DD_var*
//#UC END# *4BE13147032C_4D1B16D302DD_var*
begin
//#UC START# *4BE13147032C_4D1B16D302DD_impl*
 MakeSelection(aForm.Text);
 aForm.Text.Range.Delete;
//#UC END# *4BE13147032C_4D1B16D302DD_impl*
end;//TTextMericsAfterDeleteTest.Process
{$IfEnd} // NOT Defined(NoVCM)

function TTextMericsAfterDeleteTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'EditorTests';
end;//TTextMericsAfterDeleteTest.GetFolder

function TTextMericsAfterDeleteTest.NeedSelection: Boolean;
 {* ����� �� ����-������ ��������. }
//#UC START# *4CC8189D02DF_4D1B16D302DD_var*
//#UC END# *4CC8189D02DF_4D1B16D302DD_var*
begin
//#UC START# *4CC8189D02DF_4D1B16D302DD_impl*
 Result := True;
//#UC END# *4CC8189D02DF_4D1B16D302DD_impl*
end;//TTextMericsAfterDeleteTest.NeedSelection

function TTextMericsAfterDeleteTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4D1B16D302DD';
end;//TTextMericsAfterDeleteTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
