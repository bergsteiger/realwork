unit K271754425;
 {* [$271754425] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K271754425.pas"
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
 TK271754425 = class(TArchiInsiderTest)
  {* [$271754425] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK271754425
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK271754425.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'Text2TableTests';
end;//TK271754425.GetFolder

function TK271754425.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4E0DA31F0385';
end;//TK271754425.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK271754425.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
