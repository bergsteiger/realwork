unit TextMericsAfterDeleteTest;
 {* Проверка метрик после удаления. }

// Модуль: "w:\common\components\rtl\Garant\Daily\TextMericsAfterDeleteTest.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , TextMetricsTest
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
 , nevTools
 , evCustomEditorWindow
;

type
 _SelectTablePart_Parent_ = TTextMetricsTest;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\SelectTablePart.imp.pas}
 TTextMericsAfterDeleteTest = {abstract} class(_SelectTablePart_)
  {* Проверка метрик после удаления. }
  protected
   {$If NOT Defined(NoVCM)}
   procedure Process(aForm: TPrimTextLoadForm); override;
    {* Собственно процесс обработки текста }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function NeedSelection: Boolean; override;
    {* Нужно ли чего-нибудь выделять. }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TTextMericsAfterDeleteTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , evOp
 {$If Defined(k2ForEditor)}
 , evCursorTools
 {$IfEnd} // Defined(k2ForEditor)
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

{$Include w:\common\components\rtl\Garant\ScriptEngine\SelectTablePart.imp.pas}

{$If NOT Defined(NoVCM)}
procedure TTextMericsAfterDeleteTest.Process(aForm: TPrimTextLoadForm);
 {* Собственно процесс обработки текста }
//#UC START# *4BE13147032C_4D1B16D302DD_var*
//#UC END# *4BE13147032C_4D1B16D302DD_var*
begin
//#UC START# *4BE13147032C_4D1B16D302DD_impl*
 MakeSelection(aForm.Text);
 aForm.Text.Range.Delete;
//#UC END# *4BE13147032C_4D1B16D302DD_impl*
end;//TTextMericsAfterDeleteTest.Process
{$IfEnd} // NOT Defined(NoVCM)

function TTextMericsAfterDeleteTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TTextMericsAfterDeleteTest.GetFolder

function TTextMericsAfterDeleteTest.NeedSelection: Boolean;
 {* Нужно ли чего-нибудь выделять. }
//#UC START# *4CC8189D02DF_4D1B16D302DD_var*
//#UC END# *4CC8189D02DF_4D1B16D302DD_var*
begin
//#UC START# *4CC8189D02DF_4D1B16D302DD_impl*
 Result := True;
//#UC END# *4CC8189D02DF_4D1B16D302DD_impl*
end;//TTextMericsAfterDeleteTest.NeedSelection

function TTextMericsAfterDeleteTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D1B16D302DD';
end;//TTextMericsAfterDeleteTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
