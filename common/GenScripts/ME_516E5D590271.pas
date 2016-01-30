unit K332202037;
 {* [Requestlink:332202037] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K332202037.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
;

type
 TK332202037 = class(THTMLtoEVDTest)
  {* [Requestlink:332202037] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK332202037
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK332202037.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.8';
end;//TK332202037.GetFolder

function TK332202037.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '516E5D590271';
end;//TK332202037.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK332202037.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
