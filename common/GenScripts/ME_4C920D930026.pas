unit MoveSubTest;

// ������: "w:\common\components\rtl\Garant\Daily\MoveSubTest.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

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
 {$Include CursorMover.imp.pas}
 TMoveSubTest = {abstract} class(_CursorMover_)
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
 end;//TMoveSubTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , nevTools
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

procedure TMoveSubTest.Navigate(aText: TevCustomEditorWindow;
 const anOp: Il3OpPack);
 {* ������������� ������ ��� ��������� }
//#UC START# *4C4FE56300FB_4C920D930026_var*
//#UC END# *4C4FE56300FB_4C920D930026_var*
begin
//#UC START# *4C4FE56300FB_4C920D930026_impl*
 aText.Selection.ProcessCommand(ev_msgMove, ev_ocBottomRight, anOp, 1);
//#UC END# *4C4FE56300FB_4C920D930026_impl*
end;//TMoveSubTest.Navigate

procedure TMoveSubTest.DoProcess(aText: TevCustomEditorWindow;
 const anOp: Il3OpPack);
//#UC START# *4C9214F6002C_4C920D930026_var*
var
 l_Sub : IevSub;
//#UC END# *4C9214F6002C_4C920D930026_var*
begin
//#UC START# *4C9214F6002C_4C920D930026_impl*
 with aText do
 begin
  l_Sub := TextSource.DocumentContainer.SubList.NewSub;
  l_Sub.ID := 1;
  l_Sub.SetTo(Selection.Cursor.MostInner.Obj.AsObject);
 end;//with aText
//#UC END# *4C9214F6002C_4C920D930026_impl*
end;//TMoveSubTest.DoProcess

function TMoveSubTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'EditorTests';
end;//TMoveSubTest.GetFolder

function TMoveSubTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C920D930026';
end;//TMoveSubTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
