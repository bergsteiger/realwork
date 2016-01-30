unit MouseSelectPtTest;
 {* Тест щелканья мышью по определенной точке. }

// Модуль: "w:\common\components\rtl\Garant\Abstract_Tests\MouseSelectPtTest.pas"
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
 , evCustomEditorWindow
 , nevTools
 , l3Units
 , nevGUIInterfaces
;

type
 _MouseClickOnPoint_Parent_ = TTextEditorVisitor;
 {$Include MouseClickOnPoint.imp.pas}
 TMouseSelectPtTest = {abstract} class(_MouseClickOnPoint_)
  {* Тест щелканья мышью по определенной точке. }
  protected
   {$If NOT Defined(NoVCM)}
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
    {* Обработать текст }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TMouseSelectPtTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , l3Base
;

{$Include MouseClickOnPoint.imp.pas}

{$If NOT Defined(NoVCM)}
procedure TMouseSelectPtTest.DoVisit(aForm: TPrimTextLoadForm);
 {* Обработать текст }
//#UC START# *4BE419AF0217_4D8890B102E6_var*
//#UC END# *4BE419AF0217_4D8890B102E6_var*
begin
//#UC START# *4BE419AF0217_4D8890B102E6_impl*
 ClickOnPoint(aForm.Text, False);
//#UC END# *4BE419AF0217_4D8890B102E6_impl*
end;//TMouseSelectPtTest.DoVisit
{$IfEnd} // NOT Defined(NoVCM)

function TMouseSelectPtTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TMouseSelectPtTest.GetFolder

function TMouseSelectPtTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D8890B102E6';
end;//TMouseSelectPtTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
