unit K624709249;
 {* [Requestlink:624709249] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K624709249.pas"
// Стереотип: "TestCase"
// Элемент модели: "K624709249" MUID: (5763CC780084)
// Имя типа: "TK624709249"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDFull
;

type
 TK624709249 = class(THTMLtoEVDFull)
  {* [Requestlink:624709249] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK624709249
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK624709249.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '8.0';
end;//TK624709249.GetFolder

function TK624709249.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5763CC780084';
end;//TK624709249.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK624709249.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
