unit DeleteColumnToolTest;
 {* Тест удаления колонки через редактор }

// Модуль: "w:\common\components\rtl\Garant\Daily\DeleteColumnToolTest.pas"
// Стереотип: "TestCase"
// Элемент модели: "TDeleteColumnToolTest" MUID: (4CC6E92E0233)

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , TextViaEditorProcessor
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TDeleteColumnToolTest = {abstract} class(TTextViaEditorProcessor)
  {* Тест удаления колонки через редактор }
  protected
   {$If NOT Defined(NoVCM)}
   procedure Process(aForm: TPrimTextLoadForm); override;
    {* Собственно процесс обработки текста }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TDeleteColumnToolTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 {$If Defined(k2ForEditor)}
 , evCursorTools
 {$IfEnd} // Defined(k2ForEditor)
 , nevTools
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
procedure TDeleteColumnToolTest.Process(aForm: TPrimTextLoadForm);
 {* Собственно процесс обработки текста }
//#UC START# *4BE13147032C_4CC6E92E0233_var*
var
 l_Selection : InevSelection;
//#UC END# *4BE13147032C_4CC6E92E0233_var*
begin
//#UC START# *4BE13147032C_4CC6E92E0233_impl*
 l_Selection := aForm.Text.Selection;
 if (l_Selection <> nil) then
 begin
  evSelectTableColumn(l_Selection, aForm.Text.Document.Para[0].AsList, 2);
  aForm.Text.DeleteColumn;
 end; // if (l_Selection <> nil) then
//#UC END# *4BE13147032C_4CC6E92E0233_impl*
end;//TDeleteColumnToolTest.Process

function TDeleteColumnToolTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TDeleteColumnToolTest.GetFolder

function TDeleteColumnToolTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4CC6E92E0233';
end;//TDeleteColumnToolTest.GetModelElementGUID
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
