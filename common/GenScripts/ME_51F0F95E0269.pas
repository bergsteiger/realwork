unit K460279011;
 {* [Requestlink:460279011] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K460279011.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
;

type
 TK460279011 = class(THTMLtoEVDTest)
  {* [Requestlink:460279011] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK460279011
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK460279011.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.9';
end;//TK460279011.GetFolder

function TK460279011.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '51F0F95E0269';
end;//TK460279011.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK460279011.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
