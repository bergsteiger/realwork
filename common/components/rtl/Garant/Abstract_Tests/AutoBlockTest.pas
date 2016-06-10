unit AutoBlockTest;
 {* Тест разбиения документа на блоки }

// Модуль: "w:\common\components\rtl\Garant\Abstract_Tests\AutoBlockTest.pas"
// Стереотип: "TestCase"
// Элемент модели: "TAutoBlockTest" MUID: (4D0256A60243)

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
 TAutoBlockTest = {abstract} class({$If NOT Defined(NoVCM)}
 TTextViaEditorProcessor
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* Тест разбиения документа на блоки }
  protected
   {$If NOT Defined(NoVCM)}
   procedure Process(aForm: TPrimTextLoadForm); override;
    {* Собственно процесс обработки текста }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TAutoBlockTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evAutoBlock
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
procedure TAutoBlockTest.Process(aForm: TPrimTextLoadForm);
 {* Собственно процесс обработки текста }
//#UC START# *4BE13147032C_4D0256A60243_var*
//#UC END# *4BE13147032C_4D0256A60243_var*
begin
//#UC START# *4BE13147032C_4D0256A60243_impl*
 evAutoBlock.CreateBlockStructure(aForm.Text, True);
//#UC END# *4BE13147032C_4D0256A60243_impl*
end;//TAutoBlockTest.Process

function TAutoBlockTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TAutoBlockTest.GetFolder

function TAutoBlockTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D0256A60243';
end;//TAutoBlockTest.GetModelElementGUID
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
