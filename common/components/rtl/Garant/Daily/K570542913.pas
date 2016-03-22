unit K570542913;
 {* [RequestLink:570542913] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K570542913.pas"
// Стереотип: "TestCase"
// Элемент модели: "K570542913" MUID: (54A292720306)
// Имя типа: "TK570542913"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
;

type
 TK570542913 = class(THTMLtoEVDTest)
  {* [RequestLink:570542913] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK570542913
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK570542913.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK570542913.GetFolder

function TK570542913.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '54A292720306';
end;//TK570542913.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK570542913.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
