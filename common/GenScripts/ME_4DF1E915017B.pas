unit PreviewWithRowCompare;
 {* Тест печати со сравнением строк. }

// Модуль: "w:\common\components\rtl\Garant\Abstract_Tests\PreviewWithRowCompare.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Abstract_Tests\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , PreviewTestBefore278833302
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 _PrintRowCompare_Parent_ = TPreviewTestBefore278833302;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\PrintRowCompare.imp.pas}
 TPreviewWithRowCompare = {abstract} class(_PrintRowCompare_)
  {* Тест печати со сравнением строк. }
  protected
   {$If NOT Defined(NoVCM)}
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
    {* Обработать текст }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TPreviewWithRowCompare
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , TestFrameWork
 , PrintRowHeightsSpy
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

{$If NOT Defined(NoVCM)}
{$Include w:\common\components\gui\Garant\Everest\EditorUsers\PrintRowCompare.imp.pas}

procedure TPreviewWithRowCompare.DoVisit(aForm: TPrimTextLoadForm);
 {* Обработать текст }
//#UC START# *4BE419AF0217_4DF1E915017B_var*
var
 l_OldName: string;
 l_LogName: string;
//#UC END# *4BE419AF0217_4DF1E915017B_var*
begin
//#UC START# *4BE419AF0217_4DF1E915017B_impl*
 l_LogName := OutputPath + KPage + '.rowh';
 TPrintRowHeightsSpy.Instance.StartLogging(l_LogName);
 try
  inherited DoVisit(aForm);
 finally
  TPrintRowHeightsSpy.Instance.StopLogging;
 end;
 l_OldName := f_CurrentOutput;
 try
  f_CurrentOutput := l_LogName;
  CheckOutputWithInput(ChangeFileExt(ExtractFileName(l_LogName), EtalonSuffix + '.rowh'));
 finally
  f_CurrentOutput := l_OldName;
 end;
//#UC END# *4BE419AF0217_4DF1E915017B_impl*
end;//TPreviewWithRowCompare.DoVisit

function TPreviewWithRowCompare.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TPreviewWithRowCompare.GetFolder

function TPreviewWithRowCompare.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4DF1E915017B';
end;//TPreviewWithRowCompare.GetModelElementGUID
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
