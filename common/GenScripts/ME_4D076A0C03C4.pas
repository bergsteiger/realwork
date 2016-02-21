unit TextMetricsTest;
 {* Тест проверяющий метрики текста. Такие как AllChildrenCount, NettoCharCount, BruttoCharCount, TextParaCount, BitmapParaCount }

// Модуль: "w:\common\components\rtl\Garant\Abstract_Tests\TextMetricsTest.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Abstract_Tests\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , TextMetricsPrimTest
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TTextMetricsTest = {abstract} class(TTextMetricsPrimTest)
  {* Тест проверяющий метрики текста. Такие как AllChildrenCount, NettoCharCount, BruttoCharCount, TextParaCount, BitmapParaCount }
  protected
   {$If NOT Defined(NoVCM)}
   procedure Process(aForm: TPrimTextLoadForm); override;
    {* Собственно процесс обработки текста }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TTextMetricsTest
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
procedure TTextMetricsTest.Process(aForm: TPrimTextLoadForm);
 {* Собственно процесс обработки текста }
//#UC START# *4BE13147032C_4D076A0C03C4_var*
//#UC END# *4BE13147032C_4D076A0C03C4_var*
begin
//#UC START# *4BE13147032C_4D076A0C03C4_impl*
 // - ничего не делаем
//#UC END# *4BE13147032C_4D076A0C03C4_impl*
end;//TTextMetricsTest.Process
{$IfEnd} // NOT Defined(NoVCM)

function TTextMetricsTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TTextMetricsTest.GetFolder

function TTextMetricsTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D076A0C03C4';
end;//TTextMetricsTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
