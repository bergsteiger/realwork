unit MergeAndCheckSelectionTest;
 {* ���� �������� ��������� ����� ����������� �����. }

// ������: "w:\common\components\rtl\Garant\Daily\MergeAndCheckSelectionTest.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , MergeCellsTest
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
 , evCustomEditorWindow
;

type
 _ClipboardOperations_Parent_ = TMergeCellsTest;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\ClipboardOperations.imp.pas}
 _SelectOperation_Parent_ = _ClipboardOperations_;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\SelectOperation.imp.pas}
 TMergeAndCheckSelectionTest = {abstract} class(_SelectOperation_)
  {* ���� �������� ��������� ����� ����������� �����. }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   {$If NOT Defined(NoVCM)}
   procedure CheckOperation(aForm: TPrimTextLoadForm); override;
    {* �������� ����� ���������� �����������. }
   {$IfEnd} // NOT Defined(NoVCM)
   function NeedSelection: Boolean; override;
    {* ����� �� ����-������ ��������. }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TMergeAndCheckSelectionTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , l3Base
 , evOp
 , l3InternalInterfaces
 , evTypes
 , evMsgCode
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
;

{$Include w:\common\components\rtl\Garant\ScriptEngine\ClipboardOperations.imp.pas}

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\SelectOperation.imp.pas}

function TMergeAndCheckSelectionTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'EditorTests';
end;//TMergeAndCheckSelectionTest.GetFolder

{$If NOT Defined(NoVCM)}
procedure TMergeAndCheckSelectionTest.CheckOperation(aForm: TPrimTextLoadForm);
 {* �������� ����� ���������� �����������. }
//#UC START# *4C9999C50326_4CE133F801BA_var*
//#UC END# *4C9999C50326_4CE133F801BA_var*
begin
//#UC START# *4C9999C50326_4CE133F801BA_impl*
 if aForm.Text.HasSelection then
  CopyAndPaste2DocumentBottom(aForm.Text);
//#UC END# *4C9999C50326_4CE133F801BA_impl*
end;//TMergeAndCheckSelectionTest.CheckOperation
{$IfEnd} // NOT Defined(NoVCM)

function TMergeAndCheckSelectionTest.NeedSelection: Boolean;
 {* ����� �� ����-������ ��������. }
//#UC START# *4CC8189D02DF_4CE133F801BA_var*
//#UC END# *4CC8189D02DF_4CE133F801BA_var*
begin
//#UC START# *4CC8189D02DF_4CE133F801BA_impl*
 Result := True;
//#UC END# *4CC8189D02DF_4CE133F801BA_impl*
end;//TMergeAndCheckSelectionTest.NeedSelection

function TMergeAndCheckSelectionTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4CE133F801BA';
end;//TMergeAndCheckSelectionTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
