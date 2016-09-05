unit K537234131;
 {* [Requestlink:537234131] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K537234131.pas"
// Стереотип: "TestCase"
// Элемент модели: "K537234131" MUID: (5382D53C02E0)
// Имя типа: "TK537234131"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK537234131 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:537234131] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK537234131
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *5382D53C02E0impl_uses*
 //#UC END# *5382D53C02E0impl_uses*
;

function TK537234131.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.10';
end;//TK537234131.GetFolder

function TK537234131.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5382D53C02E0';
end;//TK537234131.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK537234131.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
