unit K206078013;
 {* [Requestlink:206078013] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K206078013.pas"
// Стереотип: "TestCase"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3IntfUses
 {$If NOT Defined(NoScripts)}
 , ArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 TK206078013 = class(TArchiInsiderTest)
  {* [Requestlink:206078013] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK206078013
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK206078013.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TableBoundariesAlignment';
end;//TK206078013.GetFolder

function TK206078013.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4F30CB7B02FC';
end;//TK206078013.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK206078013.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
