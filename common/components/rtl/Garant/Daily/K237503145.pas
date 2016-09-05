unit K237503145;
 {* [Requestlink:237503145] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K237503145.pas"
// Стереотип: "TestCase"
// Элемент модели: "K237503145" MUID: (5201F4F10195)
// Имя типа: "TK237503145"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , NSRCtoEVDTest
;

type
 TK237503145 = class(TNSRCtoEVDTest)
  {* [Requestlink:237503145] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK237503145
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *5201F4F10195impl_uses*
 //#UC END# *5201F4F10195impl_uses*
;

function TK237503145.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.9';
end;//TK237503145.GetFolder

function TK237503145.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5201F4F10195';
end;//TK237503145.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK237503145.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
