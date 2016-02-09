unit ScrollAndCheckCursorTest;

// Модуль: "w:\common\components\rtl\Garant\Daily\ScrollAndCheckCursorTest.pas"
// Стереотип: "TestCase"

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
 TScrollAndCheckCursorTest = {abstract} class(TTextEditorVisitor)
  protected
   {$If NOT Defined(NoVCM)}
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
    {* Обработать текст }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   {$If NOT Defined(NoVCM)}
   function F1Like: Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TScrollAndCheckCursorTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
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

{$If NOT Defined(NoVCM)}
procedure TScrollAndCheckCursorTest.DoVisit(aForm: TPrimTextLoadForm);
 {* Обработать текст }
//#UC START# *4BE419AF0217_4D6B85E6037B_var*
var
 i : Integer;
//#UC END# *4BE419AF0217_4D6B85E6037B_var*
begin
//#UC START# *4BE419AF0217_4D6B85E6037B_impl*
 for i := 0 to 1 do
  PageDown(aForm);
 aForm.Text.GotoTop;
 Check(aForm.Text.Selection.Cursor.AtStart);
//#UC END# *4BE419AF0217_4D6B85E6037B_impl*
end;//TScrollAndCheckCursorTest.DoVisit
{$IfEnd} // NOT Defined(NoVCM)

function TScrollAndCheckCursorTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TScrollAndCheckCursorTest.GetFolder

{$If NOT Defined(NoVCM)}
function TScrollAndCheckCursorTest.F1Like: Boolean;
//#UC START# *4C9B31F6015E_4D6B85E6037B_var*
//#UC END# *4C9B31F6015E_4D6B85E6037B_var*
begin
//#UC START# *4C9B31F6015E_4D6B85E6037B_impl*
 Result := True;
//#UC END# *4C9B31F6015E_4D6B85E6037B_impl*
end;//TScrollAndCheckCursorTest.F1Like
{$IfEnd} // NOT Defined(NoVCM)

function TScrollAndCheckCursorTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D6B85E6037B';
end;//TScrollAndCheckCursorTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
