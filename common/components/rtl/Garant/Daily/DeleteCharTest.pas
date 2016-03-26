unit DeleteCharTest;

// Модуль: "w:\common\components\rtl\Garant\Daily\DeleteCharTest.pas"
// Стереотип: "TestCase"
// Элемент модели: "TDeleteCharTest" MUID: (4CA30546032E)

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
 TDeleteCharTest = {abstract} class(_CursorMover_)
  protected
   function CharCount: Integer; virtual;
   procedure Navigate(aText: TevCustomEditorWindow;
    const anOp: Il3OpPack); override;
    {* Устанавливает курсор или выделение }
   procedure DoProcess(aText: TevCustomEditorWindow;
    const anOp: Il3OpPack); override;
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TDeleteCharTest
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
;

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\CursorMover.imp.pas}

function TDeleteCharTest.CharCount: Integer;
//#UC START# *4DF781CB0217_4CA30546032E_var*
//#UC END# *4DF781CB0217_4CA30546032E_var*
begin
//#UC START# *4DF781CB0217_4CA30546032E_impl*
 Result := 1;
//#UC END# *4DF781CB0217_4CA30546032E_impl*
end;//TDeleteCharTest.CharCount

procedure TDeleteCharTest.Navigate(aText: TevCustomEditorWindow;
 const anOp: Il3OpPack);
 {* Устанавливает курсор или выделение }
//#UC START# *4C4FE56300FB_4CA30546032E_var*
//#UC END# *4C4FE56300FB_4CA30546032E_var*
begin
//#UC START# *4C4FE56300FB_4CA30546032E_impl*
 with aText do
 begin
  Check(MoveLeafCursor(ev_ocParaDown, true));
  Check(MoveLeafCursor(ev_ocBottomRight, false));
 end;//with aText
//#UC END# *4C4FE56300FB_4CA30546032E_impl*
end;//TDeleteCharTest.Navigate

procedure TDeleteCharTest.DoProcess(aText: TevCustomEditorWindow;
 const anOp: Il3OpPack);
//#UC START# *4C9214F6002C_4CA30546032E_var*
var
 l_Index : Integer;
//#UC END# *4C9214F6002C_4CA30546032E_var*
begin
//#UC START# *4C9214F6002C_4CA30546032E_impl*
 with aText do
  for l_Index := 0 to Pred(CharCount) do
   Check(Selection.Cursor.Text.Modify.DeleteChar(View, false, anOp));
//#UC END# *4C9214F6002C_4CA30546032E_impl*
end;//TDeleteCharTest.DoProcess

function TDeleteCharTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TDeleteCharTest.GetFolder

function TDeleteCharTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4CA30546032E';
end;//TDeleteCharTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
