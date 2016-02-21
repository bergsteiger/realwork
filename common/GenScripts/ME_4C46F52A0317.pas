unit DrawLineTest;
 {* ���� ��������� ����� � ��������� }

// ������: "w:\common\components\gui\Garant\Daily\DrawLineTest.pas"
// ���������: "TestCase"

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , TextViaEditorProcessor
 , PrimTextLoad_Form
;

type
 TDrawLineTest = {abstract} class(TTextViaEditorProcessor)
  {* ���� ��������� ����� � ��������� }
  protected
   procedure Process(aForm: TPrimTextLoadForm); override;
    {* ���������� ������� ��������� ������ }
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TDrawLineTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , evOp
 , nevBase
 , evMsgCode
 , TestFrameWork
 , vcmBase
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

procedure TDrawLineTest.Process(aForm: TPrimTextLoadForm);
 {* ���������� ������� ��������� ������ }
//#UC START# *4BE13147032C_4C46F52A0317_var*
var
 i    : Integer;
 l_Op : InevOp;
//#UC END# *4BE13147032C_4C46F52A0317_var*
begin
//#UC START# *4BE13147032C_4C46F52A0317_impl*
 GotoDocumentBottom(aForm);
 for i := 1 to 69 do
  aForm.Text.Selection.ProcessCommand(ev_msgMove, ev_ocLineUp, l_Op, 1);
 aForm.Text.Selection.Cursor.Move(aForm.Text.View, ev_ocLineHome);
 l_Op := aForm.Text.StartOp;
 aForm.Text.Selection.DrawLines := True;
 for i := 1 to 50 do
  aForm.Text.Selection.ProcessCommand(ev_msgMove, ev_ocExtLineUp, l_Op, 1);
//#UC END# *4BE13147032C_4C46F52A0317_impl*
end;//TDrawLineTest.Process

function TDrawLineTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'Everest';
end;//TDrawLineTest.GetFolder

function TDrawLineTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C46F52A0317';
end;//TDrawLineTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
