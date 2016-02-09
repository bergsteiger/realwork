unit SelectRowAndDeleteTest;
 {* �������� ������ � �������. }

// ������: "w:\common\components\rtl\Garant\Daily\SelectRowAndDeleteTest.pas"
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
 , nevTools
 , evCustomEditorWindow
;

type
 _SelectTablePart_Parent_ = TTextViaEditorProcessor;
 {$Include SelectTablePart.imp.pas}
 TSelectRowAndDeleteTest = {abstract} class(_SelectTablePart_)
  {* �������� ������ � �������. }
  protected
   {$If NOT Defined(NoVCM)}
   procedure Process(aForm: TPrimTextLoadForm); override;
    {* ���������� ������� ��������� ������ }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function NeedSelection: Boolean; override;
    {* ����� �� ����-������ ��������. }
   procedure GetSelectParam(out aStartRow: Integer;
    out aStartCell: Integer;
    out aFinishRow: Integer;
    out aFinishCell: Integer); override;
    {* �������� "����������" ����� ���������. }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TSelectRowAndDeleteTest
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

{$Include SelectTablePart.imp.pas}

{$If NOT Defined(NoVCM)}
procedure TSelectRowAndDeleteTest.Process(aForm: TPrimTextLoadForm);
 {* ���������� ������� ��������� ������ }
//#UC START# *4BE13147032C_4CE3E5F3012B_var*
//#UC END# *4BE13147032C_4CE3E5F3012B_var*
begin
//#UC START# *4BE13147032C_4CE3E5F3012B_impl*
 MakeSelection(aForm.Text);
 aForm.Text.Range.Delete;
//#UC END# *4BE13147032C_4CE3E5F3012B_impl*
end;//TSelectRowAndDeleteTest.Process
{$IfEnd} // NOT Defined(NoVCM)

function TSelectRowAndDeleteTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'EditorTests';
end;//TSelectRowAndDeleteTest.GetFolder

function TSelectRowAndDeleteTest.NeedSelection: Boolean;
 {* ����� �� ����-������ ��������. }
//#UC START# *4CC8189D02DF_4CE3E5F3012B_var*
//#UC END# *4CC8189D02DF_4CE3E5F3012B_var*
begin
//#UC START# *4CC8189D02DF_4CE3E5F3012B_impl*
 Result := True;
//#UC END# *4CC8189D02DF_4CE3E5F3012B_impl*
end;//TSelectRowAndDeleteTest.NeedSelection

procedure TSelectRowAndDeleteTest.GetSelectParam(out aStartRow: Integer;
 out aStartCell: Integer;
 out aFinishRow: Integer;
 out aFinishCell: Integer);
 {* �������� "����������" ����� ���������. }
//#UC START# *4CC81D4101AC_4CE3E5F3012B_var*
//#UC END# *4CC81D4101AC_4CE3E5F3012B_var*
begin
//#UC START# *4CC81D4101AC_4CE3E5F3012B_impl*
 aStartRow := 0;
 aStartCell := 0;
 aFinishRow := 0;
 aFinishCell := 1; 
//#UC END# *4CC81D4101AC_4CE3E5F3012B_impl*
end;//TSelectRowAndDeleteTest.GetSelectParam

function TSelectRowAndDeleteTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4CE3E5F3012B';
end;//TSelectRowAndDeleteTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
