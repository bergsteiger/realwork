unit K228692711;
 {* [RequestLink:228692711] }

// ������: "w:\common\components\rtl\Garant\Daily\K228692711.pas"
// ���������: "TestCase"
// ������� ������: "K228692711" MUID: (4C501CCA01C3)
// ��� ����: "TK228692711"

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
 TK228692711 = class(_CursorMover_)
  {* [RequestLink:228692711] }
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
 end;//TK228692711
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , evMsgCode
 , evOp
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
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

function TK228692711.TextForInsert: AnsiString;
 {* ����� ��� ������� }
//#UC START# *4C4FDCBA002F_4C501CCA01C3_var*
//#UC END# *4C4FDCBA002F_4C501CCA01C3_var*
begin
//#UC START# *4C4FDCBA002F_4C501CCA01C3_impl*
 Result := 'a'#13#10'b';
//#UC END# *4C4FDCBA002F_4C501CCA01C3_impl*
end;//TK228692711.TextForInsert

procedure TK228692711.Navigate(aText: TevCustomEditorWindow;
 const anOp: Il3OpPack);
 {* ������������� ������ ��� ��������� }
//#UC START# *4C4FE56300FB_4C501CCA01C3_var*
//#UC END# *4C4FE56300FB_4C501CCA01C3_var*
begin
//#UC START# *4C4FE56300FB_4C501CCA01C3_impl*
 aText.Selection.ProcessCommand(ev_msgMove, ev_ocExtWordRight, anOp, 1);
//#UC END# *4C4FE56300FB_4C501CCA01C3_impl*
end;//TK228692711.Navigate

function TK228692711.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK228692711.GetFolder

function TK228692711.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C501CCA01C3';
end;//TK228692711.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK228692711.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
