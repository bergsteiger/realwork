unit K395654924;
 {* [Requestlink:395654924] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K395654924.pas"
// Стереотип: "TestCase"

{$Include arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3IntfUses
 {$If NOT Defined(NoScripts)}
 , ArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 TK395654924 = class(TArchiInsiderTest)
  {* [Requestlink:395654924] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK395654924
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK395654924.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TableTools';
end;//TK395654924.GetFolder

function TK395654924.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '506AE10B03CF';
end;//TK395654924.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK395654924.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
