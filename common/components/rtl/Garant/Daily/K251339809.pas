unit K251339809;
 {* [Requestlink:251339809] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K251339809.pas"
// Стереотип: "TestCase"
// Элемент модели: "K251339809" MUID: (516E7443012A)
// Имя типа: "TK251339809"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoHTMLTest
;

type
 TK251339809 = class(TEVDtoHTMLTest)
  {* [Requestlink:251339809] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK251339809
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *516E7443012Aimpl_uses*
 //#UC END# *516E7443012Aimpl_uses*
;

function TK251339809.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.8';
end;//TK251339809.GetFolder

function TK251339809.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '516E7443012A';
end;//TK251339809.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK251339809.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
