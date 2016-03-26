unit InsertBreakInTextTableTest;
 {* ������� ������ � ������������ ������� � ������ ��������� ������. }

// ������: "w:\common\components\rtl\Garant\Daily\InsertBreakInTextTableTest.pas"
// ���������: "TestCase"
// ������� ������: "TInsertBreakInTextTableTest" MUID: (4CD7EBBB02D3)

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , TextViaEditorProcessorWithNavigate
 , evCustomEditorWindow
 , l3Variant
;

type
 _CursorMover_Parent_ = TTextViaEditorProcessorWithNavigate;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\CursorMover.imp.pas}
 TInsertBreakInTextTableTest = {abstract} class(_CursorMover_)
  {* ������� ������ � ������������ ������� � ������ ��������� ������. }
  protected
   procedure Navigate(aText: TevCustomEditorWindow;
    const anOp: Il3OpPack); override;
    {* ������������� ������ ��� ��������� }
   procedure DoProcess(aText: TevCustomEditorWindow;
    const anOp: Il3OpPack); override;
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TInsertBreakInTextTableTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , nevBase
 , evMsgCode
 , evOp
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
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

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\CursorMover.imp.pas}

procedure TInsertBreakInTextTableTest.Navigate(aText: TevCustomEditorWindow;
 const anOp: Il3OpPack);
 {* ������������� ������ ��� ��������� }
//#UC START# *4C4FE56300FB_4CD7EBBB02D3_var*
var
 i : Integer;
//#UC END# *4C4FE56300FB_4CD7EBBB02D3_var*
begin
//#UC START# *4C4FE56300FB_4CD7EBBB02D3_impl*
 for i := 0 to 3 do
  aText.Selection.Cursor.Move(aText.View, ev_ocCharRight);
 aText.Selection.Cursor.Move(aText.View, ev_ocLineDown);
//#UC END# *4C4FE56300FB_4CD7EBBB02D3_impl*
end;//TInsertBreakInTextTableTest.Navigate

procedure TInsertBreakInTextTableTest.DoProcess(aText: TevCustomEditorWindow;
 const anOp: Il3OpPack);
//#UC START# *4C9214F6002C_4CD7EBBB02D3_var*
//#UC END# *4C9214F6002C_4CD7EBBB02D3_var*
begin
//#UC START# *4C9214F6002C_4CD7EBBB02D3_impl*
 aText.Selection.DrawLines := True;
 aText.Selection.ProcessCommand(ev_msgBreakPara, 0, anOp, 1);
//#UC END# *4C9214F6002C_4CD7EBBB02D3_impl*
end;//TInsertBreakInTextTableTest.DoProcess

function TInsertBreakInTextTableTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'EditorTests';
end;//TInsertBreakInTextTableTest.GetFolder

function TInsertBreakInTextTableTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4CD7EBBB02D3';
end;//TInsertBreakInTextTableTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
