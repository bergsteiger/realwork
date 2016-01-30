unit K459284317;
 {* [Requestlink:459284317] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K459284317.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
;

type
 TK459284317 = class(THTMLtoEVDTest)
  {* [Requestlink:459284317] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK459284317
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK459284317.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.8';
end;//TK459284317.GetFolder

function TK459284317.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '51AC5D28030C';
end;//TK459284317.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK459284317.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
