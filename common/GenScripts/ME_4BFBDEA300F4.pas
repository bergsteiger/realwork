unit ScrollBackTest;
 {* Тест скроллирования документа в обратную сторону }

// Модуль: "w:\common\components\gui\Garant\Daily\ScrollBackTest.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , PrimScrollTest
 , PrimTextLoad_Form
;

type
 TScrollBackTest = {abstract} class(TPrimScrollTest)
  {* Тест скроллирования документа в обратную сторону }
  protected
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
    {* Обработать текст }
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TScrollBackTest
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

procedure TScrollBackTest.DoVisit(aForm: TPrimTextLoadForm);
 {* Обработать текст }
//#UC START# *4BE419AF0217_4BFBDEA300F4_var*
//#UC END# *4BE419AF0217_4BFBDEA300F4_var*
begin
//#UC START# *4BE419AF0217_4BFBDEA300F4_impl*
 ScrollBack(aForm, '');
//#UC END# *4BE419AF0217_4BFBDEA300F4_impl*
end;//TScrollBackTest.DoVisit

function TScrollBackTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'Everest';
end;//TScrollBackTest.GetFolder

function TScrollBackTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4BFBDEA300F4';
end;//TScrollBackTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
