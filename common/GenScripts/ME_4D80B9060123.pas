unit ScrollByArrowAndCheckShapesTest;
 {* ���������� �������� �� ������������ ������� � �������� "��������". }

// ������: "w:\common\components\rtl\Garant\Daily\ScrollByArrowAndCheckShapesTest.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , DrawTest
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 _CursorMover_Parent_ = TDrawTest;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\CursorMover.imp.pas}
 _ScrollSupport_Parent_ = _CursorMover_;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\ScrollSupport.imp.pas}
 TScrollByArrowAndCheckShapesTest = {abstract} class(_ScrollSupport_)
  {* ���������� �������� �� ������������ ������� � �������� "��������". }
  protected
   function GetScrollCount: Integer; virtual; abstract;
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   {$If NOT Defined(NoVCM)}
   procedure DoBeforeDrawing(aForm: TPrimTextLoadForm); override;
    {* ���������� �����-������ �������� ����� ����������. }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TScrollByArrowAndCheckShapesTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , evMsgCode
 , evOp
 , l3InternalInterfaces
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , nevTools
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 , l3Base
;

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\CursorMover.imp.pas}

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\ScrollSupport.imp.pas}

function TScrollByArrowAndCheckShapesTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'EditorTests';
end;//TScrollByArrowAndCheckShapesTest.GetFolder

{$If NOT Defined(NoVCM)}
procedure TScrollByArrowAndCheckShapesTest.DoBeforeDrawing(aForm: TPrimTextLoadForm);
 {* ���������� �����-������ �������� ����� ����������. }
//#UC START# *4CAC45AE011E_4D80B9060123_var*
var
 i : Integer;
//#UC END# *4CAC45AE011E_4D80B9060123_var*
begin
//#UC START# *4CAC45AE011E_4D80B9060123_impl*
 GotoDocumentBottom(aForm);
 for i := 0 to GetScrollCount - 1 do
 begin
  if QFLike then
  // - ����� �������� �� ��� ���-�� ��-������ ������������
  begin
   with aForm.Text do
    if not Selection.Cursor.MostInner.ParentPoint.Move(View, ev_ocParaUp{ev_ocLineUp}, StartOp(ev_msgMove)) then
     break;
  end//QFLike
  else
  begin
   if not Il3CommandTarget(aForm.Text).ProcessCommand(ev_ocLineUp, True, 1) then
    Break;
  end;//QFLike
  Application.ProcessMessages;
 end;//while not Text.View.IsDocumentTailVisible
//#UC END# *4CAC45AE011E_4D80B9060123_impl*
end;//TScrollByArrowAndCheckShapesTest.DoBeforeDrawing
{$IfEnd} // NOT Defined(NoVCM)

function TScrollByArrowAndCheckShapesTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4D80B9060123';
end;//TScrollByArrowAndCheckShapesTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
