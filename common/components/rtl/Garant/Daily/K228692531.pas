unit K228692531;
 {* [RequestLink:228692531] }

// ������: "w:\common\components\rtl\Garant\Daily\K228692531.pas"
// ���������: "TestCase"
// ������� ������: "K228692531" MUID: (4C500E2C0117)
// ��� ����: "TK228692531"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , InsertStreamTest
 , evCustomEditorWindow
 , l3Variant
;

type
 _CursorMover_Parent_ = TInsertStreamTest;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\CursorMover.imp.pas}
 TK228692531 = class(_CursorMover_)
  {* [RequestLink:228692531] }
  protected
   function TextForInsert: AnsiString; override;
    {* ����� ��� ������� }
   procedure Navigate(aText: TevCustomEditorWindow;
    const anOp: Il3OpPack); override;
    {* ������������� ������ ��� ��������� }
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK228692531
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
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
 //#UC START# *4C500E2C0117impl_uses*
 //#UC END# *4C500E2C0117impl_uses*
;

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\CursorMover.imp.pas}

function TK228692531.TextForInsert: AnsiString;
 {* ����� ��� ������� }
//#UC START# *4C4FDCBA002F_4C500E2C0117_var*
//#UC END# *4C4FDCBA002F_4C500E2C0117_var*
begin
//#UC START# *4C4FDCBA002F_4C500E2C0117_impl*
 Result := 'a'#13#10'b';
//#UC END# *4C4FDCBA002F_4C500E2C0117_impl*
end;//TK228692531.TextForInsert

procedure TK228692531.Navigate(aText: TevCustomEditorWindow;
 const anOp: Il3OpPack);
 {* ������������� ������ ��� ��������� }
//#UC START# *4C4FE56300FB_4C500E2C0117_var*
//#UC END# *4C4FE56300FB_4C500E2C0117_var*
begin
//#UC START# *4C4FE56300FB_4C500E2C0117_impl*
 aText.Selection.ProcessCommand(ev_msgMove, ev_ocParaDown, anOp, 1);
 aText.Selection.ProcessCommand(ev_msgMove, ev_ocExtParaDown, anOp, 1);
 aText.Selection.ProcessCommand(ev_msgMove, ev_ocExtCharRight, anOp, 1);
//#UC END# *4C4FE56300FB_4C500E2C0117_impl*
end;//TK228692531.Navigate

function TK228692531.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK228692531.GetFolder

function TK228692531.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C500E2C0117';
end;//TK228692531.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK228692531.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
