unit K288788279;
 {* [RequestLink:288788279] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K288788279.pas"
// Стереотип: "TestCase"
// Элемент модели: "K288788279" MUID: (4E847F620320)
// Имя типа: "TK288788279"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
;

type
 TK288788279 = class(THTMLtoEVDTest)
  {* [RequestLink:288788279] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK288788279
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK288788279.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7 Lulin';
end;//TK288788279.GetFolder

function TK288788279.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4E847F620320';
end;//TK288788279.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK288788279.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
