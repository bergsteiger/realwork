unit TextMetricsPrimTest;
 {* Тест проверяющий метрики текста. Такие как AllChildrenCount, NettoCharCount, BruttoCharCount, TextParaCount, BitmapParaCount }

// Модуль: "w:\common\components\rtl\Garant\Abstract_Tests\TextMetricsPrimTest.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Abstract_Tests\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , TextViaEditorProcessorWithExternalSave
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Filer
;

type
 TTextMetricsPrimTest = {abstract} class(TTextViaEditorProcessorWithExternalSave)
  {* Тест проверяющий метрики текста. Такие как AllChildrenCount, NettoCharCount, BruttoCharCount, TextParaCount, BitmapParaCount }
  protected
   procedure DoSave(aForm: TPrimTextLoadForm;
    aFiler: Tl3CustomFiler); override;
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   {$If NOT Defined(NoVCM)}
   function EtalonFileExtension: AnsiString; override;
    {* Расширение эталонного файла }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function HeaderBegin: AnsiChar; override;
   {$IfEnd} // NOT Defined(NoVCM)
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TTextMetricsPrimTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , k2Tags
 , TestFrameWork
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

procedure TTextMetricsPrimTest.DoSave(aForm: TPrimTextLoadForm;
 aFiler: Tl3CustomFiler);
//#UC START# *4D0771F102B6_4D07699A02E4_var*
//#UC END# *4D0771F102B6_4D07699A02E4_var*
begin
//#UC START# *4D0771F102B6_4D07699A02E4_impl*
 with aForm.Text do
 begin
  with TextSource.DocumentContainer do
  begin
   aFiler.WriteLn('AllChildrenCount = ' + IntToStr(Obj.IntA[k2_tiAllChildrenCount]));
   with DocumentInfo do
   begin
    aFiler.WriteLn('NettoCharCount = ' + IntToStr(NettoCharCount));
    aFiler.WriteLn('BruttoCharCount = ' + IntToStr(BruttoCharCount));
    aFiler.WriteLn('TextParaCount = ' + IntToStr(TextParaCount));
    aFiler.WriteLn('BitmapParaCount = ' + IntToStr(BitmapParaCount));
   end;//with DocumentInfo
  end;//with TextSource.DocumentContainer
 end;//with aForm.Text
//#UC END# *4D0771F102B6_4D07699A02E4_impl*
end;//TTextMetricsPrimTest.DoSave

function TTextMetricsPrimTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TTextMetricsPrimTest.GetFolder

{$If NOT Defined(NoVCM)}
function TTextMetricsPrimTest.EtalonFileExtension: AnsiString;
 {* Расширение эталонного файла }
//#UC START# *4D0769150130_4D07699A02E4_var*
//#UC END# *4D0769150130_4D07699A02E4_var*
begin
//#UC START# *4D0769150130_4D07699A02E4_impl*
 Result := 'metrics';
//#UC END# *4D0769150130_4D07699A02E4_impl*
end;//TTextMetricsPrimTest.EtalonFileExtension
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TTextMetricsPrimTest.HeaderBegin: AnsiChar;
//#UC START# *4D07693F0262_4D07699A02E4_var*
//#UC END# *4D07693F0262_4D07699A02E4_var*
begin
//#UC START# *4D07693F0262_4D07699A02E4_impl*
 Result := #0;
//#UC END# *4D07693F0262_4D07699A02E4_impl*
end;//TTextMetricsPrimTest.HeaderBegin
{$IfEnd} // NOT Defined(NoVCM)

function TTextMetricsPrimTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D07699A02E4';
end;//TTextMetricsPrimTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
