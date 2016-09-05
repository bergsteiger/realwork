unit K613740482;
 {* [Requestlink:613740482] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K613740482.pas"
// Стереотип: "TestCase"
// Элемент модели: "K613740482" MUID: (5677DA9902D8)
// Имя типа: "TK613740482"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK613740482 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:613740482] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK613740482
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *5677DA9902D8impl_uses*
 //#UC END# *5677DA9902D8impl_uses*
;

function TK613740482.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK613740482.GetFolder

function TK613740482.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5677DA9902D8';
end;//TK613740482.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK613740482.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
