unit K493868665;
 {* [Requestlink:493868665] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K493868665.pas"
// Стереотип: "TestCase"
// Элемент модели: "K493868665" MUID: (5260D5630045)
// Имя типа: "TK493868665"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoEVDSectionRepairTest
;

type
 TK493868665 = class(TEVDtoEVDSectionRepairTest)
  {* [Requestlink:493868665] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK493868665
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *5260D5630045impl_uses*
 //#UC END# *5260D5630045impl_uses*
;

function TK493868665.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.10';
end;//TK493868665.GetFolder

function TK493868665.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5260D5630045';
end;//TK493868665.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK493868665.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
