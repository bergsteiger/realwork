unit InsertFormulaTest;
 {* Тест на вставку формулы. }

// Модуль: "w:\common\components\rtl\Garant\Abstract_Tests\InsertFormulaTest.pas"
// Стереотип: "TestCase"
// Элемент модели: "TInsertFormulaTest" MUID: (4DAFEAAD012D)

{$Include w:\common\components\rtl\Garant\Abstract_Tests\TestDefine.inc.pas}

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
 TInsertFormulaTest = {abstract} class({$If NOT Defined(NoVCM)}
 TTextViaEditorProcessor
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* Тест на вставку формулы. }
  protected
   function GetFormulaText: AnsiString; virtual; abstract;
   {$If NOT Defined(NoVCM)}
   procedure Process(aForm: TPrimTextLoadForm); override;
    {* Собственно процесс обработки текста }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TInsertFormulaTest
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
procedure TInsertFormulaTest.Process(aForm: TPrimTextLoadForm);
 {* Собственно процесс обработки текста }
//#UC START# *4BE13147032C_4DAFEAAD012D_var*
//#UC END# *4BE13147032C_4DAFEAAD012D_var*
begin
//#UC START# *4BE13147032C_4DAFEAAD012D_impl*
 aForm.Text.InsertFormula(GetFormulaText);
//#UC END# *4BE13147032C_4DAFEAAD012D_impl*
end;//TInsertFormulaTest.Process

function TInsertFormulaTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TInsertFormulaTest.GetFolder

function TInsertFormulaTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4DAFEAAD012D';
end;//TInsertFormulaTest.GetModelElementGUID
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
