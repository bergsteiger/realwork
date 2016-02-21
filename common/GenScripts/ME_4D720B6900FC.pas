unit ScrollerParamsTestPrim;
 {* Тесты для провкрки параметров скроллера при прокрутке и переходе по сабам документа. }

// Модуль: "w:\common\components\rtl\Garant\Abstract_Tests\ScrollerParamsTestPrim.pas"
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
 TScrollerParamsTestPrim = {abstract} class(TTextViaEditorProcessorWithExternalSave)
  {* Тесты для провкрки параметров скроллера при прокрутке и переходе по сабам документа. }
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
 end;//TScrollerParamsTestPrim
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

procedure TScrollerParamsTestPrim.DoSave(aForm: TPrimTextLoadForm;
 aFiler: Tl3CustomFiler);
//#UC START# *4D0771F102B6_4D720B6900FC_var*
//#UC END# *4D0771F102B6_4D720B6900FC_var*
begin
//#UC START# *4D0771F102B6_4D720B6900FC_impl*
 with aForm.Text do
 begin
  with View.Scroller[True] do
  begin
   aFiler.WriteLn('Min = ' + IntToStr(Min));
   aFiler.WriteLn('Max = ' + IntToStr(Max));
   aFiler.WriteLn('Pos = ' + IntToStr(Pos));
   //aFiler.WriteLn('Page = ' + IntToStr(Page));
  end;//with TextSource.DocumentContainer
 end;//with aForm.Text
//#UC END# *4D0771F102B6_4D720B6900FC_impl*
end;//TScrollerParamsTestPrim.DoSave

function TScrollerParamsTestPrim.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TScrollerParamsTestPrim.GetFolder

{$If NOT Defined(NoVCM)}
function TScrollerParamsTestPrim.EtalonFileExtension: AnsiString;
 {* Расширение эталонного файла }
//#UC START# *4D0769150130_4D720B6900FC_var*
//#UC END# *4D0769150130_4D720B6900FC_var*
begin
//#UC START# *4D0769150130_4D720B6900FC_impl*
 Result := 'scroll';
//#UC END# *4D0769150130_4D720B6900FC_impl*
end;//TScrollerParamsTestPrim.EtalonFileExtension
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TScrollerParamsTestPrim.HeaderBegin: AnsiChar;
//#UC START# *4D07693F0262_4D720B6900FC_var*
//#UC END# *4D07693F0262_4D720B6900FC_var*
begin
//#UC START# *4D07693F0262_4D720B6900FC_impl*
 Result := #0;
//#UC END# *4D07693F0262_4D720B6900FC_impl*
end;//TScrollerParamsTestPrim.HeaderBegin
{$IfEnd} // NOT Defined(NoVCM)

function TScrollerParamsTestPrim.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D720B6900FC';
end;//TScrollerParamsTestPrim.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
