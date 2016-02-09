unit K228692538;
 {* [RequestLink:228692538] }

// ������: "w:\common\components\rtl\Garant\Daily\K228692538.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

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
 {$Include CursorMover.imp.pas}
 TK228692538 = class(_CursorMover_)
  {* [RequestLink:228692538] }
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
 end;//TK228692538
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

{$Include CursorMover.imp.pas}

function TK228692538.TextForInsert: AnsiString;
 {* ����� ��� ������� }
//#UC START# *4C4FDCBA002F_4C501524004F_var*
//#UC END# *4C4FDCBA002F_4C501524004F_var*
begin
//#UC START# *4C4FDCBA002F_4C501524004F_impl*
 Result := #13#10;
//#UC END# *4C4FDCBA002F_4C501524004F_impl*
end;//TK228692538.TextForInsert

procedure TK228692538.Navigate(aText: TevCustomEditorWindow;
 const anOp: Il3OpPack);
 {* ������������� ������ ��� ��������� }
//#UC START# *4C4FE56300FB_4C501524004F_var*
//#UC END# *4C4FE56300FB_4C501524004F_var*
begin
//#UC START# *4C4FE56300FB_4C501524004F_impl*
 aText.Selection.ProcessCommand(ev_msgMove, ev_ocExtWordRight, anOp, 1);
//#UC END# *4C4FE56300FB_4C501524004F_impl*
end;//TK228692538.Navigate

function TK228692538.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK228692538.GetFolder

function TK228692538.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C501524004F';
end;//TK228692538.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK228692538.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
