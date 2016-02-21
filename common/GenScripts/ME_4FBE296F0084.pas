unit K365844614;
 {* [Requestlink:365844614] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K365844614.pas"
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
 TK365844614 = class(TArchiInsiderTest)
  {* [Requestlink:365844614] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK365844614
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK365844614.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'BlockTest';
end;//TK365844614.GetFolder

function TK365844614.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4FBE296F0084';
end;//TK365844614.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK365844614.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
