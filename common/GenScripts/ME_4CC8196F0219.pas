unit MergeAndCheck;
 {* ���� ����������� ����� � ��������� ������������� }

// ������: "w:\common\components\rtl\Garant\Daily\MergeAndCheck.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , DrawTestPrim
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
 , nevTools
 , evCustomEditorWindow
;

type
 _SelectTablePart_Parent_ = TDrawTestPrim;
 {$Include SelectTablePart.imp.pas}
 TMergeAndCheck = {abstract} class(_SelectTablePart_)
  {* ���� ����������� ����� � ��������� ������������� }
  protected
   {$If NOT Defined(NoVCM)}
   procedure DoBeforeDrawing(aForm: TPrimTextLoadForm); override;
    {* ���������� �����-������ �������� ����� ����������. }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   procedure GetSelectParam(out aStartRow: Integer;
    out aStartCell: Integer;
    out aFinishRow: Integer;
    out aFinishCell: Integer); override;
    {* �������� "����������" ����� ���������. }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TMergeAndCheck
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
;

{$Include SelectTablePart.imp.pas}

{$If NOT Defined(NoVCM)}
procedure TMergeAndCheck.DoBeforeDrawing(aForm: TPrimTextLoadForm);
 {* ���������� �����-������ �������� ����� ����������. }
//#UC START# *4CAC45AE011E_4CC8196F0219_var*
//#UC END# *4CAC45AE011E_4CC8196F0219_var*
begin
//#UC START# *4CAC45AE011E_4CC8196F0219_impl*
 MakeSelection(aForm.Text);
 aForm.Text.Range.Table.Cells.Merge;
 aForm.Text.Processor.Undo;
//#UC END# *4CAC45AE011E_4CC8196F0219_impl*
end;//TMergeAndCheck.DoBeforeDrawing
{$IfEnd} // NOT Defined(NoVCM)

function TMergeAndCheck.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'EditorTests';
end;//TMergeAndCheck.GetFolder

procedure TMergeAndCheck.GetSelectParam(out aStartRow: Integer;
 out aStartCell: Integer;
 out aFinishRow: Integer;
 out aFinishCell: Integer);
 {* �������� "����������" ����� ���������. }
//#UC START# *4CC81D4101AC_4CC8196F0219_var*
//#UC END# *4CC81D4101AC_4CC8196F0219_var*
begin
//#UC START# *4CC81D4101AC_4CC8196F0219_impl*
 aStartRow := 0;
 aStartCell := 0;
 aFinishRow := 3;
 aFinishCell := 0;
//#UC END# *4CC81D4101AC_4CC8196F0219_impl*
end;//TMergeAndCheck.GetSelectParam

function TMergeAndCheck.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4CC8196F0219';
end;//TMergeAndCheck.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
