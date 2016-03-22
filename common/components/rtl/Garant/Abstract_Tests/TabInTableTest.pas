unit TabInTableTest;
 {* ������������ ��������� ���������� � ������� }

// ������: "w:\common\components\rtl\Garant\Abstract_Tests\TabInTableTest.pas"
// ���������: "TestCase"
// ������� ������: "TTabInTableTest" MUID: (4D5A45CE00ED)

{$Include w:\common\components\rtl\Garant\Abstract_Tests\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , TextEditorVisitor
 {$IfEnd} // NOT Defined(NoVCM)
 , nevTools
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 _CursorMover_Parent_ = TTextEditorVisitor;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\CursorMover.imp.pas}
 TTabInTableTest = {abstract} class(_CursorMover_)
  {* ������������ ��������� ���������� � ������� }
  protected
   procedure CheckPoint(const aCellPoint: InevBasePoint); virtual;
   function GetDownMoveCount: Integer; virtual;
    {* ���������� �������� ���� }
   function GetTabMoveCount: Integer; virtual;
    {* ���������� �������� �� ���������� }
   {$If NOT Defined(NoVCM)}
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
    {* ���������� ����� }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TTabInTableTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
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

{$If NOT Defined(NoVCM)}
{$Include w:\common\components\gui\Garant\Everest\EditorUsers\CursorMover.imp.pas}

procedure TTabInTableTest.CheckPoint(const aCellPoint: InevBasePoint);
//#UC START# *4D5A4CA602E5_4D5A45CE00ED_var*
//#UC END# *4D5A4CA602E5_4D5A45CE00ED_var*
begin
//#UC START# *4D5A4CA602E5_4D5A45CE00ED_impl*
//#UC END# *4D5A4CA602E5_4D5A45CE00ED_impl*
end;//TTabInTableTest.CheckPoint

function TTabInTableTest.GetDownMoveCount: Integer;
 {* ���������� �������� ���� }
//#UC START# *4D5A4CD801F7_4D5A45CE00ED_var*
//#UC END# *4D5A4CD801F7_4D5A45CE00ED_var*
begin
//#UC START# *4D5A4CD801F7_4D5A45CE00ED_impl*
 Result := 0;
//#UC END# *4D5A4CD801F7_4D5A45CE00ED_impl*
end;//TTabInTableTest.GetDownMoveCount

function TTabInTableTest.GetTabMoveCount: Integer;
 {* ���������� �������� �� ���������� }
//#UC START# *4D5A4CFB029F_4D5A45CE00ED_var*
//#UC END# *4D5A4CFB029F_4D5A45CE00ED_var*
begin
//#UC START# *4D5A4CFB029F_4D5A45CE00ED_impl*
 Result := 0;
//#UC END# *4D5A4CFB029F_4D5A45CE00ED_impl*
end;//TTabInTableTest.GetTabMoveCount

procedure TTabInTableTest.DoVisit(aForm: TPrimTextLoadForm);
 {* ���������� ����� }
//#UC START# *4BE419AF0217_4D5A45CE00ED_var*
var
 i       : Integer;
 l_Point : InevBasePoint;
//#UC END# *4BE419AF0217_4D5A45CE00ED_var*
begin
//#UC START# *4BE419AF0217_4D5A45CE00ED_impl*
 for i := 0 to GetDownMoveCount do
  aForm.Text.Selection.Cursor.Move(aForm.Text.View, ev_ocLineDown);
 for i := 0 to GetTabMoveCount do
  aForm.Text.Selection.Cursor.Move(aForm.Text.View, ev_ocColumnRight);
 l_Point := aForm.Text.Selection.Cursor.Inner;
 l_Point := l_Point.Inner;
 l_Point := l_Point.Inner;
 CheckPoint(l_Point);
//#UC END# *4BE419AF0217_4D5A45CE00ED_impl*
end;//TTabInTableTest.DoVisit

function TTabInTableTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'EditorTests';
end;//TTabInTableTest.GetFolder

function TTabInTableTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4D5A45CE00ED';
end;//TTabInTableTest.GetModelElementGUID
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
