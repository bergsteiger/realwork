unit TextViaEditorProcessorWithNavigate;

// Модуль: "w:\common\components\rtl\Garant\Daily\TextViaEditorProcessorWithNavigate.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , TextViaEditorProcessor
 {$IfEnd} // NOT Defined(NoVCM)
 , evCustomEditorWindow
 , l3Variant
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 _Navigator_Parent_ = TTextViaEditorProcessor;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\Navigator.imp.pas}
 TTextViaEditorProcessorWithNavigate = {abstract} class(_Navigator_)
  protected
   procedure DoProcess(aText: TevCustomEditorWindow;
    const anOp: Il3OpPack); virtual; abstract;
   {$If NOT Defined(NoVCM)}
   procedure Process(aForm: TPrimTextLoadForm); override;
    {* Собственно процесс обработки текста }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TTextViaEditorProcessorWithNavigate
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

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\Navigator.imp.pas}

{$If NOT Defined(NoVCM)}
procedure TTextViaEditorProcessorWithNavigate.Process(aForm: TPrimTextLoadForm);
 {* Собственно процесс обработки текста }
//#UC START# *4BE13147032C_4C9214C80098_var*
var
 l_Op : Il3OpPack;
//#UC END# *4BE13147032C_4C9214C80098_var*
begin
//#UC START# *4BE13147032C_4C9214C80098_impl*
 with aForm.Text do
 begin
  l_Op := StartOp;
  try
   Navigate(aForm.Text, l_Op);
   DoProcess(aForm.Text, l_Op);
  finally
   l_Op := nil;
  end;//try..finally
 end;//with aForm.Text
//#UC END# *4BE13147032C_4C9214C80098_impl*
end;//TTextViaEditorProcessorWithNavigate.Process
{$IfEnd} // NOT Defined(NoVCM)

function TTextViaEditorProcessorWithNavigate.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TTextViaEditorProcessorWithNavigate.GetFolder

function TTextViaEditorProcessorWithNavigate.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C9214C80098';
end;//TTextViaEditorProcessorWithNavigate.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
