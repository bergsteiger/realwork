unit K522781517;
 {* [Requestlink:522781517] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K522781517.pas"
// Стереотип: "TestCase"
// Элемент модели: "K522781517" MUID: (54CA21700180)
// Имя типа: "TK522781517"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
;

type
 TK522781517 = class(THTMLtoEVDTest)
  {* [Requestlink:522781517] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK522781517
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *54CA21700180impl_uses*
 //#UC END# *54CA21700180impl_uses*
;

function TK522781517.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK522781517.GetFolder

function TK522781517.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '54CA21700180';
end;//TK522781517.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK522781517.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
