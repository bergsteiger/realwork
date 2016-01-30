unit RowSelectionTest;
 {* ���� ��������� ������. }

// ������: "w:\common\components\rtl\Garant\Abstract_Tests\RowSelectionTest.pas"
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
 , nevTools
 , l3Units
 , nevGUIInterfaces
;

type
 _ClipboardOperations_Parent_ = TTextViaEditorProcessor;
 {$Include ClipboardOperations.imp.pas}
 _MouseClickOnPoint_Parent_ = _ClipboardOperations_;
 {$Include MouseClickOnPoint.imp.pas}
 TRowSelectionTest = {abstract} class(_MouseClickOnPoint_)
  {* ���� ��������� ������. }
  protected
   {$If NOT Defined(NoVCM)}
   procedure Process(aForm: TPrimTextLoadForm); override;
    {* ���������� ������� ��������� ������ }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TRowSelectionTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , l3Base
 , evOp
 , l3InternalInterfaces
;

{$Include ClipboardOperations.imp.pas}

{$Include MouseClickOnPoint.imp.pas}

{$If NOT Defined(NoVCM)}
procedure TRowSelectionTest.Process(aForm: TPrimTextLoadForm);
 {* ���������� ������� ��������� ������ }
//#UC START# *4BE13147032C_4E12DCB800E4_var*
//#UC END# *4BE13147032C_4E12DCB800E4_var*
begin
//#UC START# *4BE13147032C_4E12DCB800E4_impl*
 ClickOnPoint(aForm.Text, False);
 CopyAndPaste2DocumentBottom(aForm.Text);
//#UC END# *4BE13147032C_4E12DCB800E4_impl*
end;//TRowSelectionTest.Process
{$IfEnd} // NOT Defined(NoVCM)

function TRowSelectionTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'EditorTests';
end;//TRowSelectionTest.GetFolder

function TRowSelectionTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4E12DCB800E4';
end;//TRowSelectionTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
