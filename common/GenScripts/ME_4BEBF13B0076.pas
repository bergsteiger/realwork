unit ScrollTest;
 {* Тест скроллирования документа }

// Модуль: "w:\common\components\gui\Garant\Daily\ScrollTest.pas"
// Стереотип: "TestCase"
// Элемент модели: "TScrollTest" MUID: (4BEBF13B0076)

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , PrimScrollTest
 , PrimTextLoad_Form
;

type
 TScrollTest = {abstract} class(TPrimScrollTest)
  {* Тест скроллирования документа }
  protected
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
    {* Обработать текст }
   function GetNormalFontSize: Integer; override;
    {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TScrollTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , TestFrameWork
 , vcmBase
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

procedure TScrollTest.DoVisit(aForm: TPrimTextLoadForm);
 {* Обработать текст }
//#UC START# *4BE419AF0217_4BEBF13B0076_var*
//#UC END# *4BE419AF0217_4BEBF13B0076_var*
begin
//#UC START# *4BE419AF0217_4BEBF13B0076_impl*
 Scroll(aForm, '');
//#UC END# *4BE419AF0217_4BEBF13B0076_impl*
end;//TScrollTest.DoVisit

function TScrollTest.GetNormalFontSize: Integer;
 {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
//#UC START# *4C07AC6F036D_4BEBF13B0076_var*
//#UC END# *4C07AC6F036D_4BEBF13B0076_var*
begin
//#UC START# *4C07AC6F036D_4BEBF13B0076_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4BEBF13B0076_impl*
end;//TScrollTest.GetNormalFontSize

function TScrollTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'Everest';
end;//TScrollTest.GetFolder

function TScrollTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4BEBF13B0076';
end;//TScrollTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
