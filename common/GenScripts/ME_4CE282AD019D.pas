unit ScrollByArrow;
 {* ��������� ��������� �������� �� ����������. }

// ������: "w:\common\components\rtl\Garant\Daily\ScrollByArrow.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , PrimScrollTest
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 _CursorMover_Parent_ = TPrimScrollTest;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\CursorMover.imp.pas}
 _ScrollSupport_Parent_ = _CursorMover_;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\ScrollSupport.imp.pas}
 TScrollByArrow = {abstract} class(_ScrollSupport_)
  {* ��������� ��������� �������� �� ����������. }
  protected
   {$If NOT Defined(NoVCM)}
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
    {* ���������� ����� }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TScrollByArrow
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
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 , l3Base
;

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\CursorMover.imp.pas}

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\ScrollSupport.imp.pas}

{$If NOT Defined(NoVCM)}
procedure TScrollByArrow.DoVisit(aForm: TPrimTextLoadForm);
 {* ���������� ����� }
//#UC START# *4BE419AF0217_4CE282AD019D_var*
//#UC END# *4BE419AF0217_4CE282AD019D_var*
begin
//#UC START# *4BE419AF0217_4CE282AD019D_impl*
 GotoDocumentBottom(aForm);
 while not aForm.Text.View.TopAnchor.AtStart do
 begin
  if not Il3CommandTarget(aForm.Text).ProcessCommand(ev_ocLineUp, True, 1) then Break;
  if ShouldStop then Break;
  Application.ProcessMessages;
 end;//while not Text.View.IsDocumentTailVisible
//#UC END# *4BE419AF0217_4CE282AD019D_impl*
end;//TScrollByArrow.DoVisit
{$IfEnd} // NOT Defined(NoVCM)

function TScrollByArrow.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'EditorTests';
end;//TScrollByArrow.GetFolder

function TScrollByArrow.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4CE282AD019D';
end;//TScrollByArrow.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
