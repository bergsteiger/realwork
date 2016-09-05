unit K453151648;
 {* [Requestlink:453151648] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K453151648.pas"
// Стереотип: "TestCase"
// Элемент модели: "K453151648" MUID: (5187509D034E)
// Имя типа: "TK453151648"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK453151648 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:453151648] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK453151648
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *5187509D034Eimpl_uses*
 //#UC END# *5187509D034Eimpl_uses*
;

function TK453151648.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.8';
end;//TK453151648.GetFolder

function TK453151648.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5187509D034E';
end;//TK453151648.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK453151648.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
