unit ScrollParamsTest;
 {* Тесты для провкрки параметров скроллера при прокрутке и переходе по сабам документа. }

// Модуль: "w:\common\components\rtl\Garant\Abstract_Tests\ScrollParamsTest.pas"
// Стереотип: "TestCase"
// Элемент модели: "TScrollParamsTest" MUID: (4D7210300201)

{$Include w:\common\components\rtl\Garant\Abstract_Tests\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , ScrollerParamsTestPrim
 , Types
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TScrollParamsTest = {abstract} class(TScrollerParamsTestPrim)
  {* Тесты для провкрки параметров скроллера при прокрутке и переходе по сабам документа. }
  protected
   function GetSubNumber: Integer; virtual;
   {$If NOT Defined(NoVCM)}
   procedure Process(aForm: TPrimTextLoadForm); override;
    {* Собственно процесс обработки текста }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function FormExtent: TPoint; override;
    {* Размеры формы }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TScrollParamsTest
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
 //#UC START# *4D7210300201impl_uses*
 //#UC END# *4D7210300201impl_uses*
;

function TScrollParamsTest.GetSubNumber: Integer;
//#UC START# *4D7211F7018C_4D7210300201_var*
//#UC END# *4D7211F7018C_4D7210300201_var*
begin
//#UC START# *4D7211F7018C_4D7210300201_impl*
 Result := 1;
//#UC END# *4D7211F7018C_4D7210300201_impl*
end;//TScrollParamsTest.GetSubNumber

{$If NOT Defined(NoVCM)}
procedure TScrollParamsTest.Process(aForm: TPrimTextLoadForm);
 {* Собственно процесс обработки текста }
//#UC START# *4BE13147032C_4D7210300201_var*
//#UC END# *4BE13147032C_4D7210300201_var*
begin
//#UC START# *4BE13147032C_4D7210300201_impl*
 with aForm.Text do
  TextSource.DocumentContainer.SubList.Sub[GetSubNumber].Select(Selection);
//#UC END# *4BE13147032C_4D7210300201_impl*
end;//TScrollParamsTest.Process
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TScrollParamsTest.FormExtent: TPoint;
 {* Размеры формы }
//#UC START# *4C08CF700318_4D7210300201_var*
//#UC END# *4C08CF700318_4D7210300201_var*
begin
//#UC START# *4C08CF700318_4D7210300201_impl*
 Result.X := 1000;
 Result.Y := 750;
//#UC END# *4C08CF700318_4D7210300201_impl*
end;//TScrollParamsTest.FormExtent
{$IfEnd} // NOT Defined(NoVCM)

function TScrollParamsTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TScrollParamsTest.GetFolder

function TScrollParamsTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D7210300201';
end;//TScrollParamsTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
