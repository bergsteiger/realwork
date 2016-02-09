unit TextViaEditorProcessorWithExternalSave;

// Модуль: "w:\common\components\rtl\Garant\Abstract_Tests\TextViaEditorProcessorWithExternalSave.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

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
 , l3Filer
;

type
 TTextViaEditorProcessorWithExternalSave = {abstract} class(TTextViaEditorProcessor)
  protected
   procedure DoSave(aForm: TPrimTextLoadForm;
    aFiler: Tl3CustomFiler); virtual; abstract;
   {$If NOT Defined(NoVCM)}
   procedure Save(aForm: TPrimTextLoadForm); override;
    {* Сохраняет текст из редактора в стандартный выходной файл }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TTextViaEditorProcessorWithExternalSave
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , TestFrameWork
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

{$If NOT Defined(NoVCM)}
procedure TTextViaEditorProcessorWithExternalSave.Save(aForm: TPrimTextLoadForm);
 {* Сохраняет текст из редактора в стандартный выходной файл }
//#UC START# *4BE12AEE0190_4D0771BA0367_var*
var
 l_F : Tl3CustomFiler;
//#UC END# *4BE12AEE0190_4D0771BA0367_var*
begin
//#UC START# *4BE12AEE0190_4D0771BA0367_impl*
 l_F := FilerForOutput;
 try
  l_F.Open;
  try
   DoSave(aForm, l_F);
  finally
   l_F.Close;
  end;//try..finally
 finally
  FreeAndNil(l_F);
 end;//try..finally
//#UC END# *4BE12AEE0190_4D0771BA0367_impl*
end;//TTextViaEditorProcessorWithExternalSave.Save
{$IfEnd} // NOT Defined(NoVCM)

function TTextViaEditorProcessorWithExternalSave.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TTextViaEditorProcessorWithExternalSave.GetFolder

function TTextViaEditorProcessorWithExternalSave.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D0771BA0367';
end;//TTextViaEditorProcessorWithExternalSave.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
