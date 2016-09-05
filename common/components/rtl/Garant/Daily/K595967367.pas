unit K595967367;
 {* [RequestLink:595967367] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K595967367.pas"
// Стереотип: "TestCase"
// Элемент модели: "K595967367" MUID: (551D1EAB032E)
// Имя типа: "TK595967367"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK595967367 = class(TRTFtoEVDWriterTest)
  {* [RequestLink:595967367] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK595967367
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *551D1EAB032Eimpl_uses*
 //#UC END# *551D1EAB032Eimpl_uses*
;

function TK595967367.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK595967367.GetFolder

function TK595967367.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '551D1EAB032E';
end;//TK595967367.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK595967367.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
