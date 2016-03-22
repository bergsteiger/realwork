unit K288786476;
 {* [Requestlink:288786476] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K288786476.pas"
// Стереотип: "TestCase"
// Элемент модели: "K288786476" MUID: (516E5DCB0023)
// Имя типа: "TK288786476"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
;

type
 TK288786476 = class(THTMLtoEVDTest)
  {* [Requestlink:288786476] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK288786476
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK288786476.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.8';
end;//TK288786476.GetFolder

function TK288786476.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '516E5DCB0023';
end;//TK288786476.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK288786476.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
