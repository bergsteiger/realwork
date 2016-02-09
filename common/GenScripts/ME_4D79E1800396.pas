unit VerticalCursorMovingTest;
 {* ���� ������������� ����������� �������. }

// ������: "w:\common\components\rtl\Garant\Abstract_Tests\VerticalCursorMovingTest.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , TextEditorVisitor
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 _CursorMover_Parent_ = TTextEditorVisitor;
 {$Include CursorMover.imp.pas}
 TVerticalCursorMovingTest = {abstract} class(_CursorMover_)
  {* ���� ������������� ����������� �������. }
  protected
   {$If NOT Defined(NoVCM)}
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
    {* ���������� ����� }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TVerticalCursorMovingTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , nevBase
 , TestFrameWork
 , evMsgCode
 , evOp
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

{$Include CursorMover.imp.pas}

{$If NOT Defined(NoVCM)}
procedure TVerticalCursorMovingTest.DoVisit(aForm: TPrimTextLoadForm);
 {* ���������� ����� }
//#UC START# *4BE419AF0217_4D79E1800396_var*
var
 l_Op : InevOp;
//#UC END# *4BE419AF0217_4D79E1800396_var*
begin
//#UC START# *4BE419AF0217_4D79E1800396_impl*
 l_Op := aForm.Text.StartOp;
 try
  aForm.Text.Selection.Cursor.MostInner.SetEntryPoint(10, l_Op);
  aForm.Text.Selection.Cursor.Move(aForm.Text.View, ev_ocLineDown, l_Op);
 finally
  l_Op := nil;
 end;
 Check(aForm.Text.Selection.Cursor.MostInner.Position = 10);
//#UC END# *4BE419AF0217_4D79E1800396_impl*
end;//TVerticalCursorMovingTest.DoVisit
{$IfEnd} // NOT Defined(NoVCM)

function TVerticalCursorMovingTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'EditorTests';
end;//TVerticalCursorMovingTest.GetFolder

function TVerticalCursorMovingTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4D79E1800396';
end;//TVerticalCursorMovingTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
