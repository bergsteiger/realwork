unit K444236481;
 {* [Requestlink:444236481] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K444236481.pas"
// Стереотип: "TestCase"
// Элемент модели: "K444236481" MUID: (5153D3EB035A)
// Имя типа: "TK444236481"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
;

type
 TK444236481 = class(THTMLtoEVDTest)
  {* [Requestlink:444236481] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK444236481
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK444236481.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.8';
end;//TK444236481.GetFolder

function TK444236481.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5153D3EB035A';
end;//TK444236481.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK444236481.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
